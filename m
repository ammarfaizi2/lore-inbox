Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbULBIy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbULBIy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbULBIy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:54:56 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:2944
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261569AbULBIvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:51:52 -0500
From: John Mock <kd6pag@qsl.net>
To: Andrew Morton <akpm@osdl.org>, zadiglist@zadig.ca
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-Id: <E1CZmgM-0000Lb-00@penngrove.fdns.net>
Date: Thu, 02 Dec 2004 00:51:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the subject of Linux 2.6.10-rc2 on a PowerMac 8500, i haven't managed
to get that to work yet. It doesn't affect me much (as the much-older sync
problem dominates), but another user seems to be struggling with the same 
issue:

    did you get 2.6.10-rc2 kernel working on your PowerMac 8500?
    I am asking you this question because I have the same problem on my
    powermac 7300 with onboard video and also on a Matrox PCI video card...
    the latest kernel working on this machine is 2.6.8... after that, nothing
    works... I did not try any pre-2.6.9 kernel... and right now, I am
    compiling 2.6.10-rc2-bk7 to see if it works...

I think i narrowed the problem down to changes between 2.6.8 and 2.6.9-rc1
in the file 'drivers/video/console/fbcon.c'.  Indeed, i was able to get
Linux 2.6.9 to work on a PowerMac 8500/G3 by dropping the Linux 2.6.8
'drivers/video/console/fbcon.c' into the 2.6.9 '.../console' directory.
So that might be some help if 2.6.9 is an improvement on the PowerMac 7300.

I tried to brutally hacking the older 'fbcon.c' to compile under 2.6.10-rc2
and predictably, it didn't execute properly.  So without a serial console, 
that seemed rather close to a hopeless case.  I might try another approach 
if time permits.

I can't say i've made much more progress on the Sony VAIO latop either.
The problem i reported earlier here can be worked around by 'rmmob'ing
'snd_intel8x0' before attempting a software suspend, but that hack wasn't
much improvement.  It still crashes fairly reproducibly if left idle for
awhile and then one/it attempts a software suspend.  The symptoms appear to
be recursive page faults.  A second crash involving software suspend looks
like it might be 'UART' related, but i'm not sure if i can reproduce that
one easily (as i'm not running that kernel).  Both are attached below.
(.config's available upon request.)  As often seems to be the case for me,
i had to manually transcribe some of the software suspend console output
(after "..."), and given my clerical skills, typos are quite likely.

Aside from software suspend, the other issue is that the firewire device
(DVD/CD-RW) does not work after software suspend.  I can document thst one
also if it's not already a well-known problem.

				-- JM

-------------------------------------------------------------------------------
Linux version 2.6.10-rc2 (tvr@tvr-vaio) (gcc version 3.3.5 (Debian 1:3.3.5-2)) #9 Tue Nov 30 10:51:06 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fcf0000 (usable)
 BIOS-e820: 000000000fcf0000 - 000000000fcfc000 (ACPI data)
 BIOS-e820: 000000000fcfc000 - 000000000fd00000 (ACPI NVS)
 BIOS-e820: 000000000fd00000 - 000000000fe80000 (usable)
 BIOS-e820: 000000000fe80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
0MB HIGHMEM available.
254MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.10-rc2 ro root=307 console=ttyS0,9600 console=tty1
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1127.239 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255040k/260608k available (1664k kernel code, 4984k reserved, 715k data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
vesafb: framebuffer at 0xe8000000, mapped to 0xd0880000, using 832k, total 832k
vesafb: mode is 1024x768x8, linelength=1024, pages=0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:1f.6 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
PWRB USB1 USB2 USB3  LAN CRD0  EC0 COMA MODE 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 144k freed
Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
Real Time Clock Driver v1.12
Sony Vaio Jogdial input method installed.
Sony Vaio Keys input method installed.
sonypi: Sony Programmable I/O Controller Driverv1.24.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 9 (level, low) -> IRQ 9
e100: eth0: e100_probe: addr 0xe0204000, irq 9, MAC addr 08:00:46:4E:8C:7E
NTFS driver 2.1.22 [Flags: R/W MODULE].
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
intel8x0_measure_ac97_clock: measured 49429 usecs
intel8x0: clocking to 48000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
uhci_hcd 0000:00:1d.0: irq 9, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: Product: Intel Corp. 82801CA/CAM USB (Hub #1)
usb usb1: Manufacturer: Linux 2.6.10-rc2 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
uhci_hcd 0000:00:1d.1: irq 9, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: Product: Intel Corp. 82801CA/CAM USB (Hub #2)
usb usb2: Manufacturer: Linux 2.6.10-rc2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
uhci_hcd 0000:00:1d.2: irq 9, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: Product: Intel Corp. 82801CA/CAM USB (Hub #3)
usb usb3: Manufacturer: Linux 2.6.10-rc2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: AC Adapter [ACAD] (on-line)
usb 3-1: new full speed USB device using uhci_hcd and address 2
ACPI: Battery Slot [BAT1] (battery present)
usb 3-1: Product: USB Memory Stick Slot
usb 3-1: Manufacturer: Sony
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: Sony      Model: MSC-U03           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:05.0 [104d:8100]
Yenta: ISA IRQ mask 0x04b8, PCI irq 9
Socket status: 30000006
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 9 (level, low) -> IRQ 9
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[e0205000-e02057ff]  Max Packet=[2048]
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
parport0: Printer, EPSON Stylus Photo 700
ieee1394: sbp2: Logged into SBP-2 device
hw_random hardware driver 1.0.0 loaded
  Vendor: MATSHITA  Model: UJDA730 DVD/CDRW  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [ATF0] (52 C)
lp0: using parport0 (interrupt-driven).
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
[drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82830 CGC [Chipset Graphics Controller]
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
[drm] Initialized i830 1.3.2 20021108 on minor 1: Intel Corp. 82830 CGC [Chipset Graphics Controller] (#2)
mtrr: base(0xe8000000) is not aligned on a size(0x180000) boundary
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
sonypi: removed.
uhci_hcd 0000:00:1d.0: remove, state 1
usb usb1: USB disconnect, address 1
uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
uhci_hcd 0000:00:1d.1: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
uhci_hcd 0000:00:1d.2: remove, state 1
usb usb3: USB disconnect, address 1
usb 3-1: USB disconnect, address 2
uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
Stopping tasks: ============================================================<1>Unable to handle kernel paging request at virtual address d08562bc
 printing eip:
c015fe2b
*pde = 0123a067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in: i830 lp autofs4 thermal fan button processor sr_mod cdrom eepro100 hw_random sbp2 parport_pc parport ohci1394 ieee1394 yenta_socket pcmcia_core sd_mod usb_storage scsi_mod battery ac usbcore snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc nfsd exportfs nfs lockd sunrpc ntfs e100 mii smbfs nls_iso8859_1 nls_cp437 rtc
CPU:    0
EIP:    0060:[<c015fe2b>]    Tainted: GF     VLI
EFLAGS: 00010286   (2.6.10-rc2) 
EIP is at do_select+0x1fb/0x280
eax: c7c92f60   ebx: c7c92f60   ecx: 00000005   edx: d08562a0
esi: 00000020   edi: 00000005   ebp: c8419f60   esp: c8419ef0
ds: 007b   es: 007b   ss: 0068
Process rsjog (pid: 3425, threadinfo=c8418000 task=c8b43580)
Stack: c8698560 00000000 00000000 00000000 00000068 00000000 00000000 00000000 
       00000005 00000145 00000068 c8418000 c932afec c932afe8 c932afe4 c932aff4 
       c932aff0 c932afec 7fffffff 00000000 00000000 c015fa80 c18cd000 00000000 
Call Trace:
 [<c01034ff>] show_stack+0x7f/0xa0
 [<c01036a6>] show_registers+0x156/0x1c0
 [<c0103898>] die+0xc8/0x150
 [<c01111e6>] do_page_fault+0x376/0x6d4
 [<c0103197>] error_code+0x2b/0x30
 [<c016019e>] sys_select+0x2ae/0x570
 [<c0102fef>] syscall_call+0x7/0xb
Code: 45 a4 8b 55 cc 89 02 e9 22 ff ff ff 8d 74 26 00 89 f8 e8 b9 ee fe ff 85 c0 89 c3 74 ad 8b 50 10 c7 45 b4 45 01 00 00 85 d2 74 1f <8b> 42 1c 85 c0 74 18 89 1c 24 8b 4d dc 31 c0 85 c9 0f 44 45 e0 
 ==<1>Unable to handle kernel paging request at virtual address d08562cc
 printing eip:
c014d571
*pde = 0123a067
*pte = 00000000
Oops: 0000 [#2]
Modules linked in: i830 lp autofs4 thermal fan button processor sr_mod cdrom eepro100 hw_random sbp2 parport_pc parport ohci1394 ieee1394 yenta_socket pcmcia_core sd_mod usb_storage scsi_mod battery ac usbcore snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc nfsd exportfs nfs lockd sunrpc ntfs e100 mii smbfs nls_iso8859_1 nls_cp437 rtc
CPU:    0
EIP:    0060:[<c014d571>]    Tainted: GF     VLI
EFLAGS: 00010286   (2.6.10-rc2) 
EIP is at filp_close+0x31/0x90
eax: d08562a0   ebx: c7c92f60   ecx: 00000246   edx: c7c92f60
esi: 00000000   edi: cfa0da20   ebp: c8419d50   esp: c8419d3c
ds: 007b   es: 007b   ss: 0068
Process rsjog (pid: 3425, threadinfo=c8418000 task=c8b43580)
Stack: c818f100 cfa0da20 0000000f 00000005 cfa0da20 c8419d70 c01171d4 c7c92f60 
       cfa0da20 00000001 ce859900 ce85992c c8b43580 c8419d9c c0117ee5 c8b43580 
       0000002b c02aca1c c8419ddc 00000001 0000000b c8418000 00000000 c02aca1c 
Call Trace:
 [<c01034ff>] show_stack+0x7f/0xa0
 [<c01036a6>] show_registers+0x156/0x1c0
 [<c0103898>] die+0xc8/0x150
 [<c01111e6>] do_page_fault+0x376/0x6d4
 [<c0103197>] error_code+0x2b/0x30
 [<c01171d4>] put_files_struct+0x74/0xe0
 [<c0117ee5>] do_exit+0x115/0x3c0
 [<c0103918>] die+0x148/0x150
 [<c01111e6>] do_page_fault+0x376/0x6d4
 [<c0103197>] error_code+0x2b/0x30
 [<c016019e>] sys_select+0x2ae/0x570
 [<c0102fef>] syscall_call+0x7/0xb
Code: 89 5d f4 8b 5d 08 89 7d fc 8b 7d 0c 89 75 f8 8b 73 20 85 f6 74 07 c7 43 20 00 00 00 00 8b 43 14 85 c0 74 49 8b 43 10 85 c0 74 07 <8b> 50 2c 85 d2 75 2e 89 7c 24 04 89 1c 24 e8 5c 8f 02 00 89 7c 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c011402b
*pde = 00000000
Oops: 0000 [#3]
Modules linked in: i830 lp autofs4 thermal fan button processor sr_mod cdrom eepro100 hw_random sbp2 parport_pc parport ohci1394 ieee1394 yenta_socket pcmcia_core sd_mod usb_storage scsi_mod battery ac usbcore snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc nfsd exportfs nfs lockd sunrpc ntfs e100 mii smbfs nls_iso8859_1 nls_cp437 rtc
CPU:    0
EIP:    0060:[<c011402b>]    Tainted: GF     VLI
EFLAGS: 00010286   (2.6.10-rc2) 
EIP is at mm_release+0x3b/0xc0
eax: 00000000   ebx: b7c62848   ecx: 00000000   edx: 00000000
esi: c8b43580   edi: c8b43580   ebp: c8419bbc   esp: c8419b9c
ds: 007b   es: 007b   ss: 0068
Process rsjog (pid: 3425, threadinfo=c8418000 task=c8b43580)
Stack: c8419bb4 c0104b7c c8419bc8 c0116117 ffffe000 c02aca7e 00000000 00000000 
       c8419be8 c0117e63 c8b43580 00000000 c02aca1c c8419c28 00000000 0000000b 
       c8418000 00000000 c02aca1c c8419c28 c0103918 00000000 00000001 c8419c00 
Call Trace:
 [<c01034ff>] show_stack+0x7f/0xa0
 [<c01036a6>] show_registers+0x156/0x1c0
 [<c0103898>] die+0xc8/0x150
 [<c01111e6>] do_page_fault+0x376/0x6d4
 [<c0103197>] error_code+0x2b/0x30
 [<c0117e63>] do_exit+0x93/0x3c0
 [<c0103918>] die+0x148/0x150
 [<c01111e6>] do_page_fault+0x376/0x6d4
 [<c0103197>] error_code+0x2b/0x30
 [<c01171d4>] put_files_struct+0x74/0xe0
 [<c0117ee5>] do_exit+0x115/0x3c0
 [<c0103918>] die+0x148/0x150
 [<c01111e6>] do_page_fault+0x376/0x6d4
 [<c0103197>] error_code+0x2b/0x30
 [<c016019e>] sys_select+0x2ae/0x570
 [<c0102fef>] syscall_call+0x7/0xb
Code: f8 8b 96 10 01 00 00 8e e0 8e e8 85 d2 74 0f 31 c0 89 86 10 01 00 00 89 d0 e8 92 ee ff ff 8b 9e 18 01 00 00 85 db 74 09 8b 45 0c <8b> 40 20 48 7f 0f 8b 5d f8 8b 75 fc 89 ec 5d c3 90 8d 74 26 00 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000020
	      ...
_______________________________________________________________________________
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fcf0000 (usable)
 BIOS-e820: 000000000fcf0000 - 000000000fcfc000 (ACPI data)
 BIOS-e820: 000000000fcfc000 - 000000000fd00000 (ACPI NVS)
 BIOS-e820: 000000000fd00000 - 000000000fe80000 (usable)
 BIOS-e820: 000000000fe80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
0MB HIGHMEM available.
254MB LOWMEM available.
DMI present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.10-rc2 ro root=307 console=ttyS0,9600 console=tty1
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1127.239 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255516k/260608k available (1301k kernel code, 4508k reserved, 629k data, 132k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
Linux NoNET1.0 for Linux 2.6
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9) *0
ACPI: PCI Interrupt Link [LNKG] (IRQs 9) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0, disabled.
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x36 set to 0x1
vesafb: framebuffer at 0xe8000000, mapped to 0xd0880000, using 832k, total 832k
vesafb: mode is 1024x768x8, linelength=1024, pages=0
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 830M Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Enabling device 0000:00:1f.6 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
PWRB USB1 USB2 USB3  LAN CRD0  EC0 COMA MODE 
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda7: orphan cleanup on readonly fs
EXT3-fs: hda7: 16 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
Real Time Clock Driver v1.12
Sony Vaio Jogdial input method installed.
Sony Vaio Keys input method installed.
sonypi: Sony Programmable I/O Controller Driverv1.24.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
NTFS driver 2.1.22 [Flags: R/W MODULE].
PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
intel8x0_measure_ac97_clock: measured 49468 usecs
intel8x0: clocking to 48000
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
hw_random hardware driver 1.0.0 loaded
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Thermal Zone [ATF0] (49 C)
sonypi: removed.
Stopping tasks: ==================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done (51850 pages freed)
	...
suspend: (pages needed: 4325 + 514 free: 60825)
.<7>[nosave pfn 0x2de]<7>[nosave pfn 0x2df]............swsusp: critical section/: done (4357 pages copied)
swsusp: Restoring Highmem
PM: writing Image.
ACPI: PCI interrupt 0000:00:1f.1[A}: no GSI
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timr of device 0000:00:1f.5 to 64
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0205045
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: autofs4 thermal fan button processor hw_random battery ac snd_ac_codec snd_pcm snd_timer snd soundcore snd_page_alloc ntfs nls_iso8059_1 nls_cp437 rtc
CPU:    0
EIP:    0060:[<C0205045>]   Not tainted VLI
EFLAGS: 00010202   (2.6.10-rc2)
EIP is at uart_change_speed+0x15/0x90
eax: 00000000   ebx: cfd16000   ecx: c02c0200   edx: 00000000
esi: c0324100   edi: c0324100   ebp: cb805e84   esp: cb805e70
ds: 007b   es: 007b   ss: 0068
Process sh (pid: 3705, threadinfo=cb804000 task=ce494aa0)
Stack: c0324100 00000000 00000003 c0324100 cfd16000 cb805ea0 c0207001 cfd16000
       00000000 c0324100 c0324608 c126e768 cb805ebc c020a7d8 c02c02a0 c0324100
       c126e768 c126e768 c025e377 cb805ed0 c020f34b c126e768 00000002 c126e7f8
Call Trace:
 [...] show_stack+0x7f/0xa0
 [...] show_registers+0x156/0x1c0
 [...] die+0xc8/0x150
 [...] do_page_fault+0x376/0x6d4
 [...] uart_resume_port+0xd1/0xf0
 [...] serial8250_resume+0x5b/0x70
 [...] platform_resume+0x5b/0x60
 [...] resume_device+0x29/0x30
 [...] dpm_resume+0xdb/0xe0
 [...] device_resume+0x2c/0x40
 [...] swsusp_write+0x9/0x20
 [...] pm_suspend_disk+0x70/0xc0
 [...] enter_state+0x95/0xa0
 [...] acpi_system_write_sleep+0x6b/0x86
 [...] vfs_write+0xaa/0x130
 [...] syscall_call+0x7/0xb
Code: 83 f8 30 75 e2 8b 41 68 eb ec 8d b6 00 00 00 00 8d bf 00 00 00 00 55 89 e5 83 ec 14 89 5e f8 8b 5d f8 8b 5d 08 89 75 fc 8b 53 10 8b 73 13 <8b> 02 85 c0 74 3e 8b 46 60 85 c0 74 37 8b
===============================================================================
