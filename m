Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVGGIZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVGGIZI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVGGIZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:25:08 -0400
Received: from cartier.jerryweb.org ([80.68.90.16]:52751 "EHLO
	cartier.jerryweb.org") by vger.kernel.org with ESMTP
	id S261220AbVGGIZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:25:04 -0400
Message-ID: <1120724705.42cce6e1e33c3@webmail.jerryweb.org>
Date: Thu, 07 Jul 2005 09:25:05 +0100
From: Jeremy Laine <jeremy.laine@polytechnique.org>
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
References: <1120644686.42cbae4e16ea3@webmail.jerryweb.org> <200507061859.40565.adobriyan@gmail.com>
In-Reply-To: <200507061859.40565.adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 195.115.41.103
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try without loading all those proprietary modules (vmmon, vmnet, nvidia).

Done, sorry about not doing it from the onset. I reproduced the OOPS using the
"vesa" driver of XFree86. Below is the OOPS as well as environment information:

Jul  6 22:57:29 sharky kernel: tuner 2-0060: TV freq (0.00) out of range
(44-958)
Jul  6 22:58:45 sharky kernel: bttv0: OCERR @ 36311000,bits: HSYNC OFLOW OCERR*
Jul  6 22:58:45 sharky last message repeated 11 times
Jul  6 22:58:45 sharky kernel: bttv0: timeout: drop=67 irq=7604/49951,
risc=3631101c, bits: HSYNC OFLOW
Jul  6 22:58:45 sharky kernel: bttv0: reset, reinitialize
Jul  6 22:58:45 sharky kernel: bttv0: PLL: 28636363 => 35468950 . ok
Jul  6 23:06:08 sharky kernel: tuner 2-0060: TV freq (0.00) out of range
(44-958)
Jul  6 23:12:57 sharky kernel: tuner 2-0060: TV freq (0.00) out of range
(44-958)
Jul  6 23:14:12 sharky kernel: tuner 2-0060: TV freq (0.00) out of range
(44-958)
Jul  7 02:11:36 sharky kernel: Unable to handle kernel paging request at virtual
address 1400000c
Jul  7 02:11:36 sharky kernel:  printing eip:
Jul  7 02:11:36 sharky kernel: c013e362
Jul  7 02:11:36 sharky kernel: *pde = 00000000
Jul  7 02:11:36 sharky kernel: Oops: 0002 [#1]
Jul  7 02:11:36 sharky kernel: PREEMPT
Jul  7 02:11:36 sharky kernel: Modules linked in: lp ipt_TOS iptable_mangle
ipt_MASQUERADE ipt_multiport ipt_REJECT ipt_LOG ipt_limit ipt_state
iptable_filter parport_pc parport intel_agp 3c59x mii snd_bt87x tuner tda9887
msp3400 bttv video_buf firmware_class btcx_risc tveeprom sk98lin tun
snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd
soundcore ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack usblp
Jul  7 02:11:36 sharky kernel: CPU:    0
Jul  7 02:11:36 sharky kernel: EIP:    0060:[free_block+82/224]    Tainted: P   
  VLI
Jul  7 02:11:36 sharky kernel: EFLAGS: 00010006   (2.6.12)
Jul  7 02:11:36 sharky kernel: EIP is at free_block+0x52/0xe0
Jul  7 02:11:36 sharky kernel: eax: 14000008   ebx: e19d8000   ecx: e19d8598  
edx: 18929000
Jul  7 02:11:36 sharky kernel: esi: c17d7900   edi: 0000000f   ebp: 0000001b  
esp: f7ea3d08
Jul  7 02:11:36 sharky kernel: ds: 007b   es: 007b   ss: 0068
Jul  7 02:11:36 sharky kernel: Process kswapd0 (pid: 154, threadinfo=f7ea2000
task=f7e5a590)
Jul  7 02:11:36 sharky kernel: Stack: c01f22a0 c17db990 c17d791c c17db990
00000092 c0dde598 c17de8a0 c013e43c
Jul  7 02:11:36 sharky kernel:        c17d7900 c17db990 0000001b 0000001b
c17db980 00000092 c0dde598 00000002
Jul  7 02:11:36 sharky kernel:        c013e607 c17d7900 c17db980 00000000
c0dde598 f7ea3d78 c01effd6 c17d7900
Jul  7 02:11:36 sharky kernel: Call Trace:
Jul  7 02:11:36 sharky kernel:  [memmove+80/84] memmove+0x50/0x54
Jul  7 02:11:36 sharky kernel:  [cache_flusharray+76/208]
cache_flusharray+0x4c/0xd0
Jul  7 02:11:36 sharky kernel:  [kmem_cache_free+71/80]
kmem_cache_free+0x47/0x50
Jul  7 02:11:36 sharky kernel:  [radix_tree_delete+278/416]
radix_tree_delete+0x116/0x1a0
Jul  7 02:11:36 sharky kernel:  [__pagevec_free+28/48] __pagevec_free+0x1c/0x30
Jul  7 02:11:36 sharky kernel:  [__pagevec_release_nonlru+105/144]
__pagevec_release_nonlru+0x69/0x90
Jul  7 02:11:36 sharky kernel:  [__remove_from_page_cache+36/80]
__remove_from_page_cache+0x24/0x50
Jul  7 02:11:36 sharky kernel:  [shrink_list+755/1104] shrink_list+0x2f3/0x450
Jul  7 02:11:36 sharky kernel:  [shrink_cache+272/736] shrink_cache+0x110/0x2e0
Jul  7 02:11:36 sharky kernel:  [get_writeback_state+67/80]
get_writeback_state+0x43/0x50
Jul  7 02:11:36 sharky kernel:  [shrink_slab+136/400] shrink_slab+0x88/0x190
Jul  7 02:11:36 sharky kernel:  [shrink_zone+173/224] shrink_zone+0xad/0xe0
Jul  7 02:11:36 sharky kernel:  [balance_pgdat+732/976]
balance_pgdat+0x2dc/0x3d0
Jul  7 02:11:36 sharky kernel:  [kswapd+233/272] kswapd+0xe9/0x110
Jul  7 02:11:36 sharky kernel:  [autoremove_wake_function+0/96]
autoremove_wake_function+0x0/0x60
Jul  7 02:11:36 sharky kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Jul  7 02:11:36 sharky kernel:  [autoremove_wake_function+0/96]
autoremove_wake_function+0x0/0x60
Jul  7 02:11:36 sharky kernel:  [kswapd+0/272] kswapd+0x0/0x110
Jul  7 02:11:36 sharky kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Jul  7 02:11:36 sharky kernel: Code: 00 00 8d bc 27 00 00 00 00 8b 44 24 24 8b
15 70 97 49 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c 8b 53
04 8b 03 <89> 50 04 89 02 8b 43 0c 31 d2 c7 03 00 01 10 00 c7 43 04 00 02
Jul  7 02:11:36 sharky kernel:  <6>note: kswapd0[154] exited with preempt_count
2


---[ /proc/cpuinfo ]---

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 9
cpu MHz		: 2807.470
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 5537.79


---[ /proc/modules ]---

lp 11588 0 - Live 0xf8b80000
ipt_TOS 2688 1 - Live 0xf8b7e000
iptable_mangle 2944 1 - Live 0xf8b5b000
ipt_MASQUERADE 3584 1 - Live 0xf8b77000
ipt_multiport 2688 4 - Live 0xf8b2d000
ipt_REJECT 5248 4 - Live 0xf8b74000
ipt_LOG 7296 4 - Live 0xf8b71000
ipt_limit 2560 4 - Live 0xf8b59000
ipt_state 2048 13 - Live 0xf8b2f000
iptable_filter 3200 1 - Live 0xf8ad7000
parport_pc 36036 1 - Live 0xf8b0f000
parport 25664 2 lp,parport_pc, Live 0xf8b25000
usblp 13312 0 - Live 0xf8b0a000
intel_agp 23580 1 - Live 0xf8abd000
3c59x 42152 0 - Live 0xf8b19000
mii 5760 1 3c59x, Live 0xf8aba000
snd_bt87x 15048 0 - Live 0xf8acd000
tuner 28712 0 - Live 0xf8ac4000
tda9887 14360 0 - Live 0xf8a8b000
msp3400 27944 0 - Live 0xf8aab000
bttv 157968 0 - Live 0xf8b31000
video_buf 22404 1 bttv, Live 0xf8ab3000
firmware_class 10496 1 bttv, Live 0xf8a95000
btcx_risc 5128 1 bttv, Live 0xf8a7b000
tveeprom 13464 1 bttv, Live 0xf8956000
sk98lin 177248 0 - Live 0xf8add000
tun 11776 2 - Live 0xf8973000
snd_pcm_oss 53536 0 - Live 0xf8a9c000
snd_mixer_oss 19840 1 snd_pcm_oss, Live 0xf8a75000
snd_intel8x0 33984 0 - Live 0xf8a81000
snd_emu10k1 118788 0 - Live 0xf89f1000
snd_rawmidi 25888 1 snd_emu10k1, Live 0xf8984000
snd_seq_device 8844 2 snd_emu10k1,snd_rawmidi, Live 0xf895f000
snd_ac97_codec 83320 2 snd_intel8x0,snd_emu10k1, Live 0xf89b9000
snd_pcm 95240 5 snd_bt87x,snd_pcm_oss,snd_intel8x0,snd_emu10k1,snd_ac97_codec,
Live 0xf89a0000
snd_timer 25860 2 snd_emu10k1,snd_pcm, Live 0xf897c000
snd_page_alloc 10244 4 snd_bt87x,snd_intel8x0,snd_emu10k1,snd_pcm, Live
0xf895b000
snd_util_mem 4736 1 snd_emu10k1, Live 0xf8949000
snd_hwdep 9504 1 snd_emu10k1, Live 0xf8952000
snd 54756 11
snd_bt87x,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer,snd_hwdep,
Live 0xf8964000
soundcore 10464 1 snd, Live 0xf894e000
ip_nat_ftp 3712 0 - Live 0xf8907000
iptable_nat 24028 3 ipt_MASQUERADE,ip_nat_ftp, Live 0xf8931000
ip_tables 22400 10
ipt_TOS,iptable_mangle,ipt_MASQUERADE,ipt_multiport,ipt_REJECT,ipt_LOG,ipt_limit,ipt_state,iptable_filter,iptable_nat,
Live 0xf890a000
ip_conntrack_ftp 73104 1 ip_nat_ftp, Live 0xf891e000
ip_conntrack 45752 5
ipt_MASQUERADE,ipt_state,ip_nat_ftp,iptable_nat,ip_conntrack_ftp, Live
0xf8911000


---[ /proc/ioports ]---

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
0290-0297 : pnp 00:0a
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-040f : i801-smbus
0480-04bf : 0000:00:1f.0
0680-06ff : pnp 00:0a
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
b000-b0ff : 0000:00:1f.5
  b000-b0ff : Intel ICH5
b400-b43f : 0000:00:1f.5
  b400-b43f : Intel ICH5
b480-b49f : 0000:00:1d.0
  b480-b49f : uhci_hcd
b800-b81f : 0000:00:1d.1
  b800-b81f : uhci_hcd
b880-b89f : 0000:00:1d.2
  b880-b89f : uhci_hcd
bc00-bc1f : 0000:00:1d.3
  bc00-bc1f : uhci_hcd
c880-c8ff : 0000:02:0c.0
  c880-c8ff : 0000:02:0c.0
cc00-cc1f : 0000:02:0b.0
  cc00-cc1f : EMU10K1
d000-d007 : 0000:02:0b.1
  d000-d007 : emu10k1-gp
d080-d08f : 0000:02:09.0
d400-d403 : 0000:02:09.0
d480-d487 : 0000:02:09.0
d800-d8ff : 0000:02:05.0
  d800-d8ff : SysKonnect SK-98xx
dc00-dc03 : 0000:02:09.0
e000-e007 : 0000:02:09.0
e080-e08f : 0000:02:04.0
e400-e403 : 0000:02:04.0
e480-e487 : 0000:02:04.0
e800-e803 : 0000:02:04.0
e880-e887 : 0000:02:04.0
ec00-ec7f : 0000:02:03.0
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1


---[ /proc/iomem ]---

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ce800-000d2bff : Adapter ROM
000d3000-000d37ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ff2ffff : System RAM
  00100000-0035a10c : Kernel code
  0035a10d-0045ab7f : Kernel data
3ff30000-3ff3ffff : ACPI Tables
3ff40000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
40000000-400003ff : 0000:00:1f.1
e0000000-f3efffff : PCI Bus #01
  e0000000-efffffff : 0000:01:00.0
f3ffe000-f3ffefff : 0000:02:0a.0
  f3ffe000-f3ffefff : bttv0
f3fff000-f3ffffff : 0000:02:0a.1
f4fff400-f4fff4ff : 0000:00:1f.5
  f4fff400-f4fff4ff : Intel ICH5
f4fff800-f4fff9ff : 0000:00:1f.5
  f4fff800-f4fff9ff : Intel ICH5
f4fffc00-f4ffffff : 0000:00:1d.7
  f4fffc00-f4ffffff : ehci_hcd
f5000000-f7efffff : PCI Bus #01
  f5000000-f5ffffff : 0000:01:00.0
  f6000000-f6ffffff : 0000:01:00.0
f7ff4000-f7ff7fff : 0000:02:05.0
  f7ff4000-f7ff7fff : SysKonnect SK-98xx
f7fff000-f7fff07f : 0000:02:0c.0
f7fff400-f7fff4ff : 0000:02:09.0
  f7fff400-f7fff4ff : SiI680
f7fff800-f7ffffff : 0000:02:03.0
f8000000-fbffffff : 0000:00:00.0
ffb80000-ffffffff : reserved


---[ lspci -vvv ]---

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub
Interface (rev 02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [2106]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+
Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f5000000-f7efffff
	Prefetchable memory behind bridge: e0000000-f3efffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
(rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at b480 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
(rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at b800 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
(rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at b880 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
(rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at bc00 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at f4fffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000c000-0000efff
	Memory behind bridge: f7f00000-fbffffff
	Prefetchable memory behind bridge: f3f00000-f3ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev
02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at b000 [size=256]
	Region 1: I/O ports at b400 [size=64]
	Region 2: Memory at f4fff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at f4fff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV40 OS1RT00B30 (rev
a1) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 817b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 2: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at f7ee0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+
AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f7fff800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at ec00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:04.0 RAID bus controller: VIA Technologies, Inc. VT6410 ATA133 RAID
controller (rev 06)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e880 [size=8]
	Region 1: I/O ports at e800 [size=4]
	Region 2: I/O ports at e480 [size=8]
	Region 3: I/O ports at e400 [size=4]
	Region 4: I/O ports at e080 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:05.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T
[Marvell] (rev 12)
	Subsystem: Asustek Computer, Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at f7ff4000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at d800 [size=256]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data

0000:02:09.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology
Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Winic W-680
(Silicon Image 680 based)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x01 (4 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at e000 [size=8]
	Region 1: I/O ports at dc00 [size=4]
	Region 2: I/O ports at d480 [size=8]
	Region 3: I/O ports at d400 [size=4]
	Region 4: I/O ports at d080 [size=16]
	Region 5: Memory at f7fff400 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at f7f00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:02:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at f3ffe000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver, audio
section)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f3fff000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
08)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at cc00 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at d000 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev
74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x04 (16 bytes)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at c880 [size=128]
	Region 1: Memory at f7fff000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at f7fc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Jeremy

-- 
http://www.jerryweb.org/         : JerryWeb.org
http://sailcut.sourceforge.net/  : Sailcut CAD
http://mpf70.sourceforge.net/    : MPman MP-F70 support for Linux
