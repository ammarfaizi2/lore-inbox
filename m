Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSHOX41>; Thu, 15 Aug 2002 19:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSHOX40>; Thu, 15 Aug 2002 19:56:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18831 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317980AbSHOX40>;
	Thu, 15 Aug 2002 19:56:26 -0400
Date: Fri, 16 Aug 2002 02:00:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151653420.15744-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208160159110.6466-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:

> > okay. And it also makes sense for a newly forked task to know (and cache)
> > its own PID, without having to call getpid() again.
> 
> Well, it won't. The pid write is _after_ we've done the copy_mm(), so
> the child will never see it.

hmm.

> That looks like a potential mistake, though - it causes extra COW-faults
> and it also means that this particular optimization (which I kind of
> like) won't work.
> 
> However, if you want to fix it, you'd need to either move the
> clone_thread() earlier, or you'd need to move the CLONE_SETTID logic up
> to the generic layer (that latter path may make more sense, since if
> glibc starts using this interface, you obviously need to do this in all
> architectures anyway)

CLONE_SETTID indeed makes more sense in the do_fork() proper, there's
absolutely nothing x86-ish about it.

	Ingo

