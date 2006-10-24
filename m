Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWJXNhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWJXNhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWJXNhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:37:18 -0400
Received: from mail.tmr.com ([64.65.253.246]:10160 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965136AbWJXNhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:37:16 -0400
Message-ID: <453E1701.9010403@tmr.com>
Date: Tue, 24 Oct 2006 09:37:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Andrew Lyon <andrew.lyon@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SATA CD/DVDRW Support in 2.6.18?
References: <f4527be0610010740r662f8d8at4dbbf68d1543040f@mail.gmail.com> <f4527be0610101628h2aea0d80sda94e1431cb82f14@mail.gmail.com>
In-Reply-To: <f4527be0610101628h2aea0d80sda94e1431cb82f14@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Lyon wrote:
>> Hi,
>>
>> I have a Samsung SH-W163A SATA CD/DVDRW connected to jmicron
>> 20360/20363 onboard sata controller, running kernel 2.6.18 with sr_mod
>> loaded I can mount recorded/original disks and read them, but if I try
>> to burn a cd or dvd using cdrecord, and somtimes when mounting media I
>> get loads of errors in dmesg and the burn fails:

Not having any SATA CD burners, I can only go by my experience using USB 
and Firewire burners, which also appear to be SCSI. They work fine using 
the device name rather than playing with the ATA or ATAPI stuff. And if 
you're using ProDVD I suggest you download the latest cdrecord from the 
usual site and build that, DVD support is now in the cdrecord source, as 
it is in most distributions.

I use multiple PATA and USB burners on several systems, and haven't had 
problems. I actually do have SCSI devices, they have always worked and 
continue to (slowly) do so.

If you post again after trying the current source, please include the 
command used as well as the output from the log. By using the latest you 
at least MIGHT get some help from the author, instead of the usual 
"don't bother me with obsolete versions" reply.
>>
>> ata2.00: speed down requested but no transfer mode left
>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata2.00: (irq_stat 0x48000000, interface fatal error)
>> ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
>> ata2: soft resetting port
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata2.00: configured for PIO0
>> ata2: EH complete
>> ata2.00: speed down requested but no transfer mode left
>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata2.00: (irq_stat 0x48000000, interface fatal error)
>> ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
>> ata2: soft resetting port
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata2.00: configured for PIO0
>> ata2: EH complete
>> ata2.00: speed down requested but no transfer mode left
>> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata2.00: (irq_stat 0x48000000, interface fatal error)
>>
>>
>> It looks like the interface is trying to run at 1.5Gbps which is
>> obviously too fast for this drive, is there any way to set the
>> interface speed ? I have a WD Raptor on the other sata port of the
>> jmicron and that works perfectly (as long as NCQ is disabled - drive
>> firmware bug).
>>
>> What is the status of sata cd/dvdrw support? It is getting hard to buy
>> machines with IDE writers, most of our workstations are dell and have
>> only sata devices, we have similar problems with those.
>>
>> Andy
>>
> 
> I've done some more testing, I do not get the errors above when
> reading a cd or dvd, only when I try to record using cdrecord (or
> other apps) using ATAPI, here is some info from cdrecord:
> 
> cdrecord dev=ATAPI:0,0,0 -checkdrive
> Cdrecord-ProDVD-Clone 2.01.01a10 (i686-pc-linux-gnu) Copyright (C)
> 1995-2006 Jörg Schilling
> scsidev: 'ATAPI:0,0,0'
> devname: 'ATAPI'
> scsibus: 0 target: 0 lun: 0
> Warning: Using ATA Packet interface.
> Warning: The related Linux kernel interface code seems to be unmaintained.
> Warning: There is absolutely NO DMA, operations thus are slow.
> Using libscg version 'schily-0.8'.
> Device type    : Removable CD-ROM
> Version        : 5
> Response Format: 2
> Capabilities   :
> Vendor_info    : 'TSSTcorp'
> Identifikation : 'CD/DVDW SH-W163A'
> Revision       : 'TS01'
> Device seems to be: Generic mmc2 DVD-R/DVD-RW.
> Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
> Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE
> Supported modes: PACKET SAO
> 
> 
> Are these codes: Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen , from
> the kernel? or from the sata chip? if they are from the chip does
> anybody know where I might find datasheets for  JMicron 20360/20363
> AHCI Controller (rev 02) ? perhaps I might find a clue there..
> 
> Read speeds seem ok, 15MB/sec from a original dvd.
> 
> andy


-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
