Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTAXXMB>; Fri, 24 Jan 2003 18:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbTAXXMB>; Fri, 24 Jan 2003 18:12:01 -0500
Received: from mail.zmailer.org ([62.240.94.4]:41604 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S265857AbTAXXMA>;
	Fri, 24 Jan 2003 18:12:00 -0500
Date: Sat, 25 Jan 2003 01:21:10 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Corey Minyard <minyard@acm.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, Dan Kegel <dank@kegel.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
Message-ID: <20030124232110.GN787@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0301232144470.8203-100000@coffee.psychology.mcmaster.ca> <3E30F79D.6050709@kegel.com> <20030124082610.GA12781@mark.mielke.cc> <3E31C3FA.1060302@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E31C3FA.1060302@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 04:53:46PM -0600, Corey Minyard wrote:
...
> I would disagree.  One thread per connection is easier to conceptually 
> understand.  In my experience, an event-driven model (which is what you 
> end up with if you use one or a few threads) is actually easier to 
> correctly implement and it tends to make your code more modular and 
> portable.

  An old thing from early annals of computer science (I browsed Knuth's
"The Art" again..) is called   Coroutine.

Gives you "one thread per connection" programming model, but without
actual multiple scheduling threads in the kernel side.

Simplest coroutine implementations are truly simple.. Pagefull of C.
Knuth shows it with very few MIX (assembly) instructions.

Throwing in non-blocking socket/filedescriptor access, and in event
of "EAGAIN", coroutine-yielding to some other coroutine, does complicate
things, naturally.

Good coder finds balance in between various methods, possibly uses
both coroutine "userspace threads", and actual kernel threads.

Doing coroutine library all in portable C (by means of setjmp()/longjmp())
is possible, but not very efficient.  A bit of assembly helps a lot.

> -Corey

/Matti Aarnio
