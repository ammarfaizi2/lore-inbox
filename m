Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271262AbTGWTvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271264AbTGWTvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:51:49 -0400
Received: from mailin.radiomobil.cz ([62.141.0.149]:23217 "EHLO
	mailin.radiomobil.cz") by vger.kernel.org with ESMTP
	id S271262AbTGWTvh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:51:37 -0400
From: =?iso-8859-2?q?Vojt=ECch=20Pithart?= <vojta@sinus.cz>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: (2.6.0) uhci-hcd.c: 9400: host controller process error.
Date: Wed, 23 Jul 2003 22:06:25 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200307232206.25628.vojta@sinus.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. My kernel prints out errors to syslog and khubd[5] exits when connecting 
USB camera.
2. After connection my USB camera (vend/prod 0x4a9/0x3058), usually used with 
gphoto2, the usual message like "new USB device 00:07.2-2, assigned address 
3" does appears in syslog. Then the hotplug should be started, but instead 
look at this:
....

Jul 23 21:01:03 e ntpdate[6059]: adjust time server 195.113.144.201 offset 
0.246202 sec
Jul 23 21:30:38 e kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 
status 0x101
Jul 23 21:30:38 e kernel: hub 1-0:0: new USB device on port 2, assigned 
address 2
èec 23 21:35:26 e su(pam_unix)[6214]: session opened for user root by 
vojta(uid=3579)
Jul 23 21:35:30 e kernel: drivers/usb/host/uhci-hcd.c: 9400: host controller 
process error. something bad happened
Jul 23 21:35:30 e kernel: drivers/usb/host/uhci-hcd.c: 9400: host controller 
halted. very bad
Jul 23 21:35:30 e kernel: drivers/usb/core/message.c: usb_control/bulk_msg: 
timeout
Jul 23 21:35:35 e kernel: usb 1-2: USB disconnect, address 2
Jul 23 21:35:47 e kernel: Unable to handle kernel paging request at virtual 
address 6b6b6b7b
Jul 23 21:35:47 e kernel:  printing eip:
Jul 23 21:35:47 e kernel: c0126c2a
Jul 23 21:35:47 e kernel: *pde = 00000000
Jul 23 21:35:47 e kernel: Oops: 0000 [#1]
Jul 23 21:35:47 e kernel: CPU:    0
Jul 23 21:35:47 e kernel: EIP:    0060:[<c0126c2a>]    Not tainted
Jul 23 21:35:47 e kernel: EFLAGS: 00010046
Jul 23 21:35:47 e kernel: EIP is at specific_send_sig_info+0x3a/0x100
Jul 23 21:35:47 e kernel: eax: 00000001   ebx: 6b6b6b6b   ecx: 6b6b6b6b   edx: 
00000000
Jul 23 21:35:47 e kernel: esi: 6b6b6b6b   edi: d5d99e9c   ebp: 00000000   esp: 
d5d99e60
Jul 23 21:35:47 e kernel: ds: 007b   es: 007b   ss: 0068
Jul 23 21:35:47 e kernel: Process khubd (pid: 5, threadinfo=d5d98000 
task=d5f8e040)
Jul 23 21:35:47 e kernel: Stack: 00000202 d5d98000 cb0ac85c c70a9518 c01275a7 
6b6b6b6b d5d99e9c 6b6b6b6b 
Jul 23 21:35:47 e kernel:        cb0ac85c cb0aca14 cb0ac85c c0316dfc 6b6b6b6b 
d5d99e9c 6b6b6b6b 0000000d 
Jul 23 21:35:47 e kernel:        00000020 fffffffc 6b6b6b6b d256bae0 d256bae0 
c016436d d256bae0 c04b0c98 
Jul 23 21:35:47 e kernel: Call Trace:
Jul 23 21:35:47 e kernel:  [<c01275a7>] send_sig_info+0x27/0x60
Jul 23 21:35:47 e kernel:  [<c0316dfc>] usbfs_remove_device+0xcc/0xe9
Jul 23 21:35:47 e kernel:  [<c016436d>] dput+0x1d/0x1e0
Jul 23 21:35:47 e kernel:  [<c016c40d>] simple_rmdir+0x2d/0x40
Jul 23 21:35:47 e kernel:  [<c016436d>] dput+0x1d/0x1e0
Jul 23 21:35:47 e kernel:  [<c0181fd2>] sysfs_remove_dir+0x112/0x140
Jul 23 21:35:47 e kernel:  [<c024154b>] unlink+0x5b/0x70
Jul 23 21:35:47 e kernel:  [<c030fe50>] hcd_endpoint_disable+0x0/0x190
Jul 23 21:35:47 e kernel:  [<c030be70>] usb_disconnect+0xf0/0x140
Jul 23 21:35:47 e kernel:  [<c030fe50>] hcd_endpoint_disable+0x0/0x190
Jul 23 21:35:47 e kernel:  [<c030be8e>] usb_disconnect+0x10e/0x140
Jul 23 21:35:47 e kernel:  [<c030e19c>] hub_port_connect_change+0x5c/0x2b0
Jul 23 21:35:47 e kernel:  [<c030e537>] hub_events+0x147/0x330
Jul 23 21:35:47 e kernel:  [<c011b839>] schedule+0x2b9/0x370
Jul 23 21:35:47 e kernel:  [<c030e755>] hub_thread+0x35/0xf0
Jul 23 21:35:47 e kernel:  [<c011b950>] default_wake_function+0x0/0x20
Jul 23 21:35:47 e kernel:  [<c030e720>] hub_thread+0x0/0xf0
Jul 23 21:35:47 e kernel:  [<c01071f9>] kernel_thread_helper+0x5/0xc
Jul 23 21:35:47 e kernel: 
Jul 23 21:35:47 e kernel: Code: f6 43 10 01 75 43 8d 4e ff 0f a3 8b b4 05 00 
00 19 c0 31 d2 
Jul 23 21:35:47 e kernel:  <6>note: khubd[5] exited with preempt_count 2
Jul 23 21:35:48 e kernel: Slab corruption: start=d14227e0, expend=d142285f, 
problemat=d14227e8
Jul 23 21:35:48 e kernel: Last user: [<c0313f52>](usbdev_release+0xb2/0xc0)
Jul 23 21:35:48 e kernel: Data: ********6A *6C *************00 00 00 00 
****************************************************
***********************************************A5 
Jul 23 21:35:48 e kernel: Next: 71 F0 2C .52 3F 31 C0 71 F0 2C 
.********************
Jul 23 21:35:48 e kernel: slab error in check_poison_obj(): cache `size-128': 
object was modified after freeing
Jul 23 21:35:48 e kernel: Call Trace:
Jul 23 21:35:48 e kernel:  [<c013c2d9>] check_poison_obj+0x189/0x1a0
Jul 23 21:35:48 e kernel:  [<c013d822>] __kmalloc+0xb2/0x170
Jul 23 21:35:48 e kernel:  [<c0174b75>] load_elf_interp+0xa5/0x230
Jul 23 21:35:48 e kernel:  [<c0141e71>] pte_alloc_map+0x31/0xb0
Jul 23 21:35:48 e kernel:  [<c0174b75>] load_elf_interp+0xa5/0x230
Jul 23 21:35:48 e kernel:  [<c0159115>] setup_arg_pages+0x165/0x1a0
Jul 23 21:35:48 e kernel:  [<c0175587>] load_elf_binary+0x767/0xa00
Jul 23 21:35:48 e kernel:  [<c0174e20>] load_elf_binary+0x0/0xa00
Jul 23 21:35:48 e kernel:  [<c0159deb>] search_binary_handler+0xbb/0x260
Jul 23 21:35:48 e kernel:  [<c015a128>] do_execve+0x198/0x220
Jul 23 21:35:48 e kernel:  [<c015b71d>] getname+0x5d/0xa0
Jul 23 21:35:48 e kernel:  [<c01079bd>] sys_execve+0x2d/0x60
Jul 23 21:35:48 e kernel:  [<c0108f8f>] syscall_call+0x7/0xb
Jul 23 21:35:48 e kernel: 
(END) 

4. Kernel version Linux version 2.6.0-test1 (root@e) (gcc version 2.96 
20000731 (Red Hat Linux 7.3 2.96-110)) #6 Wed Jul 23 09:57:36 CEST 2003

7. 1. 21:49:28(root@e)/usr/src/linux-2.6.0-test1#sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux e 2.6.0-test1 #6 Wed Jul 23 09:57:36 CEST 2003 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.25
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
quota-tools            3.01.
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.1.4
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded

7.2. 22:00:31(vojta@e)~#cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm) processor
stepping        : 0
cpu MHz         : 1000.178
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 1961.98

7.3.
22:01:40(vojta@e)~#cat /proc/modules 
22:02:06(vojta@e)~#lsmod
Module                  Size  Used by
22:02:13(vojta@e)~#
(no modules loaded; but module loading _is_ currently functional)

7.4.
22:02:13(vojta@e)~#cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0278-027a : parport0
027b-027f : parport0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, In VT82C686 [Apollo Sup
6000-607f : VIA Technologies, In VT82C686 [Apollo Sup
9000-900f : VIA Technologies, In VT82C586/B/686A/B PI
  9000-9007 : ide0
  9008-900f : ide1
9400-941f : VIA Technologies, In USB
  9400-941f : uhci-hcd
9800-981f : VIA Technologies, In USB (#2)
  9800-981f : uhci-hcd
9c00-9cff : VIA Technologies, In VT82C686 AC97 Audio 
  9c00-9cff : VIA686A
a000-a003 : VIA Technologies, In VT82C686 AC97 Audio 
a400-a403 : VIA Technologies, In VT82C686 AC97 Audio 
  a400-a401 : VIA82xx MPU401
ac00-ac7f : Avance Logic Inc. ALS4000 Audio Chipse
  ac00-ac3f : ALS4000
b000-b07f : 3Com Corporation 3c900B-Combo [Etherl
b400-b41f : Realtek Semiconducto RTL-8029(AS)
  b400-b41f : ne2k-pci
b800-b807 : Promise Technology,  20265
bc00-bc03 : Promise Technology,  20265
c000-c007 : Promise Technology,  20265
  c000-c007 : ide3
c400-c403 : Promise Technology,  20265
  c402-c402 : ide3
c800-c83f : Promise Technology,  20265
  c800-c807 : ide2
  c808-c80f : ide3
  c810-c83f : PDC20265
22:03:00(vojta@e)~#cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-15feffff : System RAM
  00100000-004197b0 : Kernel code
  004197b1-0054d87f : Kernel data
15ff0000-15ff2fff : ACPI Non-volatile Storage
15ff3000-15ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, In VT8363/8365 [KT133/K
d4000000-d7ffffff : S3 Inc. ViRGE/DX or /GX
d8000000-d8ffffff : PCI Bus #01
  d8000000-d8ffffff : nVidia Corporation NV4 [Riva TnT]
d9000000-daffffff : PCI Bus #01
  d9000000-d9ffffff : nVidia Corporation NV4 [Riva TnT]
dc000000-dc01ffff : Promise Technology,  20265
dc020000-dc020fff : Harris Semiconductor Prism 2.5 Wavelan ch
dc021000-dc02107f : 3Com Corporation 3c900B-Combo [Etherl
ffff0000-ffffffff : reserved

7.5. PCI bus
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d9000000-daffffff
	Prefetchable memory behind bridge: d8000000-d8ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 9000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 50)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 3300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at 9c00 [size=256]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at a400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01) (prog-if 
00 [VGA])
	Subsystem: S3 Inc. ViRGE/DX
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [disabled] [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:09.0 Multimedia audio controller: Avance Logic Inc. ALS4000 Audio Chipset
	Subsystem: Avance Logic Inc. ALS4000 Audio Chipset
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ac00 [size=128]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c900B-Combo [Etherlink XL 
Combo] (rev 04)
	Subsystem: 3Com Corporation 3C900B-Combo Etherlink XL Combo
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 12000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b000 [size=128]
	Region 1: Memory at dc021000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0c.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset 
(rev 01)
	Subsystem: Harris Semiconductor Prism 2.5 Wavelan chipset
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at dc020000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b400 [size=32]
	Expansion ROM at <unassigned> [disabled] [size=32K]

00:0f.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b800 [size=8]
	Region 1: I/O ports at bc00 [size=4]
	Region 2: I/O ports at c000 [size=8]
	Region 3: I/O ports at c400 [size=4]
	Region 4: I/O ports at c800 [size=64]
	Region 5: Memory at dc000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV4 [RIVA TNT] (rev 04) 
(prog-if 00 [VGA])
	Subsystem: STB Systems Inc Velocity 4400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d9000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

7.6.
[root@e root]# cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MITSUMI  Model: CR-2801TE        Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02

(Emulated CD burner)



