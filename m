Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVG3BM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVG3BM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVG3BKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:10:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262884AbVG3BJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 21:09:57 -0400
Date: Fri, 29 Jul 2005 18:08:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, adaplas@gmail.com, adaplas@pol.net,
       ak@suse.de
Subject: Re: vesafb-fix-mtrr-bugs.patch added to -mm tree
Message-Id: <20050729180827.79679ff0.akpm@osdl.org>
In-Reply-To: <20050729185848.GP17003@redhat.com>
References: <200507291825.j6TIParH012406@shell0.pdx.osdl.net>
	<20050729185848.GP17003@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Fri, Jul 29, 2005 at 11:24:37AM -0700, Andrew Morton wrote:
> 
>  > From: "Antonino A. Daplas" <adaplas@gmail.com>
>  > 
>  > >> vesafb: mode is 800x600x16, linelength=1600, pages=16
>  > >> vesafb: scrolling: redraw
>  > >> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
>  > >> mtrr: type mismatch for fc000000,1000000 old: write-back new: write-
>  > >> combining
>  > 
>  > Range is already set to write-back, vesafb attempts to add a write-combining
>  > mtrr (default for vesafb).
>  > 
>  > >> mtrr: size and base must be multiples of 4 kiB
>  > 
>  > This is a bug, vesafb attempts to add a size < PAGE_SIZE triggering
>  > the messages below.
> 
> I fixed this a few weeks back. It's this line which your patch removes..
> 
> -        while (temp_size > PAGE_SIZE &&
> 
>  > To eliminate the warning messages, you can add the option mtrr:2 to add a
>  > write-back mtrr for vesafb.  Or just use nomtrr option.
> 
> If we need users to pass extra command line args to make warnings go
> away, we may as well not bother. Because 99% of users will be completely
> unaware that option even exists.  They'll still see the same message,
> and still report the same bugs.
> 
> The pains of MTRR strike again. This stuff is just screaming for
> a usable PAT implementation. Andi, you were working on that, any news ?
> Or should I resurrect Terrence's patch again ?
> 

Well something is still awry:




Begin forwarded message:

Date: Fri, 29 Jul 2005 13:40:05 +0200
From: Alessandro <alezzandro@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: "mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining" on Kernel 2.6.12


I try the new prepatch for the stable Linux kernel (2.6.13-rc4) but
the problem is the same:
...
vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 4608k,
total 131072k
vesafb: mode is 1024x768x24, linelength=3072, pages=55
vesafb: protected mode interface info at c000:56cb
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,4000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,2000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,1000000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,800000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,400000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,200000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,100000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,80000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,40000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,20000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,10000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,8000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,4000 old: write-back new: write-combining
mtrr: type mismatch for e0000000,2000 old: write-back new: write-combining
Console: switching to colour frame buffer device 128x48
...
So I attach the dmesg log.

On 7/29/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> Can you please retest 2.6.13-rc4?  If it's still happening, send a new
> report?  It would help to identify the last kernel version which wasn't
> doing this.
> 
> Does the system otherwise run OK?
> 
> Alessandro <alezzandro@gmail.com> wrote:
> >
> > Today I downloaded and installed the Kernel 2.6.12
> > (I use the old .config of kernel 2.6.11.12 but i tried also a new
> > configuration starting from the default config that the make menuconfig
> > generated).
> > When I reboot my Slackware 10.1 in Kernel 2.6.12 this is the output of
> > my dmesg:
> >
> > bash-3.00$ dmesg
> > Linux version 2.6.12 (root@freedom) (gcc version 3.3.5) #1 SMP Sat Jun
> > 18 15:16:59 CEST 2005
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000001ff30000 (usable)
> >  BIOS-e820: 000000001ff30000 - 000000001ff40000 (ACPI data)
> >  BIOS-e820: 000000001ff40000 - 000000001fff0000 (ACPI NVS)
> >  BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
> >  BIOS-e820: 00000000ffba0000 - 0000000100000000 (reserved)
> > 511MB LOWMEM available.
> > found SMP MP-table at 000ff780
> > On node 0 totalpages: 130864
> >   DMA zone: 4096 pages, LIFO batch:1
> >   Normal zone: 126768 pages, LIFO batch:31
> >   HighMem zone: 0 pages, LIFO batch:1
> > DMI 2.3 present.
> > ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9e70
> > ACPI: RSDT (v001 A M I  OEMRSDT  0x02000424 MSFT 0x00000097) @ 0x1ff30000
> > ACPI: FADT (v002 A M I  OEMFACP  0x02000424 MSFT 0x00000097) @ 0x1ff30200
> > ACPI: MADT (v001 A M I  OEMAPIC  0x02000424 MSFT 0x00000097) @ 0x1ff30390
> > ACPI: OEMB (v001 A M I  OEMBIOS  0x02000424 MSFT 0x00000097) @ 0x1ff40040
> > ACPI: DSDT (v001  P4PSS P4PSS023 0x00000023 INTL 0x02002026) @ 0x00000000
> > ACPI: Local APIC address 0xfee00000
> > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> > Processor #0 15:3 APIC version 20
> > ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> > Processor #1 15:3 APIC version 20
> > ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> > IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> > ACPI: IRQ0 used by override.
> > ACPI: IRQ2 used by override.
> > ACPI: IRQ9 used by override.
> > Enabling APIC mode:  Flat.  Using 1 I/O APICs
> > Using ACPI (MADT) for SMP configuration information
> > Allocating PCI resources starting at 20000000 (gap: 20000000:dfba0000)
> > Built 1 zonelists
> > Kernel command line: ro root=/dev/hda1 vga=792
> > mapped APIC to ffffd000 (fee00000)
> > mapped IOAPIC to ffffc000 (fec00000)
> > Initializing CPU#0
> > PID hash table entries: 2048 (order: 11, 32768 bytes)
> > Detected 2999.507 MHz processor.
> > Using tsc for high-res timesource
> > Console: colour dummy device 80x25
> > Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> > Memory: 513212k/523456k available (2918k kernel code, 9684k reserved,
> > 1121k data, 232k init, 0k highmem)
> > Checking if this processor honours the WP bit even in supervisor mode... Ok.
> > Calibrating delay loop... 5914.62 BogoMIPS (lpj=2957312)
> > Mount-cache hash table entries: 512
> > CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> > 0000041d 00000000 00000000
> > CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
> > 0000041d 00000000 00000000
> > monitor/mwait feature present.
> > using mwait in idle threads.
> > CPU: Trace cache: 12K uops, L1 D cache: 16K
> > CPU: L2 cache: 1024K
> > CPU: Physical Processor ID: 0
> > CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d
> > 00000000 00000000
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> > CPU0: Thermal monitoring enabled
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
> > Booting processor 1/1 eip 3000
> > Initializing CPU#1
> > Calibrating delay loop... 5980.16 BogoMIPS (lpj=2990080)
> > CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
> > 0000041d 00000000 00000000
> > CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000
> > 0000041d 00000000 00000000
> > monitor/mwait feature present.
> > CPU: Trace cache: 12K uops, L1 D cache: 16K
> > CPU: L2 cache: 1024K
> > CPU: Physical Processor ID: 0
> > CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000041d
> > 00000000 00000000
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#1.
> > CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> > CPU1: Thermal monitoring enabled
> > CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
> > Total of 2 processors activated (11894.78 BogoMIPS).
> > ENABLING IO-APIC IRQs
> > ..TIMER: vector=0x31 pin1=2 pin2=-1
> > checking TSC synchronization across 2 CPUs: passed.
> > Brought up 2 CPUs
> > CPU0 attaching sched-domain:
> >  domain 0: span 03
> >   groups: 01 02
> >   domain 1: span 03
> >    groups: 03
> > CPU1 attaching sched-domain:
> >  domain 0: span 03
> >   groups: 02 01
> >   domain 1: span 03
> >    groups: 03
> > NET: Registered protocol family 16
> > PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
> > PCI: Using configuration type 1
> > mtrr: v2.0 (20020519)
> > ACPI: Subsystem revision 20050309
> > ACPI: Interpreter enabled
> > ACPI: Using IOAPIC for interrupt routing
> > ACPI: PCI Root Bridge [PCI0] (0000:00)
> > PCI: Probing PCI hardware (bus 00)
> > PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> > Boot video device is 0000:01:00.0
> > PCI: Transparent bridge - 0000:00:1e.0
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> > ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
> > ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
> > disabled.
> > ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
> > disabled.
> > ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> > ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> > Linux Plug and Play Support v0.97 (c) Adam Belay
> > pnp: PnP ACPI init
> > pnp: PnP ACPI: found 13 devices
> > SCSI subsystem initialized
> > usbcore: registered new driver usbfs
> > usbcore: registered new driver hub
> > PCI: Using ACPI for IRQ routing
> > PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
> > report
> > pnp: 00:09: ioport range 0x680-0x6ff has been reserved
> > pnp: 00:09: ioport range 0x290-0x297 has been reserved
> > Machine check exception polling timer started.
> > audit: initializing netlink socket (disabled)
> > audit(1119108222.761:0): initialized
> > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > Initializing Cryptographic API
> > vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 4608k,
> > total 131072k
> > vesafb: mode is 1024x768x24, linelength=3072, pages=55
> > vesafb: protected mode interface info at c000:56cb
> > vesafb: scrolling: redraw
> > vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
> > mtrr: type mismatch for e0000000,8000000 old: write-back new:
> > write-combining
> > mtrr: type mismatch for e0000000,4000000 old: write-back new:
> > write-combining
> > mtrr: type mismatch for e0000000,2000000 old: write-back new:
> > write-combining
> > mtrr: type mismatch for e0000000,1000000 old: write-back new:
> > write-combining
> > mtrr: type mismatch for e0000000,800000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,400000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,200000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,100000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,80000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,40000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,20000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,10000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,8000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,4000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,2000 old: write-back new: write-combining
> > mtrr: type mismatch for e0000000,1000 old: write-back new: write-combining
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x800  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x400  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x200  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x100  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x80  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x40  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x20  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x10  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x8  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x4  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x2  base: 0xe0000000
> > mtrr: size and base must be multiples of 4 kiB
> > mtrr: size: 0x1  base: 0xe0000000
> > Console: switching to colour frame buffer device 128x48
> > fb0: VESA VGA frame buffer device
> > lp: driver loaded but no devices found
> > Linux agpgart interface v0.101 (c) Dave Jones
> > [drm] Initialized drm 1.0.0 20040925
> > PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> > ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > parport: PnPBIOS parport detected.
> > parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
> > lp0: using parport0 (interrupt-driven).
> > io scheduler noop registered
> > io scheduler anticipatory registered
> > io scheduler deadline registered
> > io scheduler cfq registered
> > Floppy drive(s): fd0 is 1.44M
> > FDC 0 is a post-1991 82077
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > ICH5: IDE controller at PCI slot 0000:00:1f.1
> > PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
> > ICH5: chipset revision 2
> > ICH5: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
> >     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
> > Probing IDE interface ide0...
> > hda: IC35L060AVV207-0, ATA DISK drive
> > hdb: Maxtor 6Y080L0, ATA DISK drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > Probing IDE interface ide1...
> > hdc: SAMSUNG CD-R/RW DRIVE SW-252F, ATAPI CD/DVD-ROM drive
> > hdd: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
> > ide1 at 0x170-0x177,0x376 on irq 15
> > Probing IDE interface ide2...
> > Probing IDE interface ide3...
> > Probing IDE interface ide4...
> > Probing IDE interface ide5...
> > hda: max request size: 1024KiB
> > hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63,
> > UDMA(100)
> > hda: cache flushes supported
> >  hda: hda1 hda2 < hda5 hda6 > hda4
> > hdb: max request size: 128KiB
> > hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63,
> > UDMA(100)
> > hdb: cache flushes supported
> >  hdb: hdb1 hdb2 < hdb5 hdb6 >
> > hdc: ATAPI 1X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> > Uniform CD-ROM driver Revision: 3.20
> > hdd: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
> > libata version 1.11 loaded.
> > usbmon: debugs is not available
> > ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> > PCI: Setting latency timer of device 0000:00:1d.7 to 64
> > ehci_hcd 0000:00:1d.7: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
> > EHCI Controller
> > ehci_hcd 0000:00:1d.7: debug port 1
> > ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> > ehci_hcd 0000:00:1d.7: irq 23, io mem 0xffaffc00
> > PCI: cache line size of 128 is not supported by device 0000:00:1d.7
> > ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 8 ports detected
> > USB Universal Host Controller Interface driver v2.2
> > ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1d.0 to 64
> > uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> > UHCI Controller #1
> > uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
> > uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ef00
> > hub 2-0:1.0: USB hub found
> > hub 2-0:1.0: 2 ports detected
> > ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
> > PCI: Setting latency timer of device 0000:00:1d.1 to 64
> > uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> > UHCI Controller #2
> > uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
> > uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000ef20
> > hub 3-0:1.0: USB hub found
> > hub 3-0:1.0: 2 ports detected
> > ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
> > PCI: Setting latency timer of device 0000:00:1d.2 to 64
> > uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3
> > uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> > uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000ef40
> > hub 4-0:1.0: USB hub found
> > hub 4-0:1.0: 2 ports detected
> > ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
> > PCI: Setting latency timer of device 0000:00:1d.3 to 64
> > uhci_hcd 0000:00:1d.3: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
> > UHCI Controller #4
> > uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
> > uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ef80
> > hub 5-0:1.0: USB hub found
> > hub 5-0:1.0: 2 ports detected
> > usbcore: registered new driver usblp
> > drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> > Initializing USB Mass Storage driver...
> > usbcore: registered new driver usb-storage
> > USB Mass Storage support registered.
> > usbcore: registered new driver usbhid
> > drivers/usb/input/hid-core.c: v2.01:USB HID core driver
> > mice: PS/2 mouse device common for all mice
> > Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
> > 10:33:39 2005 UTC).
> > ALSA device list:
> >   No soundcards found.
> > oprofile: using NMI interrupt.
> > NET: Registered protocol family 2
> > IP: routing cache hash table of 2048 buckets, 32Kbytes
> > TCP established hash table entries: 32768 (order: 7, 524288 bytes)
> > TCP bind hash table entries: 32768 (order: 6, 393216 bytes)
> > TCP: Hash tables configured (established 32768 bind 32768)
> > ip_conntrack version 2.1 (4089 buckets, 32712 max) - 220 bytes per conntrack
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > ip_tables: (C) 2000-2002 Netfilter core team
> > ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.
> > http://snowman.net/projects/ipt_recent/
> > arp_tables: (C) 2002 David S. Miller
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > Starting balanced_irq
> > ACPI wakeup devices:
> > P0P4 MC97 USB1 USB2 USB3 USB4 EUSB PS2K PS2M ILAN
> > ACPI: (supports S0 S1 S3 S4 S5)
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> > Freeing unused kernel memory: 232k freed
> > input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> > Adding 530108k swap on /dev/hda5.  Priority:-1 extents:1
> > EXT3 FS on hda1, internal journal
> > Bluetooth: Core ver 2.7
> > NET: Registered protocol family 31
> > Bluetooth: HCI device and connection manager initialized
> > Bluetooth: HCI socket layer initialized
> > Bluetooth: L2CAP ver 2.7
> > Bluetooth: L2CAP socket layer initialized
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS on hda4, internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS on hdb6, internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > NTFS driver 2.1.22 [Flags: R/W DEBUG MODULE].
> > NTFS volume version 3.1.
> > NTFS-fs error (device hdb1): ntfs_check_logfile(): The two restart pages
> > in $LogFile do not match.
> > NTFS-fs warning (device hdb1): load_system_files(): Failed to load
> > $LogFile.  Will not be able to remount read-write.  Mount in Windows.
> > 8139too Fast Ethernet driver 0.9.27
> > ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
> > eth0: RealTek RTL8139 at 0xd800, 00:0e:a6:b3:89:32, IRQ 22
> > eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
> > ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
> > PCI: Setting latency timer of device 0000:00:1f.5 to 64
> > eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> > intel8x0_measure_ac97_clock: measured 50202 usecs
> > intel8x0: clocking to 48000
> > hw_random: RNG not detected
> > pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> > shpchp: shpc_init : shpc_cap_offset == 0
> > shpchp: shpc_init : shpc_cap_offset == 0
> > shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > agpgart: Detected an Intel 865 Chipset.
> > agpgart: AGP aperture is 128M @ 0xf0000000
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > hw_random: RNG not detected
> > Real Time Clock Driver v1.12
> > ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> > w83627hf 1-0290: Reading VID from GPIO5
> > i2c /dev entries driver
> > mtrr: type mismatch for e0000000,8000000 old: write-back new:
> > write-combining
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> > mtrr: type mismatch for f0000000,8000000 old: write-back new:
> > write-combining
> > [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies
> > Inc RV280 [Radeon 9200 SE]
> > mtrr: type mismatch for e0000000,8000000 old: write-back new:
> > write-combining
> > agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> > agpgart: reserved bits set in mode 0x1f004a0f. Fixed.
> > agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
> > agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> > agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
> > [drm] Loading R200 Microcode
> > scsi: unknown opcode 0x01
> >
> > One of errors that I see in dmesg is "mtrr: type mismatch for
> > e0000000,8000000 old: write-back new: write-combining", I have probably
> > the same problem of the 2.6.12-rc5-mm1 that I found here:
> > http://seclists.org/lists/linux-kernel/2005/Jun/0216.html but my system
> > has only one soundcard (on board).
> >
> > Of course I attached my .config , my /proc/cpuinfo (p4 3.0 ghz
> > prescott), my /proc/modules etc...
> > I hope can you give me some help or release some patch.
> >
> > Thanks,
> > Alessandro Arrichiello from Italy.
> >
>

