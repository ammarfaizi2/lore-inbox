Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318894AbSIIS7i>; Mon, 9 Sep 2002 14:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318895AbSIIS7i>; Mon, 9 Sep 2002 14:59:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37015 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318894AbSIIS7e>;
	Mon, 9 Sep 2002 14:59:34 -0400
Date: Mon, 9 Sep 2002 21:08:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <Pine.LNX.4.33.0209091154270.14841-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209092104450.1338-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Linus Torvalds wrote:

> >  >>EIP; c0106c57 <__down_trylock+a7/b4>   <=====
> 
> Are you sure your system.map is correct? __down_trylock() should _not_ be 
> that big - it's just 67 bytes for me (and apparently almost three times 
> the size for you). Spinlock debugging or something?

i have spinlock debugging enabled - but indeed the trace could be
incorrect, let me re-check it.

doh, wrong script called ... the right backtrace is:

 >>EIP; c0106c57 <__write_lock_failed+7/20>   <=====
 Trace; c0120316 <.text.lock.exit+119/133>
 Trace; c01088c8 <common_interrupt+18/20>
 Trace; c011ef16 <exit_notify+16/230>
 Trace; c011f41a <do_exit+2ea/370>
 Trace; c0125755 <schedule_timeout+b5/c0>
 Trace; c0126686 <sig_exit+36/40>
 Trace; c0127c54 <get_signal_to_deliver+2d4/360>
 Trace; c0107cf3 <do_signal+c3/100>
 Trace; c012d572 <sys_futex+182/1b0>
 Trace; c0107fce <work_notifysig+13/15>

(we definitely need kksymoops in the 2.5 kernel - it's just *so* much
easier to debug various crashes with kksymoops enabled - especially when
debugging over a serial line.)

and this lockup definitely looks related to the signal changes.

	Ingo

