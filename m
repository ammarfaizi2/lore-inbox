Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262097AbSJAP6U>; Tue, 1 Oct 2002 11:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSJAP6U>; Tue, 1 Oct 2002 11:58:20 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:22498 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262097AbSJAP5a>;
	Tue, 1 Oct 2002 11:57:30 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Hugh Dickins <hugh@veritas.com>
Date: Tue, 1 Oct 2002 18:02:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 
Cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <35FD2132190@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Oct 02 at 14:09, Hugh Dickins wrote:
> Exemplary bug report!  Many thanks for taking so much trouble to
> reproduce the problem.  Patch below (against 2.5.39) should fix it:
> I'll send Linus and Andrew when I can get hold of a 2.5.40 tree.

You are my hero! It fixed dnetc client failing with SIGSEGV after call
to sys_mprotect(). 

Unfortunately it did not fixed another problem I have with sys_mprotect.
If I start X, system stops to do anything useful. After SAK I could
do remote connect and running 'w' and 'ps axf' moved them to 'D' state.
Clean sysrq-u,s,b was possible. 2.5.40 kernel plus Hugh's patch, 100%
reproducible with 2.5.40 SMP (non-preempt) kernel running on UP here...
                                    Thanks,
                                                Petr Vandrovec
                                                

Oct  1 17:47:35 vana kernel: SysRq : SAK
Oct  1 17:47:35 vana kernel: SAK: killed process 1482 (XFree86): fd#3 opened to the tty
...
Oct  1 17:47:55 vana kernel: XFree86       D DADE7A60     0  1482   1481                     (NOTLB)
Oct  1 17:47:55 vana kernel: Call Trace:
Oct  1 17:47:55 vana kernel:  [<c01167df>]schedule+0x3bb/0x488
Oct  1 17:47:55 vana kernel:  [<c019bdd5>]rwsem_down_read_failed+0x165/0x188
Oct  1 17:47:55 vana kernel:  [<c0114adb>].text.lock.fault+0x7/0x6c
Oct  1 17:47:55 vana kernel:  [<c01146b0>]do_page_fault+0x0/0x424
Oct  1 17:47:55 vana kernel:  [<c01323a2>]do_generic_file_read+0xee/0x35c
Oct  1 17:47:55 vana kernel:  [<c0132602>]do_generic_file_read+0x34e/0x35c
Oct  1 17:47:55 vana kernel:  [<c01328cb>]__generic_file_aio_read+0x187/0x1a0
Oct  1 17:47:55 vana kernel:  [<c0132610>]file_read_actor+0x0/0x134
Oct  1 17:47:55 vana kernel:  [<c01372bc>]free_block+0x168/0x250
Oct  1 17:47:55 vana kernel:  [<c0107ec9>]error_code+0x2d/0x38
Oct  1 17:47:55 vana kernel:  [<c011216f>]flush_tlb_mm+0x1b/0x70
Oct  1 17:47:55 vana kernel:  [<c0133ed1>]change_protection+0x1a1/0x1dc
Oct  1 17:47:55 vana kernel:  [<c01341ed>]mprotect_fixup+0x16d/0x188
Oct  1 17:47:55 vana kernel:  [<c0134392>]sys_mprotect+0x18a/0x2c4
Oct  1 17:47:55 vana kernel:  [<c0107467>]syscall_call+0x7/0xb
...
Oct  1 17:47:55 vana kernel: w             D DADE7A60     0  1563   1558                     (NOTLB)
Oct  1 17:47:55 vana kernel: Call Trace:
Oct  1 17:47:55 vana kernel:  [<c015be79>]dput+0x19/0x1d4
Oct  1 17:47:55 vana kernel:  [<c019bdd5>]rwsem_down_read_failed+0x165/0x188
Oct  1 17:47:55 vana kernel:  [<c016fecf>].text.lock.array+0x6d/0x10e
Oct  1 17:47:55 vana kernel:  [<c013b238>]__get_free_pages+0x28/0x60
Oct  1 17:47:55 vana kernel:  [<c016c807>]proc_info_read+0x4f/0x108
Oct  1 17:47:55 vana kernel:  [<c0146580>]vfs_read+0xb4/0x134
Oct  1 17:47:55 vana kernel:  [<c014676a>]sys_read+0x2a/0x3c
Oct  1 17:47:55 vana kernel:  [<c0107467>]syscall_call+0x7/0xb
...
Oct  1 17:47:55 vana kernel: ps            D DADE7A60     0  1583   1582                     (NOTLB)
Oct  1 17:47:55 vana kernel: Call Trace:
Oct  1 17:47:55 vana kernel:  [<c015be79>]dput+0x19/0x1d4
Oct  1 17:47:55 vana kernel:  [<c019bdd5>]rwsem_down_read_failed+0x165/0x188
Oct  1 17:47:55 vana kernel:  [<c016fecf>].text.lock.array+0x6d/0x10e
Oct  1 17:47:55 vana kernel:  [<c013b238>]__get_free_pages+0x28/0x60
Oct  1 17:47:55 vana kernel:  [<c016c807>]proc_info_read+0x4f/0x108
Oct  1 17:47:55 vana kernel:  [<c0146580>]vfs_read+0xb4/0x134
Oct  1 17:47:55 vana kernel:  [<c014676a>]sys_read+0x2a/0x3c
Oct  1 17:47:55 vana kernel:  [<c0107467>]syscall_call+0x7/0xb
