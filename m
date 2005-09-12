Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVILKT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVILKT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVILKT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:19:26 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:59315 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1750710AbVILKT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:19:26 -0400
Date: Mon, 12 Sep 2005 12:20:11 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Oops 2.6.13-git6
Message-ID: <20050912102011.GA2379@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I did some experiments with my cdrom and battery switchnig.

I have modular bay for cdrom or battery. 

I have two ide devices: hda - pata disk, hdb - cdrom. I suspended into ram and
removed cdrom replacing it with battery. I resumed, then I did hotswap -c
0 rescan-ide; hotswap -c probe-ide

dd if=/dev/hdb of=/dev/null bs=512 count=1 results in:
hdb: ATAPI reset complete
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
hdb: ATAPI reset complete
hdb: status error: status=0x00 { }
ide: failed opcode was: unknown
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0160f20
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: skge i915 asus_acpi rtc snd_hda_intel snd_hda_codec ehci_hcd 
uhci_hcd
CPU:    0
EIP:    0060:[<c0160f20>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13-git6) 
EIP is at create_empty_buffers+0x30/0xb0
eax: 00000000   ebx: c12d6240   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c1450144   esp: cba8aca0
ds: 007b   es: 007b   ss: 0068
Process dd (pid: 2750, threadinfo=cba8a000 task=d5f145e0)
Stack: c12d6240 00010000 00000001 c12d6258 c12d6240 c0161aee c12d6240 00010000 
       00000000 c1450148 c01deddc 00000001 00000020 00010000 c01df051 c1450148 
       c14500a4 00000000 cba8a000 c12d6240 c1450144 c013dba8 c1450148 00000000 
Call Trace:
 [<c0161aee>] block_read_full_page+0x29e/0x2f0
 [<c01deddc>] radix_tree_node_alloc+0x1c/0x60
 [<c01df051>] radix_tree_insert+0x81/0x130
 [<c013dba8>] add_to_page_cache+0x68/0xc0
 [<c0145811>] read_pages+0xe1/0x160
 [<c0166130>] blkdev_get_block+0x0/0x70
 [<c01430c0>] __alloc_pages+0x300/0x420
 [<c01459e0>] __do_page_cache_readahead+0x150/0x180
 [<c0145b75>] blockable_page_cache_readahead+0x55/0xd0
 [<c0145dd8>] page_cache_readahead+0x118/0x1c0
 [<c013e7b7>] do_generic_mapping_read+0x4d7/0x630
 [<c01771d3>] dput+0x93/0x240
 [<c013ebb4>] __generic_file_aio_read+0x1a4/0x210
 [<c013e910>] file_read_actor+0x0/0x100
 [<c013ed54>] generic_file_read+0xb4/0xe0
 [<c014ecb4>] __handle_mm_fault+0x1b4/0x210
 [<c0131580>] autoremove_wake_function+0x0/0x60
 [<c0116919>] do_page_fault+0x1b9/0x5b1
 [<c015e03c>] vfs_read+0x14c/0x160
 [<c015e331>] sys_read+0x51/0x80
 [<c01031b5>] syscall_call+0x7/0xb
Code: 00 53 83 ec 0c 8b 5c 24 18 89 44 24 08 8b 44 24 1c 8b 74 24 20 89 1c 24 89
 44 24 04 e8 1a f6 ff ff 89 c1 89 c2 8d b6 00 00 00 00 <09> 32 89 d0 8b 52 04 85
 d2 75 f5 89 48 04 b8 00 f0 ff ff 21 e0 


Is there some way how to change battery and cdrom without reboot?

-- 
Luká¹ Hejtmánek
