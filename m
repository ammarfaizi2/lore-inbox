Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWFIOng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWFIOng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWFIOng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:43:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:55775 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751320AbWFIOnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:43:32 -0400
X-Authenticated: #2308221
Date: Fri, 9 Jun 2006 16:43:26 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: acpi dock test-drive
Message-ID: <20060609144326.GA6093@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

finally I had the chance to try out the fruit of your work on my Dell
Latitude CPiA. First of all, congratulations for the ACPI part, which
seems to work pretty well so far: the second PCI bridge is detected
after a hot-dock. However, the PCI devices behind that bridge are not
yet discovered. Pushing the undock request button on the docking station
itself results in the PCI bridge being removed again - so far, so good : )

On the other hand, the undock request caused a reproducible Oops at the
first time, and kacpid exit the second time. After that, pushing the
button has no further effect ; )

This is what happened during hot-docking:

--
hub 1-0:1.0: over-current change on port 1
hub 1-0:1.0: over-current change on port 2
hub 1-0:1.0: over-current change on port 1
ACPI: docking
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.MPCI._PRT]
ACPI: Power Resource [PADA] (on)
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fd000000-feffffff
  PREFETCH window: f8000000-f9ffffff
PCI: Bus 2, cardbus bridge: 0000:00:03.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Bus 6, cardbus bridge: 0000:00:03.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 24000000-25ffffff
  MEM window: 26000000-27ffffff
PCI: Bridge: 0000:00:11.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Setting latency timer of device 0000:00:11.0 to 64
--

And here goes the Oops:

--
BUG: unable to handle kernel paging request at virtual address 00100104
 printing eip:
c01fdf5e
*pde =3D 0e426067
*pte =3D 00000000
Oops: 0002 [#1]
PREEMPT=20
Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event=
 snd_seq snd_seq_device xfs ext2 loop sg sr_mod ide_scsi rtc tun pcmcia fir=
mware_class ata_piix libata scsi_mod snd_nm256 snd_ac97_codec snd_ac97_bus =
snd_pcm snd_timer snd_page_alloc snd soundcore intel_agp agpgart evdev 8250=
_pnp yenta_socket rsrc_nonstatic uhci_hcd ide_cd cdrom usbcore pcmcia_core =
8250 parport_pc serial_core parport psmouse reiser4 piix ide_disk ide_core =
microcode unix
CPU:    0
EIP:    0060:[<c01fdf5e>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17-rc6-git #9)=20
EIP is at acpi_device_unregister+0x24/0xc7
eax: 00200200   ebx: cffa4400   ecx: cffa4410   edx: 00100100
esi: cffa4420   edi: 00000000   ebp: 00000001   esp: cffbeec4
ds: 007b   es: 007b   ss: 0068
Process kacpid (pid: 8, threadinfo=3Dcffbe000 task=3Dcffc1570)
Stack: cffa4400 00000001 c01fe0a3 cffa4400 cffb0800 c01fe142 00000008 c1238=
9a0=20
       c1238ba0 cffa4400 cf80a840 cf80a6a8 cf80aa20 00000003 c01f9381 cffa4=
400=20
       cf80aa20 00000001 cffe18a0 cffbe000 c01f9499 ce96fc00 c01f614b 00000=
00f=20
Call Trace:
 <c01fe0a3> acpi_bus_remove+0xa2/0xa7  <c01fe142> acpi_bus_trim+0x9a/0xc6
 <c01f9381> hotplug_dock_devices+0x7e/0x9e  <c01f9499> dock_notify+0xc8/0x1=
4c
 <c01f614b> acpi_bus_check_device+0x36/0x75  <c01f6201> acpi_bus_notify+0x4=
7/0x49
 <c01e373a> acpi_ev_notify_dispatch+0x49/0x52  <c01de7ea> acpi_os_execute_d=
eferred+0xc/0x16
 <c0127068> run_workqueue+0x98/0x130  <c01de7de> acpi_os_execute_deferred+0=
x0/0x16
 <c0127667> worker_thread+0x107/0x140  <c0114000> default_wake_function+0x0=
/0x10
 <c0127560> worker_thread+0x0/0x140  <c012a3d7> kthread+0xb7/0xf0
 <c012a320> kthread+0x0/0xf0  <c0101005> kernel_thread_helper+0x5/0x10
Code: e8 78 dc f5 ff eb c2 56 53 89 c3 b8 00 f0 ff ff 21 e0 ff 40 14 83 7b =
04 00 8d 73 20 0f 84 8a 00 00 00 8d 4b 10 8b 53 10 8b 41 04 <89> 42 04 89 1=
0 c7 41 04 00 02 20 00 8b 53 20 8b 4e 04 c7 43 10=20
EIP: [<c01fdf5e>] acpi_device_unregister+0x24/0xc7 SS:ESP 0068:cffbeec4
 <6>note: kacpid[8] exited with preempt_count 2
--

Attached are dmesg and lspci dumps for different configurations, where
undock means booted outside the dock, hotdock is after insertion, and
colddockboot was booted in docked state with full hardware detection.

Besides, I have the following .config items related to ACPI and hotplug:

CONFIG_HOTPLUG=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_DOCK=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_BLACKLIST_YEAR=3D0
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dy
CONFIG_HOTPLUG_PCI=3Dy
CONFIG_HOTPLUG_PCI_ACPI=3Dy
CONFIG_HOTPLUG_PCI_SHPC=3Dy
CONFIG_PNPACPI=3Dy


If there is anything else that might be helpful, let me know and I'll provi=
de it asap.

Kind regards,
Chris


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=dmesg-undocked
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.17-rc6-git (uziel@hermes) (gcc-Version 4.1.1 (Gentoo 4.1.=
1)) #9 PREEMPT Fri Jun 9 15:49:28 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000fff0000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61420 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000f38f0
ACPI: RSDT (v001 DELL    CPi A   0x27d10b07 ASL  0x00000061) @ 0x0fff0000
ACPI: FADT (v001 DELL    CPi A   0x27d10b07 ASL  0x00000061) @ 0x0fff0400
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 20000000 (gap: 10100000:efd00000)
Built 1 zonelists
Kernel command line: hostname=3Dhermes dyntick=3Ddisable noresume2 rw panic=
=3D15 resume2=3Dswap:/dev/hda7 video=3Dneofb:1024x768-16@60 splash=3Dverbos=
e,theme:lena ramfsinit=3Dverbose quiet 2
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc031c000 soft=3Dc031b000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 498.668 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 249096k/262064k available (1517k kernel code, 12444k reserved, 470k=
 data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 997.52 BogoMIPS (lpj=3D498=
763)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00=
000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0820)
checking if image is initramfs... it is
Freeing initrd memory: 7890k freed
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver=20
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfc0ee, last bus=3D1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:07.1
PCI quirk: region 0800-083f claimed by PIIX4 ACPI
PCI quirk: region 0840-084f claimed by PIIX4 SMB
PIIX4 devres B PIO at 00e0-00e7
PIIX4 devres C PIO at 0850-085f
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PADA] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x800-0x805 could not be reserved
pnp: 00:02: ioport range 0x808-0x80f could not be reserved
pnp: 00:03: ioport range 0x806-0x807 has been reserved
pnp: 00:03: ioport range 0x850-0x853 has been reserved
pnp: 00:03: ioport range 0x856-0x85f has been reserved
pnp: 00:03: ioport range 0x810-0x83f has been reserved
pnp: 00:03: ioport range 0x840-0x84f has been reserved
pnp: 00:04: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:09: ioport range 0x3f0-0x3f1 has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fd000000-feffffff
  PREFETCH window: f8000000-f9ffffff
PCI: Bus 2, cardbus bridge: 0000:00:03.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Bus 6, cardbus bridge: 0000:00:03.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 24000000-25ffffff
  MEM window: 26000000-27ffffff
PCI: Enabling device 0000:00:03.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Enabling device 0000:00:03.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
* Found PM-Timer Bug on this chipset. Due to workarounds for a bug,
* this time source is slow.  Consider trying other time sources (clock=3D)
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp_glue: can't get bus number, assuming 0
acpiphp: Slot [1] registered
acpiphp: Slot [2] registered
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
neofb: mapped io at d0880000
Autodetected internal display
Panel is a 1024x768 color TFT display
neofb: mapped framebuffer at d0b00000
neofb v0.4.2: 2560kB VRAM, using 1024x768, 48.364kHz, 60Hz
Console: switching to colour frame buffer device 128x96
fb0: MagicGraph 256AV frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THM] (49 C)
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP westwood registered
Using IPI Shortcut mode
Suspend2 Core.
Suspend2 Compression Driver loading.
Suspend2 Encryption Driver loading.
Suspend2 Swap Writer loading.
ACPI wakeup devices:=20
 LID PBTN PCI0 UAR1 MPCI=20
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 144k freed
NET: Registered protocol family 1
input: AT Translated Set 2 keyboard as /class/input/input0
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IBM-DJSA-220, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=3D38760/16/63, UDMA(3=
3)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hd=
a15 >
Probing IDE interface ide1...
hdc: Samsung CD-RW/DVD-ROM SN-308B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Loading Reiser4. See www.namesys.com for a description of Reiser4.
reiser4[mount(394)]: disable_write_barrier (/usr/src/sources/linux-git/fs/r=
eiser4/wander.c:234)[zam-1055]:
NOTICE: hda6 does not support write barriers, using synchronous write inste=
ad.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EC=
P,DMA]
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
Synaptics Touchpad, model: 1, fw: 4.2, id: 0x844a1, caps: 0x0/0x0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000ece0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
input: SynPS/2 Synaptics TouchPad as /class/input/input1
00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
Yenta: CardBus bridge found at 0000:00:03.0 [1028:0088]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:03.0, mfunc 0x01261222, devctl 0x64
Yenta: ISA IRQ mask 0x0438, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
Yenta: CardBus bridge found at 0000:00:03.1 [1028:0088]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:03.1, mfunc 0x01261222, devctl 0x64
Yenta: ISA IRQ mask 0x0438, PCI irq 11
Socket status: 30000006
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xf4000000
PCI: Enabling device 0000:01:00.1 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:01:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
nm256: found card signature in video RAM: 0x27ec00
nm256: Mapping port 1 from 0x2709a0 - 0x27ec00
SCSI subsystem initialized
libata version 1.20 loaded.
Adding 530104k swap on /dev/hda7.  Priority:0 extents:1 across:530104k
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Real Time Clock Driver v1.12ac
loop: loaded (max 8 devices)
SGI XFS with no debug enabled
XFS mounting filesystem hda15
Ending clean XFS mount for filesystem: hda15

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=lspci-undocked

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0c 02 00 00 00 00 00 09 03 10 11 11 00 00 00 00
60: 08 10 18 20 20 20 20 20 00 00 00 20 00 00 00 00
70: 20 1f 0a b8 55 00 0f 01 03 0f dc 38 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 1f 00 00 00 00 00 00 00 00
b0: 80 20 00 00 30 00 00 00 00 00 79 0f 20 10 00 00
c0: 00 00 00 00 00 00 00 00 18 0c 00 00 00 00 00 00
d0: 08 10 02 02 02 12 22 00 0c 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fd000000-feffffff
	Prefetchable memory behind bridge: f8000000-f9ffffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR+
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 01 20 02 03 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 c0 a0 82
20: 00 fd f0 fe 00 f8 f0 f9 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 28000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 00 00 28 a0 00 00 02 00 02 05 b0 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 ff 01 40 05
40: 28 10 88 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 f0 24 20 00 00 00 00 00 00 00 00 22 12 26 01
90: c0 a7 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 1b 08 00 00 07 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 28001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 24000000-25fff000 (prefetchable)
	Memory window 1: 26000000-27fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 10 00 28 a0 00 00 02 00 06 09 b0 00 00 00 24
20: 00 f0 ff 25 00 00 00 26 00 f0 ff 27 00 18 00 00
30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 ff 01 c0 05
40: 28 10 88 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 d0 24 20 00 00 00 00 00 00 00 00 22 12 26 01
90: c0 a6 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 1b 08 00 00 07 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 01 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 44 00 32 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 05 80 0b d2 00 00 00 00 f2 00 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 06 41 81 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 0860 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 e3 07 e3 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ece0 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 08 00 00 0f ff bf 1f a4 3f 00 00 00 00 00 00
50: 00 50 04 00 00 40 7d 8a 67 00 00 02 00 00 00 90
60: e0 00 67 62 50 08 6f 78 00 00 00 00 00 00 00 00
70: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 41 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

01:00.0 VGA compatible controller: Neomagic Corporation NM2200 [MagicGraph 256AV] (rev 20) (prog-if 00 [VGA])
	Subsystem: Dell Latitude CPi A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f9000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fdc00000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at fdb00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c8 10 05 00 07 00 90 02 20 00 00 03 00 20 80 00
10: 08 00 00 f9 00 00 c0 fd 00 00 b0 fd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.1 Multimedia audio controller: Neomagic Corporation NM2200 [MagicMedia 256AV Audio] (rev 20)
	Subsystem: Dell Latitude CPi A
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at f8c00000 (32-bit, prefetchable) [size=4M]
	Region 1: Memory at fda00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c8 10 05 80 02 00 90 02 20 00 01 04 00 00 80 00
10: 08 00 c0 f8 00 00 a0 fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=dmesg-hotdock
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.17-rc6-git (uziel@hermes) (gcc-Version 4.1.1 (Gentoo 4.1.=
1)) #9 PREEMPT Fri Jun 9 15:49:28 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000fff0000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61420 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000f38f0
ACPI: RSDT (v001 DELL    CPi A   0x27d10b07 ASL  0x00000061) @ 0x0fff0000
ACPI: FADT (v001 DELL    CPi A   0x27d10b07 ASL  0x00000061) @ 0x0fff0400
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 20000000 (gap: 10100000:efd00000)
Built 1 zonelists
Kernel command line: hostname=3Dhermes dyntick=3Ddisable noresume2 rw panic=
=3D15 resume2=3Dswap:/dev/hda7 video=3Dneofb:1024x768-16@60 splash=3Dverbos=
e,theme:lena ramfsinit=3Dverbose quiet 2
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc031c000 soft=3Dc031b000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 498.668 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 249096k/262064k available (1517k kernel code, 12444k reserved, 470k=
 data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 997.52 BogoMIPS (lpj=3D498=
763)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00=
000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0820)
checking if image is initramfs... it is
Freeing initrd memory: 7890k freed
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver=20
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfc0ee, last bus=3D1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:07.1
PCI quirk: region 0800-083f claimed by PIIX4 ACPI
PCI quirk: region 0840-084f claimed by PIIX4 SMB
PIIX4 devres B PIO at 00e0-00e7
PIIX4 devres C PIO at 0850-085f
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PADA] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x800-0x805 could not be reserved
pnp: 00:02: ioport range 0x808-0x80f could not be reserved
pnp: 00:03: ioport range 0x806-0x807 has been reserved
pnp: 00:03: ioport range 0x850-0x853 has been reserved
pnp: 00:03: ioport range 0x856-0x85f has been reserved
pnp: 00:03: ioport range 0x810-0x83f has been reserved
pnp: 00:03: ioport range 0x840-0x84f has been reserved
pnp: 00:04: ioport range 0xf400-0xf4fe has been reserved
pnp: 00:09: ioport range 0x3f0-0x3f1 has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fd000000-feffffff
  PREFETCH window: f8000000-f9ffffff
PCI: Bus 2, cardbus bridge: 0000:00:03.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Bus 6, cardbus bridge: 0000:00:03.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 24000000-25ffffff
  MEM window: 26000000-27ffffff
PCI: Enabling device 0000:00:03.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Enabling device 0000:00:03.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
* Found PM-Timer Bug on this chipset. Due to workarounds for a bug,
* this time source is slow.  Consider trying other time sources (clock=3D)
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp_glue: can't get bus number, assuming 0
acpiphp: Slot [1] registered
acpiphp: Slot [2] registered
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
neofb: mapped io at d0880000
Autodetected internal display
Panel is a 1024x768 color TFT display
neofb: mapped framebuffer at d0b00000
neofb v0.4.2: 2560kB VRAM, using 1024x768, 48.364kHz, 60Hz
Console: switching to colour frame buffer device 128x96
fb0: MagicGraph 256AV frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THM] (49 C)
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP westwood registered
Using IPI Shortcut mode
Suspend2 Core.
Suspend2 Compression Driver loading.
Suspend2 Encryption Driver loading.
Suspend2 Swap Writer loading.
ACPI wakeup devices:=20
 LID PBTN PCI0 UAR1 MPCI=20
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 144k freed
NET: Registered protocol family 1
input: AT Translated Set 2 keyboard as /class/input/input0
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IBM-DJSA-220, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=3D38760/16/63, UDMA(3=
3)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hd=
a15 >
Probing IDE interface ide1...
hdc: Samsung CD-RW/DVD-ROM SN-308B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Loading Reiser4. See www.namesys.com for a description of Reiser4.
reiser4[mount(394)]: disable_write_barrier (/usr/src/sources/linux-git/fs/r=
eiser4/wander.c:234)[zam-1055]:
NOTICE: hda6 does not support write barriers, using synchronous write inste=
ad.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EC=
P,DMA]
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
usbcore: registered new driver usbfs
usbcore: registered new driver hub
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
Synaptics Touchpad, model: 1, fw: 4.2, id: 0x844a1, caps: 0x0/0x0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000ece0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
input: SynPS/2 Synaptics TouchPad as /class/input/input1
00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
Yenta: CardBus bridge found at 0000:00:03.0 [1028:0088]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:03.0, mfunc 0x01261222, devctl 0x64
Yenta: ISA IRQ mask 0x0438, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
Yenta: CardBus bridge found at 0000:00:03.1 [1028:0088]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:03.1, mfunc 0x01261222, devctl 0x64
Yenta: ISA IRQ mask 0x0438, PCI irq 11
Socket status: 30000006
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xf4000000
PCI: Enabling device 0000:01:00.1 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:01:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
nm256: found card signature in video RAM: 0x27ec00
nm256: Mapping port 1 from 0x2709a0 - 0x27ec00
SCSI subsystem initialized
libata version 1.20 loaded.
Adding 530104k swap on /dev/hda7.  Priority:0 extents:1 across:530104k
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Real Time Clock Driver v1.12ac
loop: loaded (max 8 devices)
SGI XFS with no debug enabled
XFS mounting filesystem hda15
Ending clean XFS mount for filesystem: hda15
hub 1-0:1.0: over-current change on port 1
hub 1-0:1.0: over-current change on port 2
hub 1-0:1.0: over-current change on port 1
ACPI: docking
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.MPCI._PRT]
ACPI: Power Resource [PADA] (on)
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fd000000-feffffff
  PREFETCH window: f8000000-f9ffffff
PCI: Bus 2, cardbus bridge: 0000:00:03.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Bus 6, cardbus bridge: 0000:00:03.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 24000000-25ffffff
  MEM window: 26000000-27ffffff
PCI: Bridge: 0000:00:11.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Setting latency timer of device 0000:00:11.0 to 64

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=lspci-hotdock

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 00 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0c 02 00 00 00 00 00 09 03 10 11 11 00 00 00 00
60: 08 10 18 20 20 20 20 20 00 00 00 20 00 00 00 00
70: 20 1f 0a b8 55 00 0f 01 03 0f dc 38 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 1f 00 00 00 00 00 00 00 00
b0: 80 20 00 00 30 00 00 00 00 00 79 0f 20 10 00 00
c0: 00 00 00 00 00 00 00 00 18 0c 00 00 00 00 00 00
d0: 08 10 02 02 02 12 22 00 0c 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fd000000-feffffff
	Prefetchable memory behind bridge: f8000000-f9ffffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 00 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 c0 c0 a0 02
20: 00 fd f0 fe 00 f8 f0 f9 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 28000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 00 00 28 a0 00 00 02 00 02 05 b0 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 ff 01 40 05
40: 28 10 88 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 f0 24 20 00 00 00 00 00 00 00 00 22 12 26 01
90: c0 a7 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 1b 08 00 00 07 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 28001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 24000000-25fff000 (prefetchable)
	Memory window 1: 26000000-27fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 10 00 28 a0 00 00 02 00 06 09 b0 00 00 00 24
20: 00 f0 ff 25 00 00 00 26 00 f0 ff 27 00 18 00 00
30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 ff 01 c0 05
40: 28 10 88 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 d0 24 20 00 00 00 00 00 00 00 00 22 12 26 01
90: c0 a6 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 1b 08 00 00 07 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 44 00 32 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 05 0a 0b d2 00 00 00 00 f2 00 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 06 41 81 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 0860 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 e3 07 e3 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ece0 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 08 00 00 0f ff bf 1f a4 3f 00 00 00 00 00 00
50: 00 50 04 00 00 40 7d 8a 67 00 00 02 00 00 00 90
60: e0 00 67 62 50 08 6f 78 00 00 00 00 00 00 00 00
70: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 41 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:11.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 10
	Bus: primary=00, secondary=08, subordinate=08, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
00: 11 10 22 00 07 00 90 02 04 00 04 06 10 40 01 00
10: 00 00 00 00 00 00 00 00 00 08 08 40 f1 01 80 22
20: f0 ff 00 00 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 04 06
40: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 f0 00 3e 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 01
e0: 00 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Neomagic Corporation NM2200 [MagicGraph 256AV] (rev 20) (prog-if 00 [VGA])
	Subsystem: Dell Latitude CPi A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f9000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fdc00000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at fdb00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c8 10 05 00 07 00 90 02 20 00 00 03 00 40 80 00
10: 08 00 00 f9 00 00 c0 fd 00 00 b0 fd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.1 Multimedia audio controller: Neomagic Corporation NM2200 [MagicMedia 256AV Audio] (rev 20)
	Subsystem: Dell Latitude CPi A
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at f8c00000 (32-bit, prefetchable) [size=4M]
	Region 1: Memory at fda00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c8 10 05 80 02 00 90 02 20 00 01 04 00 00 80 00
10: 08 00 c0 f8 00 00 a0 fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=dmesg-colddockboot
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.17-rc6-git (uziel@hermes) (gcc-Version 4.1.1 (Gentoo 4.1.=
1)) #9 PREEMPT Fri Jun 9 15:49:28 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000fff0000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 61420 pages, LIFO batch:15
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000f38f0
ACPI: RSDT (v001 DELL    CPi A   0x27d10b07 ASL  0x00000061) @ 0x0fff0000
ACPI: FADT (v001 DELL    CPi A   0x27d10b07 ASL  0x00000061) @ 0x0fff0400
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Allocating PCI resources starting at 20000000 (gap: 10100000:efd00000)
Built 1 zonelists
Kernel command line: hostname=3Dhermes dyntick=3Ddisable noresume2 rw panic=
=3D15 resume2=3Dswap:/dev/hda7 video=3Dneofb:1024x768-16@60 splash=3Dverbos=
e,theme:lena ramfsinit=3Dverbose quiet 2
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc031c000 soft=3Dc031b000
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 498.557 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 249096k/262064k available (1517k kernel code, 12444k reserved, 470k=
 data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 997.50 BogoMIPS (lpj=3D498=
754)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 0000=
0000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000=
000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00=
000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0c20)
checking if image is initramfs... it is
Freeing initrd memory: 7890k freed
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver=20
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfc0ee, last bus=3D2
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:07.1
PCI quirk: region 0800-083f claimed by PIIX4 ACPI
PCI quirk: region 0840-084f claimed by PIIX4 SMB
PIIX4 devres B PIO at 00e0-00e7
PIIX4 devres C PIO at 0850-085f
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.MPCI._PRT]
ACPI: Power Resource [PADA] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:02: ioport range 0x800-0x805 could not be reserved
pnp: 00:02: ioport range 0x808-0x80f could not be reserved
pnp: 00:03: ioport range 0x806-0x807 has been reserved
pnp: 00:03: ioport range 0x850-0x853 has been reserved
pnp: 00:03: ioport range 0x856-0x85f has been reserved
pnp: 00:03: ioport range 0x810-0x83f has been reserved
pnp: 00:03: ioport range 0x840-0x84f has been reserved
pnp: 00:08: ioport range 0x3f0-0x3f1 has been reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fd000000-feffffff
  PREFETCH window: f8000000-f9ffffff
PCI: Bus 3, cardbus bridge: 0000:00:03.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Bus 7, cardbus bridge: 0000:00:03.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 24000000-25ffffff
  MEM window: 26000000-27ffffff
PCI: Bridge: 0000:00:11.0
  IO window: f000-ffff
  MEM window: fb000000-fcffffff
  PREFETCH window: 28000000-280fffff
PCI: Enabling device 0000:00:03.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
PCI: Enabling device 0000:00:03.1 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
* Found PM-Timer Bug on this chipset. Due to workarounds for a bug,
* this time source is slow.  Consider trying other time sources (clock=3D)
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp_glue: can't get bus number, assuming 0
acpiphp: Slot [1] registered
acpiphp: Slot [2] registered
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -=
> IRQ 11
neofb: mapped io at d0880000
Autodetected internal display
Panel is a 1024x768 color TFT display
neofb: mapped framebuffer at d0b00000
neofb v0.4.2: 2560kB VRAM, using 1024x768, 48.364kHz, 60Hz
Console: switching to colour frame buffer device 128x96
fb0: MagicGraph 256AV frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THM] (47 C)
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP westwood registered
Using IPI Shortcut mode
Suspend2 Core.
Suspend2 Compression Driver loading.
Suspend2 Encryption Driver loading.
Suspend2 Swap Writer loading.
ACPI wakeup devices:=20
 LID PBTN PCI0 UAR1 MPCI=20
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 144k freed
NET: Registered protocol family 1
input: AT Translated Set 2 keyboard as /class/input/input0
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IBM-DJSA-220, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1874KiB Cache, CHS=3D38760/16/63, UDMA(3=
3)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hd=
a15 >
Probing IDE interface ide1...
hdc: Samsung CD-RW/DVD-ROM SN-308B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Loading Reiser4. See www.namesys.com for a description of Reiser4.
reiser4[mount(398)]: disable_write_barrier (/usr/src/sources/linux-git/fs/r=
eiser4/wander.c:234)[zam-1055]:
NOTICE: hda6 does not support write barriers, using synchronous write inste=
ad.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EC=
P,DMA]
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKC] -> GSI 10 (level, low) -=
> IRQ 10
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:08.0: 3Com PCI 3c905C Tornado at d0854c00.
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
logips2pp: Detected unknown logitech mouse model 56
SCSI subsystem initialized
PCI: Enabling device 0000:01:00.1 (0000 -> 0002)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:01:00.1[B] -> Link [LNKB] -> GSI 5 (level, low) ->=
 IRQ 5
nm256: found card signature in video RAM: 0x27ec00
nm256: Mapping port 1 from 0x2709a0 - 0x27ec00
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1
00:0c: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKC] -> GSI 10 (level, low) -=
> IRQ 10
ahc_pci:2:7:0: Using left over BIOS settings
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xf4000000
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=3D7, 16/253 SCBs

usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
Yenta: CardBus bridge found at 0000:00:03.0 [1028:0088]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:03.0, mfunc 0x01261222, devctl 0x64
Yenta: ISA IRQ mask 0x0018, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
Yenta: CardBus bridge found at 0000:00:03.1 [1028:0088]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:03.1, mfunc 0x01261222, devctl 0x64
Yenta: ISA IRQ mask 0x0018, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 11 (level, low) -=
> IRQ 11
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000ece0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
libata version 1.20 loaded.
Adding 530104k swap on /dev/hda7.  Priority:0 extents:1 across:530104k
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Real Time Clock Driver v1.12ac
loop: loaded (max 8 devices)
SGI XFS with no debug enabled
XFS mounting filesystem hda15
Ending clean XFS mount for filesystem: hda15

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline; filename=lspci-colddockboot

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 0c 02 00 00 00 00 00 09 03 10 11 11 01 00 00 00
60: 08 10 18 20 20 20 20 20 00 00 00 20 00 00 00 00
70: 20 1f 0a b8 55 00 0f 01 03 0f dc 38 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 1f 00 00 00 00 00 00 00 00
b0: 80 20 00 00 30 00 00 00 00 00 07 0f 20 10 00 00
c0: 00 00 00 00 00 00 00 00 18 0c 00 00 00 00 00 00
d0: 08 10 02 02 02 12 22 00 0c 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fd000000-feffffff
	Prefetchable memory behind bridge: f8000000-f9ffffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 01 20 02 03 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 c0 a0 22
20: 00 fd f0 fe 00 f8 f0 f9 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 28100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 00 10 28 a0 00 00 02 00 03 06 b0 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 ff 01 c0 05
40: 28 10 88 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 f0 24 20 00 00 00 00 00 00 00 00 22 12 26 01
90: c0 a6 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 80 80 00 1b 08 00 00 07 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 28101000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 24000000-25fff000 (prefetchable)
	Memory window 1: 26000000-27fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 4c 10 1c ac 07 00 10 02 01 00 07 06 08 a8 82 00
10: 00 10 10 28 a0 00 00 02 00 07 0a b0 00 00 00 24
20: 00 f0 ff 25 00 00 00 26 00 f0 ff 27 00 18 00 00
30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 ff 01 c0 05
40: 28 10 88 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 21 f0 24 20 00 00 00 00 00 00 00 00 22 12 26 01
90: c0 a6 64 60 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 21 7e 00 00 80 00 1b 08 00 00 07 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 01 80 02 02 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 44 00 32 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 0b 05 0a 0b d2 00 00 00 00 f2 00 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 06 41 81 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 0860 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 e3 07 e3 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ece0 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 08 00 00 0f ff bf 1f a4 3f 00 00 00 00 00 00
50: 00 50 04 00 00 40 7d 8a 67 00 00 02 00 00 00 90
60: e0 00 67 62 50 08 6f 78 00 00 00 00 00 00 00 00
70: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 41 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

00:11.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-0000ffff
	Memory behind bridge: fb000000-fcffffff
	Prefetchable memory behind bridge: 0000000028000000-0000000028000000
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
00: 11 10 22 00 07 01 90 02 04 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 f1 f1 80 02
20: 00 fb f0 fc 01 28 01 28 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 02
40: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 f0 00 3e 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 01
e0: 00 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Neomagic Corporation NM2200 [MagicGraph 256AV] (rev 20) (prog-if 00 [VGA])
	Subsystem: Dell Latitude CPi A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f9000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at fdc00000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at fdb00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c8 10 05 00 07 00 90 02 20 00 00 03 00 20 80 00
10: 08 00 00 f9 00 00 c0 fd 00 00 b0 fd 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 ff
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.1 Multimedia audio controller: Neomagic Corporation NM2200 [MagicMedia 256AV Audio] (rev 20)
	Subsystem: Dell Latitude CPi A
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at f8c00000 (32-bit, prefetchable) [size=4M]
	Region 1: Memory at fda00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: c8 10 05 80 02 00 90 02 20 00 01 04 00 00 80 00
10: 08 00 c0 f8 00 00 a0 fd 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 88 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:05.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 07) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Silicon Image, Inc. PCI0646
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at fcf8 [size=8]
	Region 1: I/O ports at fcf0 [size=4]
	Region 2: I/O ports at fce0 [size=8]
	Region 3: I/O ports at fcd8 [size=4]
	Region 4: I/O ports at fcc0 [size=16]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-
00: 95 10 46 06 05 00 90 02 07 8f 01 01 00 20 00 00
10: f9 fc 00 00 f1 fc 00 00 e1 fc 00 00 d9 fc 00 00
20: c1 fc 00 00 00 00 00 00 00 00 00 00 95 10 46 06
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 02 04
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
50: 40 e4 00 c0 00 c0 00 cc 00 40 00 00 00 00 00 00
60: 01 00 21 06 00 60 00 80 00 00 00 00 00 00 00 00
70: 08 00 00 f0 18 55 c5 64 08 00 00 f0 70 75 6d 4c
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:07.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
	Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f800 [disabled] [size=256]
	Region 1: Memory at fbfff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fc000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 04 90 78 80 16 01 90 02 01 00 00 01 08 20 00 00
10: 01 f8 00 00 00 f0 ff fb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 04 90 80 78
30: 00 00 00 fc dc 00 00 00 00 00 00 00 0a 01 08 08
40: a0 15 00 80 a0 15 00 80 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 21 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 6c)
	Subsystem: Dell Unknown device 00a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at fc00 [size=128]
	Region 1: Memory at fbffec00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 28000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: b7 10 00 92 17 01 10 02 6c 00 00 02 08 20 00 00
10: 01 fc 00 00 00 ec ff fb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 a8 00
30: 00 00 00 fc dc 00 00 00 00 00 00 00 0a 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 fe
e0: 00 40 00 b7 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--BXVAT5kNtrzKuDFl--

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQIVAwUBRImJDV2m8MprmeOlAQLyVw//WLVyC33tP7JwE+JlsEqYWCHeCmR88Ecy
TpLlpY3Fq1q4KncDanGgxnFXkGXcl79R1oj4BS7MZkEKjnAxe9klIcR3rZeEDn5g
IlI6jXsI2wT74KYAuTqgG5T8yNEG3lLzA0ZuWfdAEZAYrHeRp6p/BZocdYfKaFYB
hcmlnkYxHrC/QHN8oGAiTrrvOwn09OG8/3nZwpfhziDfFNySXzVjbtyi0zni44ah
yfFcb+yoQpHmp/RSb4TFWa+QLRB7HGMN9Cz8mLNV7I2jDwh0J6Em6aC0Lxt7Ddsn
nhdaQHhaW0Ey5mcDz/oKLhvT8rreSFBQEW1N2+qSaSo9zvP1/9jg9gEvmpmPhY7B
e/9fIjz5r1kXKHz9BlYt5/b6MSXgktZVYaItHQzC2bUa00FDUn4a+LFRfPM9853u
rhXv89jCEsMjpP1ECclXNECT/aUQvZjwIKVRZGWQvzygX0ty/qotpdB5sOdJ9Upy
Mq9MrEtbAzoAXg1XXcanRgcXPrSH91Dqgdl3XTEsdZ0+GhVITv2AMjDcLFEqHSeo
mi0joxUb7PdvLjIAm0MGege6JsZZkU7C2teES8e7tvsSH1a7YaysTPZMdJm5DZrO
61aJ6hH0qfDQCC1ajXKt66h/JdS97nsh/XiQnamEtdgJQWJpNOU1rJ7qVZbSz8OX
CGEPCA+tWVA=
=msYz
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

