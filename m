Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265341AbSJXH0d>; Thu, 24 Oct 2002 03:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265342AbSJXH0d>; Thu, 24 Oct 2002 03:26:33 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:12557 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S265341AbSJXH0c>;
	Thu, 24 Oct 2002 03:26:32 -0400
Date: Thu, 24 Oct 2002 07:32:18 +0000
From: Eduardo =?iso-8859-1?Q?P=E9rez?= <100018135@alumnos.uc3m.es>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: async poll
Message-ID: <ef8452d35d47a17fae0094208bc02613@alumnos.uc3m.es>
References: <3DB722DC.3090306@netscape.com> <Pine.LNX.4.44.0210231543290.1581-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210231543290.1581-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-23 15:50:43 -0700, Davide Libenzi wrote:
> On Wed, 23 Oct 2002, John Gardiner Myers wrote:
> > Again, it comes down to whether or not one has the luxury of being able
> > to (re)write one's application and supporting libraries from scratch.
> >  If one can ensure that the code for handling an event will never block
> > for any significant amount of time, then single-threaded process-per-CPU
> > will most likely perform best.  If, on the other hand, the code for
> > handling an event can occasionally block, then one needs a thread pool
> > in order to have reasonable latency.
> >
> > A thread pool based server that is released will trivially outperform a
> > single threaded server that needs a few more years development to
> > convert all the blocking calls to use the event subsystem.
> 
> I beg you pardon but where an application is possibly waiting for ?
> Couldn't it be waiting to something somehow identifiable as a file ? So,
> supposing that an interface like sys_epoll ( or AIO, or whatever )
> delivers you events for all your file descriptors your application is
> waiting for, why would you need threads ? In fact, I personally find that
> coroutines make threaded->single-task transaction very easy. Your virtual
> threads shares everything by default w/out having a single lock inside
> your application.

The only uses of threads in a full aio application is task independence
(or interactivity) and process context separation

Example from GUI side:
Suppose your web (http) client is fully ported to aio (thus only one
thread), if you have two windows and one window receives a big
complicated html page that needs much CPU time to render, this window
can block the other one. If you have a thread for each window, once the
html parser has elapsed its timeslice, the other window can continue
parsing or displaying its (tiny html) page.
(In fact you should use two (or more) threads per window, as html parsing
shouldn't block widget redrawing (like menus and toolbars))
