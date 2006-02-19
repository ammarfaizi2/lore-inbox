Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWBSUZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWBSUZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWBSUZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:25:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:42667 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751014AbWBSUZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:25:43 -0500
X-Authenticated: #20450766
Date: Sun, 19 Feb 2006 21:26:06 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [RT, OOPS] 2.6.15.3-rt16 + XFS on USB => OOPS
Message-ID: <Pine.LNX.4.60.0602192117530.3700@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Got the following Oops while trying to mount an XFS partition on a USB 
disk under 2.6.15.3-rt16:

SGI XFS with ACLs, no debug enabled
XFS mounting filesystem sda6
BUG: Unable to handle kernel NULL pointer dereference at virtual address 0000001c
 printing eip:
c013b58b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: xfs rfcomm l2cap bluetooth nfsd exportfs lockd nfs_acl sunrpc lp thermal fan processor ipt_MASQUERADE iptable_nat ip_nat i2c_dev iptable_filter ipt_state ip_tables ip_conntrack_ftp ip_conntrack tun ide_cd cdrom tulip snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via686a i2c_isa i2c_viapro usbhid usb_storage zd1211 uhci_hcd ehci_hcd usbcore parport_pc parport sd_mod scsi_mod button psmouse
CPU:    0
EIP:    0060:[<c013b58b>]    Not tainted VLI
EFLAGS: 00010292   (2.6.15.3-rt16) 
EIP is at atomic_dec_and_spin_lock+0x1b/0x80
eax: dd4c1bb0   ebx: dd4c1bb0   ecx: 00000246   edx: 00000001
esi: 00000008   edi: e105f94a   ebp: 00000200   esp: dd5d7af8
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process mount (pid: 3350, threadinfo=dd5d6000 task=dd4f8090 stack_left=6852 worst_left=-1)
Stack: 00000a00 00000a00 029e8f21 dd4c1afc 00000008 00000000 e105f94a dd4c1bb0 
       00000008 dd4c1afc 029e8f20 e10601ed dd4c1afc 00000246 000002d0 00000009 
       c0311a23 deff8844 dd5eaa00 deff8844 000002d0 00000009 c016605b dd5d7b60 
Call Trace:
 [<e105f94a>] pagebuf_rele+0x2a/0xb0 [xfs] (28)
 [<e10601ed>] pagebuf_iorequest+0x9d/0x160 [xfs] (20)
 [<c0311a23>] _spin_lock+0x23/0x50 (20)
 [<c016605b>] __kmalloc+0x8b/0x120 (24)
 [<e105f6fe>] pagebuf_associate_memory+0x6e/0x1a0 [xfs] (24)
 [<e1066768>] xfsbdstrat+0x38/0x50 [xfs] (24)
 [<e10430db>] xlog_bread+0xbb/0x120 [xfs] (12)
 [<e1044562>] xlog_find_zeroed+0x62/0x2d0 [xfs] (48)
 [<e1043b15>] xlog_find_head+0x25/0x4d0 [xfs] (68)
 [<c013b623>] _spin_lock_init+0x33/0x50 (36)
 [<e1043fe5>] xlog_find_tail+0x25/0x540 [xfs] (56)
 [<e105c7d9>] kmem_alloc+0x59/0xd0 [xfs] (12)
 [<c013b623>] _spin_lock_init+0x33/0x50 (24)
 [<e1048bd7>] xlog_recover+0x37/0x100 [xfs] (40)
 [<e103f624>] xfs_log_mount+0xa4/0x110 [xfs] (56)
 [<e104a551>] xfs_mountfs+0x7e1/0xf50 [xfs] (40)
 [<e1060f91>] .text.lock.xfs_buf+0x4b/0x7a [xfs] (68)
 [<e1049a90>] xfs_readsb+0x1a0/0x200 [xfs] (72)
 [<e103ad46>] xfs_ioinit+0x26/0x50 [xfs] (16)
 [<e105252f>] xfs_mount+0x36f/0x670 [xfs] (24)
 [<e1067cf4>] vfs_mount+0x34/0x40 [xfs] (44)
 [<e1067b0b>] linvfs_fill_super+0x9b/0x1f0 [xfs] (16)
 [<c02128a7>] snprintf+0x27/0x30 (28)
 [<c01a2022>] disk_name+0x62/0xb0 (20)
 [<c01715de>] sb_set_blocksize+0x2e/0x60 (32)
 [<c017111b>] get_sb_bdev+0xfb/0x140 (24)
 [<c0166000>] __kmalloc+0x30/0x120 (24)
 [<e1067c8f>] linvfs_get_sb+0x2f/0x60 [xfs] (44)
 [<e1067a70>] linvfs_fill_super+0x0/0x1f0 [xfs] (20)
 [<c017136f>] do_kern_mount+0x5f/0xf0 (4)
 [<c018890c>] do_new_mount+0x9c/0xe0 (36)
 [<c0188f0d>] do_mount+0x16d/0x1d0 (44)
 [<c0311f78>] lock_kernel+0x28/0x50 (68)
 [<c0311f78>] lock_kernel+0x28/0x50 (36)
 [<c01892df>] sys_mount+0x9f/0xe0 (24)
 [<c0103461>] syscall_call+0x7/0xb (44)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013eada>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x20)

------------------------------
| showing all locks held by: |  (mount/3350 [dd4f8090, 117]):
------------------------------

#001:             [d7874840] {(struct rw_semaphore *)(&s->s_umount)}
... acquired at:               alloc_super+0xe4/0x1f0

#002:             [c037a9c4] {kernel_sem.lock}
... acquired at:               __reacquire_kernel_lock+0x2d/0x70

Code: c0 0f 94 c0 83 c4 04 0f b6 c0 c3 90 8d 74 26 00 83 ec 18 89 74 24 10 89 5c 24 0c 89 7c 24 14 8b 74 24 20 8b 5c 24 1c 8b 7c 24 18 <83> 7e 14 01 75 3e 89 7c 24 04 89 34 24 e8 e3 3b 1d 00 ff 0b 0f 
 BUG: nonzero lock count 2 at exit time?
           mount: 3350 [dd4f8090, 117]
 [<c0136e78>] check_no_held_locks+0x388/0x390 (8)
 [<c011f69a>] do_exit+0x2aa/0x520 (40)
 [<c0103f4b>] die+0x18b/0x190 (40)
 [<c011cdf7>] printk+0x17/0x20 (48)
 [<c011627c>] do_page_fault+0x2cc/0x590 (12)
 [<c0115fb0>] do_page_fault+0x0/0x590 (84)
 [<c01036ff>] error_code+0x4f/0x54 (8)
 [<e105f94a>] pagebuf_rele+0x2a/0xb0 [xfs] (20)
 [<c013b58b>] atomic_dec_and_spin_lock+0x1b/0x80 (24)
 [<e105f94a>] pagebuf_rele+0x2a/0xb0 [xfs] (36)
 [<e10601ed>] pagebuf_iorequest+0x9d/0x160 [xfs] (20)
 [<c0311a23>] _spin_lock+0x23/0x50 (20)
 [<c016605b>] __kmalloc+0x8b/0x120 (24)
 [<e105f6fe>] pagebuf_associate_memory+0x6e/0x1a0 [xfs] (24)
 [<e1066768>] xfsbdstrat+0x38/0x50 [xfs] (24)
 [<e10430db>] xlog_bread+0xbb/0x120 [xfs] (12)
 [<e1044562>] xlog_find_zeroed+0x62/0x2d0 [xfs] (48)
 [<e1043b15>] xlog_find_head+0x25/0x4d0 [xfs] (68)
 [<c013b623>] _spin_lock_init+0x33/0x50 (36)
 [<e1043fe5>] xlog_find_tail+0x25/0x540 [xfs] (56)
 [<e105c7d9>] kmem_alloc+0x59/0xd0 [xfs] (12)
 [<c013b623>] _spin_lock_init+0x33/0x50 (24)
 [<e1048bd7>] xlog_recover+0x37/0x100 [xfs] (40)
 [<e103f624>] xfs_log_mount+0xa4/0x110 [xfs] (56)
 [<e104a551>] xfs_mountfs+0x7e1/0xf50 [xfs] (40)
 [<e1060f91>] .text.lock.xfs_buf+0x4b/0x7a [xfs] (68)
 [<e1049a90>] xfs_readsb+0x1a0/0x200 [xfs] (72)
 [<e103ad46>] xfs_ioinit+0x26/0x50 [xfs] (16)
 [<e105252f>] xfs_mount+0x36f/0x670 [xfs] (24)
 [<e1067cf4>] vfs_mount+0x34/0x40 [xfs] (44)
 [<e1067b0b>] linvfs_fill_super+0x9b/0x1f0 [xfs] (16)
 [<c02128a7>] snprintf+0x27/0x30 (28)
 [<c01a2022>] disk_name+0x62/0xb0 (20)
 [<c01715de>] sb_set_blocksize+0x2e/0x60 (32)
 [<c017111b>] get_sb_bdev+0xfb/0x140 (24)
 [<c0166000>] __kmalloc+0x30/0x120 (24)
 [<e1067c8f>] linvfs_get_sb+0x2f/0x60 [xfs] (44)
 [<e1067a70>] linvfs_fill_super+0x0/0x1f0 [xfs] (20)
 [<c017136f>] do_kern_mount+0x5f/0xf0 (4)
 [<c018890c>] do_new_mount+0x9c/0xe0 (36)
 [<c0188f0d>] do_mount+0x16d/0x1d0 (44)
 [<c0311f78>] lock_kernel+0x28/0x50 (68)
 [<c0311f78>] lock_kernel+0x28/0x50 (36)
 [<c01892df>] sys_mount+0x9f/0xe0 (24)
 [<c0103461>] syscall_call+0x7/0xb (44)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (mount/3350 [dd4f8090, 117]):
------------------------------

#001:             [d7874840] {(struct rw_semaphore *)(&s->s_umount)}
... acquired at:               alloc_super+0xe4/0x1f0

#002:             [c037a9c4] {kernel_sem.lock}
... acquired at:               __reacquire_kernel_lock+0x2d/0x70

BUG: mount/3350, lock held at task exit time!
 [d7874840] {(struct rw_semaphore *)(&s->s_umount)}
.. held by:             mount: 3350 [dd4f8090, 117]
... acquired at:               alloc_super+0xe4/0x1f0
BUG: mount/3350, BKL held at task exit time!
BKL acquired at: sys_mount+0x77/0xe0
 [c037a9c4] {kernel_sem.lock}
.. held by:             mount: 3350 [dd4f8090, 117]
... acquired at:               __reacquire_kernel_lock+0x2d/0x70
mount/3350[CPU#0]: BUG in ____up_mutex at kernel/rt.c:1593
 [<c011d864>] __WARN_ON+0x64/0xc0 (8)
 [<c013b2fc>] rt_up+0x33c/0x4f0 (48)
 [<c030e288>] __schedule+0x688/0x700 (24)
 [<c030e288>] __schedule+0x688/0x700 (20)
 [<c011f6ba>] do_exit+0x2ca/0x520 (8)
 [<c01362b6>] printk_lock+0x86/0xd0 (4)
 [<c013eb8a>] sub_preempt_count+0x1a/0x20 (16)
 [<c0311efd>] __reacquire_kernel_lock+0x2d/0x70 (20)
 [<c011f6ba>] do_exit+0x2ca/0x520 (32)
 [<c0103f4b>] die+0x18b/0x190 (40)
 [<c011cdf7>] printk+0x17/0x20 (48)
 [<c011627c>] do_page_fault+0x2cc/0x590 (12)
 [<c0115fb0>] do_page_fault+0x0/0x590 (84)
 [<c01036ff>] error_code+0x4f/0x54 (8)
 [<e105f94a>] pagebuf_rele+0x2a/0xb0 [xfs] (20)
 [<c013b58b>] atomic_dec_and_spin_lock+0x1b/0x80 (24)
 [<e105f94a>] pagebuf_rele+0x2a/0xb0 [xfs] (36)
 [<e10601ed>] pagebuf_iorequest+0x9d/0x160 [xfs] (20)
 [<c0311a23>] _spin_lock+0x23/0x50 (20)
 [<c016605b>] __kmalloc+0x8b/0x120 (24)
 [<e105f6fe>] pagebuf_associate_memory+0x6e/0x1a0 [xfs] (24)
 [<e1066768>] xfsbdstrat+0x38/0x50 [xfs] (24)
 [<e10430db>] xlog_bread+0xbb/0x120 [xfs] (12)
 [<e1044562>] xlog_find_zeroed+0x62/0x2d0 [xfs] (48)
 [<e1043b15>] xlog_find_head+0x25/0x4d0 [xfs] (68)
 [<c013b623>] _spin_lock_init+0x33/0x50 (36)
 [<e1043fe5>] xlog_find_tail+0x25/0x540 [xfs] (56)
 [<e105c7d9>] kmem_alloc+0x59/0xd0 [xfs] (12)
 [<c013b623>] _spin_lock_init+0x33/0x50 (24)
 [<e1048bd7>] xlog_recover+0x37/0x100 [xfs] (40)
 [<e103f624>] xfs_log_mount+0xa4/0x110 [xfs] (56)
 [<e104a551>] xfs_mountfs+0x7e1/0xf50 [xfs] (40)
 [<e1060f91>] .text.lock.xfs_buf+0x4b/0x7a [xfs] (68)
 [<e1049a90>] xfs_readsb+0x1a0/0x200 [xfs] (72)
 [<e103ad46>] xfs_ioinit+0x26/0x50 [xfs] (16)
 [<e105252f>] xfs_mount+0x36f/0x670 [xfs] (24)
 [<e1067cf4>] vfs_mount+0x34/0x40 [xfs] (44)
 [<e1067b0b>] linvfs_fill_super+0x9b/0x1f0 [xfs] (16)
 [<c02128a7>] snprintf+0x27/0x30 (28)
 [<c01a2022>] disk_name+0x62/0xb0 (20)
 [<c01715de>] sb_set_blocksize+0x2e/0x60 (32)
 [<c017111b>] get_sb_bdev+0xfb/0x140 (24)
 [<c0166000>] __kmalloc+0x30/0x120 (24)
 [<e1067c8f>] linvfs_get_sb+0x2f/0x60 [xfs] (44)
 [<e1067a70>] linvfs_fill_super+0x0/0x1f0 [xfs] (20)
 [<c017136f>] do_kern_mount+0x5f/0xf0 (4)
 [<c018890c>] do_new_mount+0x9c/0xe0 (36)
 [<c0188f0d>] do_mount+0x16d/0x1d0 (44)
 [<c0311f78>] lock_kernel+0x28/0x50 (68)
 [<c0311f78>] lock_kernel+0x28/0x50 (36)
 [<c01892df>] sys_mount+0x9f/0xe0 (24)
 [<c0103461>] syscall_call+0x7/0xb (44)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c013eada>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x20)
.. [<c013afeb>] .... rt_up+0x2b/0x4f0
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x20)
.. [<c013eada>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x20)
.. [<c013eada>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x20)

Thanks
Guennadi
---
Guennadi Liakhovetski
