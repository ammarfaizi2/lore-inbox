Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSLQGA2>; Tue, 17 Dec 2002 01:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSLQGA2>; Tue, 17 Dec 2002 01:00:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42002 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264699AbSLQGA1>; Tue, 17 Dec 2002 01:00:27 -0500
Date: Mon, 16 Dec 2002 22:09:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Dec 2002, Linus Torvalds wrote:
>
> On my P4 machine, a "getppid()" is 641 cycles with sysenter/sysexit, and
> something like 1761 cycles with the old "int 0x80/iret" approach. That's a
> noticeable improvement, but I have to say that I'm a bit disappointed in
> the P4 still, it shouldn't be even that much.

On a slightly more real system call (gettimeofday - which actually matters
in real life) the difference is still visible, but less so - because the
system call itself takes more of the time, and the kernel entry overhead
is thus not as clear.

For gettimeofday(), the results on my P4 are:

	sysenter:	1280.425844 cycles
	int/iret:	2415.698224 cycles
			1135.272380 cycles diff
	factor 1.886637

ie sysenter makes that system call almost twice as fast.

It's not as good as a pure user-mode solution using tsc could be, but
we've seen the kinds of complexities that has with multi-CPU systems, and
they are so painful that I suspect the sysenter approach is a lot more
palatable even if it doesn't allow for the absolute best theoretical
numbers.

			Linus

