Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWJJX2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWJJX2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWJJX2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:28:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:48109 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030344AbWJJX2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:28:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E9xDy0nZemE7ONWSGbqsPbCWa4IIJ9hnpzJMvwJzn44TdB0ulsezLmBlGKqm9BPRt1lYsBN6TBl2vdoSUekDxeJ1TQn6bJECqknkOMLRcIjW1IzXsUE+TbcIFeiB+vCUCik3huSFZVqLbUE10TWFUyFm0akqOvpFytD3RhGHCdc=
Message-ID: <f4527be0610101628h2aea0d80sda94e1431cb82f14@mail.gmail.com>
Date: Wed, 11 Oct 2006 00:28:37 +0100
From: "Andrew Lyon" <andrew.lyon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: SATA CD/DVDRW Support in 2.6.18?
In-Reply-To: <f4527be0610010740r662f8d8at4dbbf68d1543040f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <f4527be0610010740r662f8d8at4dbbf68d1543040f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I have a Samsung SH-W163A SATA CD/DVDRW connected to jmicron
> 20360/20363 onboard sata controller, running kernel 2.6.18 with sr_mod
> loaded I can mount recorded/original disks and read them, but if I try
> to burn a cd or dvd using cdrecord, and somtimes when mounting media I
> get loads of errors in dmesg and the burn fails:
>
> ata2.00: speed down requested but no transfer mode left
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (irq_stat 0x48000000, interface fatal error)
> ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
> ata2: soft resetting port
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: configured for PIO0
> ata2: EH complete
> ata2.00: speed down requested but no transfer mode left
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (irq_stat 0x48000000, interface fatal error)
> ata2.00: tag 0 cmd 0xa0 Emask 0x50 stat 0x51 err 0x30 (ATA bus error)
> ata2: soft resetting port
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: configured for PIO0
> ata2: EH complete
> ata2.00: speed down requested but no transfer mode left
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (irq_stat 0x48000000, interface fatal error)
>
>
> It looks like the interface is trying to run at 1.5Gbps which is
> obviously too fast for this drive, is there any way to set the
> interface speed ? I have a WD Raptor on the other sata port of the
> jmicron and that works perfectly (as long as NCQ is disabled - drive
> firmware bug).
>
> What is the status of sata cd/dvdrw support? It is getting hard to buy
> machines with IDE writers, most of our workstations are dell and have
> only sata devices, we have similar problems with those.
>
> Andy
>

I've done some more testing, I do not get the errors above when
reading a cd or dvd, only when I try to record using cdrecord (or
other apps) using ATAPI, here is some info from cdrecord:

cdrecord dev=ATAPI:0,0,0 -checkdrive
Cdrecord-ProDVD-Clone 2.01.01a10 (i686-pc-linux-gnu) Copyright (C)
1995-2006 Jörg Schilling
scsidev: 'ATAPI:0,0,0'
devname: 'ATAPI'
scsibus: 0 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'TSSTcorp'
Identifikation : 'CD/DVDW SH-W163A'
Revision       : 'TS01'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE
Supported modes: PACKET SAO


Are these codes: Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen , from
the kernel? or from the sata chip? if they are from the chip does
anybody know where I might find datasheets for  JMicron 20360/20363
AHCI Controller (rev 02) ? perhaps I might find a clue there..

Read speeds seem ok, 15MB/sec from a original dvd.

andy
