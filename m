Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUBKGqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUBKGqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:46:42 -0500
Received: from pengo.systems.pipex.net ([62.241.160.193]:50358 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263620AbUBKGoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:44:07 -0500
Message-ID: <4029CF14.1090609@dsl.pipex.com>
Date: Wed, 11 Feb 2004 06:43:32 +0000
From: ck <x@dsl.pipex.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Stack Trace - problem unknown (__crc_ide_bus_type) - system running
 ok
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Stack Trace - problem unknown - system running ok?
[2.] I think it happened during the modules loading stage
[3.] kernel, pci
[4.] Linux version 2.6.3-rc2 (root@diogenis) (gcc version 3.3.2 20031218 
(Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 SMP Tue Feb 10 05:37:34 GMT 
2004
[5.]
-------------------------------------
dmesg
-------------------------------------

ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c00200018fd]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
  [<c0241b8d>] kobject_get+0x4d/0x50
  [<c028c768>] get_device+0x18/0x30
  [<c028d3eb>] bus_for_each_dev+0x6b/0xd0
  [<f8eadadd>] nodemgr_node_probe+0x4d/0x130 [ieee1394]
  [<f8ead9a0>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<f8eadf48>] nodemgr_host_thread+0x188/0x1b0 [ieee1394]
  [<f8eaddc0>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
  [<c0106ea9>] kernel_thread_helper+0x5/0xc

Unable to handle kernel paging request at virtual address b828ec83
  printing eip:
b828ec83
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<b828ec83>]    Not tainted
EFLAGS: 00010282
EIP is at 0xb828ec83
eax: b828ec83   ebx: f8eba388   ecx: f7505f9c   edx: 00000000
esi: f8ead3a0   edi: 00000000   ebp: f8eac070   esp: f7505f40
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 3442, threadinfo=f7504000 task=f7d2a6b0)
Stack: c0241c28 f8eba388 f8eba364 f8eba36c f8eba2c0 f74c6c44 c028d408 
f8eba388
        f7505f9c f8eba30c 00000000 f74c6c3c f7505f9c f76077d8 f7505f9c 
f8eadadd
        f8eba2c0 f74c6c3c f7505f9c f8ead9a0 f75f8000 f76077d8 f75f8000 
f76077d8
Call Trace:
  [<c0241c28>] kobject_cleanup+0x98/0xa0
  [<c028d408>] bus_for_each_dev+0x88/0xd0
  [<f8eadadd>] nodemgr_node_probe+0x4d/0x130 [ieee1394]
  [<f8ead9a0>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<f8eadf48>] nodemgr_host_thread+0x188/0x1b0 [ieee1394]
  [<f8eaddc0>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
  [<c0106ea9>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
  <6>eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

-------------------------------------
[6.]
--------------------------------------
[7.]
-----------------------------------------
[7.1.]
-----------------------------------------
nm vmlinux | sort | less
-----------------------------------------
b7debdf0 A __crc_inet_accept
b7e2b4a5 A __crc_auth_domain_put
b7e555a9 A __crc_rpc_new_child
b7fdcaef A __crc_ide_bus_type
b8328626 A __crc_blk_queue_merge_bvec
b837c742 A __crc_deactivate_super
b8504b1c A __crc_read_cache_page
b8520a43 A __crc_auth_unix_add_addr
-------------------------------------
root@diogenis linux-2.6.3-rc2 # dmesg | ksymoops -v vmlinux -m System.map
-------------------------------------
ksymoops 2.4.9 on i686 2.6.3-rc2.  Options used
      -v vmlinux (specified)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.6.3-rc2/ (default)
      -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
8139too Fast Ethernet driver 0.9.27
Call Trace:
  [<c0241b8d>] kobject_get+0x4d/0x50
  [<c028c768>] get_device+0x18/0x30
  [<c028d3eb>] bus_for_each_dev+0x6b/0xd0
  [<f8eadadd>] nodemgr_node_probe+0x4d/0x130 [ieee1394]
  [<f8ead9a0>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<f8eadf48>] nodemgr_host_thread+0x188/0x1b0 [ieee1394]
  [<f8eaddc0>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
  [<c0106ea9>] kernel_thread_helper+0x5/0xc
Unable to handle kernel paging request at virtual address b828ec83
b828ec83
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<b828ec83>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: b828ec83   ebx: f8eba388   ecx: f7505f9c   edx: 00000000
esi: f8ead3a0   edi: 00000000   ebp: f8eac070   esp: f7505f40
ds: 007b   es: 007b   ss: 0068
Stack: c0241c28 f8eba388 f8eba364 f8eba36c f8eba2c0 f74c6c44 c028d408 
f8eba388
        f7505f9c f8eba30c 00000000 f74c6c3c f7505f9c f76077d8 f7505f9c 
f8eadadd
        f8eba2c0 f74c6c3c f7505f9c f8ead9a0 f75f8000 f76077d8 f75f8000 
f76077d8
Call Trace:
  [<c0241c28>] kobject_cleanup+0x98/0xa0
  [<c028d408>] bus_for_each_dev+0x88/0xd0
  [<f8eadadd>] nodemgr_node_probe+0x4d/0x130 [ieee1394]
  [<f8ead9a0>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
  [<f8eadf48>] nodemgr_host_thread+0x188/0x1b0 [ieee1394]
  [<f8eaddc0>] nodemgr_host_thread+0x0/0x1b0 [ieee1394]
  [<c0106ea9>] kernel_thread_helper+0x5/0xc
Code:  Bad EIP value.


Trace; c0241b8d <kobject_get+4d/50>
Trace; c028c768 <get_device+18/30>
Trace; c028d3eb <bus_for_each_dev+6b/d0>
Trace; f8eadadd <__crc_device_suspend+54f4e/255e4e>
Trace; f8ead9a0 <__crc_device_suspend+54e11/255e4e>
Trace; f8eadf48 <__crc_device_suspend+553b9/255e4e>
Trace; f8eaddc0 <__crc_device_suspend+55231/255e4e>
Trace; c0106ea9 <kernel_thread_helper+5/c>

 >>EIP; b828ec83 <__crc_ide_bus_type+2b2194/34bb37>   <=====

 >>eax; b828ec83 <__crc_ide_bus_type+2b2194/34bb37>
 >>ebx; f8eba388 <__crc_device_suspend+617f9/255e4e>
 >>ecx; f7505f9c <__crc_redraw_screen+18dbbb/4198ad>
 >>esi; f8ead3a0 <__crc_device_suspend+54811/255e4e>
 >>ebp; f8eac070 <__crc_device_suspend+534e1/255e4e>
 >>esp; f7505f40 <__crc_redraw_screen+18db5f/4198ad>

Trace; c0241c28 <kobject_cleanup+98/a0>
Trace; c028d408 <bus_for_each_dev+88/d0>
Trace; f8eadadd <__crc_device_suspend+54f4e/255e4e>
Trace; f8ead9a0 <__crc_device_suspend+54e11/255e4e>
Trace; f8eadf48 <__crc_device_suspend+553b9/255e4e>
Trace; f8eaddc0 <__crc_device_suspend+55231/255e4e>
Trace; c0106ea9 <kernel_thread_helper+5/c>


1 error issued.  Results may not be reliable.
-------------------------------------------------------------------------
root@diogenis linux-2.6.3-rc2 # sh scripts/ver_linux
---------------------------------------------------------------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux diogenis 2.6.3-rc2 #1 SMP Tue Feb 10 05:37:34 GMT 2004 i686 AMD 
Athlon(tm) MP 1600+ AuthenticAMD GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         parport_pc lp parport ohci_hcd emu10k1_gp 
gameport ohci1394 ieee1394 snd_seq_midi snd_emu10k1_synth snd_emux_synth 
snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec 
snd_util_mem snd_hwdep snd_seq_oss snd_seq_midi_event snd_seq 
snd_seq_device snd_pcm_oss snd_pcm snd_page_alloc snd_timer 
snd_mixer_oss snd soundcore ide_floppy usblp usbcore 8139too mii crc32
---------------------------------------
[7.2.]
--------------------------------------
root@diogenis linux-2.6.3-rc2 # cat /proc/cpuinfo
---------------------------------------------
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1600+
stepping        : 2
cpu MHz         : 1399.845
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
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2768.89

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1399.845
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
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2793.47

---------------------------------------
[7.3.]
---------------------------------------
root@diogenis linux-2.6.3-rc2 # cat /proc/modules
-------------------------------------
parport_pc 40000 1 - Live 0xf8ed8000
lp 11428 0 - Live 0xf8dc0000
parport 45096 2 parport_pc,lp, Live 0xf8ecb000
ohci_hcd 19652 0 - Live 0xf8e97000
emu10k1_gp 3584 0 - Live 0xf8d35000
gameport 4992 1 emu10k1_gp, Live 0xf8de6000
ohci1394 36676 0 - Live 0xf8e8d000
ieee1394 83568 1 ohci1394, Live 0xf8ea6000
snd_seq_midi 8544 0 - Live 0xf8db2000
snd_emu10k1_synth 8128 0 - Live 0xf8daf000
snd_emux_synth 40064 1 snd_emu10k1_synth, Live 0xf8e82000
snd_seq_virmidi 8000 1 snd_emux_synth, Live 0xf8d67000
snd_seq_midi_emul 8000 1 snd_emux_synth, Live 0xf8d5d000
snd_emu10k1 101060 2 snd_emu10k1_synth, Live 0xf8df3000
snd_rawmidi 25760 3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1, Live 
0xf8db8000
snd_ac97_codec 63492 1 snd_emu10k1, Live 0xf8dc4000
snd_util_mem 4544 2 snd_emux_synth,snd_emu10k1, Live 0xf8d60000
snd_hwdep 9632 2 snd_emux_synth,snd_emu10k1, Live 0xf8d37000
snd_seq_oss 36224 0 - Live 0xf8d6a000
snd_seq_midi_event 8128 3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss, Live 
0xf8d5a000
snd_seq 59408 8 
snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,snd_seq_midi_event, 
Live 0xf8d9f000
snd_seq_device 8200 7 
snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_emu10k1,snd_rawmidi,snd_seq_oss,snd_seq, 
Live 0xf8d56000
snd_pcm_oss 54564 0 - Live 0xf8d90000
snd_pcm 103072 2 snd_emu10k1,snd_pcm_oss, Live 0xf8d75000
snd_page_alloc 12164 2 snd_emu10k1,snd_pcm, Live 0xf8d3b000
snd_timer 27204 2 snd_seq,snd_pcm, Live 0xf8d3f000
snd_mixer_oss 19968 2 snd_pcm_oss, Live 0xf8cf5000
snd 56292 16 
snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_util_mem,snd_hwdep,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss, 
Live 0xf8d47000
soundcore 10656 2 snd, Live 0xf8d31000
ide_floppy 19072 0 - Live 0xf896b000
usblp 13504 0 - Live 0xf8966000
usbcore 108444 4 ohci_hcd,usblp, Live 0xf8986000
8139too 25664 0 - Live 0xf895e000
mii 5120 1 8139too, Live 0xf8952000
crc32 4416 1 8139too, Live 0xf894f000
-----------------------------------------------
[7.4.]
--------------------------------------
root@diogenis linux-2.6.3-rc2 # cat /proc/ioports
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:0b.0
   1000-10ff : 8139too
1400-141f : 0000:00:0c.0
   1400-141f : EMU10K1
1430-143f : 0000:00:08.0
   1430-1437 : ide2
   1438-143f : ide3
1440-1443 : 0000:00:00.0
1444-1447 : 0000:00:08.0
   1446-1446 : ide3
1448-144f : 0000:00:08.0
   1448-144f : ide3
1450-1453 : 0000:00:08.0
   1452-1452 : ide2
1458-145f : 0000:00:08.0
   1458-145f : ide2
1460-1467 : 0000:00:0c.1
   1460-1467 : emu10k1-gp
f000-f00f : 0000:00:07.1
   f000-f007 : ide0
   f008-f00f : ide1

root@diogenis linux-2.6.3-rc2 # cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000dc000-000dcfff : 0000:00:07.4
   000dc000-000dcfff : ohci_hcd
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-0034431a : Kernel code
   0034431b-0042013f : Kernel data
3fff0000-3ffffbff : ACPI Tables
3ffffc00-3fffffff : ACPI Non-volatile Storage
e8000000-e8003fff : 0000:00:08.0
e8004000-e8007fff : 0000:00:0c.2
e8009000-e80097ff : 0000:00:0c.2
   e8009000-e80097ff : ohci1394
e8009800-e80098ff : 0000:00:0b.0
   e8009800-e80098ff : 8139too
e9000000-e9ffffff : PCI Bus #01
   e9000000-e9ffffff : 0000:01:05.0
ea000000-ea000fff : 0000:00:00.0
ec000000-efffffff : 0000:00:00.0
f0000000-f7ffffff : PCI Bus #01
   f0000000-f7ffffff : 0000:01:05.0
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved
------------------------------------
[7.5.]
------------------------------------
root@diogenis linux-2.6.3-rc2 # lspci -vvv
------------------------------------------
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 64
         Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
         Region 1: Memory at ea000000 (32-bit, prefetchable) [size=4K]
         Region 2: I/O ports at 1440 [disabled] [size=4]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
AGP Bridge (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 99
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: e9000000-e9ffffff
         Prefetchable memory behind bridge: f0000000-f7ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA 
(rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] 
IDE (rev 01) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI 
(rev 01)
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] 
USB (rev 07) (prog-if 10 [OHCI])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (20000ns max)
         Interrupt: pin D routed to IRQ 19
         Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 02) (prog-if 85)
         Subsystem: Promise Technology, Inc. Ultra100TX2
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1000ns min, 4500ns max), cache line size 10
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at 1458 [size=8]
         Region 1: I/O ports at 1450 [size=4]
         Region 2: I/O ports at 1448 [size=8]
         Region 3: I/O ports at 1444 [size=4]
         Region 4: I/O ports at 1430 [size=16]
         Region 5: Memory at e8000000 (32-bit, non-prefetchable) [size=16K]
         Expansion ROM at <unassigned> [disabled] [size=16K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at 1000 [size=256]
         Region 1: Memory at e8009800 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
         Subsystem: Creative Labs SB0090 Audigy Player
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at 1400 [size=32]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Audigy MIDI/Game port 
(rev 03)
         Subsystem: Creative Labs SB Audigy MIDI/Game Port
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 0: I/O ports at 1460 [size=8]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port 
(prog-if 10 [OHCI])
         Subsystem: Creative Labs SB Audigy FireWire Port
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 1000ns max), cache line size 10
         Interrupt: pin B routed to IRQ 17
         Region 0: Memory at e8009000 (32-bit, non-prefetchable) [size=2K]
         Region 1: Memory at e8004000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:05.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 
MX 100 DDR/200 DDR] (rev b2) (prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at e9000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- 
FW- Rate=<none>
------------------------------------
[7.6.] no scsi
-----------------------------------
