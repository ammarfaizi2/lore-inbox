Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUJNWhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUJNWhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUJNWgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:36:02 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:6382 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S267987AbUJNWb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:31:57 -0400
Date: Fri, 15 Oct 2004 00:31:54 +0200
From: Bjoern Brandenburg <askadar@cs.tu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: OOPS in ReiserFS
Message-ID: <20041014223154.GA12089@conde.cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gurus, 
I encountered an oops in ReiserFS. I hope I can give you some useful information (my first attempt a reporting a kernel-oops). Please cc me if you have questions, I don't usually follow lkml.

Thank you for your time,
Bjoern

[1.] 
The ReiserFS filesystem locked up with an oops after finding a corrupt partition. Hardware seems to be ok, at least I didn't have problems before.
    
[2.] 
I mounted a CD and copied a directory to my home dir (on a ReiserFS partition). In the middle of the process the kernel quit with an oops. This was reproducable, the oops would reoccur after every reboot when trying to copy the directory. A boot with knoppix followed by an reiserfsck --fix-fixable /dev/hde5 solved the problem. I don't think crashing is the expected behavior for a kernel when finding a corrupted partition. Please correct me in case that is a wrong assumption.

[3.]
[askadar@invisible-university ~]$ uname -a
Linux invisible-university 2.6.8.1 #1 SMP Sun Aug 22 16:44:06 PDT 2004 i686 AMD Athlon(tm) Processor AuthenticAMD GNU/Linux

The kernel is a stock kernel, distributed by ArchLinux (www.archlinux.org).

[4.]
[askadar@invisible-university ~]$ cat /proc/version
Linux version 2.6.8.1 (root@earth) (gcc version 3.4.1) #1 SMP Sun Aug 22 16:44:06 PDT 2004

[5.]
Oct 15 00:51:49 invisible-university ReiserFS: warning: is_tree_node: node
level 3 does not match to the expected one 1
Oct 15 00:51:49 invisible-university ReiserFS: hde5: warning: vs-5150:
search_by_key: invalid format found in block 1179648. Fsck?
Oct 15 00:51:49 invisible-university ReiserFS: hde5: warning: vs-13050:
reiserfs_update_sd: i/o failure occurred trying to update [1154 1504 0x0
SD] stat data
Oct 15 00:51:49 invisible-university ReiserFS: warning: is_tree_node: node
level 3 does not match to the expected one 1
Oct 15 00:51:49 invisible-university ReiserFS: hde5: warning: vs-5150:
search_by_key: invalid format found in block 1179648. Fsck?
Oct 15 00:51:49 invisible-university Unable to handle kernel NULL pointer
dereference at virtual address 00000018
Oct 15 00:51:49 invisible-university printing eip:
Oct 15 00:51:49 invisible-university c01cd1b5
Oct 15 00:51:49 invisible-university *pde = 00000000
Oct 15 00:51:49 invisible-university Oops: 0000 [#1]
Oct 15 00:51:49 invisible-university PREEMPT SMP
Oct 15 00:51:49 invisible-university Modules linked in: ohci_hcd 3c59x
eth1394 orinoco_pci orinoco hermes ohci1394 ieee1394 emu10k1_gp gameport
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd soundcore parport_pc parport
pci_hotplug joydev tsdev evdev rtc
Oct 15 00:51:49 invisible-university CPU:    0
Oct 15 00:51:49 invisible-university EIP:    0060:[<c01cd1b5>]    Tainted:
G S
Oct 15 00:51:49 invisible-university EFLAGS: 00010296   (2.6.8.1)
Oct 15 00:51:49 invisible-university EIP is at
prepare_for_delete_or_cut+0x25/0x830
Oct 15 00:51:49 invisible-university eax: 00000000   ebx: d642fe40   ecx:
d642fe40   edx: 00000000
Oct 15 00:51:49 invisible-university esi: 00000001   edi: 00000000   ebp:
00000000   esp: d642fb78
Oct 15 00:51:49 invisible-university ds: 007b   es: 007b   ss: 0068
Oct 15 00:51:49 invisible-university Process cp (pid: 2281,
threadinfo=d642e000 task=d8e28e30)
Oct 15 00:51:49 invisible-university Stack: 00000001 cdf86000 000009e0
0000ffff cdf85e20 000009e0 00001000 00000482
Oct 15 00:51:49 invisible-university 000005e0 00001000 20000000 00000001
00000004 df0a9cec dffbca00 00000482
Oct 15 00:51:49 invisible-university 000005e0 00000001 20000000 09e0ffff
00010404 cdf85e70 d642fec0 d642fe40
Oct 15 00:51:49 invisible-university Call Trace:
Oct 15 00:51:49 invisible-university [<c01cea04>]
reiserfs_cut_from_item+0xc4/0x5f0
Oct 15 00:51:49 invisible-university [<c01cf30a>]
reiserfs_do_truncate+0x34a/0x5f0
Oct 15 00:51:49 invisible-university [<c01d5305>]
do_journal_begin_r+0x25/0x270
Oct 15 00:51:49 invisible-university [<c01b78b7>]
reiserfs_truncate_file+0x107/0x2b0
Oct 15 00:51:49 invisible-university [<c01b9a73>]
reiserfs_file_release+0x533/0x540
Oct 15 00:51:49 invisible-university [<c01675ea>] __fput+0x12a/0x170
Oct 15 00:51:49 invisible-university [<c01659a2>] filp_close+0x52/0xa0
Oct 15 00:51:49 invisible-university [<c0165a6b>] sys_close+0x7b/0xf0
Oct 15 00:51:49 invisible-university [<c0106229>]
sysenter_past_esp+0x52/0x71
Oct 15 00:51:49 invisible-university Code: 8b 52 18 8d 04 40 8d 74 c2 18
66 83 7e 16 00 75 44 8b 4e 0c

[7.2.] Processor information (from /proc/cpuinfo):
[askadar@invisible-university ~]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1110.445
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2187.26



[7.3.] Module information (from /proc/modules):
[askadar@invisible-university ~]$ cat /proc/modules
ohci_hcd 23172 0 - Live 0xe0d9e000
3c59x 39848 0 - Live 0xe0d93000
eth1394 22280 0 - Live 0xe0d6b000
orinoco_pci 7808 0 - Live 0xe0b9b000
orinoco 47500 1 orinoco_pci, Live 0xe0d3c000
hermes 9472 2 orinoco_pci,orinoco, Live 0xe0d07000
ohci1394 36484 0 - Live 0xe0c3a000
ieee1394 113080 2 eth1394,ohci1394, Live 0xe0d10000
emu10k1_gp 4096 0 - Live 0xe0bc1000
gameport 5248 1 emu10k1_gp, Live 0xe0bbe000
snd_emu10k1 102920 1 - Live 0xe0c5f000
snd_rawmidi 26660 1 snd_emu10k1, Live 0xe0c03000
snd_pcm 104708 1 snd_emu10k1, Live 0xe0c44000
snd_timer 28164 1 snd_pcm, Live 0xe0bfb000
snd_seq_device 8584 2 snd_emu10k1,snd_rawmidi, Live 0xe0bdc000
snd_ac97_codec 71684 1 snd_emu10k1, Live 0xe0c12000
snd_page_alloc 12168 2 snd_emu10k1,snd_pcm, Live 0xe0bd8000
snd_util_mem 5120 1 snd_emu10k1, Live 0xe0b9e000
snd_hwdep 9988 1 snd_emu10k1, Live 0xe0bba000
snd 60260 10 snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, Live 0xe0beb000
soundcore 11104 1 snd, Live 0xe0bb6000
parport_pc 26688 0 - Live 0xe0bd0000
parport 43208 1 parport_pc, Live 0xe0bc4000
pci_hotplug 13188 0 - Live 0xe0bb1000
joydev 10560 0 - Live 0xe0bad000
tsdev 7808 0 - Live 0xe0baa000
evdev 10112 0 - Live 0xe0ba6000
rtc 14408 0 - Live 0xe0ba1000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[askadar@invisible-university ~]$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0278-027a : parport0
02f8-02ff : serial
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
7800-783f : 0000:00:11.0
  7800-7807 : ide2
  7808-780f : ide3
  7810-783f : PDC20265
8000-8003 : 0000:00:11.0
8400-8407 : 0000:00:11.0
8800-8803 : 0000:00:11.0
  8802-8802 : ide2
9000-9007 : 0000:00:11.0
  9000-9007 : ide2
9400-947f : 0000:00:0d.0
  9400-947f : 0000:00:0d.0
9800-987f : 0000:00:0a.0
a000-a007 : 0000:00:09.1
  a000-a007 : emu10k1-gp
a400-a41f : 0000:00:09.0
  a400-a41f : EMU10K1
d000-d01f : 0000:00:04.3
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
  d808-d80f : ide1
e400-e4ff : 0000:00:04.4
e800-e80f : 0000:00:04.4

[askadar@invisible-university ~]$ cat /proc/iomem
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cabff : Video ROM
000d0000-000d1fff : Adapter ROM
000d4000-000d47ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-0050bbdd : Kernel code
  0050bbde-0063b47f : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
d3800000-d381ffff : 0000:00:11.0
d4000000-d400007f : 0000:00:0d.0
d4800000-d48007ff : 0000:00:0a.0
  d4800000-d48007ff : ohci1394
d5000000-d6efffff : PCI Bus #01
  d5000000-d5ffffff : 0000:01:00.0
d7000000-d7000fff : 0000:00:0b.0
d7f00000-e3ffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
    d8000000-d817ffff : vesafb
e4000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

[root@invisible-university askadar]# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
        Subsystem: Asustek Computer, Inc. A7V Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: d5000000-d6efffff
        Prefetchable memory behind bridge: d7f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
        Subsystem: Asustek Computer, Inc. A7V Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs SBLive! Player 5.1
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at a400 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at a000 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at d4800000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at 9800 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
        Subsystem: Netgear: Unknown device 4105
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d7000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 9400 [size=128]
        Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9000 [size=8]
        Region 1: I/O ports at 8800 [size=4]
        Region 2: I/O ports at 8400 [size=8]
        Region 3: I/O ports at 8000 [size=4]
        Region 4: I/O ports at 7800 [size=64]
        Region 5: Memory at d3800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS] (rev a3) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. V7700 AGP Video Card
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at d7ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)
Don't have scsi.
