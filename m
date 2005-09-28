Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVI1Sdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVI1Sdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVI1Sde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:33:34 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:36619 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750719AbVI1Sdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:33:33 -0400
Date: Wed, 28 Sep 2005 20:33:24 +0200
From: Olivier Galibert <galibert@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20050928183324.GA51793@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org> <1127919909.4852.7.camel@mulgrave> <20050928160744.GA37975@dspnet.fr.eu.org> <1127924686.4852.11.camel@mulgrave> <20050928171052.GA45082@dspnet.fr.eu.org> <1127929909.4852.34.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127929909.4852.34.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 12:51:49PM -0500, James Bottomley wrote:
> On Wed, 2005-09-28 at 19:10 +0200, Olivier Galibert wrote:
> > On Wed, Sep 28, 2005 at 11:24:46AM -0500, James Bottomley wrote:
> > > On Wed, 2005-09-28 at 18:07 +0200, Olivier Galibert wrote:
> > > > scsi1:0:0:0: Attempting to abort cmd ffff8101b1cdf880: 0x28 0x0 0x0
> > > > 0xbc 0x0 0x3f 0x0 0x0 0x8 0x0
> > > 
> > > Hmm, that message doesn't appear in the current kernel driver.
> > > 
> > > Is this a non-standard kernel or non-standard aic79xx driver?
> > 
> > Just reproduced the exact same message with a vanilla 2.6.13.2.
> > Checking the just-untarred sources, it _is_ in aix79xx_osm.c, in
> > ahd_linux_abort.  You must have typoed "Attempting" in your grep :-)
> 
> Oh .. apparently that message got removed between 2.6.13 and current git
> head.
> 
> Is there any chance you could try this with the latest git snapshot and
> post all the messages from the time the aic79xx is detected to the time
> this message appears ... what I'm trying to ascertain is if anything
> went wrong in negotiating with the device (2.6.13 unfortunately is a bit
> terse on the negotiation messages ... git head will be slightly more
> verbose).

Ok, for git HEAD 95001ee9256df846e374f116c92ca8e0beec1527.  The system
has the nice idea not to crash at the end, so I can fish everything
out of /var/log/messages (kernel messages only):

Sep 28 20:21:14 m82 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep 28 20:21:14 m82 kernel: Bootdata ok (command line is ro root=/dev/sda1 rhgb)
Sep 28 20:21:14 m82 kernel: Linux version 2.6.14-rc2-g95001ee9 (galibert@m82.limsi.fr) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)) #1 SMP Wed Sep 28 20:12:23 CEST 2005
Sep 28 20:21:14 m82 kernel: BIOS-provided physical RAM map:
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 0000000000000000 - 000000000009b400 (usable)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000bff70000 - 00000000bff78000 (ACPI data)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000bff78000 - 00000000bff80000 (ACPI NVS)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
Sep 28 20:21:14 m82 kernel:  BIOS-e820: 0000000100000000 - 00000001c0000000 (usable)
Sep 28 20:21:14 m82 kernel: No NUMA configuration found
Sep 28 20:21:14 m82 kernel: Faking a node at 0000000000000000-00000001c0000000
Sep 28 20:21:14 m82 kernel: Bootmem setup node 0 0000000000000000-00000001c0000000
Sep 28 20:21:14 m82 kernel: ACPI: PM-Timer IO Port: 0x1008
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Sep 28 20:21:14 m82 kernel: Processor #0 15:4 APIC version 20
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Sep 28 20:21:14 m82 kernel: Processor #6 15:4 APIC version 20
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Sep 28 20:21:14 m82 kernel: Processor #1 15:4 APIC version 20
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Sep 28 20:21:14 m82 kernel: Processor #7 15:4 APIC version 20
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Sep 28 20:21:14 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Sep 28 20:21:15 m82 kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Sep 28 20:21:15 m82 kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Sep 28 20:21:15 m82 kernel: ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
Sep 28 20:21:15 m82 kernel: IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
Sep 28 20:21:15 m82 kernel: ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
Sep 28 20:21:15 m82 kernel: IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GSI 48-71
Sep 28 20:21:15 m82 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Sep 28 20:21:15 m82 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Sep 28 20:21:15 m82 kernel: Setting APIC routing to flat
Sep 28 20:21:15 m82 kernel: Using ACPI (MADT) for SMP configuration information
Sep 28 20:21:15 m82 kernel: Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
Sep 28 20:21:15 m82 kernel: Checking aperture...
Sep 28 20:21:15 m82 kernel: Built 1 zonelists
Sep 28 20:21:15 m82 kernel: Kernel command line: ro root=/dev/sda1 rhgb
Sep 28 20:21:15 m82 kernel: Initializing CPU#0
Sep 28 20:21:15 m82 kernel: PID hash table entries: 4096 (order: 12, 131072 bytes)
Sep 28 20:21:15 m82 kernel: time.c: Using 3.579545 MHz PM timer.
Sep 28 20:21:15 m82 kernel: time.c: Detected 3400.281 MHz processor.
Sep 28 20:21:15 m82 kernel: Console: colour VGA+ 80x25
Sep 28 20:21:15 m82 kernel: Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Sep 28 20:21:15 m82 kernel: Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Sep 28 20:21:15 m82 kernel: Placing software IO TLB between 0x7e5d000 - 0xbe5d000
Sep 28 20:21:15 m82 kernel: Memory: 6105160k/7340032k available (3441k kernel code, 185316k reserved, 2051k data, 224k init)
Sep 28 20:21:15 m82 kernel: Calibrating delay using timer specific routine.. 6806.63 BogoMIPS (lpj=3403318)
Sep 28 20:21:15 m82 kernel: Mount-cache hash table entries: 256
Sep 28 20:21:15 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Sep 28 20:21:15 m82 kernel: CPU: L2 cache: 2048K
Sep 28 20:21:15 m82 kernel: using mwait in idle threads.
Sep 28 20:21:15 m82 kernel: CPU: Physical Processor ID: 0
Sep 28 20:21:15 m82 kernel: CPU0: Thermal monitoring enabled (TM1)
Sep 28 20:21:15 m82 kernel: mtrr: v2.0 (20020519)
Sep 28 20:21:15 m82 kernel: Using local APIC timer interrupts.
Sep 28 20:21:15 m82 kernel: Detected 12.500 MHz APIC timer.
Sep 28 20:21:15 m82 kernel: Booting processor 1/4 APIC 0x6
Sep 28 20:21:15 m82 kernel: Initializing CPU#1
Sep 28 20:21:15 m82 kernel: Calibrating delay using timer specific routine.. 6804.23 BogoMIPS (lpj=3402116)
Sep 28 20:21:15 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Sep 28 20:21:15 m82 kernel: CPU: L2 cache: 2048K
Sep 28 20:21:15 m82 kernel: CPU: Physical Processor ID: 3
Sep 28 20:21:15 m82 kernel: CPU1: Thermal monitoring enabled (TM1)
Sep 28 20:21:15 m82 kernel:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Sep 28 20:21:15 m82 kernel: CPU 1: Syncing TSC to CPU 0.
Sep 28 20:21:15 m82 kernel: CPU 1: synchronized TSC with CPU 0 (last diff -13 cycles, maxerr 1581 cycles)
Sep 28 20:21:15 m82 kernel: Booting processor 2/4 APIC 0x1
Sep 28 20:21:15 m82 kernel: Initializing CPU#2
Sep 28 20:21:15 m82 kernel: Calibrating delay using timer specific routine.. 6799.27 BogoMIPS (lpj=3399639)
Sep 28 20:21:15 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Sep 28 20:21:15 m82 kernel: CPU: L2 cache: 2048K
Sep 28 20:21:15 m82 kernel: CPU: Physical Processor ID: 0
Sep 28 20:21:15 m82 kernel: CPU2: Thermal monitoring enabled (TM1)
Sep 28 20:21:15 m82 kernel:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Sep 28 20:21:15 m82 kernel: CPU 2: Syncing TSC to CPU 0.
Sep 28 20:21:15 m82 kernel: CPU 2: synchronized TSC with CPU 0 (last diff -20 cycles, maxerr 859 cycles)
Sep 28 20:21:15 m82 kernel: Booting processor 3/4 APIC 0x7
Sep 28 20:21:15 m82 kernel: Initializing CPU#3
Sep 28 20:21:15 m82 kernel: Calibrating delay using timer specific routine.. 6799.42 BogoMIPS (lpj=3399713)
Sep 28 20:21:15 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Sep 28 20:21:15 m82 kernel: CPU: L2 cache: 2048K
Sep 28 20:21:15 m82 kernel: CPU: Physical Processor ID: 3
Sep 28 20:21:15 m82 kernel: CPU3: Thermal monitoring enabled (TM1)
Sep 28 20:21:15 m82 kernel:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Sep 28 20:21:15 m82 kernel: CPU 3: Syncing TSC to CPU 0.
Sep 28 20:21:15 m82 kernel: CPU 3: synchronized TSC with CPU 0 (last diff 64 cycles, maxerr 1589 cycles)
Sep 28 20:21:15 m82 kernel: Brought up 4 CPUs
Sep 28 20:21:15 m82 kernel: time.c: Using PIT/TSC based timekeeping.
Sep 28 20:21:15 m82 kernel: testing NMI watchdog ... OK.
Sep 28 20:21:15 m82 kernel: NET: Registered protocol family 16
Sep 28 20:21:15 m82 kernel: ACPI: bus type pci registered
Sep 28 20:21:15 m82 kernel: PCI: Using configuration type 1
Sep 28 20:21:15 m82 kernel: PCI: Using MMCONFIG at e0000000
Sep 28 20:21:15 m82 kernel: ACPI: Subsystem revision 20050902
Sep 28 20:21:15 m82 kernel: ACPI: Interpreter enabled
Sep 28 20:21:15 m82 kernel: ACPI: Using IOAPIC for interrupt routing
Sep 28 20:21:15 m82 kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Sep 28 20:21:15 m82 kernel: PCI: Probing PCI hardware (bus 00)
Sep 28 20:21:15 m82 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Sep 28 20:21:15 m82 kernel: PCI: PXH quirk detected, disabling MSI for SHPC device
Sep 28 20:21:15 m82 kernel: PCI: PXH quirk detected, disabling MSI for SHPC device
Sep 28 20:21:15 m82 kernel: PCI: Transparent bridge - 0000:00:1e.0
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 14 15)
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Sep 28 20:21:16 m82 kernel: ACPI: Device [PRT] status [0000000c]: functional but not present; setting present
Sep 28 20:21:16 m82 kernel: SCSI subsystem initialized
Sep 28 20:21:16 m82 kernel: usbcore: registered new driver usbfs
Sep 28 20:21:16 m82 kernel: usbcore: registered new driver hub
Sep 28 20:21:16 m82 kernel: PCI: Using ACPI for IRQ routing
Sep 28 20:21:16 m82 kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Sep 28 20:21:16 m82 kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Sep 28 20:21:16 m82 kernel: PCI: Bridge: 0000:01:00.0
Sep 28 20:21:16 m82 kernel:   IO window: 2000-2fff
Sep 28 20:21:16 m82 kernel:   MEM window: dd200000-dd2fffff
Sep 28 20:21:16 m82 kernel:   PREFETCH window: c2000000-c20fffff
Sep 28 20:21:16 m82 kernel: PCI: Bridge: 0000:01:00.2
Sep 28 20:21:16 m82 kernel:   IO window: 3000-3fff
Sep 28 20:21:16 m82 kernel:   MEM window: dd300000-dd3fffff
Sep 28 20:21:16 m82 kernel:   PREFETCH window: disabled.
Sep 28 20:21:16 m82 kernel: PCI: Bridge: 0000:00:02.0
Sep 28 20:21:16 m82 kernel:   IO window: 2000-3fff
Sep 28 20:21:16 m82 kernel:   MEM window: dd100000-dd3fffff
Sep 28 20:21:16 m82 kernel:   PREFETCH window: c2000000-c20fffff
Sep 28 20:21:16 m82 kernel: PCI: Bridge: 0000:00:04.0
Sep 28 20:21:16 m82 kernel:   IO window: disabled.
Sep 28 20:21:16 m82 kernel:   MEM window: disabled.
Sep 28 20:21:16 m82 kernel:   PREFETCH window: disabled.
Sep 28 20:21:16 m82 kernel: PCI: Bridge: 0000:00:06.0
Sep 28 20:21:16 m82 kernel:   IO window: disabled.
Sep 28 20:21:16 m82 kernel:   MEM window: disabled.
Sep 28 20:21:16 m82 kernel:   PREFETCH window: disabled.
Sep 28 20:21:16 m82 kernel: PCI: Bridge: 0000:00:1e.0
Sep 28 20:21:16 m82 kernel:   IO window: 4000-4fff
Sep 28 20:21:16 m82 kernel:   MEM window: dd400000-deffffff
Sep 28 20:21:16 m82 kernel:   PREFETCH window: c2100000-c21fffff
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:16 m82 kernel: Simple Boot Flag at 0x39 set to 0x1
Sep 28 20:21:16 m82 kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Sep 28 20:21:16 m82 kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Sep 28 20:21:16 m82 kernel: audit: initializing netlink socket (disabled)
Sep 28 20:21:16 m82 kernel: audit(1127931611.535:1): initialized
Sep 28 20:21:16 m82 kernel: Total HugeTLB memory allocated, 0
Sep 28 20:21:16 m82 kernel: VFS: Disk quotas dquot_6.5.1
Sep 28 20:21:16 m82 kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Sep 28 20:21:16 m82 kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Sep 28 20:21:16 m82 kernel: Initializing Cryptographic API
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:16 m82 kernel: ACPI: Power Button (FF) [PWRF]
Sep 28 20:21:16 m82 kernel: ACPI: Power Button (CM) [PWRB]
Sep 28 20:21:16 m82 kernel: ACPI: CPU0 (power states: C1[C1])
Sep 28 20:21:16 m82 kernel: ACPI: CPU1 (power states: C1[C1])
Sep 28 20:21:16 m82 kernel: ACPI: CPU2 (power states: C1[C1])
Sep 28 20:21:16 m82 kernel: ACPI: CPU3 (power states: C1[C1])
Sep 28 20:21:16 m82 kernel: Real Time Clock Driver v1.12
Sep 28 20:21:16 m82 kernel: hw_random: RNG not detected
Sep 28 20:21:16 m82 kernel: Linux agpgart interface v0.101 (c) Dave Jones
Sep 28 20:21:16 m82 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 28 20:21:16 m82 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep 28 20:21:16 m82 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
Sep 28 20:21:16 m82 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep 28 20:21:16 m82 kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep 28 20:21:16 m82 kernel: io scheduler noop registered
Sep 28 20:21:16 m82 kernel: io scheduler anticipatory registered
Sep 28 20:21:16 m82 kernel: io scheduler deadline registered
Sep 28 20:21:16 m82 kernel: io scheduler cfq registered
Sep 28 20:21:16 m82 kernel: Floppy drive(s): fd0 is 1.44M
Sep 28 20:21:16 m82 kernel: FDC 0 is a National Semiconductor PC87306
Sep 28 20:21:16 m82 kernel: loop: loaded (max 8 devices)
Sep 28 20:21:16 m82 kernel: Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
Sep 28 20:21:16 m82 kernel: Copyright (c) 1999-2005 Intel Corporation.
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 54 (level, low) -> IRQ 177
Sep 28 20:21:16 m82 kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 55 (level, low) -> IRQ 185
Sep 28 20:21:16 m82 kernel: e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Sep 28 20:21:16 m82 kernel: tun: Universal TUN/TAP device driver, 1.6
Sep 28 20:21:16 m82 kernel: tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Sep 28 20:21:16 m82 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep 28 20:21:16 m82 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 28 20:21:16 m82 kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
Sep 28 20:21:16 m82 kernel: ICH5: chipset revision 2
Sep 28 20:21:16 m82 kernel: ICH5: not 100% native mode: will probe irqs later
Sep 28 20:21:16 m82 kernel:     ide0: BM-DMA at 0x14a0-0x14a7, BIOS settings: hda:pio, hdb:pio
Sep 28 20:21:16 m82 kernel:     ide1: BM-DMA at 0x14a8-0x14af, BIOS settings: hdc:pio, hdd:DMA
Sep 28 20:21:16 m82 kernel: hdd: MATSHITADVD-ROM SR-8178, ATAPI CD/DVD-ROM drive
Sep 28 20:21:16 m82 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 28 20:21:16 m82 kernel: hdd: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Sep 28 20:21:16 m82 kernel: Uniform CD-ROM driver Revision: 3.20
Sep 28 20:21:16 m82 kernel: ide-floppy driver 0.99.newide
Sep 28 20:21:16 m82 kernel: ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 32 (level, low) -> IRQ 201
Sep 28 20:21:16 m82 kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
Sep 28 20:21:16 m82 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Sep 28 20:21:16 m82 kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Sep 28 20:21:16 m82 kernel: 
Sep 28 20:21:16 m82 kernel:   Vendor: SEAGATE   Model: ST373207LC        Rev: 0003
Sep 28 20:21:16 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 28 20:21:17 m82 kernel:  target0:0:0: asynchronous.
Sep 28 20:21:17 m82 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
Sep 28 20:21:17 m82 kernel:  target0:0:0: Beginning Domain Validation
Sep 28 20:21:17 m82 kernel:  target0:0:0: wide asynchronous.
Sep 28 20:21:17 m82 kernel:  target0:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI WRFLOW PCOMP (6.25 ns, offset 63)
Sep 28 20:21:17 m82 kernel:  target0:0:0: Ending Domain Validation
Sep 28 20:21:17 m82 kernel:   Vendor: SUPER     Model: GEM318            Rev: 0   
Sep 28 20:21:17 m82 kernel:   Type:   Processor                          ANSI SCSI revision: 02
Sep 28 20:21:17 m82 kernel:  target0:0:6: asynchronous.
Sep 28 20:21:17 m82 kernel:  target0:0:6: Beginning Domain Validation
Sep 28 20:21:17 m82 kernel:  target0:0:6: Ending Domain Validation
Sep 28 20:21:17 m82 kernel: ACPI: PCI Interrupt 0000:02:02.1[B] -> GSI 33 (level, low) -> IRQ 209
Sep 28 20:21:17 m82 kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
Sep 28 20:21:17 m82 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Sep 28 20:21:17 m82 kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Sep 28 20:21:17 m82 kernel: 
Sep 28 20:21:17 m82 kernel:   Vendor: VP-1252-  Model: FB951223-VOL#00   Rev: R001
Sep 28 20:21:17 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 28 20:21:17 m82 kernel:  target1:0:0: asynchronous.
Sep 28 20:21:17 m82 kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 4
Sep 28 20:21:17 m82 kernel:  target1:0:0: Beginning Domain Validation
Sep 28 20:21:17 m82 kernel:  target1:0:0: wide asynchronous.
Sep 28 20:21:17 m82 kernel:  target1:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI WRFLOW PCOMP (6.25 ns, offset 127)
Sep 28 20:21:17 m82 kernel:  target1:0:0: Ending Domain Validation
Sep 28 20:21:17 m82 kernel:   Vendor: VP-1252-  Model: FB951223-VOL#01   Rev: R001
Sep 28 20:21:17 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Sep 28 20:21:17 m82 kernel: scsi1:A:0:1: Tagged Queuing enabled.  Depth 4
Sep 28 20:21:17 m82 kernel: st: Version 20050830, fixed bufsize 32768, s/g segs 256
Sep 28 20:21:17 m82 kernel: SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Sep 28 20:21:17 m82 kernel: SCSI device sda: drive cache: write back
Sep 28 20:21:17 m82 kernel: SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Sep 28 20:21:17 m82 kernel: SCSI device sda: drive cache: write back
Sep 28 20:21:17 m82 kernel:  sda: sda1 sda2 sda3 sda4
Sep 28 20:21:17 m82 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Sep 28 20:21:17 m82 kernel: SCSI device sdb: 3906247680 512-byte hdwr sectors (1999999 MB)
Sep 28 20:21:18 m82 kernel: SCSI device sdb: drive cache: write back
Sep 28 20:21:18 m82 kernel: SCSI device sdb: 3906247680 512-byte hdwr sectors (1999999 MB)
Sep 28 20:21:18 m82 kernel: SCSI device sdb: drive cache: write back
Sep 28 20:21:18 m82 kernel:  sdb: sdb1
Sep 28 20:21:19 m82 kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Sep 28 20:21:19 m82 kernel: SCSI device sdc: 3906242560 512-byte hdwr sectors (1999996 MB)
Sep 28 20:21:19 m82 kernel: SCSI device sdc: drive cache: write back
Sep 28 20:21:19 m82 kernel: SCSI device sdc: 3906242560 512-byte hdwr sectors (1999996 MB)
Sep 28 20:21:19 m82 kernel: SCSI device sdc: drive cache: write back
Sep 28 20:21:19 m82 kernel:  sdc: sdc1
Sep 28 20:21:19 m82 kernel: Attached scsi disk sdc at scsi1, channel 0, id 0, lun 1
Sep 28 20:21:19 m82 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Sep 28 20:21:19 m82 kernel: Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 3
Sep 28 20:21:19 m82 kernel: Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Sep 28 20:21:19 m82 kernel: Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 1,  type 0
Sep 28 20:21:19 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 217
Sep 28 20:21:19 m82 kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Sep 28 20:21:19 m82 kernel: ehci_hcd 0000:00:1d.7: debug port 1
Sep 28 20:21:19 m82 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Sep 28 20:21:19 m82 kernel: ehci_hcd 0000:00:1d.7: irq 217, io mem 0xdd000000
Sep 28 20:21:19 m82 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Sep 28 20:21:19 m82 kernel: hub 1-0:1.0: USB hub found
Sep 28 20:21:19 m82 kernel: hub 1-0:1.0: 8 ports detected
Sep 28 20:21:19 m82 kernel: USB Universal Host Controller Interface driver v2.3
Sep 28 20:21:19 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.0: irq 169, io base 0x00001400
Sep 28 20:21:19 m82 kernel: hub 2-0:1.0: USB hub found
Sep 28 20:21:19 m82 kernel: hub 2-0:1.0: 2 ports detected
Sep 28 20:21:19 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 225
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.1: irq 225, io base 0x00001420
Sep 28 20:21:19 m82 kernel: hub 3-0:1.0: USB hub found
Sep 28 20:21:19 m82 kernel: hub 3-0:1.0: 2 ports detected
Sep 28 20:21:19 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 193
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.2: irq 193, io base 0x00001440
Sep 28 20:21:19 m82 kernel: hub 4-0:1.0: USB hub found
Sep 28 20:21:19 m82 kernel: hub 4-0:1.0: 2 ports detected
Sep 28 20:21:19 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Sep 28 20:21:19 m82 kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00001460
Sep 28 20:21:19 m82 kernel: hub 5-0:1.0: USB hub found
Sep 28 20:21:19 m82 kernel: hub 5-0:1.0: 2 ports detected
Sep 28 20:21:19 m82 kernel: Initializing USB Mass Storage driver...
Sep 28 20:21:19 m82 kernel: usbcore: registered new driver usb-storage
Sep 28 20:21:19 m82 kernel: USB Mass Storage support registered.
Sep 28 20:21:19 m82 kernel: usbcore: registered new driver hiddev
Sep 28 20:21:19 m82 kernel: usbcore: registered new driver usbhid
Sep 28 20:21:19 m82 kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Sep 28 20:21:20 m82 kernel: mice: PS/2 mouse device common for all mice
Sep 28 20:21:20 m82 kernel: i2c /dev entries driver
Sep 28 20:21:20 m82 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Sep 28 20:21:20 m82 kernel: i2c_adapter i2c-0: Unsupported chip (man_id=0x01, chip_id=0x73).
Sep 28 20:21:20 m82 kernel: i2c_adapter i2c-0: detect fail: address match, 0x2e
Sep 28 20:21:20 m82 kernel: hdaps: supported laptop not found!
Sep 28 20:21:20 m82 kernel: hdaps: driver init failed (ret=-6)!
Sep 28 20:21:20 m82 kernel: Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6eb1, caps: 0xa84793/0x554755
Sep 28 20:21:20 m82 kernel: serio: Synaptics pass-through port at isa0060/serio1/input0
Sep 28 20:21:20 m82 kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Sep 28 20:21:20 m82 kernel: pc87360: PC8736x not detected, module not inserted.
Sep 28 20:21:20 m82 kernel: NET: Registered protocol family 2
Sep 28 20:21:20 m82 kernel: IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Sep 28 20:21:20 m82 kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Sep 28 20:21:20 m82 kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Sep 28 20:21:20 m82 kernel: TCP: Hash tables configured (established 262144 bind 65536)
Sep 28 20:21:20 m82 kernel: TCP reno registered
Sep 28 20:21:20 m82 kernel: ip_conntrack version 2.3 (8192 buckets, 65536 max) - 344 bytes per conntrack
Sep 28 20:21:20 m82 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Sep 28 20:21:20 m82 kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Sep 28 20:21:20 m82 kernel: ClusterIP Version 0.8 loaded successfully
Sep 28 20:21:20 m82 kernel: arp_tables: (C) 2002 David S. Miller
Sep 28 20:21:20 m82 kernel: TCP bic registered
Sep 28 20:21:20 m82 kernel: Initializing IPsec netlink socket
Sep 28 20:21:20 m82 kernel: NET: Registered protocol family 1
Sep 28 20:21:20 m82 kernel: NET: Registered protocol family 17
Sep 28 20:21:20 m82 kernel: NET: Registered protocol family 15
Sep 28 20:21:20 m82 kernel: ReiserFS: sda1: found reiserfs format "3.6" with standard journal
Sep 28 20:21:20 m82 kernel: ReiserFS: sda1: using ordered data mode
Sep 28 20:21:20 m82 kernel: ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep 28 20:21:20 m82 kernel: ReiserFS: sda1: checking transaction log (sda1)
Sep 28 20:21:20 m82 kernel: ReiserFS: sda1: Using r5 hash to sort names
Sep 28 20:21:20 m82 kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Sep 28 20:21:20 m82 kernel: Freeing unused kernel memory: 224k freed
Sep 28 20:21:20 m82 kernel: kmodule[1374]: segfault at ffffffffffffffff rip 0000003257d70313 rsp 00007fffff93d638 error 4
Sep 28 20:21:20 m82 kernel: ReiserFS: sda4: found reiserfs format "3.6" with standard journal
Sep 28 20:21:20 m82 kernel: ReiserFS: sda4: using ordered data mode
Sep 28 20:21:20 m82 kernel: ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep 28 20:21:20 m82 kernel: ReiserFS: sda4: checking transaction log (sda4)
Sep 28 20:21:20 m82 kernel: ReiserFS: sda4: Using r5 hash to sort names
Sep 28 20:21:20 m82 kernel: ReiserFS: sda2: found reiserfs format "3.6" with standard journal
Sep 28 20:21:20 m82 kernel: ReiserFS: sda2: using ordered data mode
Sep 28 20:21:20 m82 kernel: ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Sep 28 20:21:20 m82 kernel: ReiserFS: sda2: checking transaction log (sda2)
Sep 28 20:21:20 m82 kernel: ReiserFS: sda2: Using r5 hash to sort names
Sep 28 20:21:20 m82 kernel: Adding 1959920k swap on /dev/sda3.  Priority:-1 extents:1 across:1959920k
Sep 28 20:21:20 m82 kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
Sep 28 20:26:11 m82 kernel: ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
Sep 28 20:26:42 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x28 0x0 0xf 0xdc 0x0 0x3f 0x0 0x0 0x8 0x0
Sep 28 20:26:42 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Sep 28 20:26:42 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 28 20:26:42 m82 kernel: scsi1: Dumping Card State at program address 0x26 Mode 0x22
Sep 28 20:26:42 m82 kernel: Card was paused
Sep 28 20:26:42 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Sep 28 20:26:42 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
Sep 28 20:26:42 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
Sep 28 20:26:42 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
Sep 28 20:26:42 m82 kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
Sep 28 20:26:42 m82 kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
Sep 28 20:26:42 m82 kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 
Sep 28 20:26:42 m82 kernel: 
Sep 28 20:26:42 m82 kernel: SCB Count = 4 CMDS_PENDING = 4 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xffc0
Sep 28 20:26:42 m82 kernel: qinstart = 1108 qinfifonext = 1108
Sep 28 20:26:42 m82 kernel: QINFIFO:
Sep 28 20:26:42 m82 kernel: WAITING_TID_QUEUES:
Sep 28 20:26:42 m82 kernel:        0 ( 0x1 0x3 )
Sep 28 20:26:42 m82 kernel: Pending list:
Sep 28 20:26:42 m82 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:43 m82 kernel:   1 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:43 m82 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:43 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:43 m82 kernel: Total 4
Sep 28 20:26:43 m82 kernel: Kernel Free SCB list: 
Sep 28 20:26:43 m82 kernel: Sequencer Complete DMA-inprog list: 
Sep 28 20:26:43 m82 kernel: Sequencer Complete list: 
Sep 28 20:26:43 m82 kernel: Sequencer DMA-Up and Complete list: 
Sep 28 20:26:43 m82 kernel: 
Sep 28 20:26:43 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x3
Sep 28 20:26:43 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:26:43 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:26:43 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:26:43 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:26:43 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Sep 28 20:26:43 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:26:43 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:26:43 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:26:43 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:26:43 m82 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Sep 28 20:26:43 m82 kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
Sep 28 20:26:43 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
Sep 28 20:26:43 m82 kernel: SIMODE0[0xc] 
Sep 28 20:26:43 m82 kernel: CCSCBCTL[0x4] 
Sep 28 20:26:43 m82 kernel: scsi1: REG0 == 0x3, SINDEX = 0x102, DINDEX = 0x102
Sep 28 20:26:43 m82 kernel: scsi1: SCBPTR == 0x1, SCB_NEXT == 0x3, SCB_NEXT2 == 0xff01
Sep 28 20:26:43 m82 kernel: CDB 28 0 f e4 0 3f
Sep 28 20:26:43 m82 kernel: STACK: 0x14 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:26:43 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 28 20:26:43 m82 kernel: scsi1:0:0:0: Cmd aborted from QINFIFO
Sep 28 20:26:43 m82 kernel: aic79xx_abort returns 0x2002
Sep 28 20:26:52 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:26:53 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Sep 28 20:26:53 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 28 20:26:53 m82 kernel: scsi1: Dumping Card State at program address 0xf Mode 0x33
Sep 28 20:26:53 m82 kernel: Card was paused
Sep 28 20:26:53 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Sep 28 20:26:53 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
Sep 28 20:26:53 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
Sep 28 20:26:53 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
Sep 28 20:26:53 m82 kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
Sep 28 20:26:53 m82 kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
Sep 28 20:26:53 m82 kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 
Sep 28 20:26:53 m82 kernel: 
Sep 28 20:26:53 m82 kernel: SCB Count = 4 CMDS_PENDING = 3 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xffc0
Sep 28 20:26:53 m82 kernel: qinstart = 1109 qinfifonext = 1109
Sep 28 20:26:53 m82 kernel: QINFIFO:
Sep 28 20:26:53 m82 kernel: WAITING_TID_QUEUES:
Sep 28 20:26:53 m82 kernel:        0 ( 0x3 )
Sep 28 20:26:53 m82 kernel: Pending list:
Sep 28 20:26:53 m82 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:53 m82 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:53 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:53 m82 kernel: Total 3
Sep 28 20:26:53 m82 kernel: Kernel Free SCB list: 1 
Sep 28 20:26:53 m82 kernel: Sequencer Complete DMA-inprog list: 
Sep 28 20:26:53 m82 kernel: Sequencer Complete list: 
Sep 28 20:26:53 m82 kernel: Sequencer DMA-Up and Complete list: 
Sep 28 20:26:53 m82 kernel: 
Sep 28 20:26:53 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x3
Sep 28 20:26:53 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:26:53 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:26:53 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:26:53 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:26:53 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Sep 28 20:26:53 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:26:53 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:26:53 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:26:53 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:26:53 m82 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Sep 28 20:26:53 m82 kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
Sep 28 20:26:53 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
Sep 28 20:26:53 m82 kernel: SIMODE0[0xc] 
Sep 28 20:26:53 m82 kernel: CCSCBCTL[0x4] 
Sep 28 20:26:53 m82 kernel: scsi1: REG0 == 0x2, SINDEX = 0x102, DINDEX = 0x102
Sep 28 20:26:53 m82 kernel: scsi1: SCBPTR == 0x3, SCB_NEXT == 0xffc0, SCB_NEXT2 == 0xff01
Sep 28 20:26:53 m82 kernel: CDB 0 0 0 0 0 0
Sep 28 20:26:53 m82 kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:26:53 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 28 20:26:53 m82 kernel: scsi1:0:0:0: Cmd aborted from QINFIFO
Sep 28 20:26:53 m82 kernel: aic79xx_abort returns 0x2002
Sep 28 20:26:53 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x28 0x0 0xf 0xe0 0x0 0x3f 0x0 0x0 0x8 0x0
Sep 28 20:26:53 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Sep 28 20:26:53 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 28 20:26:53 m82 kernel: scsi1: Dumping Card State at program address 0x26 Mode 0x22
Sep 28 20:26:53 m82 kernel: Card was paused
Sep 28 20:26:53 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Sep 28 20:26:53 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
Sep 28 20:26:53 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
Sep 28 20:26:53 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
Sep 28 20:26:53 m82 kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
Sep 28 20:26:53 m82 kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
Sep 28 20:26:53 m82 kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 
Sep 28 20:26:53 m82 kernel: 
Sep 28 20:26:53 m82 kernel: SCB Count = 4 CMDS_PENDING = 2 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xffc0
Sep 28 20:26:53 m82 kernel: qinstart = 1109 qinfifonext = 1109
Sep 28 20:26:53 m82 kernel: QINFIFO:
Sep 28 20:26:53 m82 kernel: WAITING_TID_QUEUES:
Sep 28 20:26:53 m82 kernel: Pending list:
Sep 28 20:26:53 m82 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:53 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:26:53 m82 kernel: Total 2
Sep 28 20:26:53 m82 kernel: Kernel Free SCB list: 3 1 
Sep 28 20:26:53 m82 kernel: Sequencer Complete DMA-inprog list: 
Sep 28 20:26:53 m82 kernel: Sequencer Complete list: 
Sep 28 20:26:53 m82 kernel: Sequencer DMA-Up and Complete list: 
Sep 28 20:26:53 m82 kernel: 
Sep 28 20:26:53 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x3
Sep 28 20:26:53 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:26:53 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:26:53 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:26:53 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:26:53 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Sep 28 20:26:53 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:26:53 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:26:53 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:26:53 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:26:53 m82 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Sep 28 20:26:53 m82 kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
Sep 28 20:26:53 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
Sep 28 20:26:53 m82 kernel: SIMODE0[0xc] 
Sep 28 20:26:53 m82 kernel: CCSCBCTL[0x4] 
Sep 28 20:26:53 m82 kernel: scsi1: REG0 == 0x3, SINDEX = 0x102, DINDEX = 0x102
Sep 28 20:26:53 m82 kernel: scsi1: SCBPTR == 0xff00, SCB_NEXT == 0xff00, SCB_NEXT2 == 0x0
Sep 28 20:26:53 m82 kernel: CDB 0 1 0 0 0 0
Sep 28 20:26:53 m82 kernel: STACK: 0x14 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:26:53 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 28 20:26:53 m82 kernel: (scsi1:A:0:0): Device is disconnected, re-queuing SCB
Sep 28 20:26:53 m82 kernel: Recovery code sleeping
Sep 28 20:26:58 m82 kernel: Recovery code awake
Sep 28 20:26:58 m82 kernel: Timer Expired
Sep 28 20:26:58 m82 kernel: aic79xx_abort returns 0x2003
Sep 28 20:26:58 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x28 0x0 0xf 0xe4 0x0 0x3f 0x0 0x0 0x8 0x0
Sep 28 20:26:58 m82 kernel: scsi1:0:0:0: Command not found
Sep 28 20:26:58 m82 kernel: aic79xx_abort returns 0x2002
Sep 28 20:27:08 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:27:08 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Sep 28 20:27:08 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 28 20:27:08 m82 kernel: scsi1: Dumping Card State at program address 0xc Mode 0x33
Sep 28 20:27:08 m82 kernel: Card was paused
Sep 28 20:27:08 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Sep 28 20:27:08 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
Sep 28 20:27:08 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
Sep 28 20:27:08 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
Sep 28 20:27:08 m82 kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
Sep 28 20:27:08 m82 kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
Sep 28 20:27:08 m82 kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 
Sep 28 20:27:08 m82 kernel: 
Sep 28 20:27:08 m82 kernel: SCB Count = 4 CMDS_PENDING = 3 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xffc0
Sep 28 20:27:08 m82 kernel: qinstart = 1111 qinfifonext = 1111
Sep 28 20:27:08 m82 kernel: QINFIFO:
Sep 28 20:27:08 m82 kernel: WAITING_TID_QUEUES:
Sep 28 20:27:08 m82 kernel:        0 ( 0x0 0x3 )
Sep 28 20:27:08 m82 kernel: Pending list:
Sep 28 20:27:08 m82 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:27:08 m82 kernel:   0 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:27:08 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:27:08 m82 kernel: Total 3
Sep 28 20:27:08 m82 kernel: Kernel Free SCB list: 1 
Sep 28 20:27:08 m82 kernel: Sequencer Complete DMA-inprog list: 
Sep 28 20:27:08 m82 kernel: Sequencer Complete list: 
Sep 28 20:27:08 m82 kernel: Sequencer DMA-Up and Complete list: 
Sep 28 20:27:08 m82 kernel: 
Sep 28 20:27:08 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x3
Sep 28 20:27:08 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:27:08 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:27:08 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:27:08 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:27:08 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Sep 28 20:27:08 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:27:08 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:27:08 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:27:08 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:27:08 m82 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Sep 28 20:27:08 m82 kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
Sep 28 20:27:08 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
Sep 28 20:27:08 m82 kernel: SIMODE0[0xc] 
Sep 28 20:27:08 m82 kernel: CCSCBCTL[0x4] 
Sep 28 20:27:08 m82 kernel: scsi1: REG0 == 0x2, SINDEX = 0x102, DINDEX = 0x102
Sep 28 20:27:08 m82 kernel: scsi1: SCBPTR == 0x3, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xff04
Sep 28 20:27:08 m82 kernel: CDB 0 0 0 0 0 0
Sep 28 20:27:08 m82 kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:27:08 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 28 20:27:08 m82 kernel: Recovery SCB completes
Sep 28 20:27:08 m82 kernel: scsi1:0:0:0: Cmd aborted from QINFIFO
Sep 28 20:27:08 m82 kernel: aic79xx_abort returns 0x2002
Sep 28 20:27:08 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x28 0x0 0xf 0xe8 0x0 0x3f 0x0 0x0 0x8 0x0
Sep 28 20:27:08 m82 kernel: scsi1:0:0:0: Command not found
Sep 28 20:27:08 m82 kernel: aic79xx_abort returns 0x2002
Sep 28 20:27:18 m82 kernel: scsi1:0:0:0: Attempting to queue an ABORT message:CDB: 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:27:18 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Sep 28 20:27:18 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 28 20:27:18 m82 kernel: scsi1: Dumping Card State at program address 0xc Mode 0x33
Sep 28 20:27:18 m82 kernel: Card was paused
Sep 28 20:27:18 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Sep 28 20:27:18 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
Sep 28 20:27:18 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
Sep 28 20:27:18 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
Sep 28 20:27:18 m82 kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
Sep 28 20:27:18 m82 kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
Sep 28 20:27:18 m82 kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 
Sep 28 20:27:18 m82 kernel: 
Sep 28 20:27:18 m82 kernel: SCB Count = 4 CMDS_PENDING = 2 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xffc0
Sep 28 20:27:18 m82 kernel: qinstart = 1112 qinfifonext = 1112
Sep 28 20:27:18 m82 kernel: QINFIFO:
Sep 28 20:27:18 m82 kernel: WAITING_TID_QUEUES:
Sep 28 20:27:18 m82 kernel:        0 ( 0x3 )
Sep 28 20:27:18 m82 kernel: Pending list:
Sep 28 20:27:18 m82 kernel:   3 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:27:18 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:27:18 m82 kernel: Total 2
Sep 28 20:27:18 m82 kernel: Kernel Free SCB list: 0 1 
Sep 28 20:27:18 m82 kernel: Sequencer Complete DMA-inprog list: 
Sep 28 20:27:18 m82 kernel: Sequencer Complete list: 
Sep 28 20:27:18 m82 kernel: Sequencer DMA-Up and Complete list: 
Sep 28 20:27:18 m82 kernel: 
Sep 28 20:27:18 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x3
Sep 28 20:27:18 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:27:18 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:27:18 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:27:18 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:27:18 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Sep 28 20:27:18 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:27:18 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:27:18 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:27:18 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:27:18 m82 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Sep 28 20:27:18 m82 kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
Sep 28 20:27:18 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
Sep 28 20:27:18 m82 kernel: SIMODE0[0xc] 
Sep 28 20:27:18 m82 kernel: CCSCBCTL[0x4] 
Sep 28 20:27:18 m82 kernel: scsi1: REG0 == 0x2, SINDEX = 0x102, DINDEX = 0x102
Sep 28 20:27:18 m82 kernel: scsi1: SCBPTR == 0x3, SCB_NEXT == 0xffc0, SCB_NEXT2 == 0xff01
Sep 28 20:27:18 m82 kernel: CDB 0 0 0 0 0 0
Sep 28 20:27:18 m82 kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:27:18 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 28 20:27:18 m82 kernel: scsi1:0:0:0: Cmd aborted from QINFIFO
Sep 28 20:27:18 m82 kernel: aic79xx_abort returns 0x2002
Sep 28 20:27:18 m82 kernel: scsi1:0:0:0: Attempting to queue a TARGET RESET message:CDB: 0x28 0x0 0xf 0xdc 0x0 0x3f 0x0 0x0 0x8 0x0
Sep 28 20:27:18 m82 kernel: Infinite interrupt loop, INTSTAT = 0scsi1: At time of recovery, card was not paused
Sep 28 20:27:18 m82 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 28 20:27:18 m82 kernel: scsi1: Dumping Card State at program address 0x26 Mode 0x22
Sep 28 20:27:18 m82 kernel: Card was paused
Sep 28 20:27:18 m82 kernel: HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
Sep 28 20:27:18 m82 kernel: DFFSTAT[0x33] SCSISIGI[0x24] SCSIPHASE[0x0] SCSIBUS[0x0] 
Sep 28 20:27:18 m82 kernel: LASTPHASE[0x1] SCSISEQ0[0x40] SCSISEQ1[0x12] SEQCTL0[0x0] 
Sep 28 20:27:18 m82 kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x10] 
Sep 28 20:27:18 m82 kernel: SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0xc0] 
Sep 28 20:27:18 m82 kernel: SIMODE1[0xac] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80] 
Sep 28 20:27:18 m82 kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0x40] 
Sep 28 20:27:19 m82 kernel: 
Sep 28 20:27:19 m82 kernel: SCB Count = 4 CMDS_PENDING = 1 LASTSCB 0x1 CURRSCB 0x1 NEXTSCB 0xffc0
Sep 28 20:27:19 m82 kernel: qinstart = 1112 qinfifonext = 1112
Sep 28 20:27:19 m82 kernel: QINFIFO:
Sep 28 20:27:19 m82 kernel: WAITING_TID_QUEUES:
Sep 28 20:27:19 m82 kernel: Pending list:
Sep 28 20:27:19 m82 kernel:   2 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Sep 28 20:27:19 m82 kernel: Total 1
Sep 28 20:27:19 m82 kernel: Kernel Free SCB list: 3 0 1 
Sep 28 20:27:19 m82 kernel: Sequencer Complete DMA-inprog list: 
Sep 28 20:27:19 m82 kernel: Sequencer Complete list: 
Sep 28 20:27:19 m82 kernel: Sequencer DMA-Up and Complete list: 
Sep 28 20:27:19 m82 kernel: 
Sep 28 20:27:19 m82 kernel: scsi1: FIFO0 Free, LONGJMP == 0x8252, SCB 0x3
Sep 28 20:27:19 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:27:19 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:27:19 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:27:19 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:27:19 m82 kernel: scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
Sep 28 20:27:19 m82 kernel: SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
Sep 28 20:27:19 m82 kernel: SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
Sep 28 20:27:19 m82 kernel: SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
Sep 28 20:27:19 m82 kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
Sep 28 20:27:19 m82 kernel: LQIN: 0x8 0x0 0x0 0x3 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
Sep 28 20:27:19 m82 kernel: scsi1: LQISTATE = 0x1, LQOSTATE = 0x1a, OPTIONMODE = 0x52
Sep 28 20:27:19 m82 kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x0
Sep 28 20:27:19 m82 kernel: SIMODE0[0xc] 
Sep 28 20:27:19 m82 kernel: CCSCBCTL[0x4] 
Sep 28 20:27:19 m82 kernel: scsi1: REG0 == 0x3, SINDEX = 0x102, DINDEX = 0x102
Sep 28 20:27:19 m82 kernel: scsi1: SCBPTR == 0xff00, SCB_NEXT == 0xff00, SCB_NEXT2 == 0x0
Sep 28 20:27:19 m82 kernel: CDB 0 1 0 0 0 0
Sep 28 20:27:19 m82 kernel: STACK: 0x14 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 28 20:27:19 m82 kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 28 20:27:19 m82 kernel: (scsi1:A:0:0): Device is disconnected, re-queuing SCB
Sep 28 20:27:19 m82 kernel: Recovery code sleeping
Sep 28 20:27:23 m82 kernel: Recovery code awake
Sep 28 20:27:23 m82 kernel: Timer Expired
Sep 28 20:27:23 m82 kernel: aic79xx_dev_reset returns 0x2003
Sep 28 20:27:23 m82 kernel: Recovery SCB completes
Sep 28 20:27:33 m82 kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
Sep 28 20:27:33 m82 kernel: sd 1:0:0:0: SCSI error: return code = 0x30000
Sep 28 20:27:33 m82 kernel: end_request: I/O error, dev sdb, sector 266338367
Sep 28 20:27:33 m82 kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 20:27:34 m82 last message repeated 84 times
Sep 28 20:27:34 m82 kernel: scsi1 (0:0):csi1 (0:0): rejecting I/O to offline device
Sep 28 20:27:34 m82 kernel: scsi1 (0:0): rejecting I/O to offline device
Sep 28 20:27:34 m82 last message repeated 2724 times
Sep 28 20:27:34 m82 kernel: ReiserFS: sdb1: warning: sh-2029: reiserfs read_bitmaps: bitmap block (#33259520) reading failed
Sep 28 20:27:34 m82 kernel: ReiserFS: sdb1: warning: jmacd-8: reiserfs_fill_super: unable to read bitmap
Sep 28 20:27:34 m82 kernel: scsi1 (0:0): rejecting I/O to offline device



