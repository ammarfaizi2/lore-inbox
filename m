Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318815AbSIISou>; Mon, 9 Sep 2002 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318830AbSIISou>; Mon, 9 Sep 2002 14:44:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27798 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318815AbSIISot>;
	Mon, 9 Sep 2002 14:44:49 -0400
Date: Mon, 9 Sep 2002 20:53:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: do_syslog/__down_trylock lockup in current BK
Message-ID: <Pine.LNX.4.44.0209092052250.30743-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i can reproduce the following lockup in BK-current, SMP:

 >>EIP; c0106c57 <__down_trylock+a7/b4>   <=====
 Trace; c0120316 <do_syslog+16/6a0>
 Trace; c01088c8 <show_registers+198/1c0>
 Trace; c011ef16 <do_fork+436/b20>
 Trace; c011f41a <do_fork+93a/b20>
 Trace; c0125755 <release_resource+15/50>
 Trace; c0126686 <proc_doutsstring+76/c0>
 Trace; c0127c54 <__constant_copy_from_user+24/98>
 Trace; c0107cf3 <handle_signal+113/1a0>
 Trace; c012d572 <sys_setreuid+22/170>
 Trace; c0107fce <do_signal+24e/3c0>

it could be related to the signal changes - but at first sight it looks
like some sort of printk related lockup.

	Ingo

