Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUAQSk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUAQSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:40:57 -0500
Received: from main.gmane.org ([80.91.224.249]:26793 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266097AbUAQSk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:40:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: 2.6.1mm2: nforce2 IDE lockups + debug messages about mm/slab.c:1868
Date: Sat, 17 Jan 2004 19:40:26 +0100
Message-ID: <7361760.2YrQ8yO7uQ@spamfreemail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can anybody tell me what the following is about?


Whenever I mount my CDROM drive and try to access data on it, via KDE's
Konqueror, my computer locks up hard. Sometimes it does that even while
mounting the CDROM or DVD.

(ver_linux and lspci -vvvv output at the end)

This happened with all 2.6 kernels I've tried so far
(.0-test11, .0, .1rc1mm1, .1mm2). I've tried to compile all IDE modules
statically (I cannot use DMA with 2.6 and the IDE drivers compiled as
modules - this seems to be a known bug) but that didn't change anything.

I have the NVIDIA binary drivers loaded but this seems to happen without
NVIDIA drivers as well. And, I keep getting debug messages in syslog:


Debug: sleeping function called from invalid context at mm/slab.c:1868
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01297db>] __might_sleep+0xab/0xd0
 [<c015a4c0>] __kmalloc+0x240/0x260
 [<f8bf7375>] os_alloc_mem+0x5c/0x87 [nvidia]
 [<f8c117f0>] _nv001308rm+0x10/0x28 [nvidia]
 [<f8d29f8d>] _nv001518rm+0x7c9/0xb34 [nvidia]
 [<f8cae761>] _nv002465rm+0x81/0x420 [nvidia]
 [<f8cae778>] _nv002465rm+0x98/0x420 [nvidia]
 [<f8c07365>] _nv001338rm+0x1d/0x24 [nvidia]
 [<f8bf7f55>] _nv005601rm+0xd/0x34 [nvidia]
 [<f8bff638>] _nv000858rm+0x300/0xe14 [nvidia]
 [<c012539e>] try_to_wake_up+0x21e/0x2c0
 [<c012545e>] wake_up_process+0x1e/0x20
 [<c0137069>] run_timer_softirq+0x1c9/0x290
 [<c012623f>] scheduler_tick+0x3f/0x6b0
 [<f8bfb8ed>] _nv002962rm+0x2c5/0x3b8 [nvidia]
 [<f8c162a9>] _nv000899rm+0x4c9/0xf70 [nvidia]
 [<f8c162bc>] _nv000899rm+0x4dc/0xf70 [nvidia]
 [<f8d72b2f>] _nv000176rm+0x57/0x3ec [nvidia]
 [<c02c5c19>] dev_queue_xmit+0x389/0x460
 [<c01dd0e4>] make_cpu_key+0x54/0x60
 [<c02ea53e>] ip_finish_output+0x10e/0x260
 [<c01dd8ca>] _get_block_create_0+0x6ea/0x7b0
 [<c0157e99>] check_poison_obj+0x29/0x1a0
 [<c015a1da>] kmem_cache_alloc+0x16a/0x210
 [<c013898d>] send_signal+0x8d/0x140
 [<c0124d9e>] recalc_task_prio+0x8e/0x1b0
 [<c01270da>] __wake_up_common+0x3a/0x60
 [<c02c0d85>] kfree_skbmem+0x25/0x30
 [<f8d72b2f>] _nv000176rm+0x57/0x3ec [nvidia]
 [<f8ba9b76>] udp_data_ready+0x1e6/0x2e0 [sunrpc]
 [<c0124d9e>] recalc_task_prio+0x8e/0x1b0
 [<c01270da>] __wake_up_common+0x3a/0x60
 [<f8d72b2f>] _nv000176rm+0x57/0x3ec [nvidia]
 [<f8d72b2f>] _nv000176rm+0x57/0x3ec [nvidia]
 [<f8d72b2f>] _nv000176rm+0x57/0x3ec [nvidia]
 [<f8d72b2f>] _nv000176rm+0x57/0x3ec [nvidia]
 [<f8c07365>] _nv001338rm+0x1d/0x24 [nvidia]
 [<f8c2c8ac>] _nv005307rm+0x54/0x544 [nvidia]
 [<f8cdd09b>] _nv001532rm+0x1f/0x28 [nvidia]
 [<f8cdd04c>] _nv001534rm+0x20/0x28 [nvidia]
 [<f8cdd842>] _nv003621rm+0x1a/0x20 [nvidia]
 [<c0124d9e>] recalc_task_prio+0x8e/0x1b0
 [<c0157e99>] check_poison_obj+0x29/0x1a0
 [<c01270da>] __wake_up_common+0x3a/0x60
 [<c03306c8>] unix_stream_sendmsg+0x2f8/0x4d0
 [<c02bc805>] sock_sendmsg+0xc5/0xd0
 [<c02bc9df>] sock_aio_read+0xef/0x100
 [<c02bcbd1>] sock_readv_writev+0x71/0xa0
 [<f8c159b1>] rm_ioctl+0x19/0x20 [nvidia]
 [<f8bf4cbe>] nv_kern_ioctl+0x4de/0x529 [nvidia]
 [<c01762ed>] do_readv_writev+0x1fd/0x290
 [<c0136ced>] update_wall_time+0xd/0x40
 [<c01371ff>] do_timer+0xbf/0xd0
 [<c01144f7>] timer_interrupt+0x97/0x1f0
 [<c018c472>] sys_ioctl+0x172/0x340
 [<c0336a3b>] syscall_call+0x7/0xb

        




ds9:jens> . ../.src/2.6.1/2.6.1mm2+r/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ds9 2.6.1mm2-jb-k7 #4 SMP Tue Jan 13 23:47:40 CET 2004 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre4
e2fsprogs              1.35-WIP
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         appletalk ax25 ipx agpgart snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_ymfpci
snd_ac97_codec snd_pcm snd_opl3_lib snd_timer snd_hwdep gameport
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd hid tsdev md5
ipv6 nfs lockd sunrpc uhci_hcd ohci_hcd evdev raw1394 ohci1394 ieee1394
scanner sr_mod sg ide_scsi scsi_mod usbmouse ehci_hcd usbcore floppy rtc
nvidia isofs cdrom tuner tvaudio msp3400 bttv video_buf i2c_algo_bit
btcx_risc i2c_core v4l2_common videodev soundcore 3c59x nls_iso8859_15
nls_cp850




ds9:jens> lspci -vvvv
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: <available only to root>

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at c000 [size=32]
        Capabilities: <available only to root>

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at de086000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 22
        Region 0: Memory at de081000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
(prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc. A7N8X Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 21
        Region 0: Memory at de082000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller
(rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at de083000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at c400 [size=8]
        Capabilities: <available only to root>

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia
audio [Via VT82C686B] (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 3000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: <available only to root>

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio
Controler (MCP) (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 8095
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at b000 [size=256]
        Region 1: I/O ports at b400 [size=128]
        Region 2: Memory at de087000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: dd000000-ddffffff
        Prefetchable memory behind bridge: d8000000-d8ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a
[Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: <available only to root>

00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3) (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: d9000000-daffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE
1394) Controller (rev a3) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 809a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at de084000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at de085000 (32-bit, non-prefetchable) [size=64]
        Capabilities: <available only to root>

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: db000000-dcffffff
        Prefetchable memory behind bridge: c8000000-d7ffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S
Audio Controller] (rev 02)
        Subsystem: Yamaha Corporation DS-XG PCI Audio CODEC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=32K]
        Region 1: I/O ports at 9000 [size=64]
        Region 2: I/O ports at 9400 [size=4]
        Capabilities: <available only to root>

01:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=4K]

01:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d8001000 (32-bit, prefetchable) [size=4K]

02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast
Ethernet Controller (rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 80ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at a000 [size=128]
        Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

03:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4200] (rev a3) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 8702
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at db000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d0000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

-- 
Jens Benecke
