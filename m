Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSHOXvW>; Thu, 15 Aug 2002 19:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSHOXvW>; Thu, 15 Aug 2002 19:51:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317861AbSHOXvV>; Thu, 15 Aug 2002 19:51:21 -0400
Date: Thu, 15 Aug 2002 16:58:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208160145150.6252-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151653420.15744-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:
> 
> okay. And it also makes sense for a newly forked task to know (and cache)
> its own PID, without having to call getpid() again.

Well, it won't. The pid write is _after_ we've done the copy_mm(), so the 
child will never see it.

That looks like a potential mistake, though - it causes extra COW-faults
and it also means that this particular optimization (which I kind of like)
won't work.

However, if you want to fix it, you'd need to either move the
clone_thread() earlier, or you'd need to move the CLONE_SETTID logic up to
the generic layer (that latter path may make more sense, since if glibc
starts using this interface, you obviously need to do this in all
architectures anyway)

		Linus

