Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSHPDFW>; Thu, 15 Aug 2002 23:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318078AbSHPDFW>; Thu, 15 Aug 2002 23:05:22 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:5601 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318075AbSHPDFV>; Thu, 15 Aug 2002 23:05:21 -0400
Date: Fri, 16 Aug 2002 04:09:02 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
Message-ID: <20020816040902.A31570@kushida.apsleyroad.org>
References: <20020815222731.A28998@kushida.apsleyroad.org> <Pine.LNX.4.44.0208152350590.24024-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208152350590.24024-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Aug 16, 2002 at 12:02:54AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > [...] And I would like this while having the benefit of CLONE_DETACHED -
> > because I want to use this for high performance threading but still be
> > robust - so waitpid() is out.
> 
> like i said in the original email, the point of CLONE_DETACHED is to avoid
> the waitpid() overhead. I also said that exit notification is done via
> mutexes (futexes).

How?  Scenario:

   1. a thread calls a 3rd party library which was _not_ compiled with
      threading in mind.  (It shouldn't have to be).

   2. 3rd party library sends itself a SIGABRT; perhaps an assertion
      failed.  (Variants: SIGFPE, library does execve(), etc.)

   3. thread exits....   but the mutex was _not_ released

   4. I _want_ to report the death to other thread, without having
      to poll all my children in my main event loop.

This is a very legitimate and useful kind of thread death, and it's
perfectly safe too.  (Not pthreads-conformant, but clone() is useful for
more than just pthreads).

As things are at the moment, you've arranged things so that I can't use
CLONE_DETACHED if I want to catch threads which die unexpectedly.

Why can't I have both at the same time?  They are both good.

-- Jamie
