Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWAYHy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWAYHy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWAYHy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:54:57 -0500
Received: from marla.ludost.net ([194.12.255.250]:54662 "EHLO marla.ludost.net")
	by vger.kernel.org with ESMTP id S1750787AbWAYHy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:54:56 -0500
Subject: Re: kobject_register failed for Promise_Old_IDE (-17)
From: Vasil Kolev <vasil@ludost.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, frankt@promise.com, linux-ide@vger.kernel.org
In-Reply-To: <58cb370e0601241458y6cdf702ey9caa261702a7948a@mail.gmail.com>
References: <1138093728.5828.8.camel@lyra.home.ludost.net>
	 <20060124223527.GA26337@kroah.com>
	 <58cb370e0601241458y6cdf702ey9caa261702a7948a@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jQvf5QJhl26IWDRqEMdF"
Date: Wed, 25 Jan 2006 09:54:40 +0200
Message-Id: <1138175680.5857.4.camel@lyra.home.ludost.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jQvf5QJhl26IWDRqEMdF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=D0=92 =D0=B2=D1=82, 2006-01-24 =D0=B2 23:58 +0100, Bartlomiej Zolnierkiewi=
cz =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:
> On 1/24/06, Greg KH <greg@kroah.com> wrote:
> > On Tue, Jan 24, 2006 at 11:08:47AM +0200, Vasil Kolev wrote:
> > > Hello,
> > > I have a machine that's currently running 2.4.28 with the promise_old
> > > driver, which runs ok. I tried upgrading it last night to 2.6.15, and
> > > the following error occured, and no drives were detected/made availab=
le:
> > >
> > >  [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
> > >  [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
> > >  [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x=
40
> > >  [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
> > >  [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
> > >  [17179598.940000]  [__pci_register_driver+125/132] __pci_register_dr=
iver+0x7d/0x84
> > >  [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_regis=
ter_driver+0x13/0x35
> > >  [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12=
/0x16 [pdc202xx_old]
> > >  [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x=
1ae
> > >  [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb
> >
> > This means that some other driver tried to register with the same exact
> > name for the same bus.  As it looks like this is the ide bus, I suggest
> > asking on the linux ide mailing list.
>=20

Well, now I remember that in /sys in the proper place there were two
directories called Promise_Old_IDE, maybe the driver tried to register
twice?

> I don't see a way how this can happen.  There is only one driver with
> .name =3D "Promise_Old_IDE" and code dealing with driver registration
> looks more or less sane (+ hasn't been changed recently except
> .owner fixes).
>=20
> Vasil, are you using vanilla 2.6.15 without any distro etc patches?
> [ just to be 100% sure ]
>=20
Yes, plain vanilla 2.6.15.

> Could you send dmesg command output?
>=20
Here it is (the -scx1 is to help me track revisions of the configuration
I use):


 [17179569.184000] Linux version 2.6.15-scx1 (root@hades) (gcc version 3.3.=
5 (Debian 1:3.3.5-13)) #3 SMP Mon Jan 23 22:38:46 CET 2006
 [17179569.184000] BIOS-provided physical RAM map:
 [17179569.184000]  BIOS-e820: 0000000000000000 - 0000000000098c00 (usable)
 [17179569.184000]  BIOS-e820: 0000000000098c00 - 00000000000a0000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000000da000 - 00000000000dc000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 [17179569.184000]  BIOS-e820: 000000007fef0000 - 000000007feff000 (ACPI da=
ta)
 [17179569.184000]  BIOS-e820: 000000007feff000 - 000000007ff00000 (ACPI NV=
S)
 [17179569.184000]  BIOS-e820: 000000007ff00000 - 000000007ff80000 (usable)
 [17179569.184000]  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserve=
d)
 [17179569.184000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserve=
d)
 [17179569.184000] 1151MB HIGHMEM available.
 [17179569.184000] 896MB LOWMEM available.
 [17179569.184000] found SMP MP-table at 000f6a20
 [17179569.184000] On node 0 totalpages: 524160
 [17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
 [17179569.184000]   DMA32 zone: 0 pages, LIFO batch:0
 [17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
 [17179569.184000]   HighMem zone: 294784 pages, LIFO batch:31
 [17179569.184000] DMI present.
 [17179569.184000] ACPI: RSDP (v000 PTLTD                                 )=
 @ 0x000f6a50
 [17179569.184000] ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000=
000) @ 0x7fefb83a
 [17179569.184000] ACPI: FADT (v001 Intel  SE7500CW 0x06040000 PTL  0x00000=
008) @ 0x7fefee78
 [17179569.184000] ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000=
001) @ 0x7fefeeec
 [17179569.184000] ACPI: MADT (v001 PTLTD    APIC   0x06040000  LTP 0x00000=
000) @ 0x7fefef3c
 [17179569.184000] ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000=
001) @ 0x7fefefd8
 [17179569.184000] ACPI: DSDT (v001  INTEL   PLUMAS 0x06040000 MSFT 0x01000=
00d) @ 0x00000000
 [17179569.184000] ACPI: PM-Timer IO Port: 0x1008
 [17179569.184000] ACPI: Local APIC address 0xfee00000
 [17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
 [17179569.184000] Processor #0 15:2 APIC version 20
 [17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
 [17179569.184000] Processor #6 15:2 APIC version 20
 [17179569.184000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
 [17179569.184000] Processor #1 15:2 APIC version 20
 [17179569.184000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
 [17179569.184000] Processor #7 15:2 APIC version 20
 [17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
 [17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
 [17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
 [17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
 [17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
 [17179569.184000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GS=
I 0-23
 [17179569.184000] ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
 [17179569.184000] IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GS=
I 24-47
 [17179569.184000] ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
 [17179569.184000] IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GS=
I 48-71
 [17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edg=
e)
 [17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high lev=
el)
 [17179569.184000] ACPI: IRQ0 used by override.
 [17179569.184000] ACPI: IRQ2 used by override.
 [17179569.184000] ACPI: IRQ9 used by override.
 [17179569.184000] Enabling APIC mode:  Flat.  Using 3 I/O APICs
 [17179569.184000] Using ACPI (MADT) for SMP configuration information
 [17179569.184000] Allocating PCI resources starting at 88000000 (gap: 8000=
0000:7ec00000)
 [17179569.184000] Built 1 zonelists
 [17179569.184000] Kernel command line: root=3D/dev/sda1 ro=20
 [17179569.184000] mapped APIC to ffffd000 (fee00000)
 [17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
 [17179569.184000] mapped IOAPIC to ffffb000 (fec80000)
 [17179569.184000] mapped IOAPIC to ffffa000 (fec80400)
 [17179569.184000] Initializing CPU#0
 [17179569.184000] CPU 0 irqstacks, hard=3Dc0363000 soft=3Dc035b000
 [17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
 [17179569.184000] Detected 1993.759 MHz processor.
 [17179569.184000] Using pmtmr for high-res timesource
 [17179569.184000] Console: colour VGA+ 80x25
 [17179569.580000] Dentry cache hash table entries: 131072 (order: 7, 52428=
8 bytes)
 [17179569.580000] Inode-cache hash table entries: 65536 (order: 6, 262144 =
bytes)
 [17179569.752000] Memory: 2075128k/2096640k available (1529k kernel code, =
20312k reserved, 648k data, 208k init, 1179072k highmem)
 [17179569.752000] Checking if this processor honours the WP bit even in su=
pervisor mode... Ok.
 [17179569.836000] Calibrating delay using timer specific routine.. 3992.20=
 BogoMIPS (lpj=3D7984418)
 [17179569.836000] Mount-cache hash table entries: 512
 [17179569.836000] CPU: After generic identify, caps: 3febfbff 00000000 000=
00000 00000000 00000000 00000000 00000000
 [17179569.836000] CPU: After vendor identify, caps: 3febfbff 00000000 0000=
0000 00000000 00000000 00000000 00000000
 [17179569.836000] CPU: Trace cache: 12K uops, L1 D cache: 8K
 [17179569.836000] CPU: L2 cache: 512K
 [17179569.836000] CPU: Physical Processor ID: 0
 [17179569.836000] CPU: After all inits, caps: 3febfbff 00000000 00000000 0=
0000080 00000000 00000000 00000000
 [17179569.836000] Intel machine check architecture supported.
 [17179569.836000] Intel machine check reporting enabled on CPU#0.
 [17179569.836000] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
 [17179569.836000] mtrr: v2.0 (20020519)
 [17179569.836000] Enabling fast FPU save and restore... done.
 [17179569.836000] Enabling unmasked SIMD FPU exception support... done.
 [17179569.836000] Checking 'hlt' instruction... OK.
 [17179569.856000] CPU0: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
 [17179569.860000] Booting processor 1/1 eip 2000
 [17179569.860000] CPU 1 irqstacks, hard=3Dc0364000 soft=3Dc035c000
 [17179569.868000] Initializing CPU#1
 [17179569.948000] Calibrating delay using timer specific routine.. 3987.39=
 BogoMIPS (lpj=3D7974792)
 [17179569.948000] CPU: After generic identify, caps: 3febfbff 00000000 000=
00000 00000000 00000000 00000000 00000000
 [17179569.948000] CPU: After vendor identify, caps: 3febfbff 00000000 0000=
0000 00000000 00000000 00000000 00000000
 [17179569.948000] CPU: Trace cache: 12K uops, L1 D cache: 8K
 [17179569.948000] CPU: L2 cache: 512K
 [17179569.948000] CPU: Physical Processor ID: 0
 [17179569.948000] CPU: After all inits, caps: 3febfbff 00000000 00000000 0=
0000080 00000000 00000000 00000000
 [17179569.948000] Intel machine check architecture supported.
 [17179569.948000] Intel machine check reporting enabled on CPU#1.
 [17179569.948000] CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
 [17179569.948000] CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
 [17179569.948000] Booting processor 2/6 eip 2000
 [17179569.948000] CPU 2 irqstacks, hard=3Dc0365000 soft=3Dc035d000
 [17179569.956000] Initializing CPU#2
 [17179570.040000] Calibrating delay using timer specific routine.. 3987.43=
 BogoMIPS (lpj=3D7974865)
 [17179570.040000] CPU: After generic identify, caps: 3febfbff 00000000 000=
00000 00000000 00000000 00000000 00000000
 [17179570.040000] CPU: After vendor identify, caps: 3febfbff 00000000 0000=
0000 00000000 00000000 00000000 00000000
 [17179570.040000] CPU: Trace cache: 12K uops, L1 D cache: 8K
 [17179570.040000] CPU: L2 cache: 512K
 [17179570.040000] CPU: Physical Processor ID: 3
 [17179570.040000] CPU: After all inits, caps: 3febfbff 00000000 00000000 0=
0000080 00000000 00000000 00000000
 [17179570.040000] Intel machine check architecture supported.
 [17179570.040000] Intel machine check reporting enabled on CPU#2.
 [17179570.040000] CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
 [17179570.040000] CPU2: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
 [17179570.040000] Booting processor 3/7 eip 2000
 [17179570.040000] CPU 3 irqstacks, hard=3Dc0366000 soft=3Dc035e000
 [17179570.048000] Initializing CPU#3
 [17179570.132000] Calibrating delay using timer specific routine.. 3987.45=
 BogoMIPS (lpj=3D7974912)
 [17179570.132000] CPU: After generic identify, caps: 3febfbff 00000000 000=
00000 00000000 00000000 00000000 00000000
 [17179570.132000] CPU: After vendor identify, caps: 3febfbff 00000000 0000=
0000 00000000 00000000 00000000 00000000
 [17179570.132000] CPU: Trace cache: 12K uops, L1 D cache: 8K
 [17179570.132000] CPU: L2 cache: 512K
 [17179570.132000] CPU: Physical Processor ID: 3
 [17179570.132000] CPU: After all inits, caps: 3febfbff 00000000 00000000 0=
0000080 00000000 00000000 00000000
 [17179570.132000] Intel machine check architecture supported.
 [17179570.132000] Intel machine check reporting enabled on CPU#3.
 [17179570.132000] CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
 [17179570.132000] CPU3: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
 [17179570.132000] Total of 4 processors activated (15954.49 BogoMIPS).
 [17179570.132000] ENABLING IO-APIC IRQs
 [17179570.132000] ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin=
2=3D-1
 [17179570.276000] checking TSC synchronization across 4 CPUs: passed.
 [17179570.288000] Brought up 4 CPUs
 [17179570.288000] NET: Registered protocol family 16
 [17179570.288000] ACPI: bus type pci registered
 [17179570.288000] PCI: PCI BIOS revision 2.10 entry at 0xfd921, last bus=
=3D4
 [17179570.288000] PCI: Using configuration type 1
 [17179570.288000] ACPI: Subsystem revision 20050902
 [17179570.296000] ACPI: Interpreter enabled
 [17179570.296000] ACPI: Using IOAPIC for interrupt routing
 [17179570.296000] ACPI: PCI Root Bridge [PCI0] (0000:00)
 [17179570.296000] PCI: Probing PCI hardware (bus 00)
 [17179570.296000] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TC=
O
 [17179570.300000] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
 [17179570.300000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
 [17179570.300000] Boot video device is 0000:04:03.0
 [17179570.300000] PCI: Transparent bridge - 0000:00:1e.0
 [17179570.300000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 [17179570.304000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11 14 =
15)
 [17179570.304000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 14 =
15)
 [17179570.304000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 14 =
15)
 [17179570.304000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 =
15)
 [17179570.304000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 *11 14 =
15)
 [17179570.312000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 *11 14 =
15)
 [17179570.312000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 14 =
15)
 [17179570.312000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 *11 14 =
15)
 [17179570.316000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICH3._PRT]
 [17179570.316000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.Z000.=
_PRT]
 [17179570.316000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.Z001.=
_PRT]
 [17179570.316000] SCSI subsystem initialized
 [17179570.316000] PCI: Using ACPI for IRQ routing
 [17179570.316000] PCI: If a device doesn't work, try "pci=3Drouteirq".  If=
 it helps, post a report
 [17179570.328000] PCI: Bridge: 0000:01:1d.0
 [17179570.328000]   IO window: 8000-8fff
 [17179570.328000]   MEM window: fc200000-fc2fffff
 [17179570.328000]   PREFETCH window: 88000000-880fffff
 [17179570.328000] PCI: Bridge: 0000:01:1f.0
 [17179570.328000]   IO window: disabled.
 [17179570.328000]   MEM window: disabled.
 [17179570.328000]   PREFETCH window: disabled.
 [17179570.328000] PCI: Bridge: 0000:00:02.0
 [17179570.328000]   IO window: 8000-8fff
 [17179570.328000]   MEM window: fc100000-fc2fffff
 [17179570.328000]   PREFETCH window: 88000000-880fffff
 [17179570.328000] PCI: Bridge: 0000:00:1e.0
 [17179570.328000]   IO window: 9000-9fff
 [17179570.328000]   MEM window: fc300000-fdffffff
 [17179570.332000]   PREFETCH window: 88100000-881fffff
 [17179570.332000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
 [17179570.332000] Simple Boot Flag at 0x35 set to 0x1
 [17179570.332000] highmem bounce pool size: 64 pages
 [17179570.332000] Initializing Cryptographic API
 [17179570.332000] io scheduler noop registered
 [17179570.332000] io scheduler deadline registered
 [17179570.332000] ACPI: Power Button (FF) [PWRF]
 [17179570.332000] ACPI: Power Button (CM) [PWRB]
 [17179570.336000] Real Time Clock Driver v1.12
 [17179570.336000] Non-volatile memory driver v1.2
 [17179570.336000] hw_random hardware driver 1.0.0 loaded
 [17179570.336000] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 s=
econds, margin is 60 seconds).
 [17179570.336000] Hangcheck: Using monotonic_clock().
 [17179570.340000] serio: i8042 AUX port at 0x60,0x64 irq 12
 [17179570.340000] serio: i8042 KBD port at 0x60,0x64 irq 1
 [17179570.340000] Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
 [17179570.340000] Copyright (c) 1999-2005 Intel Corporation.
 [17179570.340000] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, lo=
w) -> IRQ 16
 [17179570.636000] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Conn=
ection
 [17179570.636000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 [17179570.636000] ide: Assuming 33MHz system bus speed for PIO modes; over=
ride with idebus=3Dxx
 [17179570.636000] PDC20267: IDE controller at PCI slot 0000:04:06.0
 [17179570.636000] ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 22 (level, lo=
w) -> IRQ 17
 [17179570.636000] PDC20267: chipset revision 2
 [17179570.636000] PDC20267: ROM enabled at 0x88140000
 [17179570.636000] PDC20267: 100%% native mode on irq 17
 [17179570.636000] PDC20267: neither IDE port enabled (BIOS)
 [17179570.636000] Probing IDE interface ide0...
 [17179571.216000] Probing IDE interface ide1...
 [17179572.104000] hdc: HL-DT-ST CD-ROM GCR-8520B, ATAPI CD/DVD-ROM drive
 [17179572.776000] ide1 at 0x170-0x177,0x376 on irq 15
 [17179572.780000] ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 17 (level, lo=
w) -> IRQ 18
 [17179572.988000] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Re=
v 7.0
 [17179572.988000]         <Adaptec 19160B Ultra160 SCSI adapter>
 [17179572.988000]         aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 3=
2/253 SCBs
 [17179572.988000]=20
 [17179588.248000]   Vendor: QUANTUM   Model: ATLAS10K3_18_WLS  Rev: 020W
 [17179588.248000]   Type:   Direct-Access                      ANSI SCSI r=
evision: 03
 [17179588.248000] scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 [17179588.248000]  target0:0:1: Beginning Domain Validation
 [17179588.248000]  target0:0:1: wide asynchronous.
 [17179588.252000]  target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, =
offset 127)
 [17179588.256000]  target0:0:1: Ending Domain Validation
 [17179588.256000]   Vendor: QUANTUM   Model: ATLAS10K3_18_WLS  Rev: 020W
 [17179588.260000]   Type:   Direct-Access                      ANSI SCSI r=
evision: 03
 [17179588.260000] scsi0:A:2:0: Tagged Queuing enabled.  Depth 32
 [17179588.260000]  target0:0:2: Beginning Domain Validation
 [17179588.260000]  target0:0:2: wide asynchronous.
 [17179588.260000]  target0:0:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, off=
set 127)
 [17179588.264000]  target0:0:2: Domain Validation skipping write tests
 [17179588.264000]  target0:0:2: Ending Domain Validation
 [17179591.340000] SCSI device sda: 35916548 512-byte hdwr sectors (18389 M=
B)
 [17179591.340000] SCSI device sda: drive cache: write through
 [17179591.340000] SCSI device sda: 35916548 512-byte hdwr sectors (18389 M=
B)
 [17179591.344000] SCSI device sda: drive cache: write through
 [17179591.344000]  sda: sda1 sda2 < sda5 >
 [17179591.352000] sd 0:0:1:0: Attached scsi disk sda
 [17179591.352000] SCSI device sdb: 35916548 512-byte hdwr sectors (18389 M=
B)
 [17179591.352000] SCSI device sdb: drive cache: write back
 [17179591.352000] SCSI device sdb: 35916548 512-byte hdwr sectors (18389 M=
B)
 [17179591.356000] SCSI device sdb: drive cache: write back
 [17179591.356000]  sdb: sdb1
 [17179591.356000] sd 0:0:2:0: Attached scsi disk sdb
 [17179591.356000] sd 0:0:1:0: Attached scsi generic sg0 type 0
 [17179591.356000] sd 0:0:2:0: Attached scsi generic sg1 type 0
 [17179591.356000] mice: PS/2 mouse device common for all mice
 [17179591.356000] NET: Registered protocol family 2
 [17179591.388000] IP route cache hash table entries: 131072 (order: 7, 524=
288 bytes)
 [17179591.392000] TCP established hash table entries: 524288 (order: 10, 4=
194304 bytes)
 [17179591.396000] TCP bind hash table entries: 65536 (order: 7, 524288 byt=
es)
 [17179591.396000] TCP: Hash tables configured (established 524288 bind 655=
36)
 [17179591.396000] TCP reno registered
 [17179591.396000] TCP bic registered
 [17179591.396000] NET: Registered protocol family 1
 [17179591.396000] NET: Registered protocol family 17
 [17179591.396000] NET: Registered protocol family 15
 [17179591.396000] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech=
.com>
 [17179591.396000] All bugs added by David S. Miller <davem@redhat.com>
 [17179591.396000] Starting balanced_irq
 [17179591.400000] Using IPI Shortcut mode
 [17179591.400000] ReiserFS: sda1: found reiserfs format "3.6" with standar=
d journal
 [17179591.416000] input: AT Translated Set 2 keyboard as /class/input/inpu=
t0
 [17179591.820000] ReiserFS: sda1: using ordered data mode
 [17179591.824000] ReiserFS: sda1: journal params: device sda1, size 8192, =
journal first block 18, max trans len 1024, max batch 900, max commit age 3=
0, max trans age 30
 [17179591.828000] ReiserFS: sda1: checking transaction log (sda1)
 [17179591.856000] ReiserFS: sda1: Using r5 hash to sort names
 [17179591.856000] VFS: Mounted root (reiserfs filesystem) readonly.
 [17179591.856000] Freeing unused kernel memory: 208k freed
 [17179592.976000] Adding 763048k swap on /dev/sda5.  Priority:-1 extents:1=
 across:763048k
 [17179596.712000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 [17179596.712000] ide: Assuming 33MHz system bus speed for PIO modes; over=
ride with idebus=3Dxx
 [17179596.716000] Probing IDE interface ide0...
 [17179598.592000] e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
 [17179598.592000] e100: Copyright(c) 1999-2005 Intel Corporation
 [17179598.592000] ACPI: PCI Interrupt 0000:04:04.0[A] -> GSI 20 (level, lo=
w) -> IRQ 19
 [17179598.616000] e100: eth1: e100_probe: addr 0xfc362000, irq 19, MAC add=
r 00:02:B3:AF:6B:2F
 [17179598.616000] ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 23 (level, lo=
w) -> IRQ 20
 [17179598.640000] e100: eth2: e100_probe: addr 0xfc363000, irq 20, MAC add=
r 00:02:B3:AF:68:39
 [17179598.940000] kobject_register failed for Promise_Old_IDE (-17)
 [17179598.940000]  [dump_stack+21/23] dump_stack+0x15/0x17
 [17179598.940000]  [kobject_register+52/64] kobject_register+0x34/0x40
 [17179598.940000]  [bus_add_driver+69/163] bus_add_driver+0x45/0xa3
 [17179598.940000]  [driver_register+57/60] driver_register+0x39/0x3c
 [17179598.940000]  [__pci_register_driver+125/132] __pci_register_driver+0=
x7d/0x84
 [17179598.940000]  [__ide_pci_register_driver+19/53] __ide_pci_register_dr=
iver+0x13/0x35
 [17179598.940000]  [pg0+945449588/1069855744] pdc202xx_ide_init+0x12/0x16 =
[pdc202xx_old]
 [17179598.940000]  [sys_init_module+193/430] sys_init_module+0xc1/0x1ae
 [17179598.940000]  [syscall_call+7/11] syscall_call+0x7/0xb
 [17179599.544000] e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mb=
ps Full Duplex


--=-jQvf5QJhl26IWDRqEMdF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: =?iso-8859-5?Q?=C2=DE=D2=D0?= =?iso-8859-5?Q?_=D5?=
	=?iso-8859-5?Q?_=E6=D8=E4=E0=DE=D2=DE?=
	=?iso-8859-5?Q?_=DF=DE=D4=DF=D8=E1=D0=DD=D0?=
	=?iso-8859-5?Q?_=E7=D0=E1=E2?= =?iso-8859-5?Q?_=DE=E2?=
	=?iso-8859-5?Q?_=DF=D8=E1=DC=DE=E2=DE?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD1y6/XGxMwFp5iTARAuELAJ9ePAqA7o8kkfqTNSSn1z0d8SL57QCdEbkU
2L0UUzch7X2JWc2+5sRkU+o=
=T2pQ
-----END PGP SIGNATURE-----

--=-jQvf5QJhl26IWDRqEMdF--

