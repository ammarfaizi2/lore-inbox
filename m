Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSIITw4>; Mon, 9 Sep 2002 15:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318809AbSIITwz>; Mon, 9 Sep 2002 15:52:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63131 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318806AbSIITwy>;
	Mon, 9 Sep 2002 15:52:54 -0400
Date: Mon, 9 Sep 2002 22:02:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <Pine.LNX.4.44.0209092117490.4363-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209092201220.13335-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the lockup, on both CPUs:

>>EIP; c01200b1 <zap_thread+21/16d>   <=====
Trace; c0120092 <zap_thread+2/16d>
Trace; c011f00c <exit_notify+10c/230>
Trace; c011f41a <do_exit+2ea/370>
Trace; c0125755 <schedule_timeout+b5/c0>
Trace; c0126686 <sig_exit+36/40>
Trace; c0127c54 <get_signal_to_deliver+2d4/360>
Trace; c0107cf3 <do_signal+c3/100>
Trace; c012d572 <sys_futex+182/1b0>
Trace; c0107fce <work_notifysig+13/15>

>>EIP; c0106c5f <__write_lock_failed+f/20>   <=====
Trace; c0120316 <.text.lock.exit+119/133>
Trace; c011ef16 <exit_notify+16/230>
Trace; c011f41a <do_exit+2ea/370>
Trace; c0125755 <schedule_timeout+b5/c0>
Trace; c0126686 <sig_exit+36/40>
Trace; c0127c54 <get_signal_to_deliver+2d4/360>
Trace; c0107cf3 <do_signal+c3/100>
Trace; c012d572 <sys_futex+182/1b0>
Trace; c0107fce <work_notifysig+13/15>

ie. either the 'zap_again' produces an infinite loop, or one of the lists 
became corrupted. I suspect the former.

	Ingo

