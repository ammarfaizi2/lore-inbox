Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTLJHwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 02:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTLJHwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 02:52:25 -0500
Received: from legolas.restena.lu ([158.64.1.34]:48828 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263007AbTLJHvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 02:51:41 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Craig Bradney <cbradney@zip.com.au>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FD6B9B4.3040906@nishanet.com>
References: <1070827127.1991.16.camel@big.pomac.com>
	 <200312081207.45297.ross@datscreative.com.au>
	 <1070993538.1674.10.camel@big.pomac.com>
	 <1071007478.5293.11.camel@athlonxp.bradney.info>
	 <3FD6B9B4.3040906@nishanet.com>
Content-Type: multipart/mixed; boundary="=-a7WveWE1FVt4lW3YDQDz"
Message-Id: <1071042693.4271.5.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 08:51:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a7WveWE1FVt4lW3YDQDz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Thanks to all for their replies.. Of course when I got the the PC this
morning.. hung. About 4 days uptime with the old IRQ0 patch it was ok
until 2am this morning.

So.. I have enabled preempt now.. and as for the patches I have put the
two 2.6test11 patches in that Jesse Allen attached for APIC and IO_APIC
that were I think originally created by Ross Dickson for 2.4.2x.

Should I also be adding in a CPU Disconnect patch (or running athcool as
theres nothing in my ASUS BIOS)?

Should I be running an ATA133 patch (previous emails indicate yes), and
if so, is there a 2.6test11 patch?

When I boot with nmi_watchdog=1 I get NMI values of about the same as
IRQ0, just a bit less (1500 less at this point). With nmi_watchdog=2, I
get barely any compared to IRQ0. IRQ0/timer is on IO-APIC-edge.

This is from my current boot up, with nmi 1, 
           CPU0
  0:     344998    IO-APIC-edge  timer
  1:       1517    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:       5313    IO-APIC-edge  i8042
 14:      10179    IO-APIC-edge  ide0
 15:        927    IO-APIC-edge  ide1
 19:      23551   IO-APIC-level  radeon@PCI:3:0:0
 21:       3882   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
 22:          3   IO-APIC-level  ohci1394
NMI:     343501
LOC:     343354
ERR:          0
MIS:          0

I have attached my dmesg outputs from the starts ups with the two nmi
options.

regards
Craig

On Wed, 2003-12-10 at 07:14, Bob wrote: 
> Craig Bradney wrote:
> 
> >What do the IDE ones[patches] claim to fix? I have had no real issue with IDE at
> >all.. being able to burn CDs, DVDs, use my ATA133 drive for hdparm,
> >greps, compilation, and general use.....
> >
> >Craig
> >
> 
> These patches belong together because the same
> necessity is the mother of their invention.
> 
> You may not have an offboard promise or sis hd
> controller.
> 
> Alan Cox looked at "nforce2 irq storm" and the
> offboard promise and sis controllers exposing
> that dma operations might be running out of
> time(time? timing..."timer"? a timer is a given
> so "timer" was unthinkable!) waiting for irq
> availability. That was months ago. It was only
> evident that giving a "bight of slack(1)" to those
> ops could help slightly, but we have a timer in
> any case, don't we?
> 
> One person with a timer patch may backed into
> the nforce2 solution while just trying to get
> nmi_watchdog to work, right?
> 
> Ian Kumlien looks most likely to reason the problem
> all the way through(2).
> 
> -Bob D
> 
> (1) "give me a bight of slack"
>      "ah, for a bitty byte of pre-unicode slack loop"
>   http://www.bartleby.com/61/13/B0241300.html
> 
> *bight*
>  
> 
> PRONUNCIATION <http://www.bartleby.com/61/12.html>: 	  
> <http://www.bartleby.com/61/wavs/13/B0241300.wav> bt
> NOUN: 	*1**a.* A loop in a rope. *b.* The middle or slack part of an 
> extended rope. *2**a.* A bend or curve, especially in a shoreline. *b.* 
> A wide bay formed by such a bend or curve.
> ETYMOLOGY: 	Middle English, bend, angle, from Old English /byht/. See 
> *bheug- <http://www.bartleby.com/61/roots/IE63.html>* in Appendix I.
> 
> 
> (2)  voted most likely to finesse through on a level above monkeys
> 
>  From Ian Kumlien:
> 
> I did some reading on amd's site, and if the disconnect + apic fixed the
> same problem as the ~500ns delay, then it could be as i suspect...
> 
> I suspect that something goes wrong with apic ack when the cpu is
> disconnected and according to the amd docs we could check the
> Northbridge's CLKFWDRST or isn't that avail on the outside?
> (It would be interesting to see if that fixes the problem as well.)
> 
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26237.PDF
> 
> I don't really have the knowledge but it would sure be nicer to fix this
> by checking this than to just disable it. I dunno if there is something
> we could do from within the kernel aswell with the sending of HLT but i
> doubt it.
> 
> Anyways, we need a generalized patch that does better checking on the
> NMI bit (like Ross' patch). 
> 
> PS. Anyone that can point me to northbridge tech docks? and CC
> 
> -- Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--=-a7WveWE1FVt4lW3YDQDz
Content-Disposition: attachment; filename=dmesg_afterpatch_r3_nmi_1
Content-Type: text/plain; name=dmesg_afterpatch_r3_nmi_1; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

000 Nvidia                                    ) @ 0x000f75e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff74c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0xf] global_irq[0xf] polarity[0x1] trigger[0x1])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda6 nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1913.382 MHz processor.
Console: colour VGA+ 80x25
Memory: 514424k/524224k available (2563k kernel code, 9052k reserved, 933k data, 168k init, 0k highmem)
Calibrating delay loop... 3784.70 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2600+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...
IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
..TIMER: works OK on apic pin0 irq0
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  0    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2-> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1912.0876 MHz.
..... host bus clock speed is 332.0674 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17)
ACPI: PCI Interrupt Link [APC3] (IRQs 18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)
00:00:01[A] -> 2-23 -> IRQ 23
Pin 2-23 already programmed
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc9 -> IRQ 16 Mode:1 Active:0)
00:01:06[A] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xd1 -> IRQ 17 Mode:1 Active:0)
00:01:06[B] -> 2-17 -> IRQ 17
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xd9 -> IRQ 18 Mode:1 Active:0)
00:01:06[C] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xe1 -> IRQ 19 Mode:1 Active:0)
00:01:06[D] -> 2-19 -> IRQ 19
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Supermount version 2.0.2a for kernel 2.6
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:01.0: 3Com PCI 3c920 Tornado at 0x9000. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-ROM SC-152C, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
hdc: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[22]  MMIO=[e0083000-e00837ff]  Max Packet=[2048]
ohci1394_0: SelfID received outside of bus reset sequence
ehci_hcd 0000:00:02.2: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem e0848000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000044dec8]
Adding 2008084k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500
registering 1-002d
registering 1-0049
registering 1-0048
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0: clocking to 47450
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:03:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:03:00.1 into 1x mode
[drm] Loading R200 Microcode

--=-a7WveWE1FVt4lW3YDQDz
Content-Disposition: attachment; filename=dmesg_afterpatch_r3_nmi_2
Content-Type: text/plain; name=dmesg_afterpatch_r3_nmi_2; charset=iso-8859-1
Content-Transfer-Encoding: 7bit


DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f75e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff74c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0xf] global_irq[0xf] polarity[0x1] trigger[0x1])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda6 nmi_watchdog=2
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1913.393 MHz processor.
Console: colour VGA+ 80x25
Memory: 514424k/524224k available (2563k kernel code, 9052k reserved, 933k data, 168k init, 0k highmem)
Calibrating delay loop... 3784.70 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2600+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...
IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
..TIMER: works OK on apic pin0 irq0
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  0    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2-> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1912.0941 MHz.
..... host bus clock speed is 332.0685 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb490, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17)
ACPI: PCI Interrupt Link [APC3] (IRQs 18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1 Active:0)
00:00:01[A] -> 2-23 -> IRQ 23
Pin 2-23 already programmed
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1 Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1 Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1 Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
Pin 2-22 already programmed
ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 21
Pin 2-21 already programmed
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 20
Pin 2-20 already programmed
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc9 -> IRQ 16 Mode:1 Active:0)
00:01:06[A] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xd1 -> IRQ 17 Mode:1 Active:0)
00:01:06[B] -> 2-17 -> IRQ 17
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xd9 -> IRQ 18 Mode:1 Active:0)
00:01:06[C] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xe1 -> IRQ 19 Mode:1 Active:0)
00:01:06[D] -> 2-19 -> IRQ 19
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Supermount version 2.0.2a for kernel 2.6
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:01.0: 3Com PCI 3c920 Tornado at 0x9000. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-ROM SC-152C, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
hdc: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[22]  MMIO=[e0083000-e00837ff]  Max Packet=[2048]
ohci1394_0: SelfID received outside of bus reset sequence
ehci_hcd 0000:00:02.2: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem e0848000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000044dec8]
Adding 2008084k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500
registering 1-002d
registering 1-0049
registering 1-0048
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0: clocking to 49371
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:03:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:03:00.1 into 1x mode
[drm] Loading R200 Microcode

--=-a7WveWE1FVt4lW3YDQDz--

