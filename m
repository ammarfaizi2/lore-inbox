Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUCKRi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 12:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUCKRi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 12:38:27 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:55225 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261472AbUCKRiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 12:38:20 -0500
Subject: Badness in remove_proc_entry called from snd_via82xx_remove
	(2.6.4-mm)
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net
In-Reply-To: <20040204203426.GA1841@miriel.finwe.eu.org>
References: <20040204203426.GA1841@miriel.finwe.eu.org>
Content-Type: text/plain
Message-Id: <1079026696.810.26.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 18:38:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens at shutdown when alsa is to be closed with kernel 2.6.4-mm.
I'm running debian sid, snd_via82xx compiled as module.
Happens also on 2.6.4-rc2-mm1, I can try on more kernels as well if it
is not a clear case.


I slapped a printk on these just before the badness:
de->subdir->name = "id", de->name = "card0"

Badness in remove_proc_entry at fs/proc/generic.c:667
Call Trace:
[<c016fb5a>] remove_proc_entry+0x13a/0x1a0
[<e083a6fb>] snd_info_unregister+0x3b/0x70 [snd]
[<e083a231>] snd_info_card_free+0x31/0x60 [snd]
[<e0838b67>] snd_card_free+0xd7/0x250 [snd]
[<c015bfde>] destroy_inode+0x4e/0x50
[<c015d0b5>] iput+0x55/0x80
[<e08709c9>] snd_via82xx_remove+0x19/0x30 [snd_via82xx]
[<c01a074b>] pci_device_remove+0x3b/0x40
[<c01c4854>] device_release_driver+0x64/0x70
[<c01c4880>] driver_detach+0x20/0x30
[<c01c4aad>] bus_remove_driver+0x3d/0x80
[<c01c4ec3>] driver_unregister+0x13/0x28
[<c01a08e2>] pci_unregister_driver+0x12/0x20
[<e08709ef>] alsa_card_via82xx_exit+0xf/0x13 [snd_via82xx]
[<c012b5d1>] sys_delete_module+0x131/0x170
[<c013e264>] sys_munmap+0x44/0x70
[<c0249c4f>] syscall_call+0x7/0xb



00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235 AC97 Audio Controller (rev 50)
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



