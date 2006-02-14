Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbWBNIim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbWBNIim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbWBNIim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:38:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39369 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030518AbWBNIil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:38:41 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43F196CF.9060608@s5r6.in-berlin.de>
Date: Tue, 14 Feb 2006 09:37:35 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de> <20060208230559.GK27946@ftp.linux.org.uk> <43F0B1AB.6010708@s5r6.in-berlin.de> <20060213181839.GA27946@ftp.linux.org.uk> <43F0EBE1.8000001@s5r6.in-berlin.de> <20060214024049.GB27946@ftp.linux.org.uk>
In-Reply-To: <20060214024049.GB27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.562) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Mon, Feb 13, 2006 at 09:28:17PM +0100, Stefan Richter wrote:
...
>> - The TI StorageLynx based bridge reports device type 0 (TYPE_DISK).
>>   The problem occurs apparently with page 4 and page 8. Sbp2 has a
>>   fix since yesterday which sets the skip_ms_page_8 flag.
> 
> That's going to cause fun problems on reboot if it actually has write-behind
> cache...

Not only on reboot but always when sd is told to shut down. I did not 
notice an actual problem so far but I will keep an eye on it.

But AFAIU, sd's cache syncing (of devices with WCE set) is ineffective 
anyway if devices are unplugged without manually shutting the driver 
down beforehand.

>>   http://marc.theaimsgroup.com/?l=linux1394-devel&m=113969287630893
>> - Another bridge made by the same manufacturer but based on TI
>>   StorageLynx revision A features the same MODE SENSE bug. This bridge
>>   reports type 14 (TYPE_RBC).
> 
> Pardon?  If it's type 14, we won't issue MODE SENSE for page 8 and will
> go for page 6 instead...

Correct. Which is why I did not notice the bug until testing with scsiinfo.

...
>>Of course sg does not care for any black list flags (like sd_mod and 
>>sr_mod do), but considering the nature of the bugs and anticipated usage 
>>of affected devices, there is hardly a reason for further safeguards in 
>>sbp2, let alone sg.
> 
> Maybe, maybe not.  Note that e.g. aforementioned INQUIRY bug in pl3507 is
> triggered by dmraid, which works via SG_IO, just as scsiinfo.  And unlike
> scsiinfo it's run from /etc/rc.sysinit on current FC4...

Are they probing all devices or only those which are part of a RAID set?
-- 
Stefan Richter
-=====-=-==- --=- -===-
http://arcgraph.de/sr/
