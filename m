Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265692AbSJXXdl>; Thu, 24 Oct 2002 19:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265701AbSJXXdl>; Thu, 24 Oct 2002 19:33:41 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:49884 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265692AbSJXXdk>; Thu, 24 Oct 2002 19:33:40 -0400
Date: Thu, 24 Oct 2002 16:39:45 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: PCI device order problem
Message-ID: <20021024163945.A21961@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/i386/kernel/pci-pc.c, there are

/*
 * Sort the device list according to PCI BIOS. Nasty hack, but since some
 * fool forgot to define the `correct' device order in the PCI BIOS specs
 * and we want to be (possibly bug-to-bug ;-]) compatible with older kernels 
 * which used BIOS ordering, we are bound to do this... 
 */

static void __devinit pcibios_sort(void)

The problem is on my MB:

00:00.0 Host bridge: Intel Corp. e7500 [Plumas] DRAM Controller (rev 03)
00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting ( rev 03)
00:03.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F0) (rev 03)
00:03.1 Class ff00: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F1) (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
03:07.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
03:07.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
03:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)

Eth1 becomes:
03:07.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)

and eth0 becomes:
03:07.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)

Is that a good idea to have an option to sort the PCI device by PCI bus and
slot numbers?


H.J.
