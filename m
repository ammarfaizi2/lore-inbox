Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTJ1She (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTJ1She
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:37:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21686 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264093AbTJ1ShA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:37:00 -0500
Message-ID: <3F9EB749.6070105@namesys.com>
Date: Tue, 28 Oct 2003 21:36:57 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml-031028@amos.mailshell.com, vs@thebsh.namesys.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
References: <20031028154920.1905.qmail@mailshell.com>
In-Reply-To: <20031028154920.1905.qmail@mailshell.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir, please look into this tomorrow.

Hans

lkml-031028@amos.mailshell.com wrote:

> [1.] One line summary of the problem:
>
> First time boot of 2.6.0test9 on a resierfs disk gives the error above.
> (buffer layer error at fs/buffer.c:431)
>
> [2.] Full description of the problem/report:
>
> Compile kernel 2.6.0 test 9 from the Debian "unstable" package using
> make-kpkg.
> I have a single-filesystem 76Gb ResierFs filesystem. (reports as
> "ReiserFS 3.6").
> I usually run a customized 2.4.22 with debian patches and the preemptive
> kernel patch.
> First time I boot the 2.6.0 kernel I got the message quoted above,
> The message repated twice in a row. Both instance seem itentical to
> me. The message with the stack trace is copied as-is from the
> output of dmesg below:
>
> buffer layer error at fs/buffer.c:431
> Call Trace:
>  [<c014f2b5>] __find_get_block_slow+0x85/0x120
>  [<c0150283>] __find_get_block+0x83/0xe0
>  [<c015030b>] __getblk+0x2b/0x60
>  [<c01503bf>] __bread+0x1f/0x40
>  [<c01a2132>] read_super_block+0x82/0x210
>  [<c01a2d95>] reiserfs_fill_super+0x555/0x5a0
>  [<c01d69b7>] snprintf+0x27/0x30
>  [<c017bce2>] disk_name+0x62/0xb0
>  [<c0154bc5>] sb_set_blocksize+0x25/0x60
>  [<c0154594>] get_sb_bdev+0x124/0x160
>  [<c01a2e4f>] get_super_block+0x2f/0x60
>  [<c01a2840>] reiserfs_fill_super+0x0/0x5a0
>  [<c01547ff>] do_kern_mount+0x5f/0xe0
>  [<c01695c8>] do_add_mount+0x78/0x150
>  [<c01698b4>] do_mount+0x124/0x170
>  [<c0169720>] copy_mount_options+0x80/0xf0
>  [<c0169c6f>] sys_mount+0xbf/0x140
>  [<c0462b9f>] do_mount_root+0x2f/0xa0
>  [<c0462c64>] mount_block_root+0x54/0x120
>  [<c0462d8e>] mount_root+0x5e/0x70
>  [<c0462dbd>] prepare_namespace+0x1d/0xe0
>  [<c01050d2>] init+0x32/0x160
>  [<c01050a0>] init+0x0/0x160
>  [<c01070c9>] kernel_thread_helper+0x5/0xc
>
> block=16, b_blocknr=64
> b_state=0x00000019, b_size=1024
> buffer layer error at fs/buffer.c:431
> Call Trace:
>  [<c014f2b5>] __find_get_block_slow+0x85/0x120
>  [<c01070c9>] kernel_thread_helper+0x5/0xc
>  [<c010970c>] dump_stack+0x1c/0x20
>  [<c0150283>] __find_get_block+0x83/0xe0
>  [<c014fec3>] __getblk_slow+0x23/0xf0
>  [<c015032f>] __getblk+0x4f/0x60
>  [<c01503bf>] __bread+0x1f/0x40
>  [<c01a2132>] read_super_block+0x82/0x210
>  [<c01a2d95>] reiserfs_fill_super+0x555/0x5a0
>  [<c01d69b7>] snprintf+0x27/0x30
>  [<c017bce2>] disk_name+0x62/0xb0
>  [<c0154bc5>] sb_set_blocksize+0x25/0x60
>  [<c0154594>] get_sb_bdev+0x124/0x160
>  [<c01a2e4f>] get_super_block+0x2f/0x60
>  [<c01a2840>] reiserfs_fill_super+0x0/0x5a0
>  [<c01547ff>] do_kern_mount+0x5f/0xe0
>  [<c01695c8>] do_add_mount+0x78/0x150
>  [<c01698b4>] do_mount+0x124/0x170
>  [<c0169720>] copy_mount_options+0x80/0xf0
>  [<c0169c6f>] sys_mount+0xbf/0x140
>  [<c0462b9f>] do_mount_root+0x2f/0xa0
>  [<c0462c64>] mount_block_root+0x54/0x120
>  [<c0462d8e>] mount_root+0x5e/0x70
>  [<c0462dbd>] prepare_namespace+0x1d/0xe0
>  [<c01050d2>] init+0x32/0x160
>  [<c01050a0>] init+0x0/0x160
>  [<c01070c9>] kernel_thread_helper+0x5/0xc
>
> block=16, b_blocknr=64
> b_state=0x00000019, b_size=1024
>
> [3.] Keywords (i.e., modules, networking, kernel):
>
> ReiserFS, 2.6.0test9
>
> [4.] Kernel version (from /proc/version):
>
> Linux version 2.6.0-test9-adelaide (root@picton) (gcc version 3.3.2 
> (Debian)) #1 Tue Oct 28 14:56:46 IST 2003
>
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
>
> No "Oops" was generated.
>
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
>
> N/A. It happens at boot time.
>
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
>
> Output of "sh scripts/ver_linux":
>
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux picton 2.6.0-test9-adelaide #1 Tue Oct 28 14:56:46 IST 2003 i686 
> GNU/Linux
>
> Gnu C                  3.3.2
> Gnu make               3.80
> binutils               2.14.90.0.6
> util-linux             2.12
> mount                  2.12
> module-init-tools      0.9.15-pre2
> e2fsprogs              1.35-WIP
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Procps                 3.1.14
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               5.0.91
> Modules Loaded         radeon snd_seq_oss snd_seq_midi_event snd_seq 
> snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm 
> snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device 
> snd ipv6
>
> [7.2.] Processor information (from /proc/cpuinfo):
>
> output of "cat /proc/cpuinfo":
>
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 10
> model name      : AMD Athlon(tm) XP 2500+
> stepping        : 0
> cpu MHz         : 1830.378
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 3620.86
>
>
> [7.3.] Module information (from /proc/modules):
>
> output of "cat /proc/modules":
>
> radeon 113644 - - Live 0xe0aad000
> snd_seq_oss 36512 - - Live 0xe0a80000
> snd_seq_midi_event 7616 - - Live 0xe09d8000
> snd_seq 60880 - - Live 0xe0a70000
> snd_pcm_oss 61604 - - Live 0xe0a20000
> snd_mixer_oss 20608 - - Live 0xe09a4000
> snd_intel8x0 25700 - - Live 0xe09c2000
> snd_ac97_codec 54852 - - Live 0xe0a32000
> snd_pcm 108708 - - Live 0xe0a41000
> snd_timer 26564 - - Live 0xe09cc000
> snd_page_alloc 12036 - - Live 0xe0999000
> snd_mpu401_uart 7872 - - Live 0xe09a1000
> snd_rawmidi 26112 - - Live 0xe09ba000
> snd_seq_device 8200 - - Live 0xe099d000
> snd 54020 - - Live 0xe09ab000
> ipv6 250592 - - Live 0xe09e1000
>
> [7.4.] Loaded driver and hardware information (/proc/ioports, 
> /proc/iomem)
>
> output of "cat /proc/ioports":
>
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 1c00-1c07 : nForce2 SMBus
> 2000-2007 : nForce2 SMBus
> 9000-9fff : PCI Bus #01
>   9000-907f : 0000:01:07.0
>     9000-907f : 0000:01:07.0
>   9400-947f : 0000:01:08.0
>     9400-947f : 0000:01:08.0
> a000-afff : PCI Bus #02
>   a000-a0ff : 0000:02:00.0
> b000-b0ff : 0000:00:06.0
> b400-b47f : 0000:00:06.0
>   b400-b43f : NVidia nForce2 - Controller
> c000-c01f : 0000:00:01.1
> c400-c407 : 0000:00:04.0
> f000-f00f : 0000:00:09.0
>   f000-f007 : ide0
>   f008-f00f : ide1
>
> output of "cat /proc/iomem":
>
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-1ffeffff : System RAM
>   00100000-00357e42 : Kernel code
>   00357e43-0045f13f : Kernel data
> 1fff0000-1fff2fff : ACPI Non-volatile Storage
> 1fff3000-1fffffff : ACPI Tables
> d0000000-d3ffffff : 0000:00:00.0
> d4000000-dbffffff : PCI Bus #02
>   d4000000-d7ffffff : 0000:02:00.0
>   d8000000-dbffffff : 0000:02:00.1
> dc000000-ddffffff : PCI Bus #02
>   dd000000-dd00ffff : 0000:02:00.0
>   dd010000-dd01ffff : 0000:02:00.1
> de000000-dfffffff : PCI Bus #01
>   df000000-df00007f : 0000:01:07.0
>   df001000-df00107f : 0000:01:08.0
> e0000000-e0000fff : 0000:00:04.0
> e0001000-e0001fff : 0000:00:06.0
>   e0001000-e00011ff : NVidia nForce2 - AC'97
> e0003000-e0003fff : 0000:00:02.0
> e0004000-e0004fff : 0000:00:02.1
> e0005000-e00050ff : 0000:00:02.2
>   e0005000-e00050ff : ehci_hcd
> fec00000-fec00fff : reserved
> fee00000-fee00fff : reserved
> ffff0000-ffffffff : reserved
>
> [7.5.] PCI information ('lspci -vvv' as root)
>
> output of "lspci -vvv" as root:
>
> 00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
> version?) (rev c1)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: <available only to root>
>
> 00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 
> (rev c1)
>         Subsystem: nVidia Corporation: Unknown device 0c17
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>
> 00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
> (rev c1)
>         Subsystem: nVidia Corporation: Unknown device 0c17
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>
> 00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
> (rev c1)
>         Subsystem: nVidia Corporation: Unknown device 0c17
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>
> 00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
> (rev c1)
>         Subsystem: nVidia Corporation: Unknown device 0c17
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>
> 00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
> (rev c1)
>         Subsystem: nVidia Corporation: Unknown device 0c17
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>
> 00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
>         Subsystem: Giga-byte Technology: Unknown device 0c11
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: <available only to root>
>
> 00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
>         Subsystem: Giga-byte Technology: Unknown device 0c11
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at c000 [size=32]
>         Capabilities: <available only to root>
>
> 00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
> a4) (prog-if 10 [OHCI])
>         Subsystem: Giga-byte Technology: Unknown device 5004
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 (750ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at e0003000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: <available only to root>
>
> 00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
> a4) (prog-if 10 [OHCI])
>         Subsystem: Giga-byte Technology: Unknown device 5004
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 (750ns min, 250ns max)
>         Interrupt: pin B routed to IRQ 9
>         Region 0: Memory at e0004000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: <available only to root>
>
> 00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
> a4) (prog-if 20 [EHCI])
>         Subsystem: Giga-byte Technology: Unknown device 5004
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 (750ns min, 250ns max)
>         Interrupt: pin C routed to IRQ 5
>         Region 0: Memory at e0005000 (32-bit, non-prefetchable) 
> [size=256]
>         Capabilities: <available only to root>
>
> 00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
> Controller (rev a1)
>         Subsystem: Giga-byte Technology: Unknown device e000
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 (250ns min, 5000ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
>         Region 1: I/O ports at c400 [size=8]
>         Capabilities: <available only to root>
>
> 00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
> Audio Controler (MCP) (rev a1)
>         Subsystem: nVidia Corporation: Unknown device 4144
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 (500ns min, 1250ns max)
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at b000 [size=256]
>         Region 1: I/O ports at b400 [size=128]
>         Region 2: Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: <available only to root>
>
> 00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
> (rev a3) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>         I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: de000000-dfffffff
>         Prefetchable memory behind bridge: fff00000-000fffff
>         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>
> 00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) 
> (prog-if 8a [Master SecP PriP])
>         Subsystem: Giga-byte Technology: Unknown device 5002
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0 (750ns min, 250ns max)
>         Region 4: I/O ports at f000 [size=16]
>         Capabilities: <available only to root>
>
> 00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 
> 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
>         I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: dc000000-ddffffff
>         Prefetchable memory behind bridge: d4000000-dbffffff
>         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
>
> 01:07.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX 
> [Cyclone] (rev 28)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 
> (32 bytes)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: I/O ports at 9000 [size=128]
>         Region 1: Memory at df000000 (32-bit, non-prefetchable) 
> [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: <available only to root>
>
> 01:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX 
> [Cyclone] (rev 30)
>         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 
> (32 bytes)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at 9400 [size=128]
>         Region 1: Memory at df001000 (32-bit, non-prefetchable) 
> [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: <available only to root>
>
> 02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If 
> [Radeon 9000] (rev 01) (prog-if 00 [VGA])
>         Subsystem: Giga-byte Technology: Unknown device 4010
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
>         Interrupt: pin A routed to IRQ 9
>         Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
>         Region 1: I/O ports at a000 [size=256]
>         Region 2: Memory at dd000000 (32-bit, non-prefetchable) 
> [size=64K]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: <available only to root>
>
> 02:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 
> 9000] (Secondary) (rev 01)
>         Subsystem: Giga-byte Technology: Unknown device 4011
>         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
>         Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled] 
> [size=64M]
>         Region 1: Memory at dd010000 (32-bit, non-prefetchable) 
> [disabled] [size=64K]
>         Capabilities: <available only to root>
>
>
>
> [7.6.] SCSI information (from /proc/scsi/scsi)
>
> Not relevant. It's a "pure IDE" system.
>
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
>
> Content of the files under /proc/fs/reiserfs/hda2:
>
> ===============>  bitmap  <=================
> free_block: 2334
>   scan_bitmap:          wait          bmap         retry        stolen 
>  journal_hintjournal_nohint
>            1167              0           1189            569    
> 0            569              0
> ===============>  journal  <=================
> jp_journal_1st_block:   18
> jp_journal_dev:         hda2[0]
> jp_journal_size:        8192
> jp_journal_trans_max:   1024
> jp_journal_magic:       595152260
> jp_journal_max_batch:   900
> jp_journal_max_commit_age:      30
> jp_journal_max_trans_age:       0
> j_1st_reserved_block:   18
> j_state:        0
> j_trans_id:     1129213
> j_mount_id:     73
> j_start:        7409
> j_len:  5
> j_len_alloc:    5
> j_wcount:       0
> j_bcount:       12
> j_first_unflushed_offset:       7197
> j_last_flush_trans_id:  1129202
> j_trans_start_time:     1067351133
> j_journal_list_index:   38
> j_list_bitmap_index:    0
> j_must_wait:    0
> j_next_full_flush:      0
> j_next_async_flush:     0
> j_cnode_used:   197
> j_cnode_free:   16187
>
> in_journal:             3015
> in_journal_bitmap:             13993
> in_journal_reusable:            2446
> lock_journal:         189919
> lock_journal_wait:               208
> journal_begin:         94959
> journal_relock_writers:                    0
> journal_relock_wcount:             1
> mark_dirty:           143126
> mark_dirty_already:           132341
> mark_dirty_notjournal:          2352
> restore_prepared:             386223
> prepare:              163335
> prepare_retry:         32078
> ===============>  oidmap  <=================
> used: [ 1 .. 543d5 )
> free: [ 543d5 .. 543d9 )
> used: [ 543d9 .. 543da )
> free: [ 543da .. 54484 )
> used: [ 54484 .. 54485 )
> free: [ 54485 .. 544ee )
> used: [ 544ee .. 544ef )
> free: [ 544ef .. 54587 )
> used: [ 54587 .. 54588 )
> free: [ 54588 .. 54692 )
> used: [ 54692 .. 54693 )
> free: [ 54693 .. 54696 )
> used: [ 54696 .. 54697 )
> free: [ 54697 .. 546b2 )
> used: [ 546b2 .. 546b3 )
> free: [ 546b3 .. 546b4 )
> used: [ 546b4 .. 546b5 )
> free: [ 546b5 .. 54857 )
> used: [ 54857 .. 54858 )
> free: [ 54858 .. 5485f )
> used: [ 5485f .. 54860 )
> free: [ 54860 .. 54919 )
> used: [ 54919 .. 5491a )
> free: [ 5491a .. 5492e )
> used: [ 5492e .. 5492f )
> free: [ 5492f .. 549b1 )
> used: [ 549b1 .. 549b2 )
> free: [ 549b2 .. 549b3 )
> used: [ 549b3 .. 549b4 )
> free: [ 549b4 .. 549b5 )
> used: [ 549b5 .. 549b7 )
> free: [ 549b7 .. 549b8 )
> used: [ 549b8 .. 549b9 )
> free: [ 549b9 .. 549bb )
> used: [ 549bb .. 549bc )
> free: [ 549bc .. 549e6 )
> used: [ 549e6 .. 549e7 )
> free: [ 549e7 .. 549ed )
> used: [ 549ed .. 549ee )
> free: [ 549ee .. 549ef )
> used: [ 549ef .. 549f0 )
> free: [ 549f0 .. 549f2 )
> used: [ 549f2 .. 549f3 )
> free: [ 549f3 .. 549f5 )
> used: [ 549f5 .. 549f6 )
> free: [ 549f6 .. 549f8 )
> used: [ 549f8 .. 549f9 )
> free: [ 549f9 .. 549fb )
> used: [ 549fb .. 549fc )
> free: [ 549fc .. 549fe )
> used: [ 549fe .. 549ff )
> free: [ 549ff .. 54a01 )
> used: [ 54a01 .. 54a02 )
> free: [ 54a02 .. 54a04 )
> used: [ 54a04 .. 54a05 )
> free: [ 54a05 .. 54a0c )
> used: [ 54a0c .. 54a0d )
> free: [ 54a0d .. 54a0e )
> used: [ 54a0e .. 54a0f )
> free: [ 54a0f .. 54a1c )
> used: [ 54a1c .. 54a1d )
> free: [ 54a1d .. 54a1e )
> used: [ 54a1e .. 54a1f )
> free: [ 54a1f .. 54a21 )
> used: [ 54a21 .. 54a22 )
> free: [ 54a22 .. 54a24 )
> used: [ 54a24 .. 54a25 )
> free: [ 54a25 .. 54a27 )
> used: [ 54a27 .. 54a28 )
> free: [ 54a28 .. 54a2a )
> used: [ 54a2a .. 54a2b )
> free: [ 54a2b .. 54a42 )
> used: [ 54a42 .. 54a43 )
> free: [ 54a43 .. 54a53 )
> used: [ 54a53 .. 54a54 )
> free: [ 54a54 .. 54a59 )
> used: [ 54a59 .. 54a5a )
> free: [ 54a5a .. 54a5c )
> used: [ 54a5c .. 54a5d )
> free: [ 54a5d .. 54a5f )
> used: [ 54a5f .. 54a60 )
> free: [ 54a60 .. 54a62 )
> used: [ 54a62 .. 54a63 )
> free: [ 54a63 .. 54a65 )
> used: [ 54a65 .. 54a66 )
> free: [ 54a66 .. 54a68 )
> used: [ 54a68 .. 54a69 )
> free: [ 54a69 .. 54a7d )
> used: [ 54a7d .. 54a7e )
> free: [ 54a7e .. 54a80 )
> used: [ 54a80 .. 54a81 )
> free: [ 54a81 .. 54aa1 )
> used: [ 54aa1 .. 54aa2 )
> free: [ 54aa2 .. 54aa4 )
> used: [ 54aa4 .. 54aa5 )
> free: [ 54aa5 .. 54aa7 )
> used: [ 54aa7 .. 54aa8 )
> free: [ 54aa8 .. 54aaa )
> used: [ 54aaa .. 54aab )
> free: [ 54aab .. 54aad )
> used: [ 54aad .. 54aae )
> free: [ 54aae .. 54ab5 )
> used: [ 54ab5 .. 54ab6 )
> free: [ 54ab6 .. 54abc )
> used: [ 54abc .. 54abd )
> free: [ 54abd .. 54ac6 )
> used: [ 54ac6 .. 54ac7 )
> free: [ 54ac7 .. 54acd )
> used: [ 54acd .. 54ace )
> free: [ 54ace .. 54ad0 )
> used: [ 54ad0 .. 54ad1 )
> free: [ 54ad1 .. 54ad5 )
> used: [ 54ad5 .. 54ad6 )
> free: [ 54ad6 .. 54ade )
> used: [ 54ade .. 54adf )
> free: [ 54adf .. 54b15 )
> used: [ 54b15 .. 54b16 )
> free: [ 54b16 .. 54b17 )
> used: [ 54b17 .. 54b18 )
> free: [ 54b18 .. 54b1a )
> used: [ 54b1a .. 54b1b )
> free: [ 54b1b .. 54b1d )
> used: [ 54b1d .. 54b1e )
> free: [ 54b1e .. 54b20 )
> used: [ 54b20 .. 54b21 )
> free: [ 54b21 .. 54b23 )
> used: [ 54b23 .. 54b24 )
> free: [ 54b24 .. 54b26 )
> used: [ 54b26 .. 54b27 )
> free: [ 54b27 .. 54b29 )
> used: [ 54b29 .. 54b2a )
> free: [ 54b2a .. 54b2c )
> used: [ 54b2c .. 54b2d )
> free: [ 54b2d .. 54b2f )
> used: [ 54b2f .. 54b30 )
> free: [ 54b30 .. 54b32 )
> used: [ 54b32 .. 54b33 )
> free: [ 54b33 .. 54b35 )
> used: [ 54b35 .. 54b36 )
> free: [ 54b36 .. 54b38 )
> used: [ 54b38 .. 54b39 )
> free: [ 54b39 .. 54b3b )
> used: [ 54b3b .. 54b3c )
> free: [ 54b3c .. 54b41 )
> used: [ 54b41 .. 54b42 )
> free: [ 54b42 .. 54b44 )
> used: [ 54b44 .. 54b45 )
> free: [ 54b45 .. 54b47 )
> used: [ 54b47 .. 54b48 )
> free: [ 54b48 .. 54c58 )
> used: [ 54c58 .. 54c59 )
> free: [ 54c59 .. 54cca )
> used: [ 54cca .. 54ccb )
> free: [ 54ccb .. 54ccc )
> used: [ 54ccc .. 54ccd )
> free: [ 54ccd .. ffffffff )
> total:  156 [156/972] used: 345122 [exact]
> ===============>  on-disk-super  <=================
> block_count:    19763966
> free_blocks:    15854011
> root_block:     2289297
> blocksize:      4096
> oid_maxsize:    972
> oid_cursize:    156
> umount_state:   2
> magic:   ReIsEr2Fs
> fs_state:       0
> hash:   r5
> tree_height:    5
> bmap_nr:        604
> version:        2
> flags:  1[attrs_cleared]
> reserved_for_journal:   0
> ===============>  per-level  <=================
> level        balances [sbk:  reads   fs_changed   restarted]   free 
> space        items   can_remove         lnum         rnum       lbytes 
>      rbytes     get_neig get_neig_res  need_l_neig  need_r_neig
> 0               11340       188527           40            0 
> 160895148      3115191          303         1725         1721 
> 4455         5984        11343            3          125          117
> 1                 148       188558            1            0 
> 151553056     25614444            1            0           22 
> -148         -148          148            0            0            1
> 2                   0       188558            0            0 
> 65905960     29183073            0            0            0 
> 0            0            0            0            0            0
> 3                   0       188558            0            0 
> 761774320       188558            0            0            0 
>  0            0            0            0            0            0
> 4                   0            0            0            0 
> 0            0            0            0            0            0 
>       0            0            0            0            0
> ===============>  super  <=================
> state:  REISERFS_VALID_FS
> mount options:  BORDER SMALL_TAILS LOG
> gen. counter:   11340
> s_kmallocs:     0
> s_disk_reads:   0
> s_disk_writes:  0
> s_fix_nodes:    11344
> s_do_balance:   11340
> s_unneeded_left_neighbor:       0
> s_good_search_by_key_reada:     0
> s_bmaps:        0
> s_bmaps_without_search:         0
> s_direct2indirect:      35
> s_indirect2direct:      583
>
> max_hash_collisions:    0
> breads:         0
> bread_misses:   0
> search_by_key:  188566
> search_by_key_fs_changed:       41
> search_by_key_restarted:        0
> insert_item_restarted:  4
> paste_into_item_restarted:      0
> cut_from_item_restarted:        0
> delete_solid_item_restarted:    0
> delete_item_restarted:  0
> leaked_oid:     0
> leaves_removable:       0
> ===============>  version  <=================
> 3.6 format      with checks off
>
>
>
>
> [X.] Other notes, patches, fixes, workarounds:
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


-- 
Hans


