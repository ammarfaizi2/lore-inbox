Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSHOXqw>; Thu, 15 Aug 2002 19:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSHOXqw>; Thu, 15 Aug 2002 19:46:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44557 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317816AbSHOXqv>; Thu, 15 Aug 2002 19:46:51 -0400
Date: Thu, 15 Aug 2002 16:53:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208160146480.6252-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151652020.15744-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:
> 
> On Thu, 15 Aug 2002, Linus Torvalds wrote:
> 
> > A thread library - maybe not. But the SETTID thing makes sense even for
> > a fork() user to avoid the fork/SIGCHLD race condition. In contrast, a
> > CLRTID does _not_ make sense in that situation, so I actually think they
> > are two separate issues (and should thus be two separate bits).
> 
> we could skip the 'clear' bit if this is the last release of the mm.

Ahhah, but you miss the point.

The fork()'ed child may clone on its own, and then exit. In which case we 
sure as heck don't want the original child to modify the VM that it now 
shares with a subthread.

This is just more on my spiel about how only the _parent_ really knows 
what it is it wants to maintain, and the child really cannot make any 
assumptions on its own.

			Linus

