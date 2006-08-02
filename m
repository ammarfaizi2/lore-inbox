Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWHBWIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWHBWIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWHBWIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:08:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932263AbWHBWIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:08:10 -0400
Date: Wed, 2 Aug 2006 18:08:05 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: md/dm lockdep bug.
Message-ID: <20060802220805.GF3639@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <44D121A2.4090602@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D121A2.4090602@freemail.hu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just had a user report this against our 2.6.18-rc3-git1 kernel...

		Dave

 > I see three problems on x86-64.
 > These two are on boot, kernel-2.6.17-1.2505.fc6:
 > 
 > ...
 > =============================================
 > [ INFO: possible recursive locking detected ]
 > ---------------------------------------------
 > vol_id/973 is trying to acquire lock:
 > (&md->io_lock){----}, at: [<ffffffff880c8653>] dm_request+0x25/0x130 
 > [dm_mod]
 > 
 > but task is already holding lock:
 > (&md->io_lock){----}, at: [<ffffffff880c8653>] dm_request+0x25/0x130 
 > [dm_mod]
 > 
 > other info that might help us debug this:
 > 1 lock held by vol_id/973:
 > #0:  (&md->io_lock){----}, at: [<ffffffff880c8653>] 
 > dm_request+0x25/0x130 [dm_mod]
 > 
 > stack backtrace:
 > 
 > Call Trace:
 > [<ffffffff8026e7fd>] show_trace+0xae/0x30e
 > [<ffffffff8026ea72>] dump_stack+0x15/0x17
 > [<ffffffff802a7fa3>] __lock_acquire+0x135/0xa54
 > [<ffffffff802a8e63>] lock_acquire+0x4b/0x69
 > [<ffffffff802a599c>] down_read+0x3e/0x4a
 > [<ffffffff880c8653>] :dm_mod:dm_request+0x25/0x130
 > [<ffffffff8021cfb3>] generic_make_request+0x21a/0x235
 > [<ffffffff880c7401>] :dm_mod:__map_bio+0xca/0x104
 > [<ffffffff880c7e47>] :dm_mod:__split_bio+0x16a/0x36b
 > [<ffffffff880c874b>] :dm_mod:dm_request+0x11d/0x130
 > [<ffffffff8021cfb3>] generic_make_request+0x21a/0x235
 > [<ffffffff80235f5c>] submit_bio+0xcc/0xd5
 > [<ffffffff8021b409>] submit_bh+0x100/0x124
 > [<ffffffff802e0b35>] block_read_full_page+0x283/0x2a1
 > [<ffffffff802e31db>] blkdev_readpage+0x13/0x15
 > [<ffffffff80213617>] __do_page_cache_readahead+0x17b/0x1fc
 > [<ffffffff80234ecf>] blockable_page_cache_readahead+0x5f/0xc1
 > [<ffffffff8021480e>] page_cache_readahead+0x146/0x1bb
 > [<ffffffff8020c329>] do_generic_mapping_read+0x157/0x4b4
 > [<ffffffff8020c7e0>] __generic_file_aio_read+0x15a/0x1b0
 > [<ffffffff802c7659>] generic_file_read+0xc6/0xe0
 > [<ffffffff8020b615>] vfs_read+0xcc/0x172
 > [<ffffffff80212248>] sys_read+0x47/0x6f
 > [<ffffffff8026048e>] system_call+0x7e/0x83
 > DWARF2 unwinder stuck at system_call+0x7e/0x83
 > Leftover inexact backtrace:


-- 
http://www.codemonkey.org.uk
