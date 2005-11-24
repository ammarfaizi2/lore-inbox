Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVKXKJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVKXKJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVKXKJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:09:57 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:46720 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932618AbVKXKJ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:09:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K92bDk5lQew7DowhCQIi+hIjst8DlPrjQgv8xtg9Vjic9zuPcq3i2dDdkGfX8wQJzxrr1JOMi98XwxWsZ3euc22VkjSnZ12D8tq+FraZhYefMeRY+tGY+ixkN8pzJ9QjjkchBlE4AhvWJlym+G2i8g8XDqGQhsrAjy0sihdkPAw=
Message-ID: <6dd519ae0511240209y712549bep6ba626134bb6f502@mail.gmail.com>
Date: Thu, 24 Nov 2005 10:09:55 +0000
From: Brian Marete <bgmarete@gmail.com>
To: Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Oops in 2.6.15-rc1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
---------
Oops in Kernel 2.6.15-rc1

Description:
 -----------------

I just upgraded from kernel 2.6.14 to the above mentioned
kernel. Immediately after rebooting & logging into X, I decided to have
a look at dmesg(1), only to discover that the kernel oopsed while
(apparently) saa7134.ko -- which drives my TV card -- was getting
loaded. Subsequently, I discovered that while saa7134.ko successfully
loaded, tuner.ko did not and udev did not create /dev/video0, so that I
was unable to access my TV card.

After this oops, hotplugging for my USB memory key does not work, even
after I load usbcore.ko and usb-strorage.ko manually. (Nonetheless, I
can log into X and otherwise use the computer in a normal way.)

I have not seen such an oops with Kernel 2.6.14 (Of course, I am aware
that the -rcn kernels are for testing :) My main motivation in
installing 2.6.15-rc5 was actually to test drive the new ALSA capability
for saa7134 driver)

Perhaps I should mention that while my TV card is not known by the
saa7134 driver, I can always get TV to work with the insmod option:
options saa7134 card=3, and the default tuner for that card. (FM Radio,
however, does not work at all.) Also, apparently the card presents 2
addresses to the tuner driver, so that I use an insmod option ( options
tuner addr=0x61 ) to get it to use one of them.

This kernel (2.6.15-rc1) was compiled with gcc-3.4.4, as was my
previous kernel (2.6.14)

I have confirmed that the oops is __repeatable__. It happens every time I
(re)boot. (saa7134.ko is loaded on boot)

Oops Message
----------------

The following is the oops message, taken from dmesg(1). I have included
a little of what preceded the oops.

====================================================================
saa7130/34: v4l2 driver version 0.2.14 loaded
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 19
saa7130[0]: found at 0000:00:0a.0, rev: 1, irq: 19, latency: 32, mmio:
0xdfffdc00
saa7130[0]: subsystem: 4e42:0138, board: LifeView FlyVIDEO2000
[card=3,insmod option]
saa7130[0]: board init: gpio is 39100
saa7130[0]: there are different flyvideo cards with different tuners
saa7130[0]: out there, you might have to use the tuner=<nr> insmod
saa7130[0]: option to override the default value.
Unable to handle kernel NULL pointer dereference at virtual address 000006d0
 printing eip:
c0299163
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: saa7134 video_buf v4l2_common v4l1_compat ir_common
videodev via_agp agpgart snd_via82xx snd_ac97_codec snd_ac97_bus
snd_mpu401_uart snd_rawmidi snd_seq_device snd_rtctimer snd_pcm_oss
snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore video fan
button thermal processor via_rhine fuse md5 ipv6 loop rtc pcspkr
ide_cd cdrom dm_mod
CPU:    0
EIP:    0060:[<c0299163>]    Not tainted VLI
EFLAGS: 00010296   (2.6.15-rc1)
EIP is at input_register_device+0x9/0x180
eax: 00000000   ebx: cd24fe38   ecx: 00000000   edx: cb12a000
esi: 00000000   edi: cd24fc00   ebp: c7daf800   esp: c98dfdd8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 5691, threadinfo=c98de000 task=c9ee0540)
Stack: cd24fe38 cd24fe18 cd24fc00 c7daf800 c0211856 cd24fe38 cd24fe18 cd24fe38
       cd24fe18 d111ea6d 00000000 cd24fc04 00000063 d1130720 00040000 0ec00000
       d1130720 cb12a000 cdc2a400 00000000 cb12a0d4 d1114421 cb12a000 d11200dc
Call Trace:
 [<c0211856>] snprintf+0x27/0x2b
 [<d111ea6d>] saa7134_input_init1+0x1f2/0x3d2 [saa7134]
 [<d1114421>] saa7134_hwinit1+0x92/0x142 [saa7134]
 [<d1114bf9>] saa7134_initdev+0x2ec/0x868 [saa7134]
 [<c0218649>] __pci_device_probe+0x5f/0x6d
 [<c0218686>] pci_device_probe+0x2f/0x59
 [<c0269e07>] driver_probe_device+0x38/0xc2
 [<c0269efa>] __driver_attach+0x0/0x43
 [<c0269f3b>] __driver_attach+0x41/0x43
 [<c02693ef>] bus_for_each_dev+0x58/0x78
 [<c0269f63>] driver_attach+0x26/0x2a
 [<c0269efa>] __driver_attach+0x0/0x43
 [<c0269908>] bus_add_driver+0x83/0xe9
 [<c026a38d>] driver_register+0x3b/0x40
 [<c026a33e>] klist_devices_get+0x0/0xa
 [<c026a348>] klist_devices_put+0x0/0xa
 [<c02188e6>] __pci_register_driver+0x6b/0x93
 [<c011abde>] printk+0x17/0x1b
 [<d1115447>] saa7134_init+0x4f/0x53 [saa7134]
 [<c0135cd8>] sys_init_module+0x153/0x20e
 [<c0103041>] syscall_call+0x7/0xb
Code: 24 04 50 76 39 c0 e8 1f 81 f0 ff 89 1c 24 c7 44 24 04 48 77 39
c0 e8 0f 81 f0 ff 83 c4 10 5b 5e 5f c3 56 53 83 ec 1c 8b 74 24 28 <8b>
9e d0 06 00 00 85 db 0f 84 45 01 00 00 8d 86 3c 06 00 00 c7
 <6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
===========================================================


Program Versions (Output from the ver_linux script)
---------------------------------------------------
Linux gamma 2.6.15-rc1 #1 PREEMPT Fri Nov 18 21:23:44 EAT 2005 i686
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
reiser4progs           line
xfsprogs               2.6.25
quota-tools            3.11.
PPP                    2.4.1
isdn4k-utils           3.2p3
nfs-utils              1.0.7
Linux C Library        14 02:33 /lib/libc.so.6
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.06
Sh-utils               4.5.8
udev                   068
Modules Loaded         8250_pci 8250 serial_core saa7134 video_buf
v4l2_common v4l1_compat ir_common videodev via_agp agpgart snd_via82xx
snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_rawmidi snd_seq_device
snd_rtctimer snd_pcm_oss snd_pcm snd_timer snd_page_alloc
snd_mixer_oss snd soundcore video fan button thermal processor
via_rhine fuse md5 ipv6 loop rtc pcspkr ide_cd cdrom dm_mod


Processor Info
--------------

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Celeron(R) CPU 2.00GHz
stepping	: 9
cpu MHz		: 2660.341
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 5322.66

/proc/modules
----------------

8250_pci 19739 1 - Loading 0xd10dc000
8250 23892 1 8250_pci, Live 0xd10f2000
serial_core 22528 1 8250, Live 0xd10eb000
saa7134 126940 1 - Loading 0xd1113000
video_buf 22148 1 saa7134, Live 0xd10e4000
v4l2_common 5888 1 saa7134, Live 0xd10d1000
v4l1_compat 14340 1 saa7134, Live 0xd10d7000
ir_common 8964 1 saa7134, Live 0xd10ba000
videodev 9728 1 saa7134, Live 0xd1036000
via_agp 9856 1 - Live 0xd102e000
agpgart 35144 1 via_agp, Live 0xd0fec000
snd_via82xx 28052 1 - Live 0xd0fdb000
snd_ac97_codec 94240 1 snd_via82xx, Live 0xd103b000
snd_ac97_bus 2304 1 snd_ac97_codec, Live 0xd0f66000
snd_mpu401_uart 8064 1 snd_via82xx, Live 0xd0f6a000
snd_rawmidi 26016 1 snd_mpu401_uart, Live 0xd0fe4000
snd_seq_device 8588 1 snd_rawmidi, Live 0xd0f77000
snd_rtctimer 3340 0 - Live 0xd0f06000
snd_pcm_oss 53408 0 - Live 0xd100e000
snd_pcm 91684 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live 0xd0ff6000
snd_timer 25732 2 snd_rtctimer,snd_pcm, Live 0xd0fd3000
snd_page_alloc 10888 2 snd_via82xx,snd_pcm, Live 0xd0f73000
snd_mixer_oss 19584 1 snd_pcm_oss, Live 0xd0f6d000
snd 56420 11 snd_via82xx,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss,
Live 0xd0fc4000
soundcore 10336 2 saa7134,snd, Live 0xd0f0f000
video 16004 0 - Live 0xd0f61000
fan 4612 0 - Live 0xd0f38000
button 6672 0 - Live 0xd0f35000
thermal 13320 0 - Live 0xd0f3b000
processor 23228 1 thermal, Live 0xd0f54000
via_rhine 24452 0 - Live 0xd0f4d000
fuse 39436 0 - Live 0xd0f42000
md5 3968 1 - Live 0xd0f0d000
ipv6 267392 23 - Live 0xd0f81000
loop 17544 0 - Live 0xd0f2f000
rtc 13748 1 snd_rtctimer, Live 0xd0f2a000
pcspkr 2180 0 - Live 0xd0f08000
ide_cd 41860 0 - Live 0xd0f1e000
cdrom 40224 1 ide_cd, Live 0xd0f13000
dm_mod 57272 9 - Live 0xce836000


/proc/ioports
-----------------

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
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-040f : 0000:00:11.0
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
e400-e41f : 0000:00:10.1
e800-e81f : 0000:00:10.2
ec00-ecff : 0000:00:0b.0
fc00-fc0f : 0000:00:11.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1

/proc/iomem
----------------------

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-0032f1f2 : Kernel code
  0032f1f3-003d4477 : Kernel data
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
	Interrupt: pin A routed to IRQ 19
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
	Interrupt: pin A routed to IRQ 20
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
	Interrupt: pin A routed to IRQ 21
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
	Interrupt: pin B routed to IRQ 21
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
	Interrupt: pin C routed to IRQ 21
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
	Interrupt: pin D routed to IRQ 21
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



I hope the above information is as complete as possible and that it will
not be misleading. I will be glad to answer any query.

With kind regards,
--
B. Gitonga Marete
Tel: +254-722-151-590
