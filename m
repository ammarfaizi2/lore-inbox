Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVCaVwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVCaVwX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCaVwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:52:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261521AbVCaVwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:52:16 -0500
Date: Thu, 31 Mar 2005 16:52:09 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050331215209.GA11355@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20050330214455.GF10159@redhat.com> <20050331104117.GD1623@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331104117.GD1623@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 12:41:17PM +0200, Andi Kleen wrote:
 > On Wed, Mar 30, 2005 at 04:44:55PM -0500, Dave Jones wrote:
 > > [apologies to Andi for getting this twice, I goofed the l-k address
 > >  the first time]
 > > 
 > >  
 > >  I arrived at the office today to find my workstation had this spew
 > >  in its dmesg buffer..
 > 
 > Looks like random memory corruption to me.
 > 
 > Can you enable slab debugging etc.?

SLAB_DEBUG=y.  Nothing in the logs.

 > Yes I saw them, but I supposed it is some driver going bad.
 > If you want you can collect hardware data and see if there is
 > a common driver.

There's quite a bit in this box 

00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) 00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05) 00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) 00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 AC97 Audio (rev 03)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
02:07.0 USB Controller: NEC Corporation USB (rev 41)
02:07.1 USB Controller: NEC Corporation USB (rev 41)
02:07.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
02:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
02:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet (rev 02)
03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:0a.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 03)
03:0b.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
03:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
04:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller (rev 13)
04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 13)
05:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)

The SATA & SCSI controllers have no disks attached.  Firewire can be ignored (theres
no actual connector even for it on the board). The various USB controllers
are mostly unused. Only one of them is USB2.0, so that sees occasional
usb-storage use. Not noticed anything going bad there though.

		Dave

