Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTKNS7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbTKNS7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:59:52 -0500
Received: from imr2.ericy.com ([198.24.6.3]:30908 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S262750AbTKNS7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:59:42 -0500
From: Frederic Rossi <frederic.rossi@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16309.9600.110303.245402@localhost.localdomain>
Date: Fri, 14 Nov 2003 13:57:04 -0500
To: "Dan Kegel" <dank@kegel.com>
Cc: "kirk bae" <justformoonie@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: So, Poll is not scalable... what to do?
X-Mailer: VM 7.07 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

Dan Kegel wrote:
> Kirk Bae wrote:
> >>>If poll is not scalable, which method should I use when writing 
> >>>multithreaded socket server?
> >>
> >>People who write multithreaded servers tend to use thread pools
> >>and never need to use poll().  (Well, ok, I've written multithreaded
> >>servers that used poll(), but the threads were there for disk I/O,
> >>not networking.)
> > 
> > By thread pool, do you mean, one thread per socket?, or a work-crew
> model 
> > where a specified number of threads handle many sockets?
> 
> The latter.  But I don't have much recent experience writing threaded
> servers, as I usually use somthing like epoll.
> 
> > My definition of "efficient" is a method that is most widely used or 
> > accepted for writing a robust scalable server. So I guess, "'runs like
> a bat 
> > out of hell, and I don't care how long it takes to write'" is close.
> > 
> > Would it be thread pool or epoll? 
> 
> My personal bias is towards epoll (suitably wrapped for portability;
> no need to require epoll when sigio is nearly as good, and universally
> deployed).
> 
>  > Is it uncommon to mix these two?
> 
> Folks who know how to program with things like epoll and aio tend
> to use threads carefully, and try to avoid using blocking I/O for
> networking.
> Blocking I/O is unavoidable for things like opening files, though,
> so it's perfectly fine to have a thread that handles stuff like that.
> 
> > Currently, I have a thread-1 calling poll, and dispatching its
> workload to 
> > thread-2 and thread-3 in blocking sockets. I dispatch the workload to
> worker 
> > threads because some of the operations take considerable time.
> > 
> > Is mixing threads with poll uncommon? Is this a bad design? any
> comments 
> > would be appreciated.
> 
> What are the operations that take considerable time?  Are they
> networking
> calls, or disk I/O, or ...?   If they're just networking calls,
> you might consider turning your code inside out to do everything with
> nonblocking I/O and state machines, but only if you're hitting a
> bottleneck
> because of the number of threads active.
> 
> Whatever design you're comfortable with is fine until you fail to hit
> your
> performance requirement.  No point in optimizing one little part
> of the system if the whole system is fast enough, or if the real
> bottleneck is elsewhere...
> - Dan

I think you're right when talking about the design decision and 
regarding the initial question (since it is not referenced on the 
C10K page) I'd like to suggest 
	  http://aem.sourceforge.net
which provides another possible approach for that kind of problem.

The question of I/O completion port was also raised and I think 
it must be taken into account in the initial design as well.
In many situations people use threads to handle this asynchronously
AEM is targeting event handling but provides a native asynchronous 
socket interface that brings data directly to the applications.
This is one way of doing it.

On the other hand, it might not be the perfect solution for 
the problem above. See it as an alternative.

Frederic
