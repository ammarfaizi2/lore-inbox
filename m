Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267969AbUGaQfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267969AbUGaQfl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 12:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUGaQfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 12:35:41 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:19654 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267969AbUGaQfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 12:35:38 -0400
Date: Sat, 31 Jul 2004 12:39:15 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8-rc2-mm1
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0407311230330.4095@montezuma.fsmlabs.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo i believe you have a patch for this, could you push it to Andrew? I
reckon it's provoked by CONFIG_PREEMPT.

Unable to handle kernel paging request at virtual address dd27dfa0
 printing eip:
c01f1576
*pde = 00076067
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c01f1576>]    Not tainted VLI
EFLAGS: 00010246   (2.6.8-rc2-mm1)
EIP is at __journal_clean_checkpoint_list+0x136/0x1b0
eax: 00000000   ebx: de6e1a3c   ecx: dd27df78   edx: 04000000
esi: df6ea000   edi: de6e1a3c   ebp: df6ebdb0   esp: df6ebd8c
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 273, threadinfo=df6ea000 task=dfa8ba40)
Stack: df6ea000 de6e1a3c 0000007f dce48f78 d7afcf78 dd27df78 df6ea000 df639df8
       00000000 df6ebf50 c01ee617 df639df8 df639edc df639e8c 5a5a5a5a 5a5a5a5a
       d7afcfd0 5a5a5a5a d74d3fb0 df639e0c 00000000 00000000 00000000 00000000
Call Trace:
 [<c0108795>] show_stack+0x75/0x90
 [<c01088f5>] show_registers+0x125/0x190
 [<c0108aca>] die+0xda/0x1c0
 [<c011c4c8>] do_page_fault+0x1e8/0x565
 [<c01083ed>] error_code+0x2d/0x40
 [<c01ee617>] journal_commit_transaction+0x3c7/0x1c40
 [<c01f27d8>] kjournald+0x118/0x3d0
 [<c0105355>] kernel_thread_helper+0x5/0x10
Code: 63 8b 4d 08 8a 81 e4 00 00 00 84 c0 7f 4c 8b 45 08 86 90 e4 00 00 00
8b 55 dc 8b 4a 14 8b 42 08 49 a8 08 89 4a 14 75 2b 8b 4d f0 <8b> 59 28 85
db 74 06 8b 43 28 89 41 28 8b 45 08 8b 40 40 89 45

(gdb) list *__journal_clean_checkpoint_list+0x136
0xc01f1576 is in __journal_clean_checkpoint_list (fs/jbd/checkpoint.c:514).
509                             /*
510                              * We need to schedule away.  Rotate both this
511                              * transaction's buffer list and the checkpoint list to
512                              * try to avoid quadratic behaviour.
513                              */
514                             jh = transaction->t_checkpoint_list;
515                             if (jh)
516                                     transaction->t_checkpoint_list = jh->b_cpnext;
517
518                             transaction = journal->j_checkpoint_transactions;
