Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272302AbTG0Wxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 18:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272379AbTG0Wxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 18:53:48 -0400
Received: from zeus.kernel.org ([204.152.189.113]:65009 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272302AbTG0Wxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:53:43 -0400
Date: Sun, 27 Jul 2003 18:16:10 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: PCI trouble with 2.6.0-test2
Message-ID: <20030727221610.GA763@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't say offhand what the last 2.5.x kernel to boot on this system was;
it's been a while since I tried.  2.6.0-test2 definitely doesn't though. 
The machine is a dual-Pentium3 using an Abit motherboard; nothing
else particularly fancy.

Thanks to the wonders of serial console, here's the interesting parts of the
boot log:

checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 2
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbd80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbdb0, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
aty128fb: Invalid ROM signature 0
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 RE (PCI) [chip rev 0x2] 16M 128-bit SDR SGRAM (1:1)


On a much older 2.4 kernel, I get something very different:
checking TSC synchronization across CPUs: passed.
Starting migration thread for cpu 0
smp_num_cpus: 2.
Starting migration thread for cpu 1
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
aty128fb: Rage128 BIOS located at segment C00C0000
aty128fb: Rage128 RE (PCI) [chip rev 0x2] 16M 128-bit SDR SGRAM (1:1)


So the PCI subsystem doesn't get initialized correctly.  Suggestions on
where to look next would be appreciated.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
