Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbSLQT21>; Tue, 17 Dec 2002 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbSLQT21>; Tue, 17 Dec 2002 14:28:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63238 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266584AbSLQT20>; Tue, 17 Dec 2002 14:28:26 -0500
Date: Tue, 17 Dec 2002 11:37:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF7951.6020309@transmeta.com>
Message-ID: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, H. Peter Anvin wrote:
>
> Let's see... it works fine on UP and on *most* SMP, and on the ones
> where it doesn't work you just fill in a system call into the vsyscall
> slot.  It just means that gettimeofday() needs a different vsyscall slot.

The thing is, gettimeofday() isn't _that_ special. It's just not worth a
vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?
Just because we can?

This is especially true since the people who _really_ might care about
gettimeofday() are exactly the people who wouldn't be able to use the fast
user-space-only version.

How much do you think gettimeofday() really matters on a desktop? Sure, X
apps do gettimeofday() calls, but they do a whole lot more of _other_
calls, and gettimeofday() is really far far down in the noise for them.
The people who really call for gettimeofday() as a performance thing seem
to be database people who want it as a timestamp. But those are the same
people who also want NUMA machines which don't necessarily have
synchronized clocks.

		Linus

