Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVHCLoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVHCLoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVHCLoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:44:38 -0400
Received: from steakhouse.mbo.de ([213.20.229.118]:131 "EHLO steakhouse.mbo.de")
	by vger.kernel.org with ESMTP id S262232AbVHCLnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:43:14 -0400
Message-ID: <42F0ADEE.7020405@mbo.de>
Date: Wed, 03 Aug 2005 13:43:42 +0200
From: Daniel Walter <walter@mbo.de>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ReiserFS crashing
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
X-Spamtest-Info: Pass through
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acessing the (software-)raid1 results in crash of shell
raid worked ok for some days before
error message appeared upon first hangup:


Linux version 2.6.11.10BERNHADINERMBO.DE (root@shepard) (gcc version 
3.3.4) #3 Fri Jul 15 11:53:00 CEST 2005


ReiserFS: warning: is_leaf: item location seems wrong (second one): 
*3.6* [2 2690 0x0 SD], item_len 492, item_location 3836, 
free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
ReiserFS: warning: is_leaf: item location seems wrong (second one): 
*3.6* [2 2691 0x0 SD], item_len 3628, item_location 3836, 
free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
ReiserFS: warning: is_leaf: item length seems wrong: *3.6* [2 2694 0x0 
SD], item_len 28716, item_location 3836, free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
ReiserFS: warning: is_leaf: item length seems wrong: *3.6* [2 2701 0x0 
SD], item_len 32812, item_location 3839, free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
ReiserFS: warning: is_leaf: item location seems wrong (second one): 
*3.6* [2 2702 0x0 SD], item_len 44, item_location 3516, 
free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
ReiserFS: warning: is_leaf: item location seems wrong: *3.6* [2709 2714 
0x0 SD], item_len 44, item_location 32144, free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
ReiserFS: warning: is_leaf: item location seems wrong (second one): 
*3.6* [27092714 0x0 SD], item_len 47, item_location 3472, 
free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
ReiserFS: warning: is_leaf: item location seems wrong (second one): 
*3.5*[2709 2713 0x0 SD], item_len 44, item_location 3532, 
free_space(entry_count) 65535
ReiserFS: md0: warning: vs-5150: search_by_key: invalid format found in 
block 720896. Fsck?
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:494!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c01ac802>]    Not tainted VLI
EFLAGS: 00010286   (2.6.11.10BERNHADINERMBO.DE)
EIP is at reiserfs_in_journal+0x132/0x1a0
eax: e0935148   ebx: 000e0000   ecx: 00000cc8   edx: e0914000
esi: df065c00   edi: e0914104   ebp: 00000000   esp: de11fbc4
ds: 007b   es: 007b   ss: 0068
Process cp (pid: 6771, threadinfo=de11f000 task=cdeb7ac0)
Stack: df065c00 de11fc50 00000000 e0914000 00000000 e09120e0 df065c00 
de11fc50
       c01894cd df065c00 0000001c 00000000 00000001 de11fc04 00000000 
00000000
       00000000 0000001c df065c00 de11fc50 00000000 c01897b2 de11feb4 
0000001c
Call Trace:
 [<c01894cd>] scan_bitmap_block+0x28d/0x320
 [<c01897b2>] scan_bitmap+0x162/0x280
 [<c018aa4a>] reiserfs_allocate_blocknrs+0x18a/0x4f0
 [<c019747e>] reiserfs_allocate_blocks_for_region+0x23e/0x15f0
 [<c03742e6>] schedule+0x2e6/0x510
 [<c037455a>] preempt_schedule+0x4a/0x70
 [<c037455a>] preempt_schedule+0x4a/0x70
 [<c010171c>] __up+0x1c/0x20
 [<c0373ffb>] __up_wakeup+0x7/0xc
 [<c0375551>] .text.lock.kernel_lock+0x35/0x37
 [<c019933b>] reiserfs_prepare_file_region_for_write+0x34b/0x920
 [<c0199fa2>] reiserfs_file_write+0x692/0x6c0
 [<c0131520>] file_read_actor+0x0/0xe0
 [<c014f757>] vfs_write+0xd7/0x150
 [<c014f8a1>] sys_write+0x51/0x80
 [<c010272f>] syscall_call+0x7/0xb
Code: 31 c2 31 d1 8b 54 24 0c 81 e1 ff 1f 00 00 8b 84 8a 0c 01 00 00 85 
c0 74 0c


/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux shepard 2.6.11.10BERNHADINERMBO.DE #3 Fri Jul 15 11:53:00 CEST 
2005 i686 unknown unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          3.6.18
reiser4progs           line
quota-tools            3.12.
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.6
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   050
Modules Loaded


# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1060.878
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
cmov pat pse36 mmx fxsr pni syscall mmxext 3dnowext 3dnow
bogomips        : 2097.15


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
03c0-03df : vga+
0cf8-0cff : PCI conf1
8800-88ff : 0000:00:0c.0
  8800-88ff : sym53c8xx
9000-903f : 0000:00:09.0
  9000-903f : eepro100
9400-94ff : 0000:00:05.0
b000-b01f : 0000:00:04.3
b800-b80f : 0000:00:04.1
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:05.0
e000-e003 : 0000:00:00.0
e300-e37f : 0000:00:04.4
e400-e47f : motherboard
  e400-e403 : PM1a_EVT_BLK
  e404-e405 : PM1a_CNT_BLK
  e408-e40b : PM_TMR
  e410-e415 : ACPI CPU throttle
  e420-e423 : GPE0_BLK
e800-e80f : 0000:00:04.4
  e800-e80f : motherboard
    e800-e80f : pnp 00:02


# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cd7ff : Adapter ROM
000d0000-000d35ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-00376836 : Kernel code
  00376837-0045d37f : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
f1000000-f1000fff : 0000:00:0c.0
  f1000000-f1000fff : sym53c8xx
f1800000-f18000ff : 0000:00:0c.0
  f1800000-f18000ff : sym53c8xx
f2000000-f201ffff : 0000:00:09.0
f2800000-f2800fff : 0000:00:09.0
  f2800000-f2800fff : eepro100
f3000000-f3dfffff : PCI Bus #01
  f3000000-f3003fff : 0000:01:05.0
f3f00000-fb7fffff : PCI Bus #01
  f4000000-f7ffffff : 0000:01:05.0
fb800000-fb800fff : 0000:00:00.0
fc000000-fdffffff : 0000:00:00.0
ffff0000-ffffffff : reserved


# lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
System Controller (rev 13)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fb800000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at e000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP 
Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f3000000-f3dfffff
        Prefetchable memory behind bridge: f3f00000-fb7fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
        Subsystem: Asustek Computer, Inc. A7M266 Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 4: I/O ports at b800 [disabled] [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 
controller] (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 20, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 
[Apollo Super ACPI] (rev 40)
        Subsystem: Asustek Computer, Inc. A7M266 Mainboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 20 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 10)
        Subsystem: Intel Corp.: Unknown device 0070
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 20 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at f2800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 9000 [size=64]
        Region 2: Memory at f2000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
        Subsystem: Unknown device dc93:2980
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 134 (7500ns min, 16000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at f1800000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at f1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO 
AGP 4x TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at f3000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at f3fe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DORS-32160       Rev: S82C
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02



# cat /etc/raidtab
raiddev /dev/md0
    raid-level                1
    nr-raid-disks             2
    persistent-superblock     1
    chunk-size                4

    device                    /dev/sdb1
    raid-disk                 0
    device                    /dev/sdc1
    raid-disk                 1




