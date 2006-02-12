Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWBLSvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWBLSvG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWBLSvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:51:06 -0500
Received: from ruault.com ([81.57.109.127]:4818 "EHLO ruault.com")
	by vger.kernel.org with ESMTP id S1750853AbWBLSvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:51:05 -0500
Message-ID: <43EF8388.10202@ruault.com>
Date: Sun, 12 Feb 2006 19:50:48 +0100
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
X-Enigmail-Version: 0.93.2.0
OpenPGP: id=E4D2B80C
Content-Type: multipart/mixed;
 boundary="------------070301070801070605060800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301070801070605060800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi All,
i was trying to rip a CD when the whole machine started to freeze
periodicaly, i then looked at the logs and found the following :

Feb 12 19:23:39 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
Feb 12 19:23:39 ruault kernel: BUG: soft lockup detected on CPU#0!
Feb 12 19:23:39 ruault kernel:
Feb 12 19:23:39 ruault kernel: Pid: 0, comm:              swapper
Feb 12 19:23:39 ruault kernel: EIP: 0060:[<c0272b75>] CPU: 0
Feb 12 19:23:39 ruault kernel: EIP is at ide_inb+0x5/0x10
Feb 12 19:23:39 ruault kernel:  EFLAGS: 00000216    Tainted: P      
(2.6.15.4)
Feb 12 19:23:39 ruault kernel: EAX: 00000180 EBX: 01aefc21 ECX: cfd3beae
EDX: 00000177
Feb 12 19:23:39 ruault kernel: ESI: 00000088 EDI: c0419e30 EBP: c0419ec4
DS: 007b ES: 007b
Feb 12 19:23:39 ruault kernel: CR0: 8005003b CR2: b7274c4c CR3: 2086e000
CR4: 000006d0
Feb 12 19:23:39 ruault kernel:  [<c0273656>] ide_wait_stat+0xf6/0x140
Feb 12 19:23:39 ruault kernel:  [<c0271cf6>] start_request+0xe6/0x2e0
Feb 12 19:23:39 ruault kernel:  [<c027220b>] ide_do_request+0x2eb/0x400
Feb 12 19:23:39 ruault kernel:  [<c0280ff0>] cdrom_newpc_intr+0x0/0x470
Feb 12 19:23:39 ruault kernel:  [<c027255c>] ide_timer_expiry+0xec/0x290
Feb 12 19:23:39 ruault kernel:  [<c0272470>] ide_timer_expiry+0x0/0x290
Feb 12 19:23:39 ruault kernel:  [<c0128afc>] run_timer_softirq+0xbc/0x210
Feb 12 19:23:39 ruault kernel:  [<c0123f12>] __do_softirq+0x52/0xa0
Feb 12 19:23:39 ruault kernel:  [<c0123f8d>] do_softirq+0x2d/0x40
Feb 12 19:23:39 ruault kernel:  [<c0124068>] irq_exit+0x38/0x40
Feb 12 19:23:39 ruault kernel:  [<c0105a77>] do_IRQ+0x37/0x70
Feb 12 19:23:39 ruault kernel:  [<c0103d4e>] common_interrupt+0x1a/0x20
Feb 12 19:23:39 ruault kernel:  [<c010105b>] default_idle+0x2b/0x60
Feb 12 19:23:39 ruault kernel:  [<c01010f5>] cpu_idle+0x45/0x80
Feb 12 19:23:39 ruault kernel:  [<c03b084f>] start_kernel+0x17f/0x1e0
Feb 12 19:23:39 ruault kernel:  [<c03b0390>] unknown_bootoption+0x0/0x1e0
Feb 12 19:23:39 ruault kernel: hdc: status timeout: status=0x80 { Busy }
Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
Feb 12 19:23:39 ruault kernel: hdc: drive not ready for command
Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
Feb 12 19:23:39 ruault kernel: hdd: ATAPI reset complete
Feb 12 19:23:49 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
Feb 12 19:23:49 ruault kernel: ide: failed opcode was: unknown
Feb 12 19:23:49 ruault kernel: hdd: status timeout: status=0x80 { Busy }
Feb 12 19:24:09 ruault kernel: hdc: irq timeout: status=0x80 { Busy }

After a few seconds, the whole machine was totally locked up and the
only option i had was a hard reset.
I was able to reproduce it once more.

I'm running vanilla kernel 2.6.15.4 on an athlon 32 bits. here's generic
info about my configuration :

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2400+
stepping        : 1
cpu MHz         : 2000.448
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4004.40

/sbin/lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge
        Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d6800000-d7dfffff
        Prefetchable memory behind bridge: d8000000-efffffff
        Capabilities: <available only to root>

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 20
        Memory at d6000000 (32-bit, non-prefetchable) [size=2K]
        I/O ports at b800 [size=128]
        Capabilities: <available only to root>

00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak
376) (rev 02)
        Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 10
        I/O ports at b400 [size=64]
        I/O ports at b000 [size=16]
        I/O ports at a800 [size=128]
        Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
        Memory at d5000000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: <available only to root>

00:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
        Flags: bus master, fast devsel, latency 32, IRQ 16
        Memory at d4800000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at d7ff0000 [disabled] [size=16K]
        Capabilities: <available only to root>

00:0d.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management
Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at a400 [size=64]
        Memory at d3800000 (32-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at 50000000 [disabled] [size=1M]
        Capabilities: <available only to root>

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at a000 [size=32]
        Capabilities: <available only to root>

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at 9800 [size=32]
        Capabilities: <available only to root>

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at 9400 [size=32]
        Capabilities: <available only to root>

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if
20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at d3000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. A7V8X / A7V333 motherboard
        Flags: bus master, medium devsel, latency 32, IRQ 255
        I/O ports at 9000 [size=16]
        Capabilities: <available only to root>

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: ASUSTeK Computer Inc. A7V8X Motherboard (Realtek
ALC650 codec)
        Flags: medium devsel, IRQ 18
        I/O ports at e000 [size=256]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE
[Radeon 9500 Pro] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro]
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 255,
IRQ 17
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at e7fe0000 [disabled] [size=128K]
        Capabilities: <available only to root>

01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon
9500 Pro] (Secondary)
        Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro]
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Memory at d6800000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: <available only to root>

/sbin/lsmod
Module                  Size  Used by
rfcomm                 36504  0
l2cap                  24196  5 rfcomm
bluetooth              44900  4 rfcomm,l2cap
deflate                 3328  0
zlib_deflate           23576  1 deflate
twofish                47104  0
serpent                20224  0
aes_i586               38272  0
blowfish                8192  0
des                    16384  0
lp                     10696  0
sha256                 10880  0
sha1                    2816  0
crypto_null             2560  0
xfrm4_tunnel            3204  0
ipcomp                  7176  0
esp4                    7168  0
ah4                     5632  0
af_key                 31248  0
autofs4                18052  1
vmnet                  35748  3
parport_pc             38852  1
parport                35528  2 lp,parport_pc
vmmon                 111468  0
sunrpc                139836  1
ipt_MARK                2432  1
iptable_mangle          2560  1
ipt_MASQUERADE          3072  1
iptable_nat             6916  1
ip_nat                 17068  2 ipt_MASQUERADE,iptable_nat
ipt_LOG                 6656  1
ipt_limit               2432  1
ipt_mark                1664  1
ipt_state               1920  1
ip_conntrack           48556  4 ipt_MASQUERADE,iptable_nat,ip_nat,ipt_state
nfnetlink               5272  2 ip_nat,ip_conntrack
iptable_filter          2560  1
ip_tables              21120  9
ipt_MARK,iptable_mangle,ipt_MASQUERADE,iptable_nat,ipt_LOG,ipt_limit,ipt_mark,ipt_state,iptable_filter
binfmt_misc             9864  1
fglrx                 454604  7
ipv6                  259840  23
sd_mod                 17296  0
dm_mod                 54072  0
video                  14468  0
button                  5264  0
ac                      3716  0
quickcam               77348  0
videodev                7936  1 quickcam
usbhid                 37344  0
usb_storage            32516  0
scsi_mod              126824  2 sd_mod,usb_storage
ohci1394               33460  0
ieee1394               92600  1 ohci1394
uhci_hcd               31888  0
ehci_hcd               33416  0
via_agp                 8320  1
agpgart                29768  2 fglrx,via_agp
shpchp                 44224  0
i2c_viapro              7828  0
i2c_core               18192  1 i2c_viapro
snd_via82xx            24468  4
snd_ac97_codec         94112  1 snd_via82xx
snd_ac97_bus            2176  1 snd_ac97_codec
snd_seq_dummy           3076  0
snd_seq_oss            34176  0
snd_seq_midi_event      6784  1 snd_seq_oss
snd_seq                52112  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            50848  0
snd_mixer_oss          18048  1 snd_pcm_oss
snd_pcm                85128  5 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              22788  3 snd_seq,snd_pcm
snd_page_alloc          8968  2 snd_via82xx,snd_pcm
snd_mpu401_uart         6784  1 snd_via82xx
snd_rawmidi            22176  1 snd_mpu401_uart
snd_seq_device          7436  4
snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi
snd                    49252  16
snd_via82xx,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               8416  1 snd
eepro100               27920  0
b44                    23948  0
mii                     5376  2 eepro100,b44
floppy                 60100  0
usbcore               120836  6
quickcam,usbhid,usb_storage,uhci_hcd,ehci_hcd

relevant info regarding drives etc :

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 12 19:37:12 ruault kernel: VP_IDE: IDE controller at PCI slot
0000:00:11.1
Feb 12 19:37:12 ruault kernel: ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
Feb 12 19:37:12 ruault kernel: PCI: Via IRQ fixup for 0000:00:11.1, from
255 to 15
Feb 12 19:37:12 ruault kernel: VP_IDE: chipset revision 6
Feb 12 19:37:12 ruault kernel: VP_IDE: not 100% native mode: will probe
irqs later
Feb 12 19:37:12 ruault kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133
controller on pci0000:00:11.1
Feb 12 19:37:12 ruault kernel:     ide0: BM-DMA at 0x9000-0x9007, BIOS
settings: hda:DMA, hdb:pio
Feb 12 19:37:12 ruault kernel:     ide1: BM-DMA at 0x9008-0x900f, BIOS
settings: hdc:DMA, hdd:DMA
Feb 12 19:37:12 ruault kernel: hda: Maxtor 6Y080L0, ATA DISK drive
Feb 12 19:37:12 ruault kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 19:37:12 ruault kernel: hdc: PLEXTOR CD-R PX-W1610A, ATAPI
CD/DVD-ROM drive
Feb 12 19:37:12 ruault kernel: hdd: _NEC DVD_RW ND-3500AG, ATAPI
CD/DVD-ROM drive
Feb 12 19:37:12 ruault kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 12 19:37:12 ruault kernel: hda: max request size: 128KiB
Feb 12 19:37:12 ruault kernel: hda: 160086528 sectors (81964 MB)
w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
Feb 12 19:37:12 ruault kernel: hda: cache flushes supported
Feb 12 19:37:12 ruault kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6
hda7 hda8 hda9 hda10 >
Feb 12 19:37:12 ruault kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive,
2048kB Cache, DMA
Feb 12 19:37:12 ruault kernel: Uniform CD-ROM driver Revision: 3.20
Feb 12 19:37:12 ruault kernel: hdd: ATAPI 32X DVD-ROM DVD-R CD-R/RW
drive, 2048kB Cache, UDMA(33)
Feb 12 19:37:12 ruault kernel: ide-floppy driver 0.99.newide


I'm also attaching my kernel config.

Let me know if you need anything else to troobleshoot the problem.
Regards.

PS: i'm not on the list so please CC me when answering !
Thanks

-- 
Charles-Edouard Ruault
PGP Key ID E4D2B80C


--------------070301070801070605060800
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
jjy1AAA=
--------------070301070801070605060800--
