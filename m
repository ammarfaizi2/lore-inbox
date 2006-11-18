Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756290AbWKRL3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290AbWKRL3I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 06:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296AbWKRL3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 06:29:08 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:64474 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1756290AbWKRL3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 06:29:05 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455EEE17.4020605@s5r6.in-berlin.de>
Date: Sat, 18 Nov 2006 12:27:19 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2 (Oops in class_device_remove_attrs during nodemgr_remove_host)
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de> <20061117071650.GA4974@inferi.kami.home> <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de> <20061118094706.GA17879@kroah.com>
In-Reply-To: <20061118094706.GA17879@kroah.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Nov 17, 2006 at 04:24:27PM +0100, Stefan Richter wrote:
>> I wrote:
>>> Either the FireWire host's device->klist_children was overwritten before
>>> the call to device_for_each_child
>> or *during* the run of device_for_each_child, which first successfully
>> called nodemgr_remove_ne for node [0-00:1023] but then stumbled over the
>> false node [20754571-38:0455].
>>
>>> (perhaps nodemgr didn't hold a reference which it should have), or/and
>>> all of this is an issue with the ongoing migration away from class_device.
> 
> I don't have any firewire class_device migration patches in -mm right
> now.

Yes, I looked through the driver core related patches in -mm but wasn't
sure if there was a change to generic code which could affect
ieee1394/nodemgr.

> I do have one sitting here if you wish to play around with it, but it
> needs some more infrastructure patches that I have not really tested all
> that well yet.

(Is this infrastructure something which other subsystems will require
anyway? If not, maybe the ieee1394 subsystem's sysfs interface could be
cut to size instead.)

> Either way, I don't think this is caused by any new class_device
> patches, but I'm very willing to be proven wrong :)

Good, I just wanted to hear your opinion before drilling further down.
Seems there is an older bug in nodemgr. But whatever it is, the reporter
reproduced it _only_ in -mm, with either of 2.6.19-rc-mm's and
2.6.19-rc's ieee1394 code. Time for me to let -mm loose on my PC.

Thanks,
-- 
Stefan Richter
-=====-=-==- =-== =--=-
http://arcgraph.de/sr/
