Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWAaSDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWAaSDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAaSDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:03:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751315AbWAaSDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:03:20 -0500
Date: Tue, 31 Jan 2006 13:03:19 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.16rc1-git4 slab corruption.
Message-ID: <20060131180319.GA18948@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff80181cc0>](free_buffer_head+0x2a/0x43)

Call Trace: <ffffffff8017b4d0>{check_poison_obj+127}
       <ffffffff80181cea>{alloc_buffer_head+17} <ffffffff8017b638>{cache_alloc_debugcheck_after+48}
       <ffffffff8017b828>{kmem_cache_alloc+231} <ffffffff80181cea>{alloc_buffer_head+17}
       <ffffffff801824b1>{alloc_page_buffers+53} <ffffffff8018255c>{create_empty_buffers+20}
       <ffffffff801831c8>{__block_prepare_write+148} <ffffffff8807e5f4>{:ext3:ext3_get_block+0}
       <ffffffff8017b0cc>{poison_obj+38} <ffffffff8017b6f7>{cache_alloc_debugcheck_after+239}
       <ffffffff80183536>{block_prepare_write+26} <ffffffff8807fcd1>{:ext3:ext3_prepare_write+148}
       <ffffffff80340386>{_write_unlock_irq+9} <ffffffff8015e3b7>{generic_file_buffered_write+603}
       <ffffffff80137896>{current_fs_time+59} <ffffffff80137896>{current_fs_time+59}
       <ffffffff8015ea13>{__generic_file_aio_write_nolock+767}
       <ffffffff8015ee22>{generic_file_aio_write+78} <ffffffff80149d23>{debug_mutex_add_waiter+159}
       <ffffffff8033fb23>{__mutex_lock_slowpath+817} <ffffffff8015ee39>{generic_file_aio_write+101}
       <ffffffff8807be5e>{:ext3:ext3_file_write+22} <ffffffff8018054e>{do_sync_write+199}
       <ffffffff801464d6>{autoremove_wake_function+0} <ffffffff8015ae1f>{audit_syscall_entry+301}
       <ffffffff80180e48>{vfs_write+206} <ffffffff801813fa>{sys_write+69}
       <ffffffff8010aa78>{tracesys+209}
020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 01 00 00 00
Prev obj: start=ffff81000057a2f0, len=88
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<ffffffff80181cea>](alloc_buffer_head+0x11/0x36)
000: 23 40 00 00 00 00 00 00 f0 a2 57 00 00 81 ff ff
010: 80 6c 11 01 00 81 ff ff 01 00 00 00 00 10 00 00
Next obj: start=ffff81000057a3d0, len=88
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<ffffffff80181cc0>](free_buffer_head+0x2a/0x43)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

