Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSHOX7s>; Thu, 15 Aug 2002 19:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSHOX7s>; Thu, 15 Aug 2002 19:59:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28686 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318035AbSHOX7r>; Thu, 15 Aug 2002 19:59:47 -0400
Date: Thu, 15 Aug 2002 17:06:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208160152260.6466-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151703310.15744-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:
> > [...] In which case we sure as heck don't want the original child to
> > modify the VM that it now shares with a subthread.
> 
> in what way is clone() utilized? if it's via any threading library then
> the fork()-ed process has its own thread state, which must be freed when
> exiting.

See this:

	process X

	fork()			
			------->	Process Y
					clone()
								----> thread Z

					exit()
					THIS MUST NOT
					WRITE TO MEMORY
					IN Z!!


Notice how the exit() in Y will never be able to write into the address 
space of X - it would only write into the address space of Z, and Z is not 
expecting that at all!

		Linus

