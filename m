Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWHBV5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWHBV5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWHBV5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:57:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbWHBV5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:57:52 -0400
Date: Wed, 2 Aug 2006 14:57:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: initramfs: recursive lock detected
Message-ID: <20060802145749.124857aa@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw this lock detector output during bootup. No clue who should
look at it? This is using 2.6.18-rc3 (latest) on x86_64.


[   42.260313] =============================================
[   42.277309] [ INFO: possible recursive locking detected ]
[   42.293594] ---------------------------------------------
[   42.309878] swapper/1 is trying to acquire lock:
[   42.323825]  (&nc->lock){.+..}, at: [<ffffffff8107a467>] kmem_cache_free+0x121/0x1d6
[   42.347591] 
[   42.347592] but task is already holding lock:
[   42.365355]  (&nc->lock){.+..}, at: [<ffffffff8107aa74>] kfree+0x125/0x1da
[   42.386368] 
[   42.386369] other info that might help us debug this:
[   42.406211] 2 locks held by swapper/1:
[   42.417560]  #0:  (&nc->lock){.+..}, at: [<ffffffff8107aa74>] kfree+0x125/0x1da
[   42.440053]  #1:  (&parent->list_lock){....}, at: [<ffffffff8107a90e>] __drain_alien_cache+0x34/0x75
[   42.468024] 
[   42.468025] stack backtrace:
[   42.481376] 
[   42.481377] Call Trace:
[   42.493541]  [<ffffffff8100ae89>] show_trace+0xae/0x31f
[   42.509335]  [<ffffffff8100b10f>] dump_stack+0x15/0x17
[   42.524867]  [<ffffffff81043e41>] __lock_acquire+0x12e/0x9fa
[   42.542034]  [<ffffffff81044c80>] lock_acquire+0x4b/0x69
[   42.558162]  [<ffffffff81250b62>] _spin_lock+0x2f/0x3c
[   42.573775]  [<ffffffff8107a467>] kmem_cache_free+0x121/0x1d6
[   42.591252]  [<ffffffff8107a5af>] slab_destroy+0x93/0x9c
[   42.607433]  [<ffffffff8107a6a0>] free_block+0xe8/0x133
[   42.623354]  [<ffffffff8107a934>] __drain_alien_cache+0x5a/0x75
[   42.641351]  [<ffffffff8107aa89>] kfree+0x13a/0x1da
[   42.656234]  [<ffffffff816e0bda>] free+0x9/0xb
[   42.669680]  [<ffffffff816e0bf7>] huft_free+0x1b/0x27
[   42.684953]  [<ffffffff816e1db6>] inflate_dynamic+0x4e9/0x51d
[   42.702303]  [<ffffffff816e22b7>] unpack_to_rootfs+0x4cd/0x930
[   42.719912]  [<ffffffff816e277f>] populate_rootfs+0x65/0xe7
[   42.739520]  [<ffffffff81007133>] init+0xd2/0x317
[   42.753752]  [<ffffffff8100a80a>] child_rip+0x8/0x12
[   42.769328] DWARF2 unwinder stuck at child_rip+0x8/0x12
[   42.785096] Leftover inexact backtrace:
[   42.796710]  [<ffffffff81251118>] _spin_unlock_irq+0x2b/0x53
[   42.813799]  [<ffffffff81009e1b>] restore_args+0x0/0x30
[   42.829591]  [<ffffffff8113a581>] acpi_os_acquire_lock+0x9/0xb
[   42.847199]  [<ffffffff81007061>] init+0x0/0x317
[   42.861146]  [<ffffffff8100a802>] child_rip+0x0/0x12
[   42.876156] 
[   42.886463]  it is
[   42.922991] Freeing initrd memory: 862k freed


-- 
