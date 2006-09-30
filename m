Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWI3STt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWI3STt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWI3STt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 14:19:49 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:29071 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751359AbWI3STs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 14:19:48 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 30 Sep 2006 11:19:41 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Andrew Morton <akpm@osdl.org>
cc: petkov@math.uni-muenster.de, Borislav Petkov <bbpetkov@yahoo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-mm2 - possible recursive locking detected
In-Reply-To: <20060930012810.d79dc8e6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609301049320.14806@alien.or.mcafeemobile.com>
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060930070406.GA7090@gollum.tnic>
 <20060930012810.d79dc8e6.akpm@osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006, Andrew Morton wrote:

> On Sat, 30 Sep 2006 09:04:06 +0200
> Borislav Petkov <bbpetkov@yahoo.de> wrote:
> 
> > On Thu, Sep 28, 2006 at 01:46:23AM -0700, Andrew Morton wrote:
> > Hi,
> > 
> >     .config is at http://tim.dnsalias.org/2.6.18-mm2.cfg.
> > 
> > Sep 30 08:38:17 zmei kernel: [  285.197902] 
> > Sep 30 08:38:19 zmei kernel: [  285.197905] =============================================
> > Sep 30 08:38:19 zmei kernel: [  285.204776] [ INFO: possible recursive locking detected ]
> > Sep 30 08:38:19 zmei kernel: [  285.210163] 2.6.18-mm2 #1
> > Sep 30 08:38:19 zmei kernel: [  285.212782] ---------------------------------------------
> > Sep 30 08:38:19 zmei kernel: [  285.218168] swapper/0 is trying to acquire lock:
> > Sep 30 08:38:19 zmei kernel: [  285.222777]  (&q->lock){++..}, at: [<c0112f70>] __wake_up+0x15/0x3b
> > Sep 30 08:38:19 zmei kernel: [  285.229114] 
> > Sep 30 08:38:19 zmei kernel: [  285.229115] but task is already holding lock:
> > Sep 30 08:38:19 zmei kernel: [  285.234952]  (&q->lock){++..}, at: [<c0112f70>] __wake_up+0x15/0x3b
> > Sep 30 08:38:19 zmei kernel: [  285.241290] 
> > Sep 30 08:38:19 zmei kernel: [  285.241291] other info that might help us debug this:
> > Sep 30 08:38:19 zmei kernel: [  285.247817] 4 locks held by swapper/0:
> > Sep 30 08:38:19 zmei kernel: [  285.251561]  #0:  (&tp->rx_lock){-+..}, at: [<c020f350>] rtl8139_poll+0x42/0x405
> > Sep 30 08:38:19 zmei kernel: [  285.259041]  #1:  (slock-AF_INET/1){-+..}, at: [<c02aa753>] tcp_v4_rcv+0x3fa/0x8eb
> > Sep 30 08:38:19 zmei kernel: [  285.266700]  #2:  (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c0278d83>] sock_def_readable+0x15/0x69
> > Sep 30 08:38:19 zmei kernel: [  285.276454]  #3:  (&q->lock){++..}, at: [<c0112f70>] __wake_up+0x15/0x3b
> > Sep 30 08:38:19 zmei kernel: [  285.283241] 
> > Sep 30 08:38:19 zmei kernel: [  285.283242] stack backtrace:
> > Sep 30 08:38:19 zmei kernel: [  285.287688]  [<c0103b65>] dump_trace+0x64/0x1cd
> > Sep 30 08:38:19 zmei kernel: [  285.292243]  [<c0103ce0>] show_trace_log_lvl+0x12/0x25
> > Sep 30 08:38:19 zmei kernel: [  285.297405]  [<c010431c>] show_trace+0xd/0x10
> > Sep 30 08:38:19 zmei kernel: [  285.301780]  [<c01043e4>] dump_stack+0x19/0x1b
> > Sep 30 08:38:19 zmei kernel: [  285.306250]  [<c013022d>] __lock_acquire+0x750/0x96c
> > Sep 30 08:38:19 zmei kernel: [  285.311304]  [<c013098c>] lock_acquire+0x4b/0x6b
> > Sep 30 08:38:19 zmei kernel: [  285.316005]  [<c02ca474>] _spin_lock_irqsave+0x2c/0x3c
> > Sep 30 08:38:19 zmei kernel: [  285.321233]  [<c0112f70>] __wake_up+0x15/0x3b
> > Sep 30 08:38:19 zmei kernel: [  285.325638]  [<c0178dd4>] ep_poll_safewake+0x91/0xc3
> > Sep 30 08:38:19 zmei kernel: [  285.330760]  [<c0179c69>] ep_poll_callback+0x83/0x8e
> > Sep 30 08:38:19 zmei kernel: [  285.335888]  [<c01122e5>] __wake_up_common+0x2f/0x53
> > Sep 30 08:38:19 zmei kernel: [  285.340898]  [<c0112f83>] __wake_up+0x28/0x3b
> > Sep 30 08:38:19 zmei kernel: [  285.345312]  [<c0278da8>] sock_def_readable+0x3a/0x69
> > Sep 30 08:38:20 zmei kernel: [  285.350778]  [<c02a1892>] tcp_data_queue+0x50f/0xa53
> > Sep 30 08:38:20 zmei kernel: [  285.356232]  [<c02a34c3>] tcp_rcv_established+0x5aa/0x64f
> > Sep 30 08:38:20 zmei kernel: [  285.362077]  [<c02a86f6>] tcp_v4_do_rcv+0x26/0x2f2
> > Sep 30 08:38:20 zmei kernel: [  285.367322]  [<c02aabd4>] tcp_v4_rcv+0x87b/0x8eb
> 
> <looks at ep_poll_safewake>
> 
> <falls out of chair>

Haha :)
I hope the comment describes the nastiness of the potential problems 
that can heppen when adding epoll descriptors inside epoll descriptors 
(non-trivial loops, looong chains, etc).



> We'll need to teach lockdep about that one, but I don't have a clue how.
> 
> Is it not vulnerable to ab/ba deadlocking?

The two locks are different. One looks the netcard ->poll one, and one is 
the epoll file ->poll one. I don't know lockdep, so I wouldn't know how to 
make it quite in this case (w/out losing the ability to detect other 
legitimate wait_queue_head_t-based x-locks).
Ingo?




- Davide


