Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293619AbSCFOqX>; Wed, 6 Mar 2002 09:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293621AbSCFOqM>; Wed, 6 Mar 2002 09:46:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29907 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293619AbSCFOpy>;
	Wed, 6 Mar 2002 09:45:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Futexes III :  performance numbers
Date: Wed, 6 Mar 2002 09:46:41 -0500
X-Mailer: KMail [version 1.3.1]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au> <20020305212210.B10A33FF04@smtp.linux.ibm.com> <20020306185420.29df1bf2.rusty@rustcorp.com.au>
In-Reply-To: <20020306185420.29df1bf2.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020306144536.C4D0E3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 March 2002 02:54 am, Rusty Russell wrote:
> On Tue, 5 Mar 2002 16:23:14 -0500
>
> Hubertus Franke <frankeh@watson.ibm.com> wrote:
> > Interesting... the strict FIFO ordering of my fast semaphores limits
> > performance as seen by 99.71% contention, so we always ditch
> > into the kernel. Convoy Avoidance locks 2.5 times better.
> > Wohh futex rock, BUT... with 0.29% contention it basically tells
> > me that we are exhausting our entire quantum getting the lock
> > without contention. So their is some serious fairness issue here
> > at least for the tightly scheduled locks. Compare the M numbers
> > for 2 and 3 children.
>
> Fairness <sigh>.  This patch should be much more FIFO: it works by handing
> the mutex straight to the first one on the queue if there is one, and only
> actually "freeing" it if there's noone waiting.
>
> Unfortunately, it seems to hurt performance by 50% on tdbtorture (although
> there are weird scheduler things happening too).
>
> Here's the "fair" patch:
> Rusty.

Thanks, Rusty, man you are a coding machine :-)

Now you are experiencing all the issues that I went through as well.
Point I was trying ot make is, that there is not cookie cutter solution.
One must provide the various options to the higher level and let
the application choose what mootex semantics it wants.

There is applicability for fair futexes and for convoy avoidance futexes.

So let's put both in, and later expand it to read/write stuff.


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
