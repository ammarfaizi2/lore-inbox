Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWBMHC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWBMHC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWBMHC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:02:28 -0500
Received: from ip-center-pc4.mts-nn.ru ([213.177.107.5]:1461 "EHLO
	vaso.ip-center.ru") by vger.kernel.org with ESMTP id S1751085AbWBMHC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:02:27 -0500
Date: Mon, 13 Feb 2006 09:57:49 +0300 (MSK)
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: "rmmod snd_cmipci" cause an Oops
From: <gaa@mail.nnov.ru>
X-Mailer: InfoMail v.4pre2
Message-ID: <43F02D99000D89BC.FE47@mail.nnov.ru>
X-Originating-IP: 62.76.114.33
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"rmmod snd_cmipci" cause an Oops.
Linux-2.6.14 does not have this bug.

# rmmod snd_cmipci
Unable to handle kernel NULL pointer dereference at virtual address 
00000018
 printing eip:
c011b9da
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: lp snd_cmipci snd_pcm_oss snd_mixer_oss snd_pcm 
snd_page_alloc snd_opl3_lib snd_timer snd_hwdep 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore pl2303 usbserial 
ohci_hcd usbcore sis_agp agpgart nls_cp866 
vfat fat fuse parport_pc parport psmouse 8250 serial_core unix
CPU:    0
EIP:    0060:[<c011b9da>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15.4-gaa)
EIP is at __release_resource+0xa/0x50
eax: 00000000   ebx: c145c000   ecx: 00000018   edx: c2f5f3a0
esi: c2c7e540   edi: 00001fff   ebp: c2c7e400   esp: c145de64
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2685, threadinfo=c145c000 task=c34d7560)
Stack: c011bae1 c2f5f3a0 c2f5f3a0 c2c7e540 c4a67914 c2f5f3a0 c3655400 
c49ed65f
       c2f5f3a0 c2f5f3e0 c4a679fd c3655400 00001000 c4a67c72 c2c7e400 
c3655400
       c145c000 c2c7e400 c4a9c548 c4a9c548 c4a62de9 c2c7e400 00000001 
c01ec0cf
Call Trace:
 [<c011bae1>] release_resource+0x21/0x50
 [<c4a67914>] release_and_free_resource+0x14/0x30 [snd]
 [<c49ed65f>] snd_opl3_free+0x1f/0x40 [snd_opl3_lib]
 [<c4a679fd>] snd_device_free+0x5d/0xb0 [snd]
 [<c4a67c72>] snd_device_free_all+0x62/0x70 [snd]
 [<c4a62de9>] snd_card_free+0x109/0x210 [snd]
 [<c01ec0cf>] kref_put+0x2f/0x80
 [<c4a97bf9>] snd_cmipci_remove+0x19/0x24 [snd_cmipci]
 [<c01f621e>] pci_device_remove+0x1e/0x40
 [<c0227522>] __device_release_driver+0x62/0xa0
 [<c0227634>] driver_detach+0xa4/0xbe
 [<c0226e83>] bus_remove_driver+0x53/0x80
 [<c0227950>] driver_unregister+0x10/0x20
 [<c01f64a3>] pci_unregister_driver+0x13/0x20
 [<c4a97c9f>] alsa_card_cmipci_exit+0xf/0x11 [snd_cmipci]
 [<c0131425>] sys_delete_module+0x155/0x1a0
 [<c014c9d4>] sys_munmap+0x44/0x70
 [<c0102f21>] syscall_call+0x7/0xb
Code: 0c c3 89 47 14 89 3a 89 77 10 31 f6 89 f0 8b 1c 24 8b 74 24 04 8b 7c 
24 08 83 c4 0c c3 8d 74 26 00 8b 54 24 04 8b 
42 10 8d 48 18 <8b> 40 18 85 c0 74 2f 39 c2 75 13 8b 42 14 89 01 31 c0 c7 
42 10
 <6>note: rmmod[2685] exited with preempt_count 1
Segmentation fault

# cat /proc/version
Linux version 2.6.15.4-gaa (root@gaa) (gcc version 4.0.3 20060115 
(prerelease) (Debian 4.0.2-7)) #1 PREEMPT Sat Feb 11 22:11:07 MSK 2006

# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux gaa 2.6.15.4-gaa #1 PREEMPT Sat Feb 11 22:11:07 MSK 2006 i686 GNU/
Linux
 
Gnu C                  4.0.3
Gnu make               3.80
binutils               2.16.91
util-linux             2.11z
mount                  2.12
module-init-tools      3.2-pre1
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.3
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         lp snd_cmipci snd_pcm_oss snd_mixer_oss snd_pcm 
snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart 
snd_rawmidi snd_seq_device snd soundcore pl2303 usbserial ohci_hcd usbcore 
sis_agp agpgart nls_cp866 vfat fat fuse parport_pc parport psmouse 8250 
serial_core unix

# cat /proc/cpuinfo
processor: 0
vendor_id: CyrixInstead
cpu family: 6
model: 2
model name: M II 3.5x Core/Bus Clock
stepping: 4
cpu MHz: 292.363
fdiv_bug: no
hlt_bug: no
f00f_bug: no
coma_bug: no
fpu: yes
fpu_exception: yes
cpuid level: 1
wp: yes
flags: fpu de tsc msr cx8 pge cmov mmx cyrix_arr
bogomips: 585.45

# cat /proc/modules
lp 12904 0 - Live 0xc4a2e000
snd_cmipci 34720 0 - Unloading 0xc4a94000
snd_pcm_oss 55680 0 - Live 0xc4ab7000
snd_mixer_oss 19968 1 snd_pcm_oss, Live 0xc4a82000
snd_pcm 95176 2 snd_cmipci,snd_pcm_oss, Live 0xc4a9e000
snd_page_alloc 10952 1 snd_pcm, Live 0xc4a3b000
snd_opl3_lib 11104 1 snd_cmipci, Live 0xc49ed000
snd_timer 26212 2 snd_pcm,snd_opl3_lib, Live 0xc4a7a000
snd_hwdep 9504 1 snd_opl3_lib, Live 0xc4a2a000
snd_mpu401_uart 7840 1 snd_cmipci, Live 0xc4981000
snd_rawmidi 26272 1 snd_mpu401_uart, Live 0xc4a33000
snd_seq_device 8748 2 snd_opl3_lib,snd_rawmidi, Live 0xc49f1000
snd 55492 10 snd_cmipci,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,
snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 
0xc4a62000
soundcore 10304 1 snd, Live 0xc49bd000
pl2303 21540 0 - Live 0xc4a17000
usbserial 29056 1 pl2303, Live 0xc4a21000
ohci_hcd 22340 0 - Live 0xc49f5000
usbcore 135748 4 pl2303,usbserial,ohci_hcd, Live 0xc4a3f000
sis_agp 8740 0 - Live 0xc49b9000
agpgart 35816 1 sis_agp, Live 0xc4a0d000
nls_cp866 5088 1 - Live 0xc4984000
vfat 14144 1 - Live 0xc49b4000
fat 53788 1 vfat, Live 0xc49fe000
fuse 40428 0 - Live 0xc49e2000
parport_pc 37124 1 - Live 0xc49d7000
parport 39592 2 lp,parport_pc, Live 0xc49cc000
psmouse 39268 0 - Live 0xc49c1000
8250 23924 0 - Live 0xc49ad000
serial_core 22688 1 8250, Live 0xc49a6000
unix 29424 8 - Live 0xc498b000

# cat /proc/ioports
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
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-400f : 0000:00:01.1
  4000-4007 : ide0
  4008-400f : ide1
f400-f47f : 0000:00:14.0
f600-f6ff : 0000:00:0d.0
  f600-f6ff : CMI8738

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03bfffff : System RAM
  00100000-002c0126 : Kernel code
  002c0127-00333eff : Kernel data
08000000-083fffff : vesafb
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff400000-ff7fffff : 0000:00:14.0
ffadf000-ffadffff : 0000:00:01.2
  ffadf000-ffadffff : ohci_hcd
ffae0000-ffae7fff : 0000:00:14.0
ffaf0000-ffafffff : 0000:00:14.0
fffe0000-ffffffff : reserved

# lspci -vvv
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] 
(rev 10)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
Latency: 64

0000:00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 
(LPC Bridge) (rev 01)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 0

0000:00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(rev d0) (prog-if 8a [Master SecP PriP])
Subsystem: Unknown device 2841:a212
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 128
Interrupt: pin A routed to IRQ 0
Region 0: I/O ports at <ignored>
Region 1: I/O ports at <ignored>
Region 2: I/O ports at <ignored>
Region 3: I/O ports at <ignored>
Region 4: I/O ports at 4000 [size=16]

0000:00:01.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 10) (prog-if 10 [OHCI])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
Latency: 32, Cache Line Size: 0x08 (32 bytes)
Interrupt: pin A routed to IRQ 11
Region 0: Memory at ffadf000 (32-bit, non-prefetchable) [size=4K]

0000:00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 
(rev 10)
Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 32 (500ns min, 6000ns max)
Interrupt: pin A routed to IRQ 10
Region 0: I/O ports at f600 [size=256]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:14.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
5597/5598/6326 VGA (rev 68) (prog-if 00 [VGA])
Subsystem: Silicon Integrated Systems [SiS] 5597/5598/6326 VGA
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 0
Region 0: Memory at ff400000 (32-bit, prefetchable) [size=4M]
Region 1: Memory at ffaf0000 (32-bit, non-prefetchable) [size=64K]
Region 2: I/O ports at f400 [size=128]
Expansion ROM at ffae0000 [disabled] [size=32K]
