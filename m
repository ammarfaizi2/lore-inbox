Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTAREkX>; Fri, 17 Jan 2003 23:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbTAREkX>; Fri, 17 Jan 2003 23:40:23 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:37836 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262394AbTAREkW>;
	Fri, 17 Jan 2003 23:40:22 -0500
Date: Sat, 18 Jan 2003 04:49:20 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Question about threads and signals
Message-ID: <20030118044920.GC18658@bjl1.asuk.net>
References: <20030118032450.GA18282@bjl1.asuk.net> <3E28CF26.6020202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E28CF26.6020202@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > 2. Is this true of POSIX threads in general, or just Linux?
> 
> Well, the above is what POSIX requires and what I think we've
> implemented.  These requirements are essential for programs which do
> much of their work in signal handlers.

So, in a program which uses pthread_create(), a SIGCHLD handler must
either (a) be reentrant, or (b) be unblocked (or installed) in one
thread only.

> Creating more threads which mainly just sit around but can react to
> signals is a valid programming model.

Indeed, as Ingo pointed out, some signals are like poor man's threads,
and that programming model makes that explicit.  I like that, because
it means the signal handler can validly do everything normal code can
do, including use mutexes and other locking primitives which may sleep.

(Some other signals are intrinsically thread-local though, such as
SIGSEGV and SIGFPE - they are synchronous exception handlers rather
than asynchronous event handlers).

Thanks for your quick answer,
-- Jamie
