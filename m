Return-Path: <linux-kernel-owner+w=401wt.eu-S965322AbXAKHiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322AbXAKHiu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbXAKHiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:38:50 -0500
Received: from digital.ist.utl.pt ([193.136.198.171]:49201 "EHLO
	digital.ist.utl.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965322AbXAKHit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:38:49 -0500
X-Greylist: delayed 1697 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 02:38:48 EST
Date: Thu, 11 Jan 2007 07:10:29 +0000 (WET)
From: Rui Saraiva <rmps@digital.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc4-git4, V4L - possible circular locking dependency detected
Message-ID: <Pine.LNX.4.64.0701110706220.4012@digital.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I run tvtime (or any other v4l userland application) I got this.

Best regards.

---

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.20-rc4-git4 #1
-------------------------------------------------------
tvtime/1356 is trying to acquire lock:
  (&mm->mmap_sem){----}, at: [<f1065234>] videobuf_dma_init_user+0xa4/0x140 
[video_buf]

but task is already holding lock:
  (&q->lock#2){--..}, at: [<f1066079>] videobuf_qbuf+0x29/0x2d0 [video_buf]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&q->lock#2){--..}:
        [<c0134016>] check_prev_add+0x166/0x230
        [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
        [<c0134166>] check_prevs_add+0x86/0x110
        [<c0135a78>] __lock_acquire+0x3c8/0xaa0
        [<c0145a44>] find_get_page+0x14/0x50
        [<c0135d7c>] __lock_acquire+0x6cc/0xaa0
        [<c015fb88>] poison_obj+0x28/0x50
        [<c0161d65>] kfree+0x95/0xc0
        [<c01367a4>] lock_acquire+0x74/0xa0
        [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
        [<c030f90f>] __mutex_lock_slowpath+0x6f/0x290
        [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
        [<c015fb88>] poison_obj+0x28/0x50
        [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
        [<c013500b>] trace_hardirqs_on+0xbb/0x160
        [<f109c793>] bttv_mmap+0x23/0x90 [bttv]
        [<c0161950>] kmem_cache_zalloc+0x90/0x100
        [<c0154f47>] do_mmap_pgoff+0x387/0x790
        [<c0154f47>] do_mmap_pgoff+0x387/0x790
        [<c0154fe5>] do_mmap_pgoff+0x425/0x790
        [<c0107ba3>] sys_mmap2+0x73/0xa0
        [<c0103130>] syscall_call+0x7/0xb
        [<ffffffff>] 0xffffffff

-> #0 (&mm->mmap_sem){----}:
        [<c0134166>] check_prevs_add+0x86/0x110
        [<c030f9e2>] __mutex_lock_slowpath+0x142/0x290
        [<c0135d7c>] __lock_acquire+0x6cc/0xaa0
        [<c01367a4>] lock_acquire+0x74/0xa0
        [<f1065234>] videobuf_dma_init_user+0xa4/0x140 [video_buf]
        [<c013145d>] down_read+0x3d/0x50
        [<f1065234>] videobuf_dma_init_user+0xa4/0x140 [video_buf]
        [<f1065234>] videobuf_dma_init_user+0xa4/0x140 [video_buf]
        [<c030f9e2>] __mutex_lock_slowpath+0x142/0x290
        [<c030f9e2>] __mutex_lock_slowpath+0x142/0x290
        [<f1065903>] videobuf_iolock+0x73/0xc0 [video_buf]
        [<c030f9ed>] __mutex_lock_slowpath+0x14d/0x290
        [<f1099715>] bttv_prepare_buffer+0x165/0x1b0 [bttv]
        [<f109980d>] buffer_prepare+0x3d/0x50 [bttv]
        [<f10661ed>] videobuf_qbuf+0x19d/0x2d0 [video_buf]
        [<f109a958>] bttv_try_fmt+0x138/0x160 [bttv]
        [<f109bfcd>] bttv_do_ioctl+0x14dd/0x1600 [bttv]
        [<c0203bb6>] __delay+0x6/0x10
        [<c02b34df>] sclhi+0x4f/0x80
        [<c0135a78>] __lock_acquire+0x3c8/0xaa0
        [<c02b1b86>] i2c_transfer+0x36/0x70
        [<c0203bb6>] __delay+0x6/0x10
        [<c02b36f8>] i2c_outb+0xe8/0x1b0
        [<c0203bb6>] __delay+0x6/0x10
        [<c02b34df>] sclhi+0x4f/0x80
        [<c02b3b83>] try_address+0x33/0xd0
        [<c0203bb6>] __delay+0x6/0x10
        [<c02b36f8>] i2c_outb+0xe8/0x1b0
        [<c0310166>] __mutex_unlock_slowpath+0x96/0x160
        [<c0134f0f>] mark_held_locks+0x6f/0x90
        [<c0310166>] __mutex_unlock_slowpath+0x96/0x160
        [<c0310166>] __mutex_unlock_slowpath+0x96/0x160
        [<c013500b>] trace_hardirqs_on+0xbb/0x160
        [<c02b1b9b>] i2c_transfer+0x4b/0x70
        [<c02b1bfa>] i2c_master_send+0x3a/0x50
        [<c0130004>] check_process_timers+0x1c4/0x560
        [<f10cba2d>] default_set_tv_freq+0x38d/0xb40 [tuner]
        [<c0135a78>] __lock_acquire+0x3c8/0xaa0
        [<c012bddc>] __kernel_text_address+0x1c/0x30
        [<c0103d4a>] dump_trace+0x5a/0xa0
        [<c010985c>] save_stack_trace+0x1c/0x30
        [<c0133040>] save_trace+0x40/0xa0
        [<c01335ca>] add_lock_to_list+0x2a/0x60
        [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
        [<c0134055>] check_prev_add+0x1a5/0x230
        [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
        [<c0135a78>] __lock_acquire+0x3c8/0xaa0
        [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
        [<c015fb88>] poison_obj+0x28/0x50
        [<f103c33f>] video_usercopy+0xdf/0x200 [videodev]
        [<c03111a4>] _spin_unlock+0x14/0x20
        [<c01543ee>] vma_link+0xae/0xf0
        [<c01550ca>] do_mmap_pgoff+0x50a/0x790
        [<f109c0f0>] bttv_ioctl+0x0/0x70 [bttv]
        [<f109c121>] bttv_ioctl+0x31/0x70 [bttv]
        [<f109aaf0>] bttv_do_ioctl+0x0/0x1600 [bttv]
        [<c0170180>] do_ioctl+0x50/0x80
        [<c01702de>] vfs_ioctl+0x5e/0x1c0
        [<c017047d>] sys_ioctl+0x3d/0x70
        [<c0103130>] syscall_call+0x7/0xb
        [<ffffffff>] 0xffffffff

other info that might help us debug this:

1 lock held by tvtime/1356:
  #0:  (&q->lock#2){--..}, at: [<f1066079>] videobuf_qbuf+0x29/0x2d0 
[video_buf]

stack backtrace:
  [<c01337fa>] print_circular_bug_tail+0x7a/0x80
  [<c0134166>] check_prevs_add+0x86/0x110
  [<c030f9e2>] __mutex_lock_slowpath+0x142/0x290
  [<c0135d7c>] __lock_acquire+0x6cc/0xaa0
  [<c01367a4>] lock_acquire+0x74/0xa0
  [<f1065234>] videobuf_dma_init_user+0xa4/0x140 [video_buf]
  [<c013145d>] down_read+0x3d/0x50
  [<f1065234>] videobuf_dma_init_user+0xa4/0x140 [video_buf]
  [<f1065234>] videobuf_dma_init_user+0xa4/0x140 [video_buf]
  [<c030f9e2>] __mutex_lock_slowpath+0x142/0x290
  [<c030f9e2>] __mutex_lock_slowpath+0x142/0x290
  [<f1065903>] videobuf_iolock+0x73/0xc0 [video_buf]
  [<c030f9ed>] __mutex_lock_slowpath+0x14d/0x290
  [<f1099715>] bttv_prepare_buffer+0x165/0x1b0 [bttv]
  [<f109980d>] buffer_prepare+0x3d/0x50 [bttv]
  [<f10661ed>] videobuf_qbuf+0x19d/0x2d0 [video_buf]
  [<f109a958>] bttv_try_fmt+0x138/0x160 [bttv]
  [<f109bfcd>] bttv_do_ioctl+0x14dd/0x1600 [bttv]
  [<c0203bb6>] __delay+0x6/0x10
  [<c02b34df>] sclhi+0x4f/0x80
  [<c0135a78>] __lock_acquire+0x3c8/0xaa0
  [<c02b1b86>] i2c_transfer+0x36/0x70
  [<c0203bb6>] __delay+0x6/0x10
  [<c02b36f8>] i2c_outb+0xe8/0x1b0
  [<c0203bb6>] __delay+0x6/0x10
  [<c02b34df>] sclhi+0x4f/0x80
  [<c02b3b83>] try_address+0x33/0xd0
  [<c0203bb6>] __delay+0x6/0x10
  [<c02b36f8>] i2c_outb+0xe8/0x1b0
  [<c0310166>] __mutex_unlock_slowpath+0x96/0x160
  [<c0134f0f>] mark_held_locks+0x6f/0x90
  [<c0310166>] __mutex_unlock_slowpath+0x96/0x160
  [<c0310166>] __mutex_unlock_slowpath+0x96/0x160
  [<c013500b>] trace_hardirqs_on+0xbb/0x160
  [<c02b1b9b>] i2c_transfer+0x4b/0x70
  [<c02b1bfa>] i2c_master_send+0x3a/0x50
  [<c0130004>] check_process_timers+0x1c4/0x560
  [<f10cba2d>] default_set_tv_freq+0x38d/0xb40 [tuner]
  [<c0135a78>] __lock_acquire+0x3c8/0xaa0
  [<c012bddc>] __kernel_text_address+0x1c/0x30
  [<c0103d4a>] dump_trace+0x5a/0xa0
  [<c010985c>] save_stack_trace+0x1c/0x30
  [<c0133040>] save_trace+0x40/0xa0
  [<c01335ca>] add_lock_to_list+0x2a/0x60
  [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
  [<c0134055>] check_prev_add+0x1a5/0x230
  [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
  [<c0135a78>] __lock_acquire+0x3c8/0xaa0
  [<f1067180>] videobuf_mmap_mapper+0x10/0x24e [video_buf]
  [<c015fb88>] poison_obj+0x28/0x50
  [<f103c33f>] video_usercopy+0xdf/0x200 [videodev]
  [<c03111a4>] _spin_unlock+0x14/0x20
  [<c01543ee>] vma_link+0xae/0xf0
  [<c01550ca>] do_mmap_pgoff+0x50a/0x790
  [<f109c0f0>] bttv_ioctl+0x0/0x70 [bttv]
  [<f109c121>] bttv_ioctl+0x31/0x70 [bttv]
  [<f109aaf0>] bttv_do_ioctl+0x0/0x1600 [bttv]
  [<c0170180>] do_ioctl+0x50/0x80
  [<c01702de>] vfs_ioctl+0x5e/0x1c0
  [<c017047d>] sys_ioctl+0x3d/0x70
  [<c0103130>] syscall_call+0x7/0xb
  =======================
