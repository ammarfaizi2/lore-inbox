Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267694AbSLTBjP>; Thu, 19 Dec 2002 20:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267697AbSLTBjP>; Thu, 19 Dec 2002 20:39:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267694AbSLTBjO>; Thu, 19 Dec 2002 20:39:14 -0500
Date: Thu, 19 Dec 2002 17:47:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       "H. Peter Anvin" <hpa@transmeta.com>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021220005333.GA20227@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0212191746200.4545-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Dec 2002, Daniel Jacobowitz wrote:
> >
> >    (ptrace also doesn't actually allow you to look at the instruction
> >    contents in high memory, so gdb won't see the instructions in the
> >    user-mode fast system call trampoline even when it can single-step
> >    them, and I don't think I'll bother to fix it up).
>
> This worries me.  I'm no x86 guru, but I assume the trampoline's setting of
> the TF bit will kick in right around the following 'ret'.  So the
> application will stop and GDB won't be able to read the instruction at
> PC.  I bet that makes it unhappy.

It doesn't make gdb all that unhappy, everything seems to work fine
despite the fact that gdb decides it just can't display the instructions.

> Shouldn't be that hard to fix this up in ptrace, though.

Or even in user space, since the high pages are all the same in all
processes (so gdb doesn't even strictly need ptrace, it can just read it's
_own_ codespace there). But yeah, we could make ptrace aware of the magic
pages.

		Linus

