Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313494AbSDJS2P>; Wed, 10 Apr 2002 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313500AbSDJS2O>; Wed, 10 Apr 2002 14:28:14 -0400
Received: from zero.tech9.net ([209.61.188.187]:12561 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313494AbSDJS2N>;
	Wed, 10 Apr 2002 14:28:13 -0400
Subject: Re: 2.5.8-pre2: preempt: exits with preempt_count 1
From: Robert Love <rml@tech9.net>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <E16vHbV-0000M5-00@baldrick>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 14:28:14 -0400
Message-Id: <1018463295.6681.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 08:53, Duncan Sands wrote:

> error: halt[411] exited with preempt_count 1
> 
> This was after about 24 hours of up time.  What can I do to help
> track down this locking problem?

It is not a big deal.  The issue is that in the system shutdown code,
something does not release a lock but just figures "the system is going
down, what is the point?"  It is probably the BKL ...

For the sake of code readability and having nothing quit with a nonzero
preempt_count, we should explicitly drop the lock, but it is not hurting
anything (now, if you get this message elsewhere, there may be a
problem).

I am trying to find what is the cause but I have not tracked it down yet
...

	Robert Love

