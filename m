Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWBTNE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWBTNE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWBTNE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:04:26 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:53065 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932615AbWBTNEZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:04:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nXbHEEFRmhyHy8+A0ggYYgsnVnU4NxIZM9AWiiS20VEWjl9agxI1/EMdH74Xu1xUOPfQ0rf8lzxeO4K9oNUZqaJoaPw4pTDCc5hgZLs1H6rl3Yc+cRBNF/TmO2hN0SiUJmsY+1h4Ipg+QPRm0CiKxmzLF7K//0zYZ3ksxK9ErK0=
Message-ID: <6dd519ae0602200504n7d89dcb9j4685f1f0939f9c53@mail.gmail.com>
Date: Mon, 20 Feb 2006 13:04:24 +0000
From: "Brian Marete" <bgmarete@gmail.com>
To: "Ricardo Cerqueira" <v4l@cerqueira.org>,
       "Mauro Carvalho Chehab" <mchehab@brturbo.com.br>
Subject: Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
----------

Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko


Description
-----------

Modprobe(8)ing saa7134.ko causes an oops. This
is repeatable and happens every time I try to load saa7134.ko. My
saa7134 compatible TV card is not known by the driver, but TV has worked
in pervious kernel versions with the insmod option `card=3'. The FM
radio has never worked.:) I use the following insmod options for
saa7134.ko:

`options saa7134 card=3 disable_ir=1'

I use the default tuner for the card, but have to pass tuner.ko the
insmod option `addr=0x61' since, apparently, the tuner driver sees two
addresses for the tuner.

The last kernel in which I had no trouble at all with regard to
successfully saa7134.ko is 2.6.15.1.

I compiled this kernel (as well as previous kernels) with gcc-3.4.4.

Following is a detailed Bug Report, with the all the information taken
immediately after the oops. (I.e. before a reboot)


Oops Message
---------------

saa7130/34: v4l2 driver version 0.2.14 loaded
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 21
saa7130[0]: found at 0000:00:0a.0, rev: 1, irq: 21, latency: 32, mmio:
0xdfffdc00
saa7130[0]: subsystem: 4e42:0138, board: LifeView/Typhoon FlyVIDEO2000
[card=3,insmod option]
saa7130[0]: board init: gpio is 39100
saa7130[0]: there are different flyvideo cards with different tuners
saa7130[0]: out there, you might have to use the tuner=<nr> insmod
saa7130[0]: option to override the default value.
saa7130[0]: i2c eeprom 00: 42 4e 38 01 10 28 ff ff ff ff ff ff ff ff ff ff
saa7130[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7130[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7130[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7130[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7130[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7130[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7130[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Unable to handle kernel NULL pointer dereference at virtual address 0000025c
 printing eip:
d118143f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: saa7134 i2c_prosavage i2c_viapro ehci_hcd uhci_hcd
usbcore 8250_pci 8250 serial_core video_buf compat_ioctl32 v4l2_common
v4l1_compat ir_kbd_i2c ir_common videodev via_agp agpgart snd_via82xx
snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_rawmidi snd_seq_device
snd_rtctimer snd_pcm_oss snd_pcm snd_timer snd_page_alloc
snd_mixer_oss snd soundcore it87 hwmon_vid hwmon i2c_isa video fan
button thermal processor via_rhine uinput fuse md5 ipv6 loop rtc
pcspkr ide_cd cdrom dm_mod
CPU:    0
EIP:    0060:[<d118143f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc4 #1)
EIP is at saa7134_hwinit2+0x8c/0xe2 [saa7134]
eax: 00000000   ebx: cc253000   ecx: 00000000   edx: 0000003f
esi: cc253000   edi: cdc36400   ebp: cc2530d8   esp: c05d3e44
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 7451, threadinfo=c05d2000 task=cb24fa70)
Stack: <0>cc253000 cc253000 00000000 d1181ae7 cc253000 d1180fdc
24000000 cc2530d8
       cc253000 00000003 d118b1cd ffffffed cdc36400 d1199920 d119994c c02188ad
       cdc36400 d1198ef4 d1198ef4 d1199920 cdc36400 d119994c c02188ea d1199920
Call Trace:
 [<d1181ae7>] saa7134_initdev+0x332/0x799 [saa7134]
 [<d1180fdc>] saa7134_irq+0x0/0x2d6 [saa7134]
 [<c02188ad>] __pci_device_probe+0x5f/0x6d
 [<c02188ea>] pci_device_probe+0x2f/0x59
 [<c026b26a>] driver_probe_device+0x93/0xe5
 [<c026b325>] __driver_attach+0x0/0x69
 [<c026b38c>] __driver_attach+0x67/0x69
 [<c026a747>] bus_for_each_dev+0x58/0x78
 [<c026b3b4>] driver_attach+0x26/0x2a
 [<c026b325>] __driver_attach+0x0/0x69
 [<c026acba>] bus_add_driver+0x83/0xd1
 [<c026b883>] driver_register+0x61/0x8f
 [<c026b80e>] klist_devices_get+0x0/0xa
 [<c026b818>] klist_devices_put+0x0/0xa
 [<c0218b33>] __pci_register_driver+0x54/0x7c
 [<c011be9a>] printk+0x17/0x1b
 [<d1182229>] saa7134_init+0x4f/0x53 [saa7134]
 [<c0137d75>] sys_init_module+0x138/0x1f7
 [<c0102f65>] syscall_call+0x7/0xb
Code: 24 04 e8 68 aa f9 ee 89 1c 24 e8 d8 81 00 00 89 1c 24 e8 74 3e
00 00 83 bb d0 00 00 00 01 ba 3f 00 00 00 75 a9 8b 8b d4 00 00 00 <8b>
81 5c 02 00 00 a9 00 00 01 00 75 0e a9 00 00 04 00 74 2e ba


Program Versions (Output from the ver_linux script)
-----------------------------------------------------

Linux gamma 2.6.16-rc4 #1 PREEMPT Sun Feb 19 18:09:39 EAT 2006 i686
unknown unknown GNU/Linux

Gnu C                  3.3
Gnu make               3.80
binutils               2.13.90.0.18
util-linux             2.11z
mount                  2.11z
module-init-tools      3.1
e2fsprogs              1.35
jfsutils               1.1.1
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.6.25
quota-tools            3.11.
PPP                    2.4.1
nfs-utils              1.0.7
Linux C Library        14 02:33 /lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8
udev                   077
Modules Loaded         saa7134 i2c_prosavage i2c_viapro ehci_hcd
uhci_hcd usbcore 8250_pci 8250 serial_core video_buf compat_ioctl32
v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev via_agp agpgart
snd_via82xx snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_rawmidi
snd_seq_device snd_rtctimer snd_pcm_oss snd_pcm snd_timer
snd_page_alloc snd_mixer_oss snd soundcore it87 hwmon_vid hwmon
i2c_isa video fan button thermal processor via_rhine uinput fuse md5
ipv6 loop rtc pcspkr ide_cd cdrom dm_mod


Processor Info
--------------

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.00GHz
stepping        : 9
cpu MHz         : 2660.340
cache size      : 128 KB
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
bogomips        : 5324.99


/proc/modules
-------------------

saa7134 115552 1 - Loading 0xd1180000
i2c_prosavage 4224 0 - Live 0xd1116000
i2c_viapro 8852 0 - Live 0xd10dc000
ehci_hcd 32392 0 - Live 0xd1128000
uhci_hcd 33808 0 - Live 0xd111e000
usbcore 132484 3 ehci_hcd,uhci_hcd, Live 0xd113a000
8250_pci 21120 0 - Live 0xd10f6000
8250 24532 1 8250_pci, Live 0xd110c000
serial_core 22400 1 8250, Live 0xd1105000
video_buf 22276 1 saa7134, Live 0xd10fe000
compat_ioctl32 1408 1 saa7134, Live 0xd1004000
v4l2_common 7808 1 saa7134, Live 0xd10d9000
v4l1_compat 14212 1 saa7134, Live 0xd10f1000
ir_kbd_i2c 8716 1 saa7134, Live 0xd10d5000
ir_common 9732 2 saa7134,ir_kbd_i2c, Live 0xd1046000
videodev 9728 1 saa7134, Live 0xd1042000
via_agp 9984 1 - Live 0xd1000000
agpgart 35036 1 via_agp, Live 0xd10cb000
snd_via82xx 28180 1 - Live 0xd0fef000
snd_ac97_codec 95136 1 snd_via82xx, Live 0xd104c000
snd_ac97_bus 2304 1 snd_ac97_codec, Live 0xd0fd5000
snd_mpu401_uart 8064 1 snd_via82xx, Live 0xd0f12000
snd_rawmidi 26016 1 snd_mpu401_uart, Live 0xd0ff8000
snd_seq_device 8588 1 snd_rawmidi, Live 0xd0feb000
snd_rtctimer 3340 0 - Live 0xd0f58000
snd_pcm_oss 53280 0 - Live 0xd101e000
snd_pcm 91912 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live 0xd1006000
snd_timer 25732 2 snd_rtctimer,snd_pcm, Live 0xd0f73000
snd_page_alloc 10888 2 snd_via82xx,snd_pcm, Live 0xd0fd1000
snd_mixer_oss 19584 1 snd_pcm_oss, Live 0xd0fcb000
snd 54884 11 snd_via82xx,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss,
Live 0xd0fdc000
soundcore 10336 1 snd, Live 0xd0fc7000
it87 21284 0 - Live 0xd0f7b000
hwmon_vid 2816 1 it87, Live 0xd0f56000
hwmon 3220 1 it87, Live 0xd0f54000
i2c_isa 4736 1 it87, Live 0xd0f51000
video 16132 0 - Live 0xd0f6e000
fan 4740 0 - Live 0xd0f37000
button 6800 0 - Live 0xd0f08000
thermal 13320 0 - Live 0xd0f69000
processor 23616 1 thermal, Live 0xd0f62000
via_rhine 24836 0 - Live 0xd0f5a000
uinput 9472 0 - Live 0xd0f3b000
fuse 42764 0 - Live 0xd0f45000
md5 4096 1 - Live 0xd0f10000
ipv6 268288 27 - Live 0xd0f84000
loop 17672 0 - Live 0xd0f31000
rtc 13876 1 snd_rtctimer, Live 0xd0f2c000
pcspkr 3460 0 - Live 0xd0f0b000
ide_cd 41860 0 - Live 0xd0f20000
cdrom 40352 1 ide_cd, Live 0xd0f15000
dm_mod 56632 9 - Live 0xce836000

/proc/ioports
-------------------

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : it87-isa
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-040f : 0000:00:11.0
  0400-0407 : vt596_smbus
0800-087f : 0000:00:11.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0810-0815 : ACPI CPU throttle
  0820-0823 : GPE0_BLK
0cf8-0cff : PCI conf1
d800-d8ff : 0000:00:12.0
  d800-d8ff : via-rhine
dc00-dcff : 0000:00:11.5
  dc00-dcff : VIA8233
e000-e01f : 0000:00:10.0
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:10.1
  e400-e41f : uhci_hcd
e800-e81f : 0000:00:10.2
  e800-e81f : uhci_hcd
ec00-ecff : 0000:00:0b.0
  ec08-ec0f : serial
  ec10-ec17 : serial
fc00-fc0f : 0000:00:11.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

/proc/iomem
----------------

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-00332c84 : Kernel code
  00332c85-003de497 : Kernel data
0dff0000-0dff7fff : ACPI Tables
0dff8000-0dffffff : ACPI Non-volatile Storage
cfb00000-dfbfffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
    d0000000-d7ffffff : savagefb
dfd00000-dfefffff : PCI Bus #01
  dfe70000-dfe7ffff : 0000:01:00.0
  dfe80000-dfefffff : 0000:01:00.0
    dfe80000-dfefffff : savagefb
dfffc000-dfffcfff : 0000:00:0b.0
dfffdc00-dfffdfff : 0000:00:0a.0
  dfffdc00-dfffdfff : saa7130[0]
dffffe00-dffffeff : 0000:00:12.0
  dffffe00-dffffeff : via-rhine
dfffff00-dfffffff : 0000:00:10.3
  dfffff00-dfffffff : ehci_hcd
e0000000-e3ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


PCI info (lspci -vvv)
-----------------------

00:00.0 Host bridge: VIA Technologies, Inc. P4M266 Host Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dfd00000-dfefffff
	Prefetchable memory behind bridge: cfb00000-dfbfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia controller: Philips Semiconductors SAA7130 Video
Broadcast Decoder (rev 01)
	Subsystem: Unknown device 4e42:0138
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at dfffdc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

00:0b.0 Modem: Smart Link Ltd. SmartLink SmartPCI562 56K Modem (rev
04) (prog-if 00 [Generic])
	Subsystem: Smart Link Ltd. SmartLink SmartPCI562 56K Modem
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 15500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at dfffc000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ec00 [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 20
	Region 4: I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 20
	Region 4: I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
(prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 20
	Interrupt: pin D routed to IRQ 20
	Region 0: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Elitegroup Computer Systems: Unknown device a101
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 18
	Region 0: I/O ports at dc00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet
Controller on VT8235
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. VT8375 [ProSavage8
KM266/KL266] (prog-if 00 [VGA])
	Subsystem: S3 Inc. VT8375 [ProSavage8 KM266/KL266]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at dfe80000 (32-bit, non-prefetchable) [size=512K]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at dfe70000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit-
FW- AGP3- Rate=x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4



I will be glad to answer any queries.

Thanks,
--
B. Gitonga Marete
Tel: +254-722-151-590
