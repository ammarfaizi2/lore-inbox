Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVKTG4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKTG4m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVKTG4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:56:42 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:20383 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750796AbVKTG4m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:56:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Vgz0Z23yjyzk/7BnChYno+Z1sNFrdHGV0XvoqUKeMPL4iODWJhRvCdAuVMab4wp9QDSZo3gjU83Ggr57b7HeGrRIZX20pgxpPtZ7HAoRdg1RXWoMJ8TiLxGSPOK/3Un86ZMchX1AaqYNK0QTqInG8vkcUlgCZ2nM/OcoNzrim24=
Message-ID: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
Date: Sat, 19 Nov 2005 22:56:41 -0800
From: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in process 'aplay', page c18eef30)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[17179671.700000] Bad page state at free_hot_cold_page (in process
'aplay', page c18eef30)
[17179671.700000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[17179671.700000] Backtrace:
[17179671.700000]  [<c0103de8>] dump_stack+0x1e/0x20
[17179671.700000]  [<c014c775>] bad_page+0x87/0x140
[17179671.700000]  [<c014d12d>] free_hot_cold_page+0x43/0x130
[17179671.700000]  [<c014d224>] free_hot_page+0xa/0xc
[17179671.700000]  [<c0150b53>] __page_cache_release+0x61/0xbf
[17179671.700000]  [<c015074d>] put_page+0x3d/0x82
[17179671.700000]  [<c015e430>] free_page_and_swap_cache+0x24/0x47
[17179671.700000]  [<c01559e4>] zap_pte_range+0x232/0x348
[17179671.700000]  [<c0155bdb>] unmap_page_range+0xe1/0x10b
[17179671.700000]  [<c0155cc4>] unmap_vmas+0xbf/0x237
[17179671.700000]  [<c015a494>] unmap_region+0xb3/0x158
[17179671.700000]  [<c015a7f2>] do_munmap+0xf8/0x138
[17179671.700000]  [<c015a889>] sys_munmap+0x57/0x73
[17179671.700000]  [<c0102e9f>] sysenter_past_esp+0x54/0x75
[17179671.700000] ---------------------------
[17179671.700000] | preempt count: 00000003 ]
[17179671.700000] | 3 level deep critical section nesting:
[17179671.700000] ----------------------------------------
[17179671.700000] .. [<c015a414>] .... unmap_region+0x33/0x158
[17179671.700000] .....[<c015a7f2>] ..   ( <= do_munmap+0xf8/0x138)
[17179671.700000] .. [<c01181dd>] .... kmap_atomic+0x15/0x9c
[17179671.700000] .....[<c01557f2>] ..   ( <= zap_pte_range+0x40/0x348)
[17179671.700000] .. [<c03ca9dc>] .... _spin_lock+0x13/0x6f
[17179671.700000] .....[<c0155809>] ..   ( <= zap_pte_range+0x57/0x348)
[17179671.700000]
[17179671.700000] Hexdump:
[17179671.700000] 000: e4 d8 cc c1 9e ff 64 00 f8 57 a7 c1 b8 ad a0 c1
[17179671.700000] 010: 14 04 00 80 00 00 00 00 ff ff ff ff 00 00 00 00
[17179671.700000] 020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[17179671.700000] 030: 00 00 00 00 f0 00 00 00 00 01 10 00 00 02 20 00
[17179671.700000] 040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
[17179671.700000] 050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[17179671.700000] 060: 00 00 00 00 f1 00 00 00 00 01 10 00 00 02 20 00
[17179671.700000] 070: 00 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[17179671.700000] 080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[17179671.700000] 090: 00 00 00 00 38 00 00 00 00 01 10 00 00 02 20 00
[17179671.700000] 0a0: 00 04 00 80 00 00 00 00 00 00 00 00 00 00 00 00
[17179671.700000] 0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[17179671.700000] Trying to fix it up, but a reboot is needed
