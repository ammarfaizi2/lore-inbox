Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWBTVTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWBTVTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWBTVTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:19:33 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:42669 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750903AbWBTVTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:19:32 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43FA321F.50100@s5r6.in-berlin.de>
Date: Mon, 20 Feb 2006 22:18:23 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Matthias_Bl=E4sing?= 
	<matthias.blaesing@rwth-aachen.de>
CC: Subodh Shrivastava <subodh.shrivastava@gmail.com>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       bcollins@debian.org, scjody@modernduck.com
Subject: Re: ieee1394 failed to work after S3 resume.
References: <8b12046a0602191137n12997938kd8404814f7c8e2ba@mail.gmail.com> <43F9E70C.5030809@s5r6.in-berlin.de> <1140454826.30310.6.camel@prometheus.glx>
In-Reply-To: <1140454826.30310.6.camel@prometheus.glx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (0.64) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Bläsing wrote:
>>Subodh Shrivastava wrote:
>>>Suspend to Ram works fine here with 2.6.16-rc3 kernel except ieee1394
>>>fails to resume properly.
...
> A workaround till then is the usage of a script (I use hibernate and
> have blacklisted ohci1394), that unloads ohci1394 prior to suspending
> and reloading the module after resume.

Note, -mm contains a patch which lets sbp2 raise ohci1394's use count 
while it is logged in to a target.
http://www.kernel.org/git/?p=linux/kernel/git/scjody/ieee1394.git;a=commitdiff;h=d415a9a9685578058800f2677bfeb8090fc212a1

If you run -mm or once this patch is merged, you have to adapt your 
script to either unload sbp2 before ohci1394, or you have to detach sbp2 
via sysfs before attempting to unload ohci1394:
# echo 1 > /sys/bus/ieee1394/drivers/sbp2/${guid}-${ud}/ignore_driver
(for each device)
The corresponding sequence after reloading ohci1394 would be
# echo 0 > /sys/bus/ieee1394/devices/${guid}-${ud}/ignore_driver
(for each device)
# echo 1 > /sys/bus/ieee1394/rescan
(once)
-- 
Stefan Richter
-=====-=-==- --=- =-=--
http://arcgraph.de/sr/
