Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129760AbQK3EwA>; Wed, 29 Nov 2000 23:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129761AbQK3Evs>; Wed, 29 Nov 2000 23:51:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129933AbQK3Ev2>;
        Wed, 29 Nov 2000 23:51:28 -0500
Date: Wed, 29 Nov 2000 21:47:32 -0600
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:84!
Message-ID: <20001129214732.A2513@intolerance.digitalpassage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Stephen Crowley <stephenc@digitalpassage.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been noticing some nasty problems with 2.4.0-test11-pre7, constantly
getting out of memory problems running megahal ( a conversation generator),
I think it has a memory leak.. nothing else seems to cause this.

Nov 29 21:36:41 intolerance kernel: kernel BUG at page_alloc.c:84!
Nov 29 21:36:41 intolerance kernel: invalid operand: 0000
Nov 29 21:36:41 intolerance kernel: CPU:    0
Nov 29 21:36:41 intolerance kernel: EIP:    0010:[__free_pages_ok+73/824]
Nov 29 21:36:41 intolerance kernel: EFLAGS: 00010282
Nov 29 21:36:41 intolerance kernel: eax: 0000001f   ebx: c100c89c   ecx: c0257828   edx: 00000000
Nov 29 21:36:41 intolerance kernel: esi: 000003ce   edi: c8c22098   ebp: 00000000   esp: cd80de68
Nov 29 21:36:41 intolerance kernel: ds: 0018   es: 0018   ss: 0018
Nov 29 21:36:41 intolerance kernel: Process megahal (pid: 31863, stackpage=cd80d000)
Nov 29 21:36:41 intolerance kernel: Stack: c0211c72 c0211e60 00000054 c100c89c 000003ce c8c22098 ce67a0c8 c1044010 
Nov 29 21:36:41 intolerance kernel:        c02588e0 00000207 ffffffff 0000317e c012a847 c012ac7b 00400000 000003ce 
Nov 29 21:36:41 intolerance kernel:        c011fa5a c100c89c cabbdfa0 08050000 cec55960 024a3000 c8c22098 09800000 
Nov 29 21:36:41 intolerance kernel: Call Trace: [tvecs+8030/43772] [tvecs+8524/43772] [__free_pages+19/20] [free_page_and_swap_cache+131/136] [zap_page_range+374/504] [exit_mmap+201/288] [mmput+21/44] 
Nov 29 21:36:41 intolerance kernel:        [do_exit+165/508] [do_signal+544/636] [do_page_fault+0/988] [update_process_times+29/144] [update_wall_time+11/60] [timer_bh+36/604] [timer_interrupt+95/264] [bh_action+27/96] 
Nov 29 21:36:41 intolerance kernel:        [tasklet_hi_action+60/96] [do_softirq+63/100] [do_IRQ+161/176] [error_code+52/60] [signal_return+20/24] 
Nov 29 21:36:41 intolerance kernel: Code: 0f 0b 83 c4 0c 89 f6 89 d8 2b 05 38 c8 2b c0 69 c0 f1 f0 f0 

Does that backtrace provide anything useful?

-- 
Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
