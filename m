Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbSJ2S2v>; Tue, 29 Oct 2002 13:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSJ2S2v>; Tue, 29 Oct 2002 13:28:51 -0500
Received: from stingr.net ([212.193.32.15]:20485 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S262034AbSJ2S2u>;
	Tue, 29 Oct 2002 13:28:50 -0500
Date: Tue, 29 Oct 2002 21:35:09 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: lots of scheduling-while-atomic in 2.5.44-mm6
Message-ID: <20021029183509.GA29935@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bad: scheduling while atomic!
Call Trace:
 [<c011e8cb>] do_schedule+0x40b/0x410
 [<c014c17b>] kswapd+0x12b/0x15e
 [<c0121780>] autoremove_wake_function+0x0/0x50
 [<c011e906>] preempt_schedule+0x36/0x50
 [<c0121780>] autoremove_wake_function+0x0/0x50
 [<c014c050>] kswapd+0x0/0x15e
 [<c01056fd>] kernel_thread_helper+0x5/0x18

and this

Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c0147b34>] kmem_flagcheck+0x64/0x70
 [<c0148457>] kmalloc+0x67/0xc0
 [<c01b579c>] __jbd_kmalloc+0x2c/0x80
 [<c01acb1b>] new_handle+0x2b/0x70
 [<c01ace18>] journal_try_start+0xb8/0x100
 [<c01a074c>] ext3_writepage_trans_blocks+0x1c/0x90
 [<c019e69e>] ext3_writepage+0x2ce/0x360
 [<c0182d27>] mpage_writepages+0x2f7/0x441
 [<c019e3d0>] ext3_writepage+0x0/0x360
 [<c0158ba6>] do_writepages+0x36/0x40
 [<c0158b4f>] generic_vm_writeback+0x3f/0x60
 [<c014adec>] shrink_list+0x3ec/0x650
 [<c014a133>] __pagevec_release+0x23/0x40
 [<c014a6ac>] __pagevec_lru_add_active+0x18c/0x1a0
 [<c014b270>] shrink_cache+0x220/0x4a0
 [<c0238617>] vsnprintf+0x207/0x460
 [<c014bfc2>] balance_pgdat+0xc2/0x150
 [<c014c1a7>] kswapd+0x157/0x15e
 [<c0121780>] autoremove_wake_function+0x0/0x50
 [<c011e906>] preempt_schedule+0x36/0x50
 [<c0121780>] autoremove_wake_function+0x0/0x50
 [<c014c050>] kswapd+0x0/0x15e
 [<c01056fd>] kernel_thread_helper+0x5/0x18

feeling that it eating my fs while emitting these :)

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
