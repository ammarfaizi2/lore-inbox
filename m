Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbUK3PGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUK3PGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbUK3PGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:06:48 -0500
Received: from oceanite.ens-lyon.fr ([140.77.1.22]:40909 "EHLO
	oceanite.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262099AbUK3PGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:06:06 -0500
Date: Tue, 30 Nov 2004 16:06:41 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Mike Kirk <mike.kirk@sympatico.ca>
Subject: 2.6.10-rc2-mm3 [was: Re: 2.6.9-rc2: "kernel BUG at mm/rmap.c:473!"]
Message-ID: <20041130150639.GA11294@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409191220390.13142-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, 19 Sep 2004, Hugh Dickins wrote:
> On Sat, 18 Sep 2004, Mike Kirk wrote:
> > Not sure what this means: but the system kept running and I only lost a
> > bzip2 process: 2.6.9-rc2 w/preempt AMD 2700+ on A7N8X motherboard, 1GB
> > DDR400:
> > ==============================
> > kernel BUG at mm/rmap.c:473!
> > EIP is at page_remove_rmap+0x29/0x40
> 
> Was there a "Bad page state" message and backtrace shortly before this?
> I say "shortly" because I don't suppose bzip2 had been running for hours,
> I'd expect the underlying error to have occurred while it was running.
> 
> BUG_ON(page_mapcount(page) < 0);
>

I had the same BUG_ON with 2.6.10-rc2-mm3 while transcoding a video.

------------[ cut here ]------------
kernel BUG at mm/rmap.c:479!
invalid operand: 0000 [#1]
Modules linked in: radeon drm snd_seq snd_via82xx snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ide_cd cdrom sk98lin
CPU:    0
EIP:    0060:[<c01454a4>]    Not tainted VLI
EFLAGS: 00010286   (2.6.10-rc2-mm3-arakou) 
EIP is at page_remove_rmap+0x34/0x40
eax: ffffffff   ebx: 00007000   ecx: c03be100   edx: c17712c0
esi: cbfa60bc   edi: 003ce000   ebp: c6648d78   esp: c6648d78
ds: 007b   es: 007b   ss: 0068
Process transcode (pid: 14505, threadinfo=c6648000 task=dac3aaa0)
Stack: c6648dac c013f2af c6648e34 c02d74dd 00000003 0000000e 3b896067 c17712c0 
       b2028000 c03be100 b2428000 c8027b24 b23f6000 c6648dd4 c013f439 003ce000 
       00000000 00000000 c0310524 c03be100 b2028000 c8027b24 b23f6000 c6648df4 
Call Trace:
 [<c0103b2a>] show_stack+0x7a/0x90
 [<c0103cad>] show_registers+0x14d/0x1c0
 [<c0103e82>] die+0xc2/0x140
 [<c01042a3>] do_invalid_op+0xa3/0xb0
 [<c01037e3>] error_code+0x2b/0x30
 [<c013f2af>] zap_pte_range+0x13f/0x280
 [<c013f439>] zap_pmd_range+0x49/0x70
 [<c013f49d>] zap_pgd_range+0x3d/0x70
 [<c013f4fb>] unmap_page_range+0x2b/0x40
 [<c013f600>] unmap_vmas+0xf0/0x1f0
 [<c014399b>] exit_mmap+0x6b/0x120
 [<c0116431>] mmput+0x41/0xd0
 [<c011a2db>] do_exit+0x15b/0x420
 [<c011a616>] do_group_exit+0x36/0x70
 [<c0122b0b>] get_signal_to_deliver+0x1bb/0x2b0
 [<c0102b76>] do_signal+0x66/0x120
 [<c0102c69>] do_notify_resume+0x39/0x3c
 [<c0102daa>] work_notifysig+0x13/0x15
Code: 08 75 1e 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 17 9c 58 fa ff 0d d0 c4 3c c0 50 9d c9 c3 0f 0b dc 01 db 95 2d c0 eb d8 <0f> 0b df 01 db 95 2d c0 eb df 89 f6 55 89 e5 83 ec 18 89 5d f4 
 BUG: atomic counter underflow at:
 [<c0103b57>] dump_stack+0x17/0x20
 [<c011a51e>] do_exit+0x39e/0x420
 [<c0103efc>] die+0x13c/0x140
 [<c01042a3>] do_invalid_op+0xa3/0xb0
 [<c01037e3>] error_code+0x2b/0x30
 [<c013f2af>] zap_pte_range+0x13f/0x280
 [<c013f439>] zap_pmd_range+0x49/0x70
 [<c013f49d>] zap_pgd_range+0x3d/0x70
 [<c013f4fb>] unmap_page_range+0x2b/0x40
 [<c013f600>] unmap_vmas+0xf0/0x1f0
 [<c014399b>] exit_mmap+0x6b/0x120
 [<c0116431>] mmput+0x41/0xd0
 [<c011a2db>] do_exit+0x15b/0x420
 [<c011a616>] do_group_exit+0x36/0x70
 [<c0122b0b>] get_signal_to_deliver+0x1bb/0x2b0
 [<c0102b76>] do_signal+0x66/0x120
 [<c0102c69>] do_notify_resume+0x39/0x3c
 [<c0102daa>] work_notifysig+0x13/0x15
Bad page state at prep_new_page (in process 'mpd', page c17712c0)
flags:0x40020114 mapping:00000000 mapcount:-1 count:0
Backtrace:
 [<c0103b57>] dump_stack+0x17/0x20
 [<c0136352>] bad_page+0x72/0xb0
 [<c013669b>] prep_new_page+0x2b/0x80
 [<c0136d8b>] buffered_rmqueue+0xcb/0x170
 [<c0136ffd>] __alloc_pages+0x11d/0x340
 [<c013925c>] do_page_cache_readahead+0xcc/0x120
 [<c0139476>] page_cache_readahead+0x1c6/0x1f0
 [<c0132ecb>] do_generic_mapping_read+0x11b/0x630
 [<c013361d>] __generic_file_aio_read+0x16d/0x1e0
 [<c0133784>] generic_file_read+0x94/0xc0
 [<c014e6f1>] vfs_read+0x101/0x140
 [<c014e99d>] sys_read+0x3d/0x70
 [<c0102d0d>] sysenter_past_esp+0x52/0x71
Trying to fix it up, but a reboot is needed

Regards,

Benoit

--CE+1k2dSO48ffgeK
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
1YxvfNRX18STsP8HeZYJR+R6AAA=

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Description: output of lspci -vv
Content-Disposition: attachment; filename="lspci.log"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
	Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable)
	Capabilities: [80] AGP version 3.5
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3+ Rate=x4,x8,x@
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d7ffffff
	Prefetchable memory behind bridge: d8000000-efffffff
	Expansion ROM at 0000d000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (5750ns min, 7750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at d6800000 (32-bit, non-prefetchable)
	Region 1: I/O ports at b800 [size=256]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at b400
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: I/O ports at 9800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 169
	Region 4: I/O ports at 9400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 9000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 8800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 8400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 8000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 0
	Region 0: Memory at d6000000 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.5 Network controller: VIA Technologies, Inc. VT8237 Integrated Fast Ethernet Controller
	Subsystem: VIA Technologies, Inc. VT8237 Integrated Fast Ethernet Controller
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 240
	Region 0: Memory at d5800000 (32-bit, non-prefetchable) [disabled]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk+ DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800 South]
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: ASUSTeK Computer Inc. A7V600 motherboard (ADI AD1980 codec [SoundMAX])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 185
	Region 0: I/O ports at e000
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: Hightech Information System Ltd.: Unknown device 2012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 193
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=e7fe0000]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d7800000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: Hightech Information System Ltd.: Unknown device 2013
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled]
	Region 1: Memory at d7000000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--CE+1k2dSO48ffgeK--
