Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSLVSpN>; Sun, 22 Dec 2002 13:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSLVSpN>; Sun, 22 Dec 2002 13:45:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21254 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265134AbSLVSpN>; Sun, 22 Dec 2002 13:45:13 -0500
Date: Sun, 22 Dec 2002 10:53:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212221111080.31068-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212221050210.2587-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Dec 2002, Ingo Molnar wrote:
>
> On Sat, 21 Dec 2002, Linus Torvalds wrote:
>
> > Saving and restoring eflags in user mode avoids all of these
> > complications, and means that there are no special cases. None. Zero.
> > Nada.
>
> and i'm 100% sure the more robust eflags saving will also avoid security
> holes. The amount of security-relevant complexity that comes from all the
> x86 features [and their combinations] is amazing.

I looked a bit at what it would take to have the TF bit handled by the
sysenter path, and it might not be so horrible - certainly not as ugly as
the register restore bits.

Jamie, if you want to do it, it looks like you could add a new "work" bit
in the thread flags, and add it to the _TIF_ALLWORK_MASK tests. At least
that way it wouldn't touch the regular code, and I don't think that the
result would have any strange "magic EIP" tests or anything horrible like
that ;)

		Linus

