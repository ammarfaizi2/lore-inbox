Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWBNVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWBNVOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWBNVOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:14:18 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:21258 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1422707AbWBNVOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:14:18 -0500
Message-ID: <43F247EC.3070503@cfl.rr.com>
Date: Tue, 14 Feb 2006 16:13:16 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com> <F157 <D2DF8AE9-51A0-42DF-8346-0EF4C264627D@mac.com>
In-Reply-To: <D2DF8AE9-51A0-42DF-8346-0EF4C264627D@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 21:15:33.0214 (UTC) FILETIME=[CA6FEFE0:01C631AB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14268.000
X-TM-AS-Result: No--21.099000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> How is swapping USB devices while suspended unreasonable?  Come to 
> think of it, I did it inadvertently about 15 minutes ago with my PowerBook

Because you can not go yanking devices out from under the kernel without 
it's knowledge or consent.  This is no more acceptable than ejecting a 
floppy without first unmounting it; the only difference is that the 
floppy drive doesn't erroneously inform the kernel that you have done 
this simply because you suspend. 

> (while booted into Mac OS).  I had a USB key that I was copying a file 
> to for someone.  After shutting the lid, I unplugged mouse, USB key, 
> and power block.  About 30 minutes later I had somebody else with a 
> key who wanted to give me a file.  I had the key plugged in before the 
> laptop was finished waking up from sleep.  Now, I don't know for 
> certain that neither key had a serial number, but the two I have here 
> in my hand certainly don't, and I could _easily_ see somebody swapping 
> USB keys not knowing that they're "not supposed to do that" and 
> getting massive data corruption when the filesystem reads and writes 
> pages from a completely different block device.
>

Then they shot themselves in the foot.  That is no different than 
switching mounted floppies while suspended, or removing a mounted IDE 
hard drive while suspended, so they get what they deserve. 

> Did you read what I wrote?  People don't generally expect to randomly 
> plug and unplug SCSI drives whenever they feel like it.  They _do_ 
> expect to randomly plug and unplug USB drives, mice, keyboards, 
> tablets, network adapters, etc, because _everything_ supports such 
> random plugging.
>

No, they don't.  Users do not expect ( or should not and are told not to 
by admins ) to be able to yank out their usb memory stick while it is 
mounted.  They are told to always unmount first.  If they fail to do so, 
then they get what they asked for.  It doesn't matter if the disk is 
SCSI or USB; you don't go yanking it out without unmounting it first, or 
you will loose data. 

> Creating an extremely odd and hard to predict failure mode (when you 
> reconnect USB devices while suspended on hardware that doesn't support 
> proper USB suspend) with a high probability of causing data corruption 
> or crashes is wrong.  Especially since you could easily teach users 
> that "You need to eject USB things before you sleep the computer _or_ 
> just fix the kernel to do it for you.  That's probably something we 
> should be doing for all network filesystems anyways.
>

Users are already told to eject/unmount the media before removing it.  
If they fail to do that, it doesn't matter if the system is suspended or 
not; they broke the drive when they yanked it out while mounted.  As for 
fixing the kernel to unmount it for you, that is not always possible; 
take the root on usb case. 

Maybe it does make sense to have hibernation scripts unmount removable 
media for the common silly user who can't remember to unmount disks 
before ejecting/unplugging them, but you should be able to suspend a 
system with its root on a usb disk and not have the kernel panic for no 
good reason when it resumes. 


