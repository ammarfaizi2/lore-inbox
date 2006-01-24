Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWAXWRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWAXWRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWAXWRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:17:20 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:53446 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750776AbWAXWRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:17:19 -0500
Message-ID: <43D6A76D.2000502@comcast.net>
Date: Tue, 24 Jan 2006 17:17:17 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
References: <43D5CC88.9080207@comcast.net> <1138116579.14675.22.camel@localhost.localdomain>
In-Reply-To: <1138116579.14675.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Maw, 2006-01-24 at 01:43 -0500, Ed Sweetman wrote:
>  
>
>>problem.  The problem is that there appears to be two nvidia/amd ata 
>>drivers and I'm unsure which I should try using, if i compile both in, 
>>which get loaded first (i assume scsi is second to ide) and if i want my 
>>pata disks loaded under the new libata drivers, will my cdrom work under 
>>them too, or do i still need some sort of regular ide drivers loaded 
>>just for cdrom (to use native ata mode for recording access).  
>>    
>>
>
>The goal of the drivers/scsi/pata_* drivers is to replace drivers/ide in
>its entirity with code using the newer and cleaner libata logic. There
>is still much to do but my SIL680, SiS, Intel MPIIX, AMD and VIA boxes
>are using libata and the additional patch patches still queued
>  
>

>>1.  Atapi is most definitely not supported by libata, right now.
>>    
>>
>
>It works in the -mm tree.
>  
>
Intriguing, when I had no ide chipset compiled in kernel, only libata 
drivers, I got no mention at all about my dvd writer.  I even had the 
scsi cd driver installed and generic devices, still nothing seemed to 
initialize the dvd drive.  It detected the second pata bus but no 
devices attached to it. 

this is using the kernel mentioned in the subject header.  
2.6.16-rc1-mm2.  using the amd/nvidia drivers for pata and sata.

Is there anything i can do to give more info to the list to figure out 
why my atapi writer is being ignored by pata even when there are no ide 
drivers loaded?

>>4.  moving to pata libata drivers _will_ change the enumeration of your 
>>sata devices, it seems that pata is initialized first, so when setting 
>>up your fstab entries and grub, you'll have to take into account how 
>>many pata devices you have and offset your current sata device names by 
>>that amount.
>>    
>>
>
>Or use labels. As you move into the world of hot pluggable hardware it
>becomes more and more impractical to guarantee drive ordering by name.
>
>You can mix and match the drivers providing you don't try and load both
>libata and old ide drives for the same chip. Even then it should fail
>correctly with one of them reporting resources unavailable.
>
>In fact I do this all the time when debugging so I've got a stable disk
>for debug work and a devel disk.
>
>Alan
>  
>

I'm not familiar with labeling ...will have to look into it, since 
borking a kernel after changing the drivers can result in a non-bootable 
system depending on how the partitions are setup across the devices. 
(since you'd have to change them in fstab and such before a reboot).  A 
way around that would be very useful.


