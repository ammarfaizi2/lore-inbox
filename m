Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbULUOcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbULUOcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 09:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbULUOcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 09:32:10 -0500
Received: from village.ehouse.ru ([193.111.92.18]:43270 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261764AbULUObx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 09:31:53 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc3-bk13: Badness in smp_call_function at arch/i386/kernel/smp.c:523
Date: Tue, 21 Dec 2004 17:31:50 +0300
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412211731.51243.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got it on Dual AthlonMP 2200+ ( 4G RAM, LSI320-1 ) under heavy load 
( load avarage > 100 i guess ) just after Emergency Sync and SysRq Boot

bo.srv.ehouse.ru login: SysRq : Changing Loglevel
Loglevel set to 6
SysRq : Emergency Sync
SysRq : Emergency Sync
SysRq : Resetting
Badness in smp_call_function at arch/i386/kernel/smp.c:523
 [<c010e05e>] smp_call_function+0xfe/0x110
 [<c01191e4>] call_console_drivers+0x74/0x100
 [<c0119593>] release_console_sem+0x73/0xc0
 [<c010e0cb>] smp_send_stop+0x1b/0x30
 [<c010d411>] machine_restart+0x81/0x100
 [<c0119367>] printk+0x17/0x20
 [<c024e25b>] __handle_sysrq+0x6b/0xf0
 [<c02484f2>] kbd_event+0x92/0xf0
 [<c028f6ea>] input_event+0xea/0x3e0
 [<c0291cef>] atkbd_report_key+0x2f/0x80
 [<c0291f32>] atkbd_interrupt+0x1f2/0x5e0
 [<c026d0ad>] e1000_clean_rx_irq+0x17d/0x440
 [<c02520b7>] serio_interrupt+0x47/0x98
 [<c02526b4>] i8042_interrupt+0x94/0x150
 [<c0132359>] handle_IRQ_event+0x29/0x60
 [<c0132464>] __do_IRQ+0xd4/0x130
 [<c0104946>] do_IRQ+0x46/0x70
 =======================
 [<c010308e>] common_interrupt+0x1a/0x20
 [<c0146a6e>] page_referenced_anon+0x6e/0x90
 [<c0146bd0>] page_referenced+0x80/0x90
 [<c013e03b>] shrink_list+0xdb/0x430
 [<c0146a7a>] page_referenced_anon+0x7a/0x90
 [<c013d175>] __pagevec_release+0x15/0x20
 [<c013e4ee>] shrink_cache+0x15e/0x380
 [<c013ecb5>] shrink_zone+0xa5/0xc0
 [<c013ed33>] shrink_caches+0x63/0x70
 [<c013edf4>] try_to_free_pages+0xb4/0x180
 [<c0137bcf>] __alloc_pages+0x1ef/0x320
 [<c0133bb0>] find_get_pages_tag+0x70/0x80
 [<c0133abf>] find_or_create_page+0x6f/0x80
 [<c0152048>] grow_dev_page+0x28/0x110
 [<c01521a8>] __getblk_slow+0x78/0xf0
 [<c0152527>] __getblk+0x37/0x40
 [<c01a5869>] do_journal_end+0x169/0x980
 [<c0133bb0>] find_get_pages_tag+0x70/0x80
 [<c01a43e6>] do_journal_begin_r+0x26/0x290
 [<c013d46a>] pagevec_lookup_tag+0x2a/0x40
 [<c0133337>] wait_on_page_writeback_range+0x77/0x120
 [<c01398e0>] pdflush+0x0/0x20
 [<c01a4e3c>] journal_end_sync+0x4c/0x90
 [<c0193053>] reiserfs_sync_fs+0x53/0x60
 [<c016fb95>] get_super_to_sync+0x35/0x70
 [<c0155c2f>] sync_supers+0x8f/0xa0
 [<c015147c>] do_sync+0x1c/0x60
 [<c01397fd>] __pdflush+0xbd/0x1a0
 [<c01398fa>] pdflush+0x1a/0x20
 [<c0151460>] do_sync+0x0/0x60
 [<c01398e0>] pdflush+0x0/0x20
 [<c012ba0c>] kthread+0x9c/0xb0
 [<c012b970>] kthread+0x0/0xb0
 [<c010097d>] kernel_thread_helper+0x5/0x18

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
