Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUBSSXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUBSSXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:23:40 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:54657 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267350AbUBSSXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:23:31 -0500
Date: Thu, 19 Feb 2004 19:23:29 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: proc_pid_stat crashes in 2.6.2 (was 2.6.0-test11: Crash in ps axH)
Message-ID: <20040219182329.GA10868@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I already reported this crash twice on 2.6.0-test11, and now I
reproduced it on something more fresh - on 2.6.2-bk-something like it
was actual on Feb 4. It is really annoying, as any user can do 'ps axH'
and crash system after some uptime :-( Crash is identical to one
I got with 2.6.0-test11, so it looks like that I'll have to go back
to 2.4.x on publicly accessible machines. After about 14 days uptime. 

  I've got no replies to previous reports.
  						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

Unable to handle kernel NULL pointer dereference at virtual address 00000df9
 printing eip:
c018ea16
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c018ea16>]    Not tainted
EFLAGS: 00010286
EIP is at proc_pid_stat+0xa6/0x510
eax: 000203ea   ebx: 00000d9d   ecx: d6662000   edx: edc1e4bc
esi: ed3c2ce0   edi: edc1e4bc   ebp: 00000000   esp: e6745e3c
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 19007, threadinfo=e6744000 task=ed3c3940)
Stack: edc1e4bc f3acf3a8 c0401150 ed3c2ce0 e81c74fc ed3c2ce0 0000001d c018c2fc
       ed3c2ce0 4034fdab 28e18b6e c0401150 f3acf42c c0401150 c0401150 c018c82e
       f3acf3a8 e81c74fc 0000001d 00000004 ed3c2ce0 ffffffea fffffff4 e81c76e0
Call Trace:
 [<c018c2fc>] proc_pid_make_inode+0x9c/0xd0
 [<c018c82e>] proc_pident_lookup+0xfe/0x260
 [<c016cf75>] real_lookup+0xd5/0x100
 [<c01433c4>] buffered_rmqueue+0xd4/0x180
 [<c0145e3b>] check_poison_obj+0x2b/0x1a0
 [<c015fc48>] get_empty_filp+0x68/0xe0
 [<c018b7d4>] proc_info_read+0x54/0x150
 [<c015df48>] filp_open+0x68/0x70
 [<c015ed78>] vfs_read+0xb8/0x130
 [<c015e3be>] sys_open+0x7e/0x90
 [<c015f022>] sys_read+0x42/0x70
 [<c010939f>] syscall_call+0x7/0xb
Code: 0f bf 43 5c 0f bf 5b 5e c1 e0 14 09 d8 8b 59 08 01 d8 89 c1

Linux usermap 2.6.2-c1549 #1 SMP Wed Feb 4 23:42:14 CET 2004 i686 GNU/Linux

----- Forwarded message from Petr Vandrovec <vandrove@vc.cvut.cz> -----

Date: Wed, 4 Feb 2004 18:07:48 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11: Crash in ps axH

Hi,
   maybe that this problem is already fixed in 2.6.2-rc3, but just
in case that somebody has a clue what's going on, after about
month of uptime, running couple of multithreaded apps on 2.6.0-test11
(of which slapd was running for this month without restart),
today I decided to use 'ps axH' to find what server is doing.

   In the middle of 'ps axH' output I was awarded by 'Segmentation
fault', and following oops appeared in kernel log. It died
in proc_pid_stat when doing tty_devnum(task->tty) because
task->tty->driver was 0x269BD005 (see %ebx). I'm not able to explain
what happened, but as it happened second time on this system, and
once on other one (also running 2.6.0-test11), there is certainly
something wrong... It may be also interesting that task->tty->pgrp was
0x4E70F005 (%eax), so it looks like that task->tty points just to
the garbage (task was 0xF7C12080 (%esi), and its address looks safe.
task->tty was 0xC82B2000 (%ecx), and it also looks like possible
value for tty).

   Kernel is SMP, PIII, non-preempt, with DEBUG_SLAB enabled, 4GB
config. Machine is dual PIII/933MHz, with 1.25GB of memory.

   I'm now building latest 2.6.2 from bk, but as it usually takes
about one month to get these oopses, it may take a while until
I can report success/failure. 
						Best regards,
							Petr Vandrovec

P.S.: Sorry, I noticed only after crash that Debian still does not
run klogd with -x, so numbers were converted to symbolics in the
trace.

Feb  4 17:18:06 usermap kernel: Unable to handle kernel paging request at virtual address 269bd061
Feb  4 17:18:06 usermap kernel:  printing eip:
Feb  4 17:18:06 usermap kernel: c018cbc6
Feb  4 17:18:06 usermap kernel: *pde = 00000000
Feb  4 17:18:06 usermap kernel: Oops: 0000 [#1]
Feb  4 17:18:06 usermap kernel: CPU:    1
Feb  4 17:18:06 usermap kernel: EIP:    0060:[proc_pid_stat+166/1296]    Not tainted
Feb  4 17:18:06 usermap kernel: EFLAGS: 00010286
Feb  4 17:18:06 usermap kernel: EIP is at proc_pid_stat+0xa6/0x510
Feb  4 17:18:06 usermap kernel: eax: 4e70f005   ebx: 269bd005   ecx: c82b2000   edx: db55f2a4
Feb  4 17:18:06 usermap kernel: esi: f7c12080   edi: db55f2a4   ebp: 00000000   esp: e82e7e3c
Feb  4 17:18:06 usermap kernel: ds: 007b   es: 007b   ss: 0068
Feb  4 17:18:06 usermap kernel: Process ps (pid: 6437, threadinfo=e82e6000 task=d72346b0)
Feb  4 17:18:06 usermap kernel: Stack: db55f2a4 c1cd3104 d26d729c c03fa790 f7c12080 db8194fc f7c12080 0000001d
Feb  4 17:18:06 usermap kernel:        c018a53c f7c12080 40211b3e 16ff7c54 c03fa790 d26d7320 c03fa790 c03fa790
Feb  4 17:18:06 usermap kernel:        c018aa6e d26d729c db8194fc 0000001d 00000004 f7c12080 ffffffea fffffff4
Feb  4 17:18:06 usermap kernel: Call Trace:
Feb  4 17:18:06 usermap kernel:  [proc_pid_make_inode+156/208] proc_pid_make_inode+0x9c/0xd0
Feb  4 17:18:06 usermap kernel:  [proc_pident_lookup+254/608] proc_pident_lookup+0xfe/0x260
Feb  4 17:18:06 usermap kernel:  [real_lookup+213/256] real_lookup+0xd5/0x100
Feb  4 17:18:06 usermap kernel:  [buffered_rmqueue+212/384] buffered_rmqueue+0xd4/0x180
Feb  4 17:18:06 usermap kernel:  [check_poison_obj+43/416] check_poison_obj+0x2b/0x1a0
Feb  4 17:18:06 usermap kernel:  [__alloc_pages+176/832] __alloc_pages+0xb0/0x340
Feb  4 17:18:06 usermap kernel:  [get_empty_filp+104/224] get_empty_filp+0x68/0xe0
Feb  4 17:18:06 usermap kernel:  [proc_info_read+84/336] proc_info_read+0x54/0x150
Feb  4 17:18:06 usermap kernel:  [filp_open+104/112] filp_open+0x68/0x70
Feb  4 17:18:06 usermap kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Feb  4 17:18:06 usermap kernel:  [sys_open+126/144] sys_open+0x7e/0x90
Feb  4 17:18:06 usermap kernel:  [sys_read+66/112] sys_read+0x42/0x70
Feb  4 17:18:06 usermap kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  4 17:18:06 usermap kernel:
Feb  4 17:18:06 usermap kernel: Code: 0f bf 43 5c 0f bf 5b 5e c1 e0 14 09 d8 8b 59 08 01 d8 89 c1


----- End forwarded message -----
