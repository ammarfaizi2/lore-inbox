Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272362AbTHSPzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272064AbTHSPzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:55:32 -0400
Received: from zeus.kernel.org ([204.152.189.113]:64226 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272362AbTHSPyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:54:55 -0400
Subject: Re: weird pcmcia problem
From: Sven Dowideit <svenud@ozemail.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Narayan Desai <desai@mcs.anl.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <20030819124547.B18205@flint.arm.linux.org.uk>
References: <87u18efpsc.fsf@mcs.anl.gov>
	 <20030819124547.B18205@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1061336817.641.6.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Aug 2003 09:46:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 21:45, Russell King asked for:

> - make/model of machine
IBM thinkpad t21

> - type of cardbus bridge (from lspci)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: IBM: Unknown device 0130
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 50000000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20000000-203ff000 (prefetchable)
        Memory window 1: 20400000-207ff000
        I/O window 0: 00001400-000014ff
        I/O window 1: 00002400-000024ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: IBM: Unknown device 0130
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at 50100000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 20800000-20bff000 (prefetchable)
        Memory window 1: 20c00000-20fff000
        I/O window 0: 00002800-000028ff
        I/O window 1: 00002c00-00002cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

> - type of card (pcmcia or cardbus)
cardbus

> - make/model of card
cisco aironet 340

> - full kernel dmesg (including yenta, card services messages)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
PCI: Found IRQ 9 for device 0000:00:02.0
PCI: Sharing IRQ 9 with 0000:00:05.0
PCI: Sharing IRQ 9 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0130]
Yenta IRQ list 00b8, PCI irq9
Socket status: 30000010
PCI: Found IRQ 9 for device 0000:00:02.1
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0130]
Yenta IRQ list 00b8, PCI irq9
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.

(then when i re-insert it)
airo: Doing fast bap_reads
airo: MAC enabled eth0 0:40:96:33:e:a4
eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
bad: scheduling while atomic!
Call Trace:
 [<c011a487>] schedule+0x3b7/0x3c0
 [<e0852d3a>] sendcommand+0xaa/0xe0 [airo]
 [<e0852c5c>] issuecommand+0x5c/0x90 [airo]
 [<e085321a>] PC4500_accessrid+0x4a/0x90 [airo]
 [<c010b855>] error_code+0x2d/0x38
 [<e08532c1>] PC4500_readrid+0x61/0x130 [airo]
 [<e0850661>] readStatsRid+0x31/0x50 [airo]
 [<e0850d17>] airo_read_stats+0x67/0x150 [airo]
 [<c01189c8>] pgd_alloc+0x18/0x20
 [<c013745c>] find_get_page+0x2c/0x60
 [<c013861e>] filemap_nopage+0x28e/0x320
 [<c013b131>] buffered_rmqueue+0xd1/0x170
 [<c017fd2c>] proc_alloc_inode+0x4c/0x80
 [<c017fd2c>] proc_alloc_inode+0x4c/0x80
 [<c016afec>] alloc_inode+0x1c/0x140
 [<c013ae60>] __rmqueue+0xd0/0x120
 [<c013b131>] buffered_rmqueue+0xd1/0x170
 [<c0202466>] vsnprintf+0x246/0x470
 [<e0850e16>] airo_get_stats+0x16/0x20 [airo]
 [<c0299bbb>] dev_seq_printf_stats+0xeb/0x100
 [<c0299bf8>] dev_seq_show+0x28/0x90
 [<c01705ad>] seq_read+0x1dd/0x310
 [<c0152498>] vfs_read+0xb8/0x130
 [<c0152742>] sys_read+0x42/0x70
 [<c010ae4b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011a487>] schedule+0x3b7/0x3c0
 [<e0852d3a>] sendcommand+0xaa/0xe0 [airo]
 [<e0852c5c>] issuecommand+0x5c/0x90 [airo]
 [<e085321a>] PC4500_accessrid+0x4a/0x90 [airo]
 [<e08532c1>] PC4500_readrid+0x61/0x130 [airo]
 [<e0850661>] readStatsRid+0x31/0x50 [airo]
 [<e0850d17>] airo_read_stats+0x67/0x150 [airo]
 [<c0202466>] vsnprintf+0x246/0x470
 [<e0850e16>] airo_get_stats+0x16/0x20 [airo]
 [<c0299bbb>] dev_seq_printf_stats+0xeb/0x100
 [<c0299bf8>] dev_seq_show+0x28/0x90
 [<c01705ad>] seq_read+0x1dd/0x310
 [<c0152498>] vfs_read+0xb8/0x130
 [<c0152742>] sys_read+0x42/0x70
 [<c010ae4b>] syscall_call+0x7/0xb
 


> - cardmgr messages from system log
Aug 20 09:37:19 sven cardmgr[322]: starting, version is 3.2.2
Aug 20 09:37:19 sven cardmgr[322]: socket 0: Anonymous Memory
Aug 20 09:37:19 sven cardmgr[322]: executing: 'modprobe memory_cs'
Aug 20 09:37:19 sven cardmgr[322]: + FATAL: Module memory_cs not found.
Aug 20 09:37:19 sven cardmgr[322]: modprobe exited with status 1
Aug 20 09:37:19 sven cardmgr[322]: module /lib/modules/2.6.0-test3/pcmcia/memory_cs.o not available
Aug 20 09:37:19 sven cardmgr[322]: bind 'memory_cs' to socket 0 failed: Invalid argument
Aug 20 09:37:19 sven cardmgr[322]: socket 0: Anonymous Memory
Aug 20 09:38:35 sven cardmgr[322]: executing: 'modprobe -r memory_cs'
Aug 20 09:38:35 sven cardmgr[322]: + FATAL: Module memory_cs not found.
Aug 20 09:38:35 sven cardmgr[322]: modprobe exited with status 1
Aug 20 09:38:44 sven cardmgr[322]: socket 0: Aironet PC4800
Aug 20 09:38:44 sven cardmgr[322]: executing: 'modprobe airo_cs'
Aug 20 09:38:45 sven cardmgr[322]: executing: './network start eth0'
Aug 20 09:38:45 sven cardmgr[322]: + Ignoring unknown interface eth0=eth0.



