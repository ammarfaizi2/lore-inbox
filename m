Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSLXUac>; Tue, 24 Dec 2002 15:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLXUac>; Tue, 24 Dec 2002 15:30:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6153 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265819AbSLXUac>; Tue, 24 Dec 2002 15:30:32 -0500
Date: Tue, 24 Dec 2002 12:39:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Ulrich Drepper <drepper@redhat.com>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <hpa@transmeta.com>,
       <terje.eggestad@scali.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
       <hugh@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212242127190.6603-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212241235110.1219-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Dec 2002, Ingo Molnar wrote:
>
> this basically hardcodes flat segment layout on x86. If anything (Wine?)
> modifies the default segments, it can wrap syscalls by saving/restoring
> the modified %ds and %es selectors explicitly.

Note that that was true even before this patch - you cannot use glibc
without having the default DS/ES settings anyway. I not only checked with
Uli, but gcc simply cannot generate code that has different segments for
stack and data, so if you have non-flat segments you had to either

 - flatten them out before calling the standard library
 - do your system calls directly by hand

And note how both of these still work fine (if you flatten things out it
trivially works, and if you do system calls by hand the old "int 0x80"
approach obviously doesn't change anything, and non-flat still works).

So the new code really only takes advantage of the fact that non-flat
wouldn't have worked with glibc in the first place, and without glibc you
don't see any difference in behaviour since it won't be using the new
calling convention.

				Linus

