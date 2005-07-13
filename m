Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVGMImN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVGMImN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 04:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVGMImN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 04:42:13 -0400
Received: from mx.wurtel.net ([195.64.88.114]:50443 "EHLO mx.wurtel.net")
	by vger.kernel.org with ESMTP id S262601AbVGMImJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 04:42:09 -0400
Date: Wed, 13 Jul 2005 10:41:53 +0200
From: Paul Slootman <paul+nospam@wurtel.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops when running mkreiserfs on large (9TB) raid0 set on AMD64 SMP
Message-ID: <20050713084152.GA5765@wurtel.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Scanner: exiscan *1DscoT-0005jo-00*gP/MRSCF1Ew*Wurtel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After having installed a base system (Debian) on our shiny new AMD64 SMP
system, with 2 x 3ware 9000 SATA controllers for a total of 24 disks
(excluding the 2 connected to the motherboard), I wanted as a "quick"
test to put them all in a raid0 and put a reiserfs on it (just to see
the 'df' output :-). It all went OK up to the mkreiserfs, when an Oops
happened, mkreiserfs stopped doing anything useful (besides eating
system time in state 'D', untraceable). The system slowed literally to
a crawl, typing in stuff over the network lagged by 1-6 seconds.

Root, swap is on LVM2 over raid1 over 2 SATA disks connected to the
Tyan motherboard (SiI 3114 controller). That works fine. lvm, raid1,
sata_sil are built into the kernel; 3w_9000 and raid0 are modules.

Note that the system time was a couple of weeks in the future...


Paul Slootman



# cat /proc/version
Linux version 2.6.12 (root@zaadzilla) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Fri Aug 5 20:36:51 CEST 2005


Output from kern.log:

Aug  9 20:08:37 localhost kernel: raid0: done.
Aug  9 20:08:37 localhost kernel: raid0 : md_size is 9374734848 blocks.
Aug  9 20:08:37 localhost kernel: raid0 : conf->hash_spacing is 9374734848 blocks.
Aug  9 20:08:37 localhost kernel: raid0 : nb_zone is 12.
Aug  9 20:08:37 localhost kernel: raid0 : Allocating 96 bytes for hash.
Aug  9 20:09:18 localhost kernel: Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
Aug  9 20:09:18 localhost kernel: <ffffffff8808eb98>{:raid0:raid0_make_request+472}
Aug  9 20:09:18 localhost kernel: PGD f3d16067 PUD f387e067 PMD 0
Aug  9 20:09:18 localhost kernel: Oops: 0000 [1] SMP
Aug  9 20:09:18 localhost kernel: CPU 1
Aug  9 20:09:18 localhost kernel: Modules linked in: raid0 ipv6 evdev tg3 3w_9xxx hw_random i2c_amd756 i2c_amd8111 i2c_core psmouse rtc
Aug  9 20:09:18 localhost kernel: Pid: 8901, comm: mkreiserfs Not tainted 2.6.12
Aug  9 20:09:18 localhost kernel: RIP: 0010:[__nosave_end+129608600/2131804160] <ffffffff8808eb98>{:raid0:raid0_make_request+472}
Aug  9 20:09:18 localhost kernel: RSP: 0018:ffff81007ec898e8  EFLAGS: 00010206
Aug  9 20:09:18 localhost kernel: RAX: 0000000000000078 RBX: ffff8100821c0500 RCX: ffff0201f361ee78
Aug  9 20:09:18 localhost kernel: RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8100f3f0b4a8
Aug  9 20:09:18 localhost kernel: RBP: 0000000000000040 R08: 0000000008bb1c67 R09: ffff8100f9b0f700
Aug  9 20:09:18 localhost kernel: R10: 000000000000007f R11: 000000007fe93d40 R12: ffff81007fdc4940
Aug  9 20:09:18 localhost kernel: R13: ffff8100f9b15308 R14: 0000000000001000 R15: 0000000000000001
Aug  9 20:09:18 localhost kernel: FS:  00002aaaaaf04090(0000) GS:ffffffff804b6e00(0000) knlGS:0000000000000000
Aug  9 20:09:18 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Aug  9 20:09:18 localhost kernel: CR2: 0000000000000028 CR3: 00000000f3e80000 CR4: 00000000000006e0
Aug  9 20:09:18 localhost kernel: Process mkreiserfs (pid: 8901, threadinfo ffff81007ec88000, task ffff81007fcd1050)
Aug  9 20:09:18 localhost kernel: Stack: 0000000000000001 ffff8100821c0500 ffff8100f9b15308 ffff81007ec89948
Aug  9 20:09:18 localhost kernel:        ffff8100821c0500 ffffffff8025c101 0000000000000000 ffff81007fcd1050
Aug  9 20:09:18 localhost kernel:        ffffffff801483b0 ffff81007ec89960
Aug  9 20:09:18 localhost kernel: Call Trace:<ffffffff8025c101>{generic_make_request+481} <ffffffff801483b0>{autoremove_wake_function+0}
Aug  9 20:09:18 localhost kernel:        <ffffffff801483b0>{autoremove_wake_function+0} <ffffffff801483b0>{autoremove_wake_function+0}
Aug  9 20:09:18 localhost kernel:        <ffffffff8025c1ff>{submit_bio+223} <ffffffff8017ba00>{bio_alloc_bioset+288}
Aug  9 20:09:18 localhost kernel:        <ffffffff8017b271>{submit_bh+273} <ffffffff8017a1dd>{block_read_full_page+621}
Aug  9 20:09:18 localhost kernel:        <ffffffff80202b53>{radix_tree_node_alloc+19} <ffffffff8017e250>{blkdev_get_block+0}
Aug  9 20:09:18 localhost kernel:        <ffffffff80202d82>{radix_tree_insert+114} <ffffffff8015ad02>{read_pages+178}
Aug  9 20:09:18 localhost kernel:        <ffffffff80158433>{buffered_rmqueue+323} <ffffffff80158943>{__alloc_pages+963}
Aug  9 20:09:18 localhost kernel:        <ffffffff8015aebc>{__do_page_cache_readahead+284} <ffffffff8015b067>{blockable_page_cache_readahead+103}
Aug  9 20:09:18 localhost kernel:        <ffffffff8015b29b>{page_cache_readahead+267} <ffffffff80154637>{do_generic_mapping_read+343}
Aug  9 20:09:18 localhost kernel:        <ffffffff80154a40>{file_read_actor+0} <ffffffff80154d07>{__generic_file_aio_read+407}
Aug  9 20:09:18 localhost kernel:        <ffffffff80154e32>{generic_file_read+194} <ffffffff8012da73>{__wake_up+67}
Aug  9 20:09:18 localhost kernel:        <ffffffff80231555>{tty_ldisc_deref+117} <ffffffff801483b0>{autoremove_wake_function+0}
Aug  9 20:09:18 localhost kernel:        <ffffffff801483b0>{autoremove_wake_function+0} <ffffffff80329110>{thread_return+0}
Aug  9 20:09:18 localhost kernel:        <ffffffff801a612e>{dnotify_parent+46} <ffffffff801768bf>{vfs_read+191}
Aug  9 20:09:18 localhost kernel:        <ffffffff80176b93>{sys_read+83} <ffffffff8010d91a>{system_call+126}
Aug  9 20:09:18 localhost kernel:
Aug  9 20:09:18 localhost kernel:
Aug  9 20:09:18 localhost kernel: Code: 48 8b 42 28 48 89 43 10 b8 01 00 00 00 48 03 4a 40 48 89 0b
Aug  9 20:09:18 localhost kernel: RIP <ffffffff8808eb98>{:raid0:raid0_make_request+472} RSP <ffff81007ec898e8>
Aug  9 20:09:18 localhost kernel: CR2: 0000000000000028


Output of scripts/ver_linux:

Linux zaadzilla 2.6.12 #1 SMP Fri Aug 5 20:36:51 CEST 2005 x86_64 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
reiserfsprogs          3.6.19
reiser4progs           line
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Kbd                    81:
Sh-utils               5.2.1
Modules Loaded         raid0 ipv6 evdev tg3 3w_9xxx hw_random i2c_amd756 i2c_amd8111 i2c_core psmouse rtc


# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 10
cpu MHz         : 1794.281
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3522.56
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 244
stepping        : 10
cpu MHz         : 1794.281
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3579.90
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


# cat /proc/modules
raid0 8192 0 - Live 0xffffffff8808e000
ipv6 285376 16 - Live 0xffffffff88047000
evdev 10560 0 - Live 0xffffffff88043000
tg3 99972 0 - Live 0xffffffff88029000
3w_9xxx 38404 0 - Live 0xffffffff8801e000
hw_random 6240 0 - Live 0xffffffff8801b000
i2c_amd756 7492 0 - Live 0xffffffff88018000
i2c_amd8111 6976 0 - Live 0xffffffff88015000
i2c_core 24384 2 i2c_amd756,i2c_amd8111, Live 0xffffffff8800e000
psmouse 31044 0 - Live 0xffffffff88005000
rtc 15056 0 - Live 0xffffffff88000000

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
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10bf : motherboard
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1020-1023 : GPE0_BLK
  10b0-10b7 : GPE1_BLK
10c0-10df : motherboard
10e0-10ff : motherboard
  10e0-10ef : amd756-smbus
7000-7fff : PCI Bus #01
  7800-78ff : 0000:01:01.0
    7800-78ff : 3w-9xxx
8000-8fff : PCI Bus #02
  8800-88ff : 0000:02:02.0
    8800-88ff : 3w-9xxx
9000-bfff : PCI Bus #03
  a800-a83f : 0000:03:08.0
    a800-a83f : e100
  a880-a88f : 0000:03:05.0
    a880-a88f : sata_sil
  ac00-ac03 : 0000:03:05.0
    ac00-ac03 : sata_sil
  b000-b0ff : 0000:03:06.0
  b800-b807 : 0000:03:05.0
    b800-b807 : sata_sil
  b880-b883 : 0000:03:05.0
    b880-b883 : sata_sil
  bc00-bc07 : 0000:03:05.0
    bc00-bc07 : sata_sil
cc00-cc1f : 0000:00:07.2
  cc00-cc1f : amd8111 SMBus 2.0
de00-de7f : motherboard
de80-deff : motherboard
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

# cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Adapter ROM
000ce000-000ce7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-f9feffff : System RAM
  00100000-0032cf67 : Kernel code
  0032cf68-0045d06f : Kernel data
f9ff0000-f9ffefff : ACPI Tables
f9fff000-f9ffffff : ACPI Non-volatile Storage
fa400000-fb4fffff : PCI Bus #01
  fa800000-faffffff : 0000:01:01.0
    fa800000-faffffff : 3w-9xxx
fb500000-fc5fffff : PCI Bus #02
  fb800000-fbffffff : 0000:02:02.0
    fb800000-fbffffff : 3w-9xxx
fc700000-fc7fffff : PCI Bus #01
  fc7ffc00-fc7ffcff : 0000:01:01.0
    fc7ffc00-fc7ffcff : 3w-9xxx
fc800000-fc8fffff : PCI Bus #02
  fc890000-fc89ffff : 0000:02:09.0
    fc890000-fc89ffff : tg3
  fc8a0000-fc8affff : 0000:02:09.0
    fc8a0000-fc8affff : tg3
  fc8c0000-fc8cffff : 0000:02:09.1
    fc8c0000-fc8cffff : tg3
  fc8d0000-fc8dffff : 0000:02:09.1
    fc8d0000-fc8dffff : tg3
  fc8ffc00-fc8ffcff : 0000:02:02.0
    fc8ffc00-fc8ffcff : 3w-9xxx
fc900000-feafffff : PCI Bus #03
  fd000000-fdffffff : 0000:03:06.0
  feaa0000-feabffff : 0000:03:08.0
    feaa0000-feabffff : e100
  feafb000-feafbfff : 0000:03:08.0
    feafb000-feafbfff : e100
  feafc000-feafcfff : 0000:03:00.0
    feafc000-feafcfff : ohci_hcd
  feafd000-feafdfff : 0000:03:00.1
    feafd000-feafdfff : ohci_hcd
  feafec00-feafefff : 0000:03:05.0
    feafec00-feafefff : sata_sil
  feaff000-feafffff : 0000:03:06.0
febfe000-febfefff : 0000:00:0b.1
febff000-febfffff : 0000:00:0a.1
ff780000-ffffffff : reserved


# lspci -vvv
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 00009000-0000bfff
        Memory behind bridge: fc900000-feafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [c0] #08 [0086]
        Capabilities: [f0] #08 [8000]

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]

0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 10
        Region 0: I/O ports at cc00 [size=32]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: fc800000-fc8fffff
        Prefetchable memory behind bridge: 00000000fb500000-00000000fc500000
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [004a]

0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at febff000 (64-bit, non-prefetchable) [size=4K]

0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: fc700000-fc7fffff
        Prefetchable memory behind bridge: 00000000fa400000-00000000fb400000
        BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]

0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at febfe000 (64-bit, non-prefetchable) [size=4K]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:01:01.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
        Subsystem: 3ware Inc 3ware ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2250ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at 7800 [size=256]
        Region 1: Memory at fc7ffc00 (64-bit, non-prefetchable) [size=256]
        Region 3: Memory at fa800000 (64-bit, prefetchable) [size=8M]
        Expansion ROM at fc7e0000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:02.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
        Subsystem: 3ware Inc 3ware ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2250ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at fc8ffc00 (64-bit, non-prefetchable) [size=256]
        Region 3: Memory at fb800000 (64-bit, prefetchable) [size=8M]
        Expansion ROM at fc8e0000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
        Subsystem: Broadcom Corporation: Unknown device 1644
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at fc8a0000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at fc890000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fc880000 [disabled] [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 0563549d734f6a64  Data: a88d

0000:02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
        Subsystem: Broadcom Corporation: Unknown device 1644
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin B routed to IRQ 209
        Region 0: Memory at fc8d0000 (64-bit, non-prefetchable) [size=64K]
        Region 2: Memory at fc8c0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fc8b0000 [disabled] [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 2903234500c240a8  Data: 8d2d

0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 177
        Region 0: Memory at feafc000 (32-bit, non-prefetchable) [size=4K]

0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 177
        Region 0: Memory at feafd000 (32-bit, non-prefetchable) [size=4K]

0000:03:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at bc00 [size=8]
        Region 1: I/O ports at b880 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at ac00 [size=4]
        Region 4: I/O ports at a880 [size=16]
        Region 5: Memory at feafec00 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at fea00000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at b000 [size=256]
        Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at feafb000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a800 [size=64]
        Region 2: Memory at feaa0000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD800JD-75JN Rev: 05.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD800JD-75JN Rev: 05.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 00  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 01 Lun: 00
  Vendor: 3ware    Model: Logical Disk 01  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 02 Lun: 00
  Vendor: 3ware    Model: Logical Disk 02  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 03 Lun: 00
  Vendor: 3ware    Model: Logical Disk 03  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 04 Lun: 00
  Vendor: 3ware    Model: Logical Disk 04  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 05 Lun: 00
  Vendor: 3ware    Model: Logical Disk 05  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 06 Lun: 00
  Vendor: 3ware    Model: Logical Disk 06  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 07 Lun: 00
  Vendor: 3ware    Model: Logical Disk 07  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 08 Lun: 00
  Vendor: 3ware    Model: Logical Disk 08  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 09 Lun: 00
  Vendor: 3ware    Model: Logical Disk 09  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 10 Lun: 00
  Vendor: 3ware    Model: Logical Disk 10  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi4 Channel: 00 Id: 11 Lun: 00
  Vendor: 3ware    Model: Logical Disk 11  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: Logical Disk 00  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 01 Lun: 00
  Vendor: 3ware    Model: Logical Disk 01  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 02 Lun: 00
  Vendor: 3ware    Model: Logical Disk 02  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 03 Lun: 00
  Vendor: 3ware    Model: Logical Disk 03  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 04 Lun: 00
  Vendor: 3ware    Model: Logical Disk 04  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 05 Lun: 00
  Vendor: 3ware    Model: Logical Disk 05  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 06 Lun: 00
  Vendor: 3ware    Model: Logical Disk 06  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 07 Lun: 00
  Vendor: 3ware    Model: Logical Disk 07  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 08 Lun: 00
  Vendor: 3ware    Model: Logical Disk 08  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 09 Lun: 00
  Vendor: 3ware    Model: Logical Disk 09  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 10 Lun: 00
  Vendor: 3ware    Model: Logical Disk 10  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi5 Channel: 00 Id: 11 Lun: 00
  Vendor: 3ware    Model: Logical Disk 11  Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff


# grep -v '^#' .config
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_KALLSYMS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_BASE_SMALL=0

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_K8_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_NUMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=2
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_SECCOMP=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_CONTAINER=m

CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y

CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=y
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_UID16=y

CONFIG_FW_LOADER=m

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y

CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDECD=y

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=m

CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

CONFIG_SCSI_SPI_ATTRS=m

CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_SIL=y
CONFIG_SCSI_QLA2XXX=y

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=m
CONFIG_MD_RAID5=m
CONFIG_MD_RAID6=m
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m

CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_MULTIPATH_CACHED=y
CONFIG_IP_ROUTE_MULTIPATH_RR=m
CONFIG_IP_ROUTE_MULTIPATH_RANDOM=m
CONFIG_IP_ROUTE_MULTIPATH_WRANDOM=m
CONFIG_IP_ROUTE_MULTIPATH_DRR=m
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=y

CONFIG_IP_VS=m
CONFIG_IP_VS_TAB_BITS=12

CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_RAW=m

CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

CONFIG_IP_SCTP=m
CONFIG_SCTP_HMAC_MD5=y
CONFIG_BRIDGE=m
CONFIG_VLAN_8021Q=m

CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_TUN=m

CONFIG_NET_ETHERNET=y
CONFIG_MII=y

CONFIG_NET_PCI=y
CONFIG_E100=y

CONFIG_VIA_VELOCITY=m
CONFIG_TIGON3=m

CONFIG_SHAPER=m

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4

CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_WATCHDOG=m

CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y

CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

CONFIG_I2C_ALGOBIT=m

CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ISA=m

CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

CONFIG_SENSORS_EEPROM=m

CONFIG_VIDEO_DEV=m

CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y

CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y

CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y

CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y

CONFIG_EDD=m

CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y

CONFIG_XFS_FS=m
CONFIG_XFS_EXPORT=y
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y

CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m

CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m

CONFIG_MSDOS_PARTITION=y

CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17

CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m

CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
