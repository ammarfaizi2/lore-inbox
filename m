Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTLSSai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 13:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTLSSai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 13:30:38 -0500
Received: from luna.pixar.com ([138.72.152.152]:36224 "EHLO luna.pixar.com")
	by vger.kernel.org with ESMTP id S263130AbTLSSab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 13:30:31 -0500
Date: Fri, 19 Dec 2003 10:30:29 -0800
From: Lars Damerow <lars@pixar.com>
To: linux-kernel@vger.kernel.org
Subject: help debugging kernel freeze w/sysrq-t traces?
Message-ID: <20031219183027.GA2198@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm experiencing system freezes on my machine, usually once or twice a day, and
have managed to capture SysRq-t traces for three of the freezes. When the
machine freezes, nothing is responsive (keyboard, mouse, network) except for
using the magic SysRq key. These captures come from a serial console.

Might someone be kind enough to help me trace down what's happening? I'd
appreciate any tips on the best way to use these traces.

Some pertinent information:

- the system is running Fedora Core 1
- kernel version: 2.4.22-1.2115.nptlsmp (stock Fedora Core 1 kernel)
- it's a dual-processor 2.0GHz Xeon machine with 2GB RAM
- all mounted filesystems are either NFS3 or ext3

I won't attach the full traces here, since they're pretty long, but they seem
to have some things in common; the current process is busy doing proc_lookup or
proc_get_inode calls.

Thanks for any help, and please CC me on responses as I'm not a member of the
list.

cheers,
lars damerow
pixar animation studios

------------------------------------
The highlights from the first trace:
------------------------------------

multiload-app R current   2520      1          2528  2518 (NOTLB)
Call Trace:   [<c017d8d7>] proc_lookup [kernel] 0xd7 (0xf51abe94)
[<c017b3e5>] proc_root_lookup [kernel] 0x25 (0xf51abec0)
[<c015f1dc>] real_lookup [kernel] 0xec (0xf51abed4)
[<c015f9c2>] link_path_walk [kernel] 0x612 (0xf51abef4)
[<c015fcf9>] path_lookup [kernel] 0x39 (0xf51abf30) [<c01602b0>] open_namei [kernel] 0x70 (0xf51abf40) [<c0151073>] filp_open [kernel] 0x43 (0xf51abf70)
[<c0151473>] sys_open [kernel] 0x53 (0xf51abfa8)
[<c0109f6f>] system_call [kernel] 0x33 (0xf51abfc0)

ahc_dv_0      S F7077F3C    16      1            17    10 (L-TLB)
Call Trace:   [<c011ec00>] recalc_task_prio [kernel] 0x90 (0xf7077f1c)
[<c0120605>] schedule [kernel] 0x385 (0xf7077f40)
[<f8816be2>] scsi_request_fn [scsi_mod] 0x1f2 (0xf7077f50)
[<c0108c7a>] __down_interruptible [kernel] 0x8a (0xf7077f90)
[<c0108d47>] __down_failed_interruptible [kernel] 0x7 (0xf7077fb8)

wait_on_irq, CPU 1:
irq:  1 [ 1 0 ]
bh:   1 [ 0 1 ]
Stack dumps:
CPU 0:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:   [<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad13c)
[<c01537a0>] end_buffer_io_sync [kernel] 0x0 (0xf51ad1bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad23c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad2bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad33c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad3bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad43c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad4bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad53c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad5bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad63c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad6bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad73c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad7bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad83c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad8bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad93c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ad9bc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ada3c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adabc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adb3c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adbbc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adc3c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adcbc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51add3c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51addbc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51ade3c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adebc)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adf3c)
[<c01545d0>] end_buffer_io_async [kernel] 0x0 (0xf51adfbc)


CPU 1:ec371e94 00000001 00000001 ffffffff 00000001 c010c7c8 c02a772a 00000001 
       00000004 c010b962 00000001 c284ca80 c01c7e0b 00000296 c284c540 00000080 
       c0460e60 c01c7dc0 00000080 00000001 c0130e2f 00000000 ec371eec ec371eec 
Call Trace:   [<c010c7c8>] wait_on_irq [kernel] 0xf8 (0xec371ea8)
[<c010b962>] __global_cli [kernel] 0x62 (0xec371eb8)
[<c01c7e0b>] rs_timer [kernel] 0x4b (0xec371ec4)
[<c01c7dc0>] rs_timer [kernel] 0x0 (0xec371ed8)
[<c0130e2f>] run_timer_list [kernel] 0x12f (0xec371ee4)
[<c012bf75>] bh_action [kernel] 0x55 (0xec371f04)
[<c012be17>] tasklet_hi_action [kernel] 0x67 (0xec371f0c)
[<c012bbd9>] do_softirq [kernel] 0xd9 (0xec371f20)
[<c010bd6b>] do_IRQ [kernel] 0xfb (0xec371f3c)
[<c010ec88>] call_do_IRQ [kernel] 0x5 (0xec371f60)
[<c0164972>] .text.lock.ioctl [kernel] 0x9 (0xec371f8c)
[<c0109f6f>] system_call [kernel] 0x33 (0xec371fc0)


[<f8836acb>] .text.lock.aic7xxx_osm [aic7xxx] 0x115 (0xf7077fc4)
[<f88319d0>] ahc_linux_dv_thread [aic7xxx] 0x0 (0xf7077fe4)
[<c010758d>] kernel_thread_helper [kernel] 0x5 (0xf7077ff0)

-------------------------------------
The highlights from the second trace:
-------------------------------------

multiload-app R current   2548      1          2564  2541 (NOTLB)
Call Trace:   [<c017d8d7>] proc_lookup [kernel] 0xd7 (0xf40e3e94)
[<c017b3e5>] proc_root_lookup [kernel] 0x25 (0xf40e3ec0)
[<c015f1dc>] real_lookup [kernel] 0xec (0xf40e3ed4)
[<c015f9c2>] link_path_walk [kernel] 0x612 (0xf40e3ef4)
[<c015fcf9>] path_lookup [kernel] 0x39 (0xf40e3f30)
[<c01602b0>] open_namei [kernel] 0x70 (0xf40e3f40)
[<c0151073>] filp_open [kernel] 0x43 (0xf40e3f70)
[<c0151473>] sys_open [kernel] 0x53 (0xf40e3fa8)
[<c0109f6f>] system_call [kernel] 0x33 (0xf40e3fc0)

------------------------------------
The highlights from the third trace:
------------------------------------

sendmail      R current   4802      1          4811  4780 (NOTLB)
Call Trace:   [<c017b1b1>] proc_get_inode [kernel] 0x41 (0xf6779e74)
[<c017d8d7>] proc_lookup [kernel] 0xd7 (0xf6779e94)
[<c017b3e5>] proc_root_lookup [kernel] 0x25 (0xf6779ec0)
[<c015f1dc>] real_lookup [kernel] 0xec (0xf6779ed4)
[<c015f9c2>] link_path_walk [kernel] 0x612 (0xf6779ef4)
[<c015fcf9>] path_lookup [kernel] 0x39 (0xf6779f30)
[<c01602b0>] open_namei [kernel] 0x70 (0xf6779f40)
[<c0151073>] filp_open [kernel] 0x43 (0xf6779f70)
[<c0151473>] sys_open [kernel] 0x53 (0xf6779fa8)
[<c0109f6f>] system_call [kernel] 0x33 (0xf6779fc0)

ahc_dv_1      S F7073F3C    17      1            18    16 (L-TLB)
Call Trace:   [<c011ec00>] recalc_task_prio [kernel] 0x90 (0xf7073f1c)
[<c0120605>] schedule [kernel] 0x385 (0xf7073f40)
[<c0108c7a>] __down_interruptible [kernel] 0x8a (0xf7073f90)
[<c0108d47>] __down_failed_interruptible [kernel] 0x7 (0xf7073fb8)
[<f8836acb>] .text.lock.aic7xxx_osm [aic7xxx] 0x115 (0xf7073fc4)
[<f88319d0>] ahc_linux_dv_thread [aic7xxx] 0x0 (0xf7073fe4)

wait_on_irq, CPU 1:
irq:  1 [ 1 0 ]
bh:   1 [ 0 1 ]
Stack dumps:
CPU 0:00000001 00000000 00000001 f677a71c f677a71c c04418e0 c03bdaa0 f7f9f800 
       00000001 f677a734 f677a734 00000000 f677a744 f677a744 f677a744 f677a74c 
       f677a74c f677a754 f677a754 00000000 c04418a0 f677a680 00000000 00000000 
Call Trace:   [<f8880b80>] ext3_file_inode_operations [ext3] 0x0 (0xf677a924)
[<f8880b20>] ext3_file_operations [ext3] 0x0 (0xf677a928)
[<f8880be0>] ext3_aops [ext3] 0x0 (0xf677a960)
[<f8880d20>] ext3_fast_symlink_inode_operations [ext3] 0x0 (0xf677ab24)
[<f8880b80>] ext3_file_inode_operations [ext3] 0x0 (0xf677ad24)
[<f8880b20>] ext3_file_operations [ext3] 0x0 (0xf677ad28)
[<f8880be0>] ext3_aops [ext3] 0x0 (0xf677ad60)


CPU 1:ef5e7db4 00000001 00000001 ffffffff 00000001 c010c7c8 c02a772a 00000001 
       00000004 c010b962 00000001 c284ca80 c01c7e0b 00000292 f6f07f40 00000080 
       c0460e60 c01c7dc0 00000080 00000001 c0130e2f 00000000 ef5e7e0c ef5e7e0c 
Call Trace:   [<c010c7c8>] wait_on_irq [kernel] 0xf8 (0xef5e7dc8)
[<c010b962>] __global_cli [kernel] 0x62 (0xef5e7dd8)
[<c01c7e0b>] rs_timer [kernel] 0x4b (0xef5e7de4)
[<c01c7dc0>] rs_timer [kernel] 0x0 (0xef5e7df8)
[<c0130e2f>] run_timer_list [kernel] 0x12f (0xef5e7e04)
[<c012bf75>] bh_action [kernel] 0x55 (0xef5e7e24)
[<c012be17>] tasklet_hi_action [kernel] 0x67 (0xef5e7e2c)
[<c012bbd9>] do_softirq [kernel] 0xd9 (0xef5e7e40)
[<c010bd6b>] do_IRQ [kernel] 0xfb (0xef5e7e5c)
[<c010ec88>] call_do_IRQ [kernel] 0x5 (0xef5e7e80)
[<c012299e>] .text.lock.sched [kernel] 0xa9 (0xef5e7eac)
[<c010bd6b>] do_IRQ [kernel] 0xfb (0xef5e7ec8)
[<c01549e2>] invalidate_inode_buffers [kernel] 0xd2 (0xef5e7f04)
[<c016bc5f>] invalidate_list [kernel] 0x3f (0xef5e7f20)
[<f8ac084c>] nfs_fs_type [nfs] 0x0 (0xef5e7f3c)
[<c016bd1d>] invalidate_inodes [kernel] 0x4d (0xef5e7f40)
[<f8ac0720>] nfs_sops [nfs] 0x0 (0xef5e7f60)
[<c0159482>] kill_super [kernel] 0xe2 (0xef5e7f64)
[<c016f1af>] sys_umount [kernel] 0x3f (0xef5e7f80)
[<c015159e>] filp_close [kernel] 0x8e (0xef5e7f94)
[<c016f227>] sys_oldumount [kernel] 0x17 (0xef5e7fb4)
[<c0109f6f>] system_call [kernel] 0x33 (0xef5e7fc0)


[<c010758d>] kernel_thread_helper [kernel] 0x5 (0xf7073ff0)

___________________________________________________________
lars damerow
button pusher
pixar animation studios
lars@pixar.com

END OF LINE.

