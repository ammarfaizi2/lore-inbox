Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVCUWbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVCUWbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVCUW26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:28:58 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:688 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261947AbVCUW1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:27:36 -0500
Date: Mon, 21 Mar 2005 17:27:01 -0500
To: Jay Roplekar <jay_roplekar@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SATA] sata-via : bug?
Message-ID: <20050321222701.GI17865@csclub.uwaterloo.ca>
References: <200503211618.16942.jay_roplekar@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503211618.16942.jay_roplekar@hotmail.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:18:16PM -0600, Jay Roplekar wrote:
> I  have  a brand new Western Digital sata drive, VIA KT600  based ECS 
> motherboard on which I am trying to install various distros (with installers 
> based on 2.4.26, 2.6.7, 2.6.8, 2.6.11 etc)  all of them fail to detect the HD 
> (and bomb out) because sata-via is ignoring it .  I have only one disk, I am 
> not interested in raid.
>  
>  lspci which tells me it is VIA 6420 and should be  supported based on 
> sata-via.c.   Following are syslog snippets that show more.
> I would appreciate your help in resolving this. Thanks,
> 
> Jay
> ##
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 
> [Normal decode])
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: e0000000-e1ffffff
>         Prefetchable memory behind bridge: d8000000-dfffffff
>         Capabilities: [80] Power Management version 2
> 
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
> Controller (rev 80)
>         Subsystem: Elitegroup Computer Systems: Unknown device 1884
>         Flags: bus master, medium devsel, latency 32, IRQ 11
>         I/O ports at b000 [size=8]
>         I/O ports at b400 [size=4]
>         I/O ports at b800 [size=8]
>         I/O ports at bc00 [size=4]
>         I/O ports at c000 [size=16]
>         I/O ports at c400 [size=256]
>         Capabilities: [c0] Power Management version 2
> 
> ##Dmesg when I connect the disk on channel 1
> libata version 1.10 loaded.
> sata_via version 1.1
> ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 11 (level, low) -> IRQ 11
> sata_via(0000:00:0f.0): routed to hard irq line 11
> ata1: SATA max UDMA/133 cmd 0xB000 ctl 0xB402 bmdma 0xC000 irq 11
> ata2: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC008 irq 11
> ata1: dev 0 cfg 49:3030 82:0078 83:0078 84:0000 85:0000 86:3fff 87:0010 
> 88:000f
> ata1: no dma/lba
> ata1: dev 0 not supported, ignoring
> scsi0 : sata_via
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_via
> ##with disk on second channel following
> ata1: no device found (phy stat 00000000)
> scsi0 : sata_via
> ata2: dev 0 cfg 49:3030 82:0078 83:0078 84:0078 85:0000 86:0000 87:0000 
> 88:0000
> ata2: no dma/lba
> ata2: dev 0 not supported, ignoring
> scsi1 : sata_via
> ## I took this disk and sata cable on a different (ICH5 based) motherboard and 
> ## knoppix detected the disk ok and associated sda with it. 

Any modes in the bios for the SATA ports?  Maybe it is in a mode not
supported by linux.  I know the ICH5 only wanted to work for me in
native (enhanced?) mode, not compatible (emulating PATA) mode.  Maybe
via does something similar.  I am puzzles by the UDMA/133 message which
makes no sense for SATA which should be 150 or 300 not 133.

Len Sorensen
