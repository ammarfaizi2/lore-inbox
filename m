Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbTAEDcP>; Sat, 4 Jan 2003 22:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTAEDcO>; Sat, 4 Jan 2003 22:32:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45580 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262646AbTAEDcO>; Sat, 4 Jan 2003 22:32:14 -0500
Date: Sat, 4 Jan 2003 19:35:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Andi Kleen <ak@suse.de>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
In-Reply-To: <3E1783D0.5A47A299@digeo.com>
Message-ID: <Pine.LNX.4.44.0301041930300.1388-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Jan 2003, Andrew Morton wrote:
> 
> Looks like you're right.  The indications are that this change
> has slowed context switches by ~5% on a PIII.   The backout patch
> against 2.5.54 is below.  Testing on a P4 would be useful.

Hmm.. The backup patch doesn't handle single-stepping correctly: the
eflags cleanup singlestep patch later in the sysenter sequence _depends_
on the stack (and thus thread) being right on the very first in-kernel
instruction.

That (along with benchmarking of system call numbers - the stack switch at
system call run-time ends up being quite expensive on a P4) was what made
me decide to do the traditional "write MSR in schedule" approach, even
though I agree that it would be much nicer to not have to rewrite that
stupid MSR all the time.

It doesn't show up on lmbench (insufficient precision), but your AIM9
numbers are quite interesting. Are they stable?

		Linus

