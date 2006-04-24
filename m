Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWDXR0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWDXR0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWDXR0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:26:34 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:52177 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751013AbWDXR0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:26:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id:from;
        b=fdpWBKedIgNeSDFQOAu4oDBI6atoXGMl1EOF/0s7wnxChphmjsWLbLqQy5ONGT2zOwC9T2MvwW6ny1RUOuv34ZGnQBLoHvZVT+/2KDyOfv9N/MlHplCVj39NPU++oU/vcOp+juoCW4fnE+uWuld0V3In7RzwNOk37khgZmjLee8=
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: 2.6.17-rc1: kernel only boots one CPU on HT system
Date: Mon, 24 Apr 2006 19:26:24 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200604231434.59966.Kevin.Baradon@gmail.com> <20060423141519.314ae567.akpm@osdl.org> <1145843859.19994.63.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1145843859.19994.63.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BpQTEl1bNVSxmqn"
Message-Id: <200604241926.25239.Kevin.Baradon@gmail.com>
From: Kevin Baradon <kevin.baradon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_BpQTEl1bNVSxmqn
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Lundi 24 Avril 2006 03:57, Shaohua Li a =E9crit=A0:
> Hi,

Hello,=20
>
> On Sun, 2006-04-23 at 14:15 -0700, Andrew Morton wrote:
> > Kevin Baradon <kevin.baradon@gmail.com> wrote:
> > > Hello,
> > >
> > > Starting with kernel 2.6.17-rc1 (also happens with 2.6.17-rc2), second
> > > logical-CPU of my Hyperthreading system no longer boots.
> > >
> > > I tracked up changes in APIC code, and it appears reverting commit
> > > 7c5c1e427b5e83807fd05419d1cf6991b9d87247 fixes this bug.
> >
> > That helps heaps, thanks.
>
> The commit doesn't look like the root cause to me. BIOS already assigns
> unique id to ioapic, and the cpu family is 15, so with/without the patch
> the code path hasn't any difference. Kevin, can you please make a clean
> build and check if the patch is the real cause?
>

You were right. Reverting this commit helps sometimes, but doesn't work=20
reliably. When my computer booted this morning, I've had only one CPU=20
detected. I've tried booting several times, even with a complete power down=
=2E=20
Nothing changed.=20

I've also tried with kernel 2.6.16-rc6, which booted fine and detected two=
=20
CPUs.

I've applied your small patch. Debugging output is attached.

If you want, I can apply this small patch also to kernel 2.6.16-rc6, and se=
nd=20
you debugging output.

> If it still doesn't work, you might apply a small change below to
> include/asm-i386/apic.h, and attach the dmesg, so we could analyze it.
>

=46ile attached.

> -#define Dprintk(x...)
> +#define Dprintk(format, arg...) printk(format, ##arg)
>
> > > See both dmesgs, and kernel configuration attached.
> > >
> > > Feel free to ask me if you need other informations.
> > > Please CC me as I'm not subscribed to LKML.
> > >
> > >
> > > Hardware :
> > > ------------------------------
> > > MB: Gigabyte GA-8SINXP1394
> > > CPU: Intel Pentium 4 3.06Ghz HT
> > > RAM: Corsair 512Mo
> > >
> > > cat /proc/cpuinfo: (patched kernel)
> > > ------------------------------
> > > processor       : 0
> > > vendor_id       : GenuineIntel
> > > cpu family      : 15
> > > model           : 2
> > > model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
> > > stepping        : 7
> > > cpu MHz         : 3081.400
> > > cache size      : 512 KB
> > > physical id     : 0
> > > siblings        : 2
> > > core id         : 0
> > > cpu cores       : 1
> > > fdiv_bug        : no
> > > hlt_bug         : no
> > > f00f_bug        : no
> > > coma_bug        : no
> > > fpu             : yes
> > > fpu_exception   : yes
> > > cpuid level     : 2
> > > wp              : yes
> > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> > > bogomips        : 6165.74
> > >
> > > processor       : 1
> > > vendor_id       : GenuineIntel
> > > cpu family      : 15
> > > model           : 2
> > > model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
> > > stepping        : 7
> > > cpu MHz         : 3081.400
> > > cache size      : 512 KB
> > > physical id     : 0
> > > siblings        : 2
> > > core id         : 0
> > > cpu cores       : 1
> > > fdiv_bug        : no
> > > hlt_bug         : no
> > > f00f_bug        : no
> > > coma_bug        : no
> > > fpu             : yes
> > > fpu_exception   : yes
> > > cpuid level     : 2
> > > wp              : yes
> > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > > mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> > > bogomips        : 6162.10
> > >
> > > cat /proc/interrupts :  (patched kernel)
> > > -----------------------------
> > >            CPU0       CPU1
> > >   0:    2143303       6647    IO-APIC-edge  timer
> > >   1:         15          9    IO-APIC-edge  i8042
> > >   4:          7          1    IO-APIC-edge  serial
> > >   8:      19518          1    IO-APIC-edge  rtc
> > >   9:          0          0   IO-APIC-level  acpi
> > >  15:      37053         23    IO-APIC-edge  ide1
> > >  16:     240872          1   IO-APIC-level  cx88[0], eth-lan
> > >  17:      11128         19   IO-APIC-level  ide2, ide3
> > >  18:      63432          4   IO-APIC-level  libata, ohci1394, CS46XX
> > >  19:          0          3   IO-APIC-level  ehci_hcd:usb1
> > >  20:     457635        195   IO-APIC-level  ohci_hcd:usb2
> > >  21:          0          0   IO-APIC-level  ohci_hcd:usb3
> > >  22:          0          0   IO-APIC-level  ohci_hcd:usb4
> > > NMI:    2149889    2149786
> > > LOC:    2150122    2150121
> > > ERR:          0
> > > MIS:          0
> >
> > Shaohua, I'll queue up a reversion patch so this doesn't get forgotten
> > about but I won't send it to Linus at this stage.
>
> Thanks, Andrew.
>
> Thanks,
> Shaohua

=2D-=20
Kevin Baradon
Telecom Student
=2D

--Boundary-00=_BpQTEl1bNVSxmqn
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg-2.6.17-rc2-bug"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg-2.6.17-rc2-bug"

Linux version 2.6.17-rc2apic-debug (root@kev1) (version gcc 4.0.3 (Debian 4.0.3-1)) #12 SMP PREEMPT Mon Apr 24 11:18:28 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5650
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f71f0
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fff6bc0
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
Boot CPU = 0
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    Cache Line Flush Instruction present.
    Debug Trace and EMON Store present.
    ACPI Thermal Throttle Registers  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Willamette New Instructions  present.
    Self Snoop  present.
    HT  present.
    Thermal Monitor present.
    Bootup CPU
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    Cache Line Flush Instruction present.
    Debug Trace and EMON Store present.
    ACPI Thermal Throttle Registers  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Willamette New Instructions  present.
    Self Snoop  present.
    HT  present.
    Thermal Monitor present.
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 20, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 0, irq 0, 2-2
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Int: type 0, pol 3, trig 3, bus 0, irq 9, 2-9
Bus #0 is ISA
ACPI: IRQ0 used by override.
Int: type 0, pol 0, trig 0, bus 0, irq 1, 2-1
ACPI: IRQ2 used by override.
Int: type 0, pol 0, trig 0, bus 0, irq 3, 2-3
Int: type 0, pol 0, trig 0, bus 0, irq 4, 2-4
Int: type 0, pol 0, trig 0, bus 0, irq 5, 2-5
Int: type 0, pol 0, trig 0, bus 0, irq 6, 2-6
Int: type 0, pol 0, trig 0, bus 0, irq 7, 2-7
Int: type 0, pol 0, trig 0, bus 0, irq 8, 2-8
ACPI: IRQ9 used by override.
Int: type 0, pol 0, trig 0, bus 0, irq 10, 2-10
Int: type 0, pol 0, trig 0, bus 0, irq 11, 2-11
Int: type 0, pol 0, trig 0, bus 0, irq 12, 2-12
Int: type 0, pol 0, trig 0, bus 0, irq 13, 2-13
Int: type 0, pol 0, trig 0, bus 0, irq 14, 2-14
Int: type 0, pol 0, trig 0, bus 0, irq 15, 2-15
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: root=/dev/sda3 panic=30 vga=extended nmi_watchdog=1 selinux=0 ro 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 3176.461 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x50
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515328k/524224k available (2512k kernel code, 8416k reserved, 815k data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6312.32 BogoMIPS (lpj=3156163)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00000400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00000400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 20k freed
CPU0: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
CPU present map: 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
Not responding.
Inquiring remote APIC #1...
... APIC #1 ID: failed
... APIC #1 VERSION: failed
... APIC #1 SPIV: failed
CPU #1 not responding - cannot use it.
Before bogomips.
Total of 1 processors activated (6312.32 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
migration_cost=0
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb020, last bus=1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: f0000000-f1ffffff
  PREFETCH window: e0000000-efffffff
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [FUTS]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected SiS 655 chipset
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/1000 Network Driver - version 7.0.33-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 19 (level, low) -> IRQ 16
e1000: 0000:00:0f.0: e1000_probe: (PCI:33MHz:32-bit) 00:20:ed:5b:02:f6
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: ASUS CRW-5224A, ATAPI CD/DVD-ROM drive
hdd: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
IT8212: IDE controller at PCI slot 0000:00:0e.0
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 18 (level, low) -> IRQ 17
IT8212: chipset revision 16
it821x: controller in pass through mode.
IT8212: 100% native mode on irq 17
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:pio, hdf:pio
it821x: Revision 0x10, workarounds activated.
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:pio, hdh:pio
it821x: Revision 0x10, workarounds activated.
Probing IDE interface ide2...
hde: Maxtor 6Y080P0, ATA DISK drive
ide2 at 0xb810-0xb817,0xbc02 on irq 17
Probing IDE interface ide3...
hdg: Maxtor 6Y080P0, ATA DISK drive
hdh: HDT722525DLAT80, ATA DISK drive
ide3 at 0xc010-0xc017,0xc402 on irq 17
hde: max request size: 128KiB
hde: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
hde: cache flushes supported
 hde: hde1 hde2 hde3
hdg: max request size: 128KiB
hdg: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
hdg: cache flushes supported
 hdg: hdg1
hdh: max request size: 512KiB
hdh: 488397168 sectors (250059 MB) w/7674KiB Cache, CHS=30401/255/63, UDMA(133)
hdh: cache flushes supported
 hdh: hdh1 hdh2 hdh3
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
libata version 1.20 loaded.
sata_sil 0000:00:10.0: version 0.9
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 17 (level, low) -> IRQ 18
ata1: SATA max UDMA/100 cmd 0xE080E080 ctl 0xE080E08A bmdma 0xE080E000 irq 18
ata2: SATA max UDMA/100 cmd 0xE080E0C0 ctl 0xE080E0CA bmdma 0xE080E008 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA-6, max UDMA/133, 72303840 sectors: LBA48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 35.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 > sda3
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 19
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: irq 19, io mem 0xf5127000
ehci_hcd 0000:00:03.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.0: irq 20, io mem 0xf5123000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.1: irq 21, io mem 0xf5124000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:03.2: irq 22, io mem 0xf5126000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using ohci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 2 ports detected
usb 2-2: new full speed USB device using ohci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
usb 2-1.1: new low speed USB device using ohci_hcd and address 4
usb 2-1.1: configuration #1 chosen from 1 choice
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: Logitech USB Receiver as /class/input/input0
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:03.0-1.1
input: Logitech USB Receiver as /class/input/input1
input,hiddev96: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:03.0-1.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input2
input: AT Translated Set 2 keyboard as /class/input/input3
i2c /dev entries driver
it87: Found IT8705F chip at 0x290, revision 2
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10:27:24 2006 UTC).
ALSA device list:
  No soundcards found.
u32 classifier
    Perfomance counters on
    Actions configured 
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 196608 bytes)
TCP bind hash table entries: 8192 (order: 4, 98304 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 224 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2006 Netfilter Core Team
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
NET: Registered protocol family 8
NET: Registered protocol family 20
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Pin 2-17 already programmed
ACPI: PCI Interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[18]  MMIO=[f5122000-f51227ff]  Max Packet=[2048]  IR/IT contexts=[4/6]
cx2388x v4l2 driver version 0.0.5 loaded
Pin 2-19 already programmed
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 16
CORE cx88[0]: subsystem: 0070:3401, board: Hauppauge WinTV 34xxx models [card=1,autodetected]
TV tuner -1 at 0x1fe, Radio tuner -1 at 0x1fe
tveeprom 0-0050: Hauppauge model 34519, rev G152, serial# 6748079
tveeprom 0-0050: tuner model is Microtune 4049 FM5 (idx 52, type 45)
tveeprom 0-0050: TV standards PAL(B/G) PAL(I) SECAM(L/L') PAL(D/D1/K) (eeprom 0x74)
tveeprom 0-0050: audio processor is CX881 (idx 31)
tveeprom 0-0050: has radio
cx88[0]: hauppauge eeprom: model=34519
input: cx88 IR (Hauppauge WinTV 34xxx  as /class/input/input4
cx88[0]/0: found at 0000:00:0b.0, rev: 3, irq: 16, latency: 32, mmio: 0xf3000000
tuner 0-0061: chip found @ 0xc2 (cx88[0])
tuner 0-0061: type set to 45 (Microtune 4049 FM5)
tda9887 0-0043: chip found @ 0x86 (cx88[0])
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
Pin 2-17 already programmed
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 18
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000020ed00694b66]
usb 2-2: reset full speed USB device using ohci_hcd and address 3
usbcore: registered new driver speedtch
speedtch 2-2:1.0: found stage 1 firmware speedtch-1.bin
speedtch 2-2:1.0: found stage 2 firmware speedtch-2.bin
ACPI: PCI interrupt for device 0000:00:0d.0 disabled
Pin 2-17 already programmed
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 18
cs46xx: failure waiting for FIFO command to complete
Adding 2008116k swap on /dev/sda5.  Priority:-1 extents:1 across:2008116k
EXT3 FS on sda3, internal journal
ATM dev 0: ADSL line is synchronising
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth-lan: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
microcode: CPU0 updated from revision 0x27 to 0x37, date = 06042003 
eth-lan: no IPv6 routers present
usb 2-1.2: new full speed USB device using ohci_hcd and address 5
usb 2-1.2: configuration #1 chosen from 1 choice
ATM dev 0: ADSL line is up (608 kb/s down | 160 kb/s up)
input: Bluetooth HID Boot Protocol Device as /class/input/input5

--Boundary-00=_BpQTEl1bNVSxmqn--
