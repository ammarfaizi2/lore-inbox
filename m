Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbTA1ODC>; Tue, 28 Jan 2003 09:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTA1ODC>; Tue, 28 Jan 2003 09:03:02 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:48001 "EHLO
	humilis.humilis.net") by vger.kernel.org with ESMTP
	id <S265517AbTA1ODA>; Tue, 28 Jan 2003 09:03:00 -0500
Date: Tue, 28 Jan 2003 15:12:19 +0100
From: Ookhoi <ookhoi@humilis.net>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: 2.5.59 oops with modprobe lp
Message-ID: <20030128151219.A953@humilis>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Uptime: 12:08:18 up 10 min, 14 users,  load average: 0.47, 0.39, 0.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just booted my fresh compiled 2.5.59 (patched with reiser4 and kexec),
and did a 'modprobe lp'. It segfaulted. lsmod hangs.

gcc (GCC) 3.2.2 20030124 (Debian prerelease)

module-init-tools version 0.9.9-pre


Unable to handle kernel paging request at virtual address 30cb40c0
 printing eip:
c012c3b8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c012c3b8>]    Not tainted
EFLAGS: 00010097
EIP is at __find_symbol+0x38/0x70
eax: 00000001   ebx: c0309a8b   ecx: c03ce300   edx: 00000000
esi: 30cb40c0   edi: e098d118   ebp: 000005ec   esp: dd081ec8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 210, threadinfo=dd080000 task=dd274d20)
Stack: dd080000 e098d118 e098d9e0 e097f3b8 c012ccbd e098d118 dd081ee8 00000001
       00000013 e098b9f8 000000cb 00000116 c012cf1e e097f3b8 00000013 e098bea8
       e098d118 e098d9e0 00000000 e098bea8 e0979000 e097f3b8 00000007 00000348
Call Trace:
 [<c012ccbd>] resolve_symbol+0x2d/0x80
 [<c012cf1e>] simplify_symbols+0xae/0x110
 [<c012d681>] load_module+0x461/0x880
 [<c01110c6>] do_timer_interrupt+0xd6/0xf0
 [<c012db09>] sys_init_module+0x69/0x1d0
 [<c010ae47>] syscall_call+0x7/0xb

Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 16
 <6>note: modprobe[210] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c01191a9>] schedule+0x319/0x320
 [<c013cbbe>] cond_resched_lock+0x1e/0x30
 [<c013ae1a>] unmap_vmas+0x15a/0x250
 [<c013e9f9>] exit_mmap+0x69/0x180
 [<c011abb4>] mmput+0x54/0xa0
 [<c011e1e3>] do_exit+0x103/0x2d0
 [<c010c321>] die+0x71/0x80
 [<c0117a8d>] do_page_fault+0x12d/0x459
 [<c018bee9>] reiserfs_dirty_inode+0x59/0x80
 [<c018bef1>] reiserfs_dirty_inode+0x61/0x80
 [<c012372a>] update_process_times+0x2a/0x30
 [<c0117960>] do_page_fault+0x0/0x459
 [<c010be0d>] error_code+0x2d/0x40
 [<c012c3b8>] __find_symbol+0x38/0x70
 [<c012ccbd>] resolve_symbol+0x2d/0x80
 [<c012cf1e>] simplify_symbols+0xae/0x110
 [<c012d681>] load_module+0x461/0x880
 [<c01110c6>] do_timer_interrupt+0xd6/0xf0
 [<c012db09>] sys_init_module+0x69/0x1d0
 [<c010ae47>] syscall_call+0x7/0xb


Can I provide more info?
