Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVCWRiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVCWRiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVCWRiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:38:46 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:33496 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261985AbVCWRhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:37:50 -0500
Message-ID: <4241A94E.2070101@ens-lyon.org>
Date: Wed, 23 Mar 2005 18:37:18 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] intelfb crash on i845
References: <42402CBA.6090401@ens-lyon.org> <42405518.3090009@worldonline.fr> <42414D32.20605@ens-lyon.org> <42419FBC.2050705@worldonline.fr>
In-Reply-To: <42419FBC.2050705@worldonline.fr>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090109020402010000090004"
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090109020402010000090004
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Sylvain Meyer a écrit :
>    You should use video=intelfb:accel=0 (zero). Could you set the "Intel 
> driver Debug Messages" on on your linux kernel config ? You must have 
> the output
> intelfb: options: vram = 4, accel = 0, hwcursor = 1, fixed = 0, noinit = 0
> or similar in the dmesg output (the important is accel = 0, for sure).
>    In this case the hw acceleration is off.

Ok, dmesg says accel = 0.
But chvt 1 gives a black screen, no text at all.
chvt [23456] gives a dirty screen as before.
dmesg attached (2.6.12-rc1-mm1 with CONFIG_FB_INTEL_DEBUG).

By the way, cat /sys/module/intelfb/parameters/accel still says Y.

And cat /sys/module/intelfb/parameters/mode gives the following oops
(I think it is related to CONFIG_FB_INTEL_DEBUG):

c01cc2b2
PREEMPT
Modules linked in: videodev i915 tun ipt_MASQUERADE iptable_nat 
ipt_state ip_conntrack iptable_filter ip_tables floppy uhci_hcd ehci_hcd
  dm_mod snd_intel8x0 snd_ac97_codec
CPU:    0
EIP:    0060:[<c01cc2b2>]    Not tainted VLI
EFLAGS: 00010297   (2.6.12-rc1-mm1=Macvin)
EIP is at vsnprintf+0x332/0x4d0
eax: f05fc051   ebx: 0000000a   ecx: f05fc051   edx: fffffffe
esi: dc4b4000   edi: 00000000   ebp: ffffffff   esp: dec15ea8
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 3711, threadinfo=dec15000 task=c261ea90)
Stack: db34a480 00000000 00008124 c013dc80 c1389680 0000002c 00000000 
c013e4e4
        ffffffff ffffffff 00000000 c14aa400 dc4b4000 00000001 c01cc558 
dc4b4000
        23b4c000 c035d872 dec15f04 c012af25 dc4b4000 c035d871 f05fc051 
c012b337
Call Trace:
  [<c013dc80>] prep_new_page+0x60/0x70
  [<c013e4e4>] buffered_rmqueue+0xf4/0x1e0
  [<c01cc558>] sprintf+0x28/0x30
  [<c012af25>] param_get_charp+0x25/0x30
  [<c012b337>] param_attr_show+0x27/0x60
  [<c012b5ea>] module_attr_show+0x7a/0xe0
  [<c01965ad>] fill_read_buffer+0x5d/0xa0
  [<c01966ed>] sysfs_read_file+0x2d/0x70
  [<c0159266>] vfs_read+0xb6/0x170
  [<c01595d1>] sys_read+0x51/0x80
  [<c0103235>] syscall_call+0x7/0xb
Code: 00 83 cf 01 89 44 24 24 eb bb 8b 44 24 48 8b 54 24 20 83 44 24 48 
04 8b 08 b8 6c 65 35 c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <
80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 20

Regards,
Brice

--------------090109020402010000090004
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

0:00:1f.1
ACPI: Can't get handler for 0000:00:1f.3
ACPI: Can't get handler for 0000:00:1f.5
ACPI: Can't get handler for 0000:01:0c.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: No ACPI bus support for 00:00
ACPI: No ACPI bus support for 00:01
ACPI: No ACPI bus support for 00:02
ACPI: No ACPI bus support for 00:03
ACPI: No ACPI bus support for 00:04
ACPI: No ACPI bus support for 00:05
ACPI: No ACPI bus support for 00:06
ACPI: No ACPI bus support for 00:07
ACPI: No ACPI bus support for 00:08
ACPI: No ACPI bus support for 00:09
ACPI: No ACPI bus support for 00:0a
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0a: ioport range 0x800-0x85f could not be reserved
pnp: 00:0a: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0a: ioport range 0x860-0x8ff could not be reserved
Simple Boot Flag at 0x7a set to 0x80
Machine check exception polling timer started.
inotify device minor=63
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 845G Chipset.
agpgart: Detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] Initialized drm 1.0.0 20040925
intelfb: intelfb_init
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G chipsets
intelfb: Version 0.9.2
intelfb: intelfb_setup
intelfb: options: accel=0
intelfb: intelfb_pci_register
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
intelfb: fb aperture: 0xe8000000/0x8000000, MMIO region: 0xff680000/0x80000
intelfb: 00:02.0: Intel(R) 845G, aperture size 128MB, stolen memory 892kB
intelfb: fb: 0xe80e1000(+ 0xe1)/0x400000 (0xe0a61000)
intelfb: MMIO: 0xff680000/0x80000 (0xe8a00000)
intelfb: ring buffer: 0x0/0x0 (0x0)
intelfb: HW cursor: 0xe80e0000/0x1000 (0xe0a60000) (offset 0xe0) (phys 0xe80e0000)
intelfb: options: vram = 4, accel = 0, hwcursor = 1, fixed = 0, noinit = 0
intelfb: options: mode = ""
intelfb: intelfb_set_fbinfo
intelfb: intelfb_init_var
intelfb: intelfb_check_var: accel_flags is 0
intelfb: Mode is interlaced.
intelfb: intelfb_check_var: accel_flags is 0
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 0
intelfb: intelfb_check_var: accel_flags is 0
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
intelfb: Initial video mode is 1024x768-32@70.
intelfb: Initial video mode is from 1.
intelfb: update_dinfo
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
intelfb: intelfb_get_fix
intelfb: intelfbhw_print_hw_state
hw state dump start
	VGA0_DIVISOR:		0x00021207
	VGA1_DIVISOR:		0x00031406
	VGAPD: 			0x0000888b
	VGA0: (m1, m2, n, p1, p2) = (18, 7, 2, 11, 1)
	VGA0: clock is 25153
	VGA1: (m1, m2, n, p1, p2) = (20, 6, 3, 8, 1)
	VGA1: clock is 28320
	DPLL_A:			0x808b0000
	DPLL_B:			0x00000000
	FPA0:			0x00021207
	FPA1:			0x00021207
	FPB0:			0x00000000
	FPB1:			0x00000000
	PLLA0: (m1, m2, n, p1, p2) = (18, 7, 2, 11, 1)
	PLLA0: clock is 25153
	PLLA1: (m1, m2, n, p1, p2) = (18, 7, 2, 11, 1)
	PLLA1: clock is 25153
	HTOTAL_A:		0x031f027f
	HBLANK_A:		0x03170287
	HSYNC_A:		0x02ef028f
	VTOTAL_A:		0x020c01df
	VBLANK_A:		0x020401e7
	VSYNC_A:		0x01eb01e9
	SRC_SIZE_A:		0x027f01df
	BCLRPAT_A:		0x00000000
	HTOTAL_B:		0x00000000
	HBLANK_B:		0x00000000
	HSYNC_B:		0x00000000
	VTOTAL_B:		0x00000000
	VBLANK_B:		0x00000000
	VSYNC_B:		0x00000000
	SRC_SIZE_B:		0x00000000
	BCLRPAT_B:		0x00000000
	ADPA:			0x80008000
	DVOA:			0x00000000
	DVOB:			0x00000000
	DVOC:			0x00000000
	DVOA_SRCDIM:		0x00000000
	DVOB_SRCDIM:		0x00000000
	DVOC_SRCDIM:		0x00000000
	LVDS:			0x0000b001
	PIPEACONF:		0x80000000
	PIPEBCONF:		0x00000000
	DISPARB:		0x0000005f
	CURSOR_A_CONTROL:	0x00000000
	CURSOR_B_CONTROL:	0x00000000
	CURSOR_A_BASEADDR:	0x00000000
	CURSOR_B_BASEADDR:	0x00000000
	CURSOR_A_PALETTE:	0x00000000, 0x00000000, 0x00000000, 0x00000000
	CURSOR_B_PALETTE:	0x00000000, 0x00000000, 0x00000000, 0x00000000
	CURSOR_SIZE:		0x00000000
	DSPACNTR:		0x48000000
	DSPBCNTR:		0x00000000
	DSPABASE:		0x00000000
	DSPBBASE:		0x00000000
	DSPASTRIDE:		0x00000280
	DSPBSTRIDE:		0x00000000
	VGACNTRL:		0x0000008e
	ADD_ID:			0x000000ff
	SWF00			0x00000000
	SWF01			0x00000000
	SWF02			0x00000000
	SWF03			0x00000000
	SWF04			0x00000000
	SWF05			0x00000000
	SWF06			0x00000000
	SWF10			0x00000001
	SWF11			0x00d00000
	SWF12			0x00000000
	SWF13			0x03030000
	SWF14			0xc0000000
	SWF15			0x00000041
	SWF16			0x00000000
	SWF30			0x00000000
	SWF31			0x00000000
	SWF32			0x00000000
	FENCE0			0x00000000
	FENCE1			0x00000000
	FENCE2			0x00000000
	FENCE3			0x00000000
	FENCE4			0x00000000
	FENCE5			0x00000000
	FENCE6			0x00000000
	FENCE7			0x00000000
	INSTPM			0x00000000
	MEM_MODE		0x00000004
	FW_BLC_0		0x00000108
	FW_BLC_1		0x00000000
hw state dump end
intelfb: intelfb_set_par (1024x768-32)
intelfb: intelfbhw_mode_to_hw
intelfb: Clock is 75001
intelfb: p range is 16-16 (4)
intelfb: m, n, p: 126 (20,14), 5 (3), 16 (2,1), f: 75600 (75600), VCO: 1209600
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
intelfb: H: act 1024, ss 1048, se 1184, tot 1328 bs 1024, be 1328
intelfb: V: act 768, ss 771, se 777, tot 806 bs 768, be 778
intelfb: pitch is 4096
intelfb: intelfbhw_print_hw_state
hw state dump start
	VGA0_DIVISOR:		0x00021207
	VGA1_DIVISOR:		0x00031406
	VGAPD: 			0x0000888b
	VGA0: (m1, m2, n, p1, p2) = (18, 7, 2, 11, 1)
	VGA0: clock is 25153
	VGA1: (m1, m2, n, p1, p2) = (20, 6, 3, 8, 1)
	VGA1: clock is 28320
	DPLL_A:			0x90820000
	DPLL_B:			0x00000000
	FPA0:			0x0003140e
	FPA1:			0x0003140e
	FPB0:			0x00000000
	FPB1:			0x00000000
	PLLA0: (m1, m2, n, p1, p2) = (20, 14, 3, 2, 1)
	PLLA0: clock is 75600
	PLLA1: (m1, m2, n, p1, p2) = (20, 14, 3, 2, 1)
	PLLA1: clock is 75600
	HTOTAL_A:		0x052f03ff
	HBLANK_A:		0x052f03ff
	HSYNC_A:		0x049f0417
	VTOTAL_A:		0x032502ff
	VBLANK_A:		0x030902ff
	VSYNC_A:		0x03080302
	SRC_SIZE_A:		0x03ff02ff
	BCLRPAT_A:		0x00000000
	HTOTAL_B:		0x00000000
	HBLANK_B:		0x00000000
	HSYNC_B:		0x00000000
	VTOTAL_B:		0x00000000
	VBLANK_B:		0x00000000
	VSYNC_B:		0x00000000
	SRC_SIZE_B:		0x00000000
	BCLRPAT_B:		0x00000000
	ADPA:			0x80000000
	DVOA:			0x00000000
	DVOB:			0x00000000
	DVOC:			0x00000000
	DVOA_SRCDIM:		0x00000000
	DVOB_SRCDIM:		0x00000000
	DVOC_SRCDIM:		0x00000000
	LVDS:			0x0000b001
	PIPEACONF:		0x80000000
	PIPEBCONF:		0x00000000
	DISPARB:		0x0000005f
	CURSOR_A_CONTROL:	0x01000000
	CURSOR_B_CONTROL:	0x00000000
	CURSOR_A_BASEADDR:	0x000e0000
	CURSOR_B_BASEADDR:	0x00000000
	CURSOR_A_PALETTE:	0x00000000, 0x00000000, 0x00000000, 0x00000000
	CURSOR_B_PALETTE:	0x00000000, 0x00000000, 0x00000000, 0x00000000
	CURSOR_SIZE:		0x00040040
	DSPACNTR:		0x98000000
	DSPBCNTR:		0x00000000
	DSPABASE:		0x000e1000
	DSPBBASE:		0x00000000
	DSPASTRIDE:		0x00001000
	DSPBSTRIDE:		0x00000000
	VGACNTRL:		0x8000008e
	ADD_ID:			0x000000ff
	SWF00			0x00000000
	SWF01			0x00000000
	SWF02			0x00000000
	SWF03			0x00000000
	SWF04			0x00000000
	SWF05			0x00000000
	SWF06			0x00000000
	SWF10			0x00000001
	SWF11			0x00d00000
	SWF12			0x00000000
	SWF13			0x03030000
	SWF14			0xc0000000
	SWF15			0x00000041
	SWF16			0x00000000
	SWF30			0x00000000
	SWF31			0x00000000
	SWF32			0x00000000
	FENCE0			0x00000000
	FENCE1			0x00000000
	FENCE2			0x00000000
	FENCE3			0x00000000
	FENCE4			0x00000000
	FENCE5			0x00000000
	FENCE6			0x00000000
	FENCE7			0x00000000
	INSTPM			0x00000000
	MEM_MODE		0x00000004
	FW_BLC_0		0x00000108
	FW_BLC_1		0x00000000
hw state dump end
intelfb: update_dinfo
intelfb: intelfb_var_to_depth: bpp: 32, green.length is 8
intelfb: intelfb_get_fix
Console: switching to colour frame buffer device 128x48
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
ACPI: No ACPI bus support for i8042
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel(R) PRO/1000 Network Driver - version 5.7.6-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:0c.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ACPI: No ACPI bus support for serio0
ACPI: No ACPI bus support for serio1
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC35L060AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ACPI: No ACPI bus support for 0.0
Probing IDE interface ide1...
hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: No ACPI bus support for 1.0
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 78125000 sectors (40000 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
TCP westwood registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
VBTN PCI0 USB0 USB1 USB2 PCI1  KBD 
ACPI: (supports S0 S1 S3 S4 S5)
input: AT Translated Set 2 keyboard on isa0060/serio0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 156k freed
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49023 usecs
intel8x0: clocking to 48000
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 3 (level, low) -> IRQ 3
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 3, io mem 0xffa00800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ACPI: No ACPI bus support for usb1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ACPI: No ACPI bus support for 1-0:1.0
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 9, io base 0x0000ff80
ACPI: No ACPI bus support for usb2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 2-0:1.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 11, io base 0x0000ff60
ACPI: No ACPI bus support for usb3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 3-0:1.0
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 10, io base 0x0000ff40
ACPI: No ACPI bus support for usb4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: No ACPI bus support for 4-0:1.0
ACPI: Floppy Controller [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: No ACPI bus support for floppy.0
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4083 buckets, 32664 max) - 212 bytes per conntrack
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[drm] Initialized i915 1.1.0 20040405 on minor 0: Intel Corporation 82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device
mtrr: base(0xe8020000) is not aligned on a size(0x300000) boundary
Linux video capture interface: v1.00

--------------090109020402010000090004--
