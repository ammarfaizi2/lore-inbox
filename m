Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTJSVI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTJSVI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:08:29 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:60846 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262240AbTJSVIU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:08:20 -0400
Date: Sun, 19 Oct 2003 23:07:51 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproduceable oops in -test8
Message-Id: <20031019230751.5434e3fb.aradorlinux@yahoo.es>
In-Reply-To: <20031019191346.GB1108@holomorphy.com>
References: <20031018234848.51a2b723.aradorlinux@yahoo.es>
	<20031019011949.GD711@holomorphy.com>
	<20031019165914.4360b3b7.aradorlinux@yahoo.es>
	<20031019191346.GB1108@holomorphy.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 19 Oct 2003 12:13:46 -0700 William Lee Irwin III <wli@holomorphy.com> escribió:

> You say the behavior of vanilla 2.6.0-test8 was the machine and/or process
> getting hung? And this is still happening even after the fixes?

Yes.

> 
> Thing is, it's working perfectly here, though I don't have a decent way
> to use totem. Could you send the results of sysrq t when it "hangs"?

Ok, I'll paste totem, esd, ps and xmms. xmms also hangs like totem; both of
them are trying to play through esd (which is blocked, too). This is
-test8-wli1 + fix.


Oct 19 22:52:12 estel kernel: totem         D 6EEAF49E     0   632      1   633           623 (NOTLB)
Oct 19 22:52:12 estel kernel: c63abe24 00000082 cb55c040 6eeaf49e 00000012 cd30f8e0 c5b2fd80 cd30f8e0 
Oct 19 22:52:12 estel kernel:        003a0022 00001000 00001000 003a0022 cffd2c80 6eeaf49e 00000012 cb55c040 
Oct 19 22:52:12 estel kernel:        cb55c060 c12c5c40 00027a6a 6eeaf49e 00000012 c63ab000 cf9d4520 00000282 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [__down+154/288] __down+0x9a/0x120
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Oct 19 22:52:12 estel kernel:  [.text.lock.pcm_oss+55/191] .text.lock.pcm_oss+0x37/0xbf
Oct 19 22:52:12 estel kernel:  [ext3_lookup+143/208] ext3_lookup+0x8f/0xd0
Oct 19 22:52:12 estel kernel:  [real_lookup+213/256] real_lookup+0xd5/0x100
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [cdev_get+83/176] cdev_get+0x53/0xb0
Oct 19 22:52:12 estel kernel:  [snd_pcm_oss_open+0/896] snd_pcm_oss_open+0x0/0x380
Oct 19 22:52:12 estel kernel:  [soundcore_open+366/896] soundcore_open+0x16e/0x380
Oct 19 22:52:12 estel kernel:  [chrdev_open+293/656] chrdev_open+0x125/0x290
Oct 19 22:52:12 estel kernel:  [dentry_open+352/560] dentry_open+0x160/0x230
Oct 19 22:52:12 estel kernel:  [filp_open+104/112] filp_open+0x68/0x70
Oct 19 22:52:12 estel kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: totem         S 00000001     8   633    632   634               (NOTLB)
Oct 19 22:52:12 estel kernel: c61f0f08 00000082 c12c5c40 00000001 00000003 00000000 c5b2fd80 00000000 
Oct 19 22:52:12 estel kernel:        c5986040 c030e680 00000010 c030f080 00000000 000000d0 c61f0000 c61f0f1c 
Oct 19 22:52:12 estel kernel:        00000246 c12c5c40 0000444b e0eab0cc 00000019 fffd3b2f c61f0f1c c61f0f60 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [schedule_timeout+108/192] schedule_timeout+0x6c/0xc0
Oct 19 22:52:12 estel kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
Oct 19 22:52:12 estel kernel:  [do_poll+168/208] do_poll+0xa8/0xd0
Oct 19 22:52:12 estel kernel:  [sys_poll+423/704] sys_poll+0x1a7/0x2c0
Oct 19 22:52:12 estel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: totem         S 00000001     0   634    633                     (NOTLB)
Oct 19 22:52:12 estel kernel: c6940ef8 00000082 c12cdc40 00000001 00000003 00000000 c5b2fd80 00000000 
Oct 19 22:52:12 estel kernel:        00000000 00000000 fffd2b89 00000000 c0137011 c6940edc c6940000 c6940f68 
Oct 19 22:52:12 estel kernel:        00000246 c12cdc40 000092c5 697794e8 00000019 c6940000 c6940f68 00000000 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [adjust_abs_time+193/304] adjust_abs_time+0xc1/0x130
Oct 19 22:52:12 estel kernel:  [do_clock_nanosleep+468/832] do_clock_nanosleep+0x1d4/0x340
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [nanosleep_wake_up+0/16] nanosleep_wake_up+0x0/0x10
Oct 19 22:52:12 estel kernel:  [sys_nanosleep+131/240] sys_nanosleep+0x83/0xf0
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


Oct 19 22:52:12 estel kernel: esd           D 00000001     0   565      1           567   563 (NOTLB)
Oct 19 22:52:12 estel kernel: cc97eecc 00000086 c12c5c40 00000001 00000003 bffe9000 cb565600 c014e403 
Oct 19 22:52:12 estel kernel:        c12c5020 c6d6e770 cb7d5bfc bffe8000 00001000 c12c5020 bffe8000 cb7d5c00 
Oct 19 22:52:12 estel kernel:        bffe9000 c12c5c40 0000404b b1c485e9 00000013 cc97e000 cf9d4520 00000286 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [zap_pmd_range+99/128] zap_pmd_range+0x63/0x80
Oct 19 22:52:12 estel kernel:  [__down+154/288] __down+0x9a/0x120
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
Oct 19 22:52:12 estel kernel:  [.text.lock.pcm_native+205/323] .text.lock.pcm_native+0xcd/0x143
Oct 19 22:52:12 estel kernel:  [__fput+267/288] __fput+0x10b/0x120
Oct 19 22:52:12 estel kernel:  [unmap_vma+117/128] unmap_vma+0x75/0x80
Oct 19 22:52:12 estel kernel:  [unmap_vma_list+31/48] unmap_vma_list+0x1f/0x30
Oct 19 22:52:12 estel kernel:  [do_munmap+375/480] do_munmap+0x177/0x1e0
Oct 19 22:52:12 estel kernel:  [sys_munmap+69/112] sys_munmap+0x45/0x70
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 


Oct 19 22:52:12 estel kernel: ps            D 00000001     0   644    618                     (NOTLB)
Oct 19 22:52:12 estel kernel: c8007e9c 00000082 c12c5c40 00000001 00000003 c01905ac c8003620 3f92f970 
Oct 19 22:52:12 estel kernel:        0b1ddd68 c0310650 c0310650 ce6bbb50 c02df6f8 c0190cae c5313200 ce6bbb50 
Oct 19 22:52:12 estel kernel:        0000000c c12c5c40 0023ad49 4334638e 00000017 cb565620 c7bba040 fffeffff 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [proc_pid_make_inode+156/208] proc_pid_make_inode
+0x9c/0xd0
Oct 19 22:52:12 estel kernel:  [proc_pident_lookup+254/608] proc_pident_lookup+0xfe/0x260
Oct 19 22:52:12 estel kernel:  [rwsem_down_read_failed+173/352] rwsem_down_read_failed+0xad/0x160
Oct 19 22:52:12 estel kernel:  [.text.lock.ptrace+27/85] .text.lock.ptrace+0x1b/0x55
Oct 19 22:52:12 estel kernel:  [proc_pid_cmdline+161/336] proc_pid_cmdline+0xa1/0x150
Oct 19 22:52:12 estel kernel:  [proc_info_read+84/336] proc_info_read+0x54/0x150
Oct 19 22:52:12 estel kernel:  [filp_open+104/112] filp_open+0x68/0x70
Oct 19 22:52:12 estel kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Oct 19 22:52:12 estel kernel:  [sys_read+66/112] sys_read+0x42/0x70
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb



Oct 19 22:52:12 estel kernel: xmms          S A9B901FF     0   623      1   624     632   617 (NOTLB)
Oct 19 22:52:12 estel kernel: cd632f8c 00200086 cdd21330 a9b901ff 00000015 00000000 cb565860 07fff250 
Oct 19 22:52:12 estel kernel:        00000000 00000004 00000000 00000001 07fff110 a9b901ff 00000015 cdd21330 
Oct 19 22:52:12 estel kernel:        cdd21350 c12cdc40 0000099b a9b933d6 00000015 00000000 cd632fc4 cd632000 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [sys_rt_sigsuspend+253/320] sys_rt_sigsuspend+0xfd/0x140
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: xmms          S 00000001     0   624    623   625               (NOTLB)
Oct 19 22:52:12 estel kernel: c7a47f08 00200086 c12cdc40 00000001 00000003 00000000 cb565860 00000000 
Oct 19 22:52:12 estel kernel:        cb55ace0 c030e680 00000010 c030f080 00000000 000000d0 c7a47000 c7a47f1c 
Oct 19 22:52:12 estel kernel:        00200246 c12cdc40 0000455e 87137494 00000019 fffd354b c7a47f1c c7a47f60 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [schedule_timeout+108/192] schedule_timeout+0x6c/0xc0
Oct 19 22:52:12 estel kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
Oct 19 22:52:12 estel kernel:  [do_poll+168/208] do_poll+0xa8/0xd0
Oct 19 22:52:12 estel kernel:  [sys_poll+423/704] sys_poll+0x1a7/0x2c0
Oct 19 22:52:12 estel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: xmms          S 00000001     0   625    624           626       (NOTLB)
Oct 19 22:52:12 estel kernel: c8adaeb0 00200086 c12c5c40 00000001 00000003 c0144110 cb565860 00000000 
Oct 19 22:52:12 estel kernel:        00000000 cdd21330 00000000 cb55a690 c030e680 00000010 c8ada000 c8adaec4 
Oct 19 22:52:12 estel kernel:        00200246 c12c5c40 0000027f 22546e4b 0000001a fffd380c c8adaec4 00000005 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [__alloc_pages+176/832] __alloc_pages+0xb0/0x340
Oct 19 22:52:12 estel kernel:  [schedule_timeout+108/192] schedule_timeout+0x6c/0xc0
Oct 19 22:52:12 estel kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
Oct 19 22:52:12 estel kernel:  [do_select+417/784] do_select+0x1a1/0x310
Oct 19 22:52:12 estel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Oct 19 22:52:12 estel kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: xmms          S F818322B     0   626    624           627   625 (NOTLB)
Oct 19 22:52:12 estel kernel: c8ad9ef8 00200086 cb55c040 f818322b 00000019 c010b2a8 cb565860 00000000 
Oct 19 22:52:12 estel kernel:        00000000 c011e1a0 fffd34e3 00000000 c0137011 f818322b 00000019 cb55c040 
Oct 19 22:52:12 estel kernel:        cb55c060 c12cdc40 00001d81 f818322b 00000019 c8ad9000 c8ad9f68 00000000 Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [do_nmi+88/96] do_nmi+0x58/0x60
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [adjust_abs_time+193/304] adjust_abs_time+0xc1/0x130
Oct 19 22:52:12 estel kernel:  [do_clock_nanosleep+468/832] do_clock_nanosleep+0x1d4/0x340
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
Oct 19 22:52:12 estel kernel:  [nanosleep_wake_up+0/16] nanosleep_wake_up+0x0/0x10
Oct 19 22:52:12 estel kernel:  [sys_nanosleep+131/240] sys_nanosleep+0x83/0xf0
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: xmms          Z 1E04D0BA     0   627    624           628   626 (L-TLB)
Oct 19 22:52:12 estel kernel: c7a49f84 00200046 cdd20040 1e04d0ba 00000011 c7a49f40 cb565860 00000020 
Oct 19 22:52:12 estel kernel:        00000000 00200086 00000273 cb55ace0 c034bf60 1e04d0ba 00000011 cdd20040 
Oct 19 22:52:12 estel kernel:        cdd20060 c12c5c40 000016e4 1e04e543 00000011 cffeeaa0 c7a49000 c9887330 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [do_exit+766/1264] do_exit+0x2fe/0x4f0
Oct 19 22:52:12 estel kernel:  [do_group_exit+62/256] do_group_exit+0x3e/0x100
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: xmms          Z 1E0397A7     0   628    624           629   627 (L-TLB)
Oct 19 22:52:12 estel kernel: c692ef84 00200046 c9887330 1e0397a7 00000011 c692ef40 cb565860 00000020 
Oct 19 22:52:12 estel kernel:        00000000 00000000 00000274 cb55ace0 c034bf60 1e0397a7 00000011 c9887330 
Oct 19 22:52:12 estel kernel:        c9887350 c12c5c40 0005152d 1e040053 00000011 cffeeaa0 c692e000 c9886ce0 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [do_exit+766/1264] do_exit+0x2fe/0x4f0
Oct 19 22:52:12 estel kernel:  [do_group_exit+62/256] do_group_exit+0x3e/0x100
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: xmms          S A9E63D61     0   629    624           630   628 (NOTLB)
Oct 19 22:52:12 estel kernel: c63aaf8c 00200086 cb55c040 a9e63d61 00000015 bffe6000 cb565860 bffe7000 
Oct 19 22:52:12 estel kernel:        c63aaf64 c7152310 cb565860 c0153c88 00200292 a9e63d61 00000015 cb55c040 
Oct 19 22:52:12 estel kernel:        cb55c060 c12c5c40 0000a96d a9e63d61 00000015 00000000 c63aafc4 c63aa000 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [unmap_vma+72/128] unmap_vma+0x48/0x80
Oct 19 22:52:12 estel kernel:  [sys_rt_sigsuspend+253/320] sys_rt_sigsuspend+0xfd/0x140
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 
Oct 19 22:52:12 estel kernel: xmms          S AF5050EE     4   630    624                 629 (NOTLB)
Oct 19 22:52:12 estel kernel: c93ced6c 00200086 cb55c040 af5050ee 00000013 c030e680 cb565860 00000000 
Oct 19 22:52:12 estel kernel:        ffffffff 00000000 c9886040 c030e680 c14af330 af5050ee 00000013 cb55c040 
Oct 19 22:52:12 estel kernel:        cb55c060 c12cdc40 00004a0f af5050ee 00000013 c93ce000 7fffffff c93cedcc 
Oct 19 22:52:12 estel kernel: Call Trace:
Oct 19 22:52:12 estel kernel:  [schedule_timeout+190/192] schedule_timeout+0xbe/0xc0
Oct 19 22:52:12 estel kernel:  [sock_wait_for_wmem+189/224] sock_wait_for_wmem+0xbd/0xe0
Oct 19 22:52:12 estel kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct 19 22:52:12 estel kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
Oct 19 22:52:12 estel kernel:  [alloc_skb+71/240] alloc_skb+0x47/0xf0
Oct 19 22:52:12 estel kernel:  [sock_alloc_send_pskb+146/480] sock_alloc_send_pskb+0x92/0x1e0
Oct 19 22:52:12 estel kernel:  [memcpy_fromiovec+99/176] memcpy_fromiovec+0x63/0xb0
Oct 19 22:52:12 estel kernel:  [sock_alloc_send_skb+45/64] sock_alloc_send_skb+0x2d/0x40
Oct 19 22:52:12 estel kernel:  [unix_stream_sendmsg+421/1136] unix_stream_sendmsg+0x1a5/0x470
Oct 19 22:52:12 estel kernel:  [recalc_task_prio+168/464] recalc_task_prio+0xa8/0x1d0
Oct 19 22:52:12 estel kernel:  [sock_aio_write+189/224] sock_aio_write+0xbd/0xe0
Oct 19 22:52:12 estel kernel:  [do_sync_write+137/192] do_sync_write+0x89/0xc0
Oct 19 22:52:12 estel kernel:  [do_clock_nanosleep+485/832] do_clock_nanosleep+0x1e5/0x340
Oct 19 22:52:12 estel kernel:  [schedule+113/1856] schedule+0x71/0x740
Oct 19 22:52:12 estel kernel:  [vfs_write+255/304] vfs_write+0xff/0x130
Oct 19 22:52:12 estel kernel:  [sys_write+66/112] sys_write+0x42/0x70
Oct 19 22:52:12 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 19 22:52:12 estel kernel: 

