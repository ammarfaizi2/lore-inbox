Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUAHRvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUAHRvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:51:18 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:36545 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265686AbUAHRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:50:47 -0500
Date: Thu, 08 Jan 2004 09:50:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Hang on boot 2.6.1-rc2
Message-ID: <65350000.1073584238@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this gets very wierd ... not sure if it's a kernel thing or a
userspace thing, but 2.5.59 boots fine, so ...

Booting gets to mounting the filesystems, then appears to hang.
Alt+sysrq+T shows the appended, but then the serial console goes
into a very wierd state where every time I press return, I get 
a few (10 or so) more characters of the bootup sequence. No idea
what the hell's going on ... (this is Debian sid, BTW).

kseriod       S 00000001     4    92      1            93    91 (L-TLB)
ef539fb0 00000046 c393abc0 00000001 0000000f c0129320 c02ce03c c02ce038 
       ef538000 c01217b2 c02ce03c c02ca950 00000008 c393abc0 16789040 25224d80 
       000f4203 ef5500a0 ef550268 ef538000 ffffe000 ef538000 ef539fc0 c0220906 
Call Trace:
 [<c0129320>] free_uid+0x20/0x70
 [<c01217b2>] reparent_to_init+0x102/0x180
 [<c0220906>] serio_thread+0x106/0x130
 [<c0108fd2>] ret_from_fork+0x6/0x14
 [<c011c360>] default_wake_function+0x0/0x20
 [<c0220800>] serio_thread+0x0/0x130
 [<c0106f39>] kernel_thread_helper+0x5/0xc

init          S EF4E3CB8  7408    93      1    94     163    92 (NOTLB)
ef4a5f3c 00000082 00000000 ef4e3cb8 ef4ecae0 ef4ecb00 ef4e3220 ef5506d0 
       c011901c ef4ecae0 ef4e3220 0804f568 f019f900 c3932bc0 00000000 487ac3c0 
       000f4203 ef5506d0 ef550898 fffffe00 ef5506d0 00000001 ef550778 c0123111 
Call Trace:
 [<c011901c>] do_page_fault+0x12c/0x595
 [<c0123111>] sys_wait4+0x1b1/0x280
 [<c011c360>] default_wake_function+0x0/0x20
 [<c011c360>] default_wake_function+0x0/0x20
 [<c0123205>] sys_waitpid+0x25/0x29
 [<c01090bf>] syscall_call+0x7/0xb

rcS           S 00000001  5488    94     93   202               (NOTLB)
ef493f3c 00000082 c3962bc0 00000001 000000f0 ef483d40 ef4e3d20 ef550d00 
       c011901c ef483d20 ef4e3d20 080e7390 00000001 c3962bc0 00000000 cbcd5ec0 
       000f420a ef550d00 ef550ec8 fffffe00 ef550d00 00000001 ef550da8 c0123111 
Call Trace:
 [<c011901c>] do_page_fault+0x12c/0x595
 [<c0123111>] sys_wait4+0x1b1/0x280
 [<c011c360>] default_wake_function+0x0/0x20
 [<c011c360>] default_wake_function+0x0/0x20
 [<c0123205>] sys_waitpid+0x25/0x29
 [<c01090bf>] syscall_call+0x7/0xb

kjournald     S 00000001     0   163      1           164    93 (L-TLB)
ef1ebf68 00000046 c394abc0 00000001 0000000f 3600000a 00000286 ffff4dbe 
       00000032 c01a1330 ef504258 ef504254 00000286 c394abc0 0510ff40 9041d700 
       000f420a dda200c0 dda20288 00000000 ef504200 00000001 ef50426c c01a1554 
Call Trace:
 [<c01a1330>] commit_timeout+0x0/0x10
 [<c01a1554>] kjournald+0x204/0x210
 [<c011e1d0>] autoremove_wake_function+0x0/0x50
 [<c01584b0>] end_buffer_async_read+0x0/0xe0
 [<c011e1d0>] autoremove_wake_function+0x0/0x50
 [<c0108fd2>] ret_from_fork+0x6/0x14
 [<c01a1350>] kjournald+0x0/0x210
 [<c01a1330>] commit_timeout+0x0/0x10
 [<c01a1350>] kjournald+0x0/0x210
 [<c0106f39>] kernel_thread_helper+0x5/0xc

kjournald     S EF28EA58     0   164      1           196   163 (L-TLB)
ef201f68 00000046 00000000 ef28ea58 00000001 ef201f48 c011c3ba dda206f0 
       00000003 00000000 ef28ea58 ef28ea54 dda206f0 c3932bc0 00000000 8d09dd80 
       000f420a dda20d20 dda20ee8 00000000 ef28ea00 00000001 ef28ea6c c01a1554 
Call Trace:
 [<c011c3ba>] __wake_up_common+0x3a/0x70
 [<c01a1554>] kjournald+0x204/0x210
 [<c011e1d0>] autoremove_wake_function+0x0/0x50
 [<c01584b0>] end_buffer_async_read+0x0/0xe0
 [<c011e1d0>] autoremove_wake_function+0x0/0x50
 [<c0108fd2>] ret_from_fork+0x6/0x14
 [<c01a1350>] kjournald+0x0/0x210
 [<c01a1330>] commit_timeout+0x0/0x10
 [<c01a1350>] kjournald+0x0/0x210
 [<c0106f39>] kernel_thread_helper+0x5/0xc

portmap       S 00000001     0   196      1                 164 (NOTLB)
e7fc7f08 00000086 c397abc0 00000001 00000f00 000000d0 ef1d5000 00000000 
       000000d0 00000246 ef5120c0 ef48bb10 ef5122a4 c397abc0 00000000 c8f0f2c0 
       000f420a ef551330 ef5514f8 00000000 7fffffff e7fc7f60 7fffffff c0128dee 
Call Trace:
 [<c0128dee>] schedule_timeout+0xbe/0xc0
 [<c0227229>] sock_poll+0x29/0x40
 [<c0169eeb>] do_pollfd+0x5b/0xa0
 [<c0169fd8>] do_poll+0xa8/0xd0
 [<c016a1a7>] sys_poll+0x1a7/0x2bd
 [<c0169480>] __pollwait+0x0/0xd0
 [<c01090bf>] syscall_call+0x7/0xb

rcS           S 00000001  6472   202     94   205               (NOTLB)
ef18ff3c 00000086 c39aabc0 00000001 0000f000 ef07dd20 ef0d5260 ef2d9980 
       c011901c ef07dd00 ef0d5260 08101fe8 00000001 c39aabc0 000f4240 d0cf1bc0 
       000f420a ef2d9980 ef2d9b48 fffffe00 ef2d9980 00000001 ef2d9a28 c0123111 
Call Trace:
 [<c011901c>] do_page_fault+0x12c/0x595
 [<c0123111>] sys_wait4+0x1b1/0x280
 [<c011c360>] default_wake_function+0x0/0x20
 [<c011c360>] default_wake_function+0x0/0x20
 [<c0123205>] sys_waitpid+0x25/0x29
 [<c01090bf>] syscall_call+0x7/0xb

consolechars  R 0804E1C0     0   205    202   206               (NOTLB)
0804e128 00000000 c0134558 0804e1c0 00000002 7fffffff 0000000a c013467b 
       0804e1c0 00000000 00000002 7fffffff 0804e128 00000000 c011635d 00000000 
       00000000 00000060 00000001 0804e1c0 00000000 0804e128 e90a6000 c01090bf 
Call Trace:
 [<c0134558>] do_futex+0x78/0x90
 [<c013467b>] sys_futex+0x10b/0x130
 [<c01090bf>] syscall_call+0x7/0xb

gunzip        Z 00000001  5780   206    205           207       (L-TLB)
dcd09f80 00000046 c3952bc0 00000001 000000f0 dcd0b940 f019f900 c012209a 
       dcd0b940 00000011 00000282 ef271480 dcd0b998 c3952bc0 00000000 d6d43f00 
       000f420a dcd0b940 dcd0bb08 00000000 00000000 dcd0b940 00000000 c012284d 
Call Trace:
 [<c012209a>] exit_notify+0x23a/0x7d0
 [<c012284d>] do_exit+0x21d/0x370
 [<c0122a72>] do_group_exit+0x42/0xc0
 [<c01090bf>] syscall_call+0x7/0xb

consolechars  Z DCD0B310  6776   207    205           208   206 (L-TLB)
dcd11f80 00000046 00000282 dcd0b310 c0309220 dccc52d0 f019f900 c012209a 
       dccc52d0 00000011 00000282 ef2710c0 dcd0b310 c3962bc0 00000000 d5290000 
       000f420a dccc52d0 dccc5498 00000000 00000000 dccc52d0 00000000 c012284d 
Call Trace:
 [<c012209a>] exit_notify+0x23a/0x7d0
 [<c012284d>] do_exit+0x21d/0x370
 [<c0122a72>] do_group_exit+0x42/0xc0
 [<c01090bf>] syscall_call+0x7/0xb

consolechars  S 00000001     0   208    205                 207 (NOTLB)
eb0fdeb4 00000082 c396abc0 00000001 000000f0 dcd08000 c3952bc0 00000012 
       00000010 00000086 dcd0b940 d6d43f00 000f420a c396abc0 00000000 d6d43f00 
       000f420a dccc4ca0 dccc4e68 ef4bcd2c ef4bccc0 eb0fdedc 00000200 c0162e8e 
Call Trace:
 [<c0162e8e>] pipe_wait+0x7e/0xa0
 [<c011e1d0>] autoremove_wake_function+0x0/0x50
 [<c0170ce9>] update_atime+0xd9/0xe0
 [<c011e1d0>] autoremove_wake_function+0x0/0x50
 [<c01633e4>] pipe_writev+0x204/0x380
 [<c0163598>] pipe_write+0x38/0x40
 [<c01568d8>] vfs_write+0xb8/0x130
 [<c0156a02>] sys_write+0x42/0x70
 [<c01090bf>] syscall_call+0x7/0xb

