Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945965AbWBCVyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945965AbWBCVyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWBCVyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:54:14 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:19666 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751134AbWBCVyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:54:14 -0500
Message-ID: <43E3D103.70505@comcast.net>
Date: Fri, 03 Feb 2006 16:54:11 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Still using mm kernels here, now on 2.6.16-rc1-mm5.   Still no atapi 
device detection - much less function - when using the libata pata amd 
driver for the nvidia Nforce4 chipset.   I tried, libata.atapi_enabled=1 
and just atapi_enabled=1 in the boot args and nothing was mentioned 
about atapi devices in dmesg.

Is it a known issue with the pata libata drivers that atapi isn't 
working yet? ...  all i've seen is people with sata atapi devices 
chiming in.





>On Maw, 2006-01-24 at 01:43 -0500, Ed Sweetman wrote:
>
>
>              
>
>>problem.  The problem is that there appears to be two nvidia/amd ata
>>drivers and I'm unsure which I should try using, if i compile both in,
>>which get loaded first (i assume scsi is second to ide) and if i want my
>>pata disks loaded under the new libata drivers, will my cdrom work under
>>them too, or do i still need some sort of regular ide drivers loaded
>>just for cdrom (to use native ata mode for recording access).

>>>The goal of the drivers/scsi/pata_* drivers is to replace drivers/ide in
>its entirity with code using the newer and cleaner libata logic. There
>is still much to do but my SIL680, SiS, Intel MPIIX, AMD and VIA boxes
>are using libata and the additional patch patches still queued
>>>              
>>>1.  Atapi is most definitely not supported by libata, right now.

>>>It works in the -mm tree.
>>>              
>Intriguing, when I had no ide chipset compiled in kernel, only libata
>drivers, I got no mention at all about my dvd writer.  I even had the
>scsi cd driver installed and generic devices, still nothing seemed to
>initialize the dvd drive.  It detected the second pata bus but no
>devices attached to it.

>this is using the kernel mentioned in the subject header.
>2.6.16-rc1-mm2.  using the amd/nvidia drivers for pata and sata.

>Is there anything i can do to give more info to the list to figure out
>why my atapi writer is being ignored by pata even when there are no ide
>drivers loaded?




>>>>>Currently you need to use libata.atapi_enabled=1
>>>>>(assuming that libata is in the kernel image, not a loadable module).
>>>>I just built/tested this also, working for me as well.
>>>>>(hard drives, not ATAPI)
>>>          
>>>I assume libata.atapi_enabled=1 is a boot arg, not some structure member
>>>>in the source for the pata driver that i need to set to 1, correct?
>>        
>Yes, it's a kernel boot option if libata is in the kernel image.
>>>If libata is a loadable module, just use something like
>>>      modprobe libata atapi_enabled=1

>>>      
>And you just built and tested it, how did you test if the atapi argument
>>>>worked when you then say "not ATAPI" as something you tested?
>>        
>Sorry, I mean that I built and booted a kernel with libata/PATA
>>>hard drive (vs. legacy drivers/ide/ PATA support).  I have not
>>>tested ATAPI at all and didn't mean to imply that I had.
>I reported on libata.atapi_enabled=1 based on documentation
>>>and other emails that I have read.

>>>      
>In any case, i'll try out libata.atapi_enabled=1 and see if it detects
>>>>the dvd drive.
>>        
>HTH.  Please continue to post any questions or problems.

>>>
>>I Rebooted several times, both setting the option in the kernel boot
>>args and editing the source to have it set by default.  No atapi devices
>>are found/mentioned or even described as not found in dmesg/bootup.   So
>>apparently, on my chipset, the amd/nvidia pata driver is not detecting
>>atapi devices.
>>
>>0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
>>0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA
>>Controller (rev f3)
>>0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA
>>Controller (rev f3)
>>
>>0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
>>(prog-if 8a [Master SecP PriP])
>>        Subsystem: Unknown device f043:815a
>>        Flags: bus master, 66MHz, fast devsel, latency 0
>>        I/O ports at f000 [size=16]
>>        Capabilities: [44] Power Management version 2
>the atapi device in question is a plextor px-712A, it's the only device
>>on the secondary channel.
>>    
>>
>
>And this is with using only ATA (libata) drivers in drivers/scsi/
>and not ATA drivers in drivers/ide/, right?
>
>Hm.  I guess we treat this as a bug report for NV ATA/ATAPI then.
>
>I just tested my system with a Plextor PX-712SA drive plus
>booting with libata.atapi_enabled=1 and the driver (not nv)
>sees the ATAPI drive and can read it.
>
>  
>
 >Indeed, this is with only libata.  I had scsi disk driver and cdrom
 >driver compiled in as well, because i assumed that the "low level"
 >libata drivers required those scsi interfaces to access the disks and
 >atapi devices that are found by libata.  ide isn't even compiled in.
 >
 >Like i said, i booted with libata.atapi_enabled=1 and that produced
 >nothing about cdroms/atapi devices and then I simply set the variable 
 >to 1 in source and recompiled and booted and same problem.

 >my board is an Asus A8N-E and my plextor is on the PATA controller, not
 >the SATA like yours.  Perhaps mine would work too if it was sata, but 
 >it appears that the pata driver has no provisions for atapi devices >yet.



