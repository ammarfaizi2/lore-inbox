Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSHPJot>; Fri, 16 Aug 2002 05:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318270AbSHPJot>; Fri, 16 Aug 2002 05:44:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39875 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318269AbSHPJos>;
	Fri, 16 Aug 2002 05:44:48 -0400
Date: Fri, 16 Aug 2002 11:49:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151804030.1188-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208161144040.3062-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:

> The problem spot is the _fork_ from process X. Which gives a address in
> process' _X_ virtual address space - used for SETTID.
> 
> See? Process _X_ is not threaded, and is not maintaining any thread data
> structures.

okay, this is the misunderstanding then. If it fork()s and then uses some
threading (which uses clone()) then in all cases i know about it must be
linked against some threading library. Otherwise Y couldnt do a clone()  
call and expect threading to work. In theory Y could 'become' a
threading-capable process, but right now no threading library i'm aware of
allows this - lots of standard C calls must be threading-aware and
threading-safe. So right now 'threading' is a property that comes with the
process image at exec()  time. But this must not be so from a conceptual
angle, so i agree with you.

(but the question is mostly academic anyway, because it makes perfect
sense to use a pure SETTID for a completely unthreaded application, to get
the fork() PID return value in the child's context as well.)

	Ingo

