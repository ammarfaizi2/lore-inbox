Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318830AbSIIUKg>; Mon, 9 Sep 2002 16:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSIIUKf>; Mon, 9 Sep 2002 16:10:35 -0400
Received: from crack.them.org ([65.125.64.184]:49425 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318830AbSIIUKf>;
	Mon, 9 Sep 2002 16:10:35 -0400
Date: Mon, 9 Sep 2002 16:15:16 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: do_syslog/__down_trylock lockup in current BK
Message-ID: <20020909201516.GA7465@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209092117490.4363-100000@localhost.localdomain> <Pine.LNX.4.44.0209092201220.13335-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209092201220.13335-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 10:02:11PM +0200, Ingo Molnar wrote:
> 
> the lockup, on both CPUs:
> 
> >>EIP; c01200b1 <zap_thread+21/16d>   <=====
> Trace; c0120092 <zap_thread+2/16d>
> Trace; c011f00c <exit_notify+10c/230>
> Trace; c011f41a <do_exit+2ea/370>
> Trace; c0125755 <schedule_timeout+b5/c0>
> Trace; c0126686 <sig_exit+36/40>
> Trace; c0127c54 <get_signal_to_deliver+2d4/360>
> Trace; c0107cf3 <do_signal+c3/100>
> Trace; c012d572 <sys_futex+182/1b0>
> Trace; c0107fce <work_notifysig+13/15>
> 
> >>EIP; c0106c5f <__write_lock_failed+f/20>   <=====
> Trace; c0120316 <.text.lock.exit+119/133>
> Trace; c011ef16 <exit_notify+16/230>
> Trace; c011f41a <do_exit+2ea/370>
> Trace; c0125755 <schedule_timeout+b5/c0>
> Trace; c0126686 <sig_exit+36/40>
> Trace; c0127c54 <get_signal_to_deliver+2d4/360>
> Trace; c0107cf3 <do_signal+c3/100>
> Trace; c012d572 <sys_futex+182/1b0>
> Trace; c0107fce <work_notifysig+13/15>
> 
> ie. either the 'zap_again' produces an infinite loop, or one of the lists 
> became corrupted. I suspect the former.

How do you reproduce this?  It's probably my fault, if it's stuck in
zap_thread... but that's a pretty suspicious looking trace to me, if it
goes from schedule_timeout to do_exit.
-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
