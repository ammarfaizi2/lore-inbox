Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275663AbTHOC4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 22:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275643AbTHOC4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 22:56:01 -0400
Received: from 62-43-28-141.user.ono.com ([62.43.28.141]:30080 "EHLO wanda")
	by vger.kernel.org with ESMTP id S275667AbTHOCyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 22:54:38 -0400
Message-ID: <3F3C4B65.8090002@tiscali.es>
Date: Fri, 15 Aug 2003 04:54:29 +0200
From: Paco Ros <switch@tiscali.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] ide-scsi on a 2.4.21-ac8
Content-Type: multipart/mixed;
 boundary="------------030307090201030301020504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030307090201030301020504
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi.

This bug seems to be reported as:
http://www.cs.helsinki.fi/linux/linux-kernel/2003-21/0508.html

I'll try to give some more information

IDE CD's cannot be mounted while using ide-scsi emulation.
Perhaps, they can be mounted using  ide-cd driver.

Some HW information:
switch@wanda:~# cdrecord --scanbus
Cdrecord 2.01a16 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
Linux sg driver version: 3.1.25
Using libscg version 'schily-0.7'
scsibus0:
         0,0,0     0) '   LG   ' 'CD-ROM CRD-8322B' '1.02' Removable CD-ROM
         0,1,0     1) 'SONY    ' 'CD-RW  CRX140E  ' '1.0n' Removable CD-ROM

hda: 40GB IDE HD
hdb: 20GB IDE HD
hdc: LG CDROM (32x) (This is giving the error)
hdd: Sony CD-RW

Kernel version: 2.4.21-ac8 (XFS Support)

Boot parameters:
hdc=cdrom hdd=ide-scsi

cpuinfo:
wanda:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP1600+
stepping        : 2
cpu MHz         : 1411.822
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2791.83

modules:
wanda:~# cat /proc/modules
sr_mod                 15544   0 (autoclean)
cdrom                  28256   0 (autoclean) [sr_mod]
parport_pc             27624   0
parport                25992   0 [parport_pc]
ipt_state                568   8 (autoclean)
ipt_MASQUERADE          1368   1 (autoclean)
iptable_nat            16302   1 (autoclean) [ipt_MASQUERADE]
iptable_filter          1772   1 (autoclean)
ip_tables              11776   6 [ipt_state ipt_MASQUERADE iptable_nat 
iptable_filter]
irda-usb               14192   0 (unused)
mousedev                4180   2
irda                  164896   0 [irda-usb]
usbmouse                2264   0 (unused)
hid                    19172   0 (unused)
nls_iso8859-15          3388   1 (autoclean)
nls_cp437               4380   1 (autoclean)
ip_conntrack_ftp        4048   0 (unused)
ip_conntrack           18308   3 [ipt_state ipt_MASQUERADE iptable_nat 
ip_conntrack_ftp]
ide-scsi               10160   0
smbfs                  38704   0 (unused)
emu10k1                60812   3
ac97_codec             12564   0 [emu10k1]
sound                  58248   0 [emu10k1]
soundcore               3844   7 [emu10k1 sound]
keybdev                 2052   0 (unused)
usbkbd                  3640   0 (unused)
input                   3392   0 [mousedev usbmouse hid keybdev usbkbd]
usb-uhci               23280   0 (unused)
usbcore                63148   1 [irda-usb usbmouse hid usbkbd usb-uhci]

ioports:
wanda:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a400-a41f : VIA Technologies, Inc. USB (#3)
   a400-a41f : usb-uhci
a800-a81f : VIA Technologies, Inc. USB (#2)
   a800-a81f : usb-uhci
b000-b01f : VIA Technologies, Inc. USB
   b000-b01f : usb-uhci
b400-b40f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C 
PIPC Bus Master IDE
   b400-b407 : ide0
   b408-b40f : ide1
b800-b807 : Creative Labs SB Live! MIDI/Game Port
d000-d01f : Creative Labs SB Live! EMU10k1
   d000-d01f : EMU10K1
d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (#2)
   d400-d4ff : 8139too
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   d800-d8ff : 8139too

iomem:
wanda:~# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
   00100000-002ff356 : Kernel code
   002ff357-00392ae3 : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
ed000000-ed0000ff : Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (#2)
   ed000000-ed0000ff : 8139too
ed800000-ed8000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
   ed800000-ed8000ff : 8139too
ee000000-efefffff : PCI Bus #01
   ee000000-eeffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
eff00000-f7ffffff : PCI Bus #01
   f0000000-f7ffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
f8000000-fbffffff : VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
ffff0000-ffffffff : reserved

lspci:
wanda:~# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
         Subsystem: Asustek Computer, Inc. A7V266-E Mainboard
         Flags: bus master, medium devsel, latency 0
         Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
         Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
         Flags: bus master, 66Mhz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: ee000000-efefffff
         Prefetchable memory behind bridge: eff00000-f7ffffff
         Capabilities: [80] Power Management version 2

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at d800 [size=256]
         Memory at ed800000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at d400 [size=256]
         Memory at ed000000 (32-bit, non-prefetchable) [size=256]

00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
         Subsystem: Creative Labs: Unknown device 8064
         Flags: bus master, medium devsel, latency 32, IRQ 5
         I/O ports at d000 [size=32]
         Capabilities: [dc] Power Management version 1

00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
         Subsystem: Creative Labs Gameport Joystick
         Flags: bus master, medium devsel, latency 32
         I/O ports at b800 [size=8]
         Capabilities: [dc] Power Management version 1

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
         Subsystem: Asustek Computer, Inc. VT8233A
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Flags: bus master, stepping, medium devsel, latency 32
         I/O ports at b400 [size=16]
         Capabilities: [c0] Power Management version 2

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 32, IRQ 9
         I/O ports at b000 [size=32]
         Capabilities: [80] Power Management version 2

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 32, IRQ 9
         I/O ports at a800 [size=32]
         Capabilities: [80] Power Management version 2

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Flags: bus master, medium devsel, latency 32, IRQ 9
         I/O ports at a400 [size=32]
         Capabilities: [80] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev b2) (prog-if 00 [VGA])
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
         Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
         Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at efff0000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
         Capabilities: [44] AGP version 2.0


Problem:
When trying to mount /dev/scd0 lots of errors like this are thrown:
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding 
data
ide-scsi: [[ 28 0 0 0 0 63 0 0 1 0 0 0 ]
]
(full error attached in dmesg)

And mount outputs: "mount: wrong fs type, bad option, bad superblock on 
/dev/sr0, or too many mounted file systems"

Please, ask for more info if needed.

Best greetings.

--
Paco Ros (a.k.a. Switch)
Member of Balearic Islands Linux User Group BULMA

--------------030307090201030301020504
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

ide-scsi: hdc: unsupported command in request queue (0)
end_request: I/O error, dev 16:00 (hdc), sector 64
isofs_read_super: bread failed, dev=16:00, iso_blknum=16, block=32
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
cdrom: open failed.
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 10 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 11 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 12 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 13 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 14 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 15 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 16 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 17 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 18 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 19 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 20 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 21 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 22 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 23 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 24 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 25 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 26 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 27 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 28 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 29 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 30 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 31 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 32 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 33 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 34 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 35 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 36 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 37 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 38 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 39 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 40 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 41 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 42 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 43 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 44 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 45 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 46 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 47 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 48 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 49 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 50 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 51 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 52 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 53 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 54 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 55 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 56 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 57 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 58 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 59 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 60 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 61 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 62 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 63 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
Unable to identify CD-ROM format.
--------------030307090201030301020504
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_H2999 is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_IKCONFIG is not set
CONFIG_PM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_RELAXED_AML is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
# CONFIG_PARIDE_PD is not set
# CONFIG_PARIDE_PCD is not set
# CONFIG_PARIDE_PF is not set
# CONFIG_PARIDE_PT is not set
# CONFIG_PARIDE_PG is not set

#
# Parallel IDE protocol modules
#
# CONFIG_PARIDE_ATEN is not set
# CONFIG_PARIDE_BPCK is not set
# CONFIG_PARIDE_BPCK6 is not set
# CONFIG_PARIDE_COMM is not set
# CONFIG_PARIDE_DSTR is not set
# CONFIG_PARIDE_FIT2 is not set
# CONFIG_PARIDE_FIT3 is not set
# CONFIG_PARIDE_EPAT is not set
# CONFIG_PARIDE_EPIA is not set
# CONFIG_PARIDE_FRIQ is not set
# CONFIG_PARIDE_FRPW is not set
# CONFIG_PARIDE_KBIC is not set
# CONFIG_PARIDE_KTTI is not set
# CONFIG_PARIDE_ON20 is not set
# CONFIG_PARIDE_ON26 is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_DM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_AMANDA=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_EDP2 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDE_CHIPSETS=y

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_PDC4030 is not set
# CONFIG_BLK_DEV_QD65XX is not set
# CONFIG_BLK_DEV_UMC8672 is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
CONFIG_FUSION=m
# CONFIG_FUSION_BOOT is not set
CONFIG_FUSION_MAX_SGE=40
CONFIG_FUSION_ISENSE=m
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_NET_FC=y

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=y
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
# CONFIG_IRNET is not set
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
# CONFIG_ESI_DONGLE is not set
CONFIG_ACTISYS_DONGLE=m
# CONFIG_TEKRAM_DONGLE is not set
# CONFIG_GIRBIL_DONGLE is not set
# CONFIG_LITELINK_DONGLE is not set
# CONFIG_MCP2120_DONGLE is not set
# CONFIG_OLD_BELKIN_DONGLE is not set
# CONFIG_ACT200L_DONGLE is not set
# CONFIG_MA600_DONGLE is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
# CONFIG_TOSHIBA_OLD is not set
# CONFIG_TOSHIBA_FIR is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ATI_CD1865 is not set
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_ESPSERIAL=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_SYNCLINK=m
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
CONFIG_SPECIALIX_RTSCTS=y
CONFIG_SX=m
CONFIG_RIO=m
CONFIG_RIO_OLDPCI=y
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
# CONFIG_SCx200_I2C is not set
CONFIG_SCx200_ACB=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set

#
# Joysticks
#
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_AMD_RNG=m
CONFIG_INTEL_RNG=m
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
# CONFIG_VIDEO_PROC_FS is not set
# CONFIG_I2C_PARPORT is not set

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QIFACE_COMPAT=y
CONFIG_QIFACE_V1=y
# CONFIG_QIFACE_V2 is not set
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_RW=y
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
CONFIG_UDF_RW=y
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_AD1889 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_KAHLUA is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
CONFIG_SOUND_UART6850=m
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
# CONFIG_ZLIB_DEFLATE is not set

--------------030307090201030301020504--

