Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSHPBHK>; Thu, 15 Aug 2002 21:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSHPBHK>; Thu, 15 Aug 2002 21:07:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5906 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317833AbSHPBHK>; Thu, 15 Aug 2002 21:07:10 -0400
Date: Thu, 15 Aug 2002 18:14:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151804030.1188-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208151809190.1188-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:
> 
> See? Process _X_ is not threaded, and is not maintaining any thread data 
> structures.

.. Just to clarify: CLONE_SETTID is useful even outside of threading, so X 
wants to use CLONE_SETTID simply because it keeps track of it's children 
that way - but it is otherwise completely traditional, and depends on 
SIGCHLD to tell it when the children have died. 

The child (Y) it forks off, however, may use thread (Z) for some subtask.  
Not pthreads, it might be just a clone-by-hand.  So it may be doing an
exit while it's address space is still actively used by another thread -
but just because (X) wanted to use CLONE_SETTID to get the child
information on (Y) does _not_ mean that it's address space (and thus 
that of Z) would somehow be updated at its exit.

		Linus

