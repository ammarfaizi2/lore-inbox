Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTBTLhO>; Thu, 20 Feb 2003 06:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbTBTLhO>; Thu, 20 Feb 2003 06:37:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11753 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265196AbTBTLhJ>;
	Thu, 20 Feb 2003 06:37:09 -0500
Date: Thu, 20 Feb 2003 12:46:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302192039400.1453-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201245100.10184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i think i managed to trigger a potentially useful oops, with BK-curr:

Unable to handle kernel paging request at virtual address 6b6b6b8b
 printing eip:
c011944b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c011944b>]    Not tainted
EFLAGS: 00010046
EIP is at do_page_fault+0x7b/0x4e4
eax: 6b6b6b8b   ebx: 6b6b6b6b   ecx: 0000002b   edx: c02dd6ac
esi: 6b6b6b8b   edi: ca095320   ebp: ca092170   esp: ca0920c8
ds: 007b   es: 007b   ss: 0068
Process start-threads (pid: 21685, threadinfo=ca090000 task=ca094ce0)
Stack: c02dd6ac 0000002b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b8b 6b6b6b6b 6b6b6b6b
       6b6b6b6b 00030001 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b
       6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b 6b6b6b6b
Call Trace:

 [tons of pagefault recursion]

 [<c01193d0>] do_page_fault+0x0/0x4e4
 [<c010a691>] error_code+0x2d/0x38
 [<c011944b>] do_page_fault+0x7b/0x4e4
 [<c01193d0>] do_page_fault+0x0/0x4e4
 [<c010a691>] error_code+0x2d/0x38
 [<c011944b>] do_page_fault+0x7b/0x4e4
 [<c01294f8>] do_timer+0xc8/0xd0
 [<c013330c>] rcu_process_callbacks+0x17c/0x1b0
 [<c011b4bf>] scheduler_tick+0x3ff/0x410
 [<c0125113>] tasklet_action+0x73/0xc0
 [<c01193d0>] do_page_fault+0x0/0x4e4
 [<c010a691>] error_code+0x2d/0x38
 [<c011b598>] schedule+0xb8/0x3d0
 [<c01219fd>] release_task+0x17d/0x200
 [<c011e70f>] mmput+0x1f/0xc0
 [<c0122cad>] do_exit+0x31d/0x3b0
 [<c010b328>] do_nmi+0x58/0x60
 [<c012a93e>] __dequeue_signal+0x6e/0xb0
 [<c0122ef0>] do_group_exit+0x110/0x140
 [<c012a9ae>] dequeue_signal+0x2e/0x60
 [<c012c2b1>] get_signal_to_deliver+0x2b1/0x440
 [<c01099a2>] do_signal+0xb2/0xf0
 [<c01296c4>] schedule_timeout+0x74/0xc0
 [<c012c4f9>] sigprocmask+0x89/0x140
 [<c0129640>] process_timeout+0x0/0x10
 [<c012c62d>] sys_rt_sigprocmask+0x7d/0x1a0
 [<c0129944>] sys_nanosleep+0x154/0x180
 [<c0109a3b>] do_notify_resume+0x5b/0x60
 [<c0109c72>] work_notifysig+0x13/0x15


