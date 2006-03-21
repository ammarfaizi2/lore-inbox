Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWCUVyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWCUVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWCUVyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:54:08 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:56277
	"EHLO rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S1751773AbWCUVyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:54:06 -0500
Subject: Re: p4-clockmod not working in 2.6.16
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321210106.GA25370@redhat.com>
References: <1142974528.3470.4.camel@localhost>
	 <20060321210106.GA25370@redhat.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 22:57:10 +0100
Message-Id: <1142978230.3470.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 16:01 -0500, Dave Jones wrote:
> On Tue, Mar 21, 2006 at 09:55:28PM +0100, Sasa Ostrouska wrote:
>  > Hello people,
>  > 
>  > I would like to advise you that in kernel 2.6.16 the 
>  > p4-clockmod module cant recognise my P4 cpu anymore.
>  > 
>  > This worked perfectly in kernel 2.6.15. I get the following
>  > error when I modprobe it:
>  > 
>  > root@rc-vaio:/home/sasa# modprobe msr && modprobe cpuid && modprobe
>  > p4_clockmod && modprobe speedstep-lib && modprobe microcode && modprobe
>  > hwmon
>  > FATAL: Error inserting p4_clockmod
>  > (/lib/modules/2.6.16/kernel/arch/i386/kernel/cpu/cpufreq/p4-clockmod.ko): No such device
>  > 
>  > Can somebody explain what happened or how can I set it up ?
> 
> Can you send /proc/cpuinfo and dmesg output please ?
> The only thing that recently changed in p4-clockmod is addition
> of an errata workaround that disables freqs <2GHz on certain CPUs.
> 
> If the max freq is <2GHz this would disable it completely.
> 
> 		Dave
> 

Hi Dave, here it is, this is on a Sony Vaio PCG-GRT816S laptop:


root@rc-vaio:/home/sasa# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2807.083
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 5617.52

============================================================================

root@rc-vaio:/home/sasa# dmesg
CPU 2.80GHz stepping 09
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=16 apic2=-1 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd996, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Embedded Controller [EC0] (gpe 21) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
pnp: 00:04: ioport range 0x8000-0x808f could not be reserved
pnp: 00:04: ioport range 0x8090-0x80ff has been reserved
pnp: 00:04: ioport range 0x8100-0x811f has been reserved
pnp: 00:04: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:04: ioport range 0xfe00-0xfe00 has been reserved
PCI: Failed to allocate mem resource #6:20000@f0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d5000000-d5ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0a.1
  IO window: 00002c00-00002cff
  IO window: 00003000-000030ff
  PREFETCH window: 54000000-55ffffff
  MEM window: 56000000-57ffffff
PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 16
PCI: Enabling device 0000:00:0a.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:0a.1[A] -> GSI 17 (level, low) -> IRQ 16
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1142855513.672:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vesafb: framebuffer at 0xe0000000, mapped to 0xf0880000, using 3750k,
total 65536k
vesafb: mode is 800x600x32, linelength=3200, pages=1
vesafb: protected mode interface info at c000:f770
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:02.6 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 17
ACPI: PCI interrupt for device 0000:00:02.6 disabled
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N080ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PIONEER DVD-RW DVR-K12D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Mar 20 2006
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
ip_conntrack version 2.4 (8175 buckets, 65400 max) - 172 bytes per
conntrack
input: AT Translated Set 2 keyboard as /class/input/input0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
PWRB COMA  EC0 USB0 USB1 USB2 USB3  ACM  AUD  LAN  CB0  CB1
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 1839376k swap on /dev/hda3.  Priority:-1 extents:1
across:1839376k
Linux agpgart interface v0.101 (c) Dave Jones
input: PS/2 Generic Mouse as /class/input/input1
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:00:0a.0 [104d:814e]
Yenta: ISA IRQ mask 0x04b8, PCI irq 16
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:0a.1[A] -> GSI 17 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:00:0a.1 [104d:814e]
Yenta: ISA IRQ mask 0x04b8, PCI irq 16
Socket status: 30000006
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 18
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-8174  Tue Nov
22 17:48:37 PST 2005
sis900.c: v1.08.09 Sep. 19 2005
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 19 (level, low) -> IRQ 19
0000:00:04.0: Realtek RTL8201 PHY transceiver found at address 1.
0000:00:04.0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x2000, IRQ 19, 08:00:46:b4:10:b5.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Enabling device 0000:00:03.3 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 20
ehci_hcd 0000:00:03.3: EHCI Host Controller
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.3: irq 20, io mem 0xd4003000
ehci_hcd 0000:00:03.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 21
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.0: irq 21, io mem 0xd4000000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 22
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.1: irq 22, io mem 0xd4001000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Enabling device 0000:00:03.2 (0010 -> 0012)
ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 23
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:03.2: irq 23, io mem 0xd4002000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using ohci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
usb 4-2: new full speed USB device using ohci_hcd and address 2
ACPI: PCI Interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 17
eth0: Media Link On 100mbps full-duplex
usb 4-2: configuration #1 chosen from 1 choice
intel8x0_measure_ac97_clock: measured 50479 usecs
intel8x0: clocking to 48000
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: Logitech USB Receiver as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:03.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
i2c-sis96x version 1.0.0
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x8100
agpgart: Detected SiS 648 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
  Vendor: Sony      Model: MSC-U03           Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete
sd 0:0:0:0: Attached scsi removable disk sda
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input3
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
USB Universal Host Controller Interface driver v2.3
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
lp0: using parport0 (interrupt-driven).
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: SiS delay workaround: giving bridge time to recover.
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: SiS delay workaround: giving bridge time to recover.
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150802800,
high=8, low=16585072, sector=150802800
ide: failed opcode was: unknown
end_request: I/O error, dev hda, sector 150802800
ReiserFS: hda2: warning: vs-13070: reiserfs_read_locked_inode: i/o
failure occurred trying to find stat data of [5932063 5932077 0x0 SD]
process `dig' is using obsolete setsockopt SO_BSDCOMPAT
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: SiS delay workaround: giving bridge time to recover.
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: SiS delay workaround: giving bridge time to recover.
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
CPU0: Temperature above threshold
CPU0: Running in modulated clock mode
root@rc-vaio:/home/sasa#

Thanks, if you need something else please just let me know.
Best Regards
Sasa Ostrouska




