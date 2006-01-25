Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWAYB4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWAYB4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 20:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWAYB4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 20:56:35 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:49150 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750787AbWAYB4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 20:56:34 -0500
Message-ID: <43D6DAD0.50900@comcast.net>
Date: Tue, 24 Jan 2006 20:56:32 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
References: <43D5CC88.9080207@comcast.net> <1138116579.14675.22.camel@localhost.localdomain> <43D6A76D.2000502@comcast.net> <Pine.LNX.4.58.0601241426180.26036@shark.he.net> <43D6B1B2.4080400@comcast.net> <Pine.LNX.4.58.0601241503110.26036@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0601241503110.26036@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Tue, 24 Jan 2006, Ed Sweetman wrote:
>
>  
>
>>Randy.Dunlap wrote:
>>
>>    
>>
>>>On Tue, 24 Jan 2006, Ed Sweetman wrote:
>>>
>>>      
>>>
>>>>Alan Cox wrote:
>>>>
>>>>        
>>>>
>>>>>On Maw, 2006-01-24 at 01:43 -0500, Ed Sweetman wrote:
>>>>>
>>>>>
>>>>>          
>>>>>
>>>>>>problem.  The problem is that there appears to be two nvidia/amd ata
>>>>>>drivers and I'm unsure which I should try using, if i compile both in,
>>>>>>which get loaded first (i assume scsi is second to ide) and if i want my
>>>>>>pata disks loaded under the new libata drivers, will my cdrom work under
>>>>>>them too, or do i still need some sort of regular ide drivers loaded
>>>>>>just for cdrom (to use native ata mode for recording access).
>>>>>>
>>>>>>
>>>>>>            
>>>>>>
>>>>>The goal of the drivers/scsi/pata_* drivers is to replace drivers/ide in
>>>>>its entirity with code using the newer and cleaner libata logic. There
>>>>>is still much to do but my SIL680, SiS, Intel MPIIX, AMD and VIA boxes
>>>>>are using libata and the additional patch patches still queued
>>>>>
>>>>>
>>>>>          
>>>>>
>>>>>>1.  Atapi is most definitely not supported by libata, right now.
>>>>>>
>>>>>>
>>>>>>            
>>>>>>
>>>>>It works in the -mm tree.
>>>>>
>>>>>
>>>>>          
>>>>>
>>>>Intriguing, when I had no ide chipset compiled in kernel, only libata
>>>>drivers, I got no mention at all about my dvd writer.  I even had the
>>>>scsi cd driver installed and generic devices, still nothing seemed to
>>>>initialize the dvd drive.  It detected the second pata bus but no
>>>>devices attached to it.
>>>>
>>>>this is using the kernel mentioned in the subject header.
>>>>2.6.16-rc1-mm2.  using the amd/nvidia drivers for pata and sata.
>>>>
>>>>Is there anything i can do to give more info to the list to figure out
>>>>why my atapi writer is being ignored by pata even when there are no ide
>>>>drivers loaded?
>>>>
>>>>        
>>>>
>>>Currently you need to use libata.atapi_enabled=1
>>>(assuming that libata is in the kernel image, not a loadable module).
>>>
>>>I just built/tested this also, working for me as well.
>>>(hard drives, not ATAPI)
>>>
>>>
>>>      
>>>
>>I assume libata.atapi_enabled=1 is a boot arg, not some structure member
>>in the source for the pata driver that i need to set to 1, correct?
>>    
>>
>
>Yes, it's a kernel boot option if libata is in the kernel image.
>If libata is a loadable module, just use something like
>	modprobe libata atapi_enabled=1
>
>  
>
>>And you just built and tested it, how did you test if the atapi argument
>>worked when you then say "not ATAPI" as something you tested?
>>    
>>
>
>Sorry, I mean that I built and booted a kernel with libata/PATA
>hard drive (vs. legacy drivers/ide/ PATA support).  I have not
>tested ATAPI at all and didn't mean to imply that I had.
>
>I reported on libata.atapi_enabled=1 based on documentation
>and other emails that I have read.
>
>  
>
>>In any case, i'll try out libata.atapi_enabled=1 and see if it detects
>>the dvd drive.
>>    
>>
>
>HTH.  Please continue to post any questions or problems.
>  
>

I Rebooted several times, both setting the option in the kernel boot 
args and editing the source to have it set by default.  No atapi devices 
are found/mentioned or even described as not found in dmesg/bootup.   So 
apparently, on my chipset, the amd/nvidia pata driver is not detecting 
atapi devices.

0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA 
Controller (rev f3)
0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA 
Controller (rev f3)

0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) 
(prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device f043:815a
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2



the atapi device in question is a plextor px-712A, it's the only device 
on the secondary channel.



