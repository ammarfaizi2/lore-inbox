Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSGYS3C>; Thu, 25 Jul 2002 14:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSGYS3C>; Thu, 25 Jul 2002 14:29:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42994 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315513AbSGYS3C>;
	Thu, 25 Jul 2002 14:29:02 -0400
Message-ID: <3D40440D.116FF155@mvista.com>
Date: Thu, 25 Jul 2002 11:31:41 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, lk@tantalophile.demon.co.uk,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
References: <20020724144433.B7192@kushida.apsleyroad.org>
		<Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com> <20020725163239.6c6e5ed6.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> On Wed, 24 Jul 2002 11:48:10 -0700 (PDT)
> Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> > The thing is, we cannot change existing select semantics, and the
> > question is whether what most soft-realtime wants is actually select, or
> > whether people really want a "waittimeofday()".
> 
> NOT waittimeofday.  You need a *new* measure which can't be set forwards
> or back if you want this to be sane.  pthreads has absolute timeouts (eg.
> pthread_cond_timedwait), but they suck IRL for this reason.
> 
> Of course, doesn't need any correlation with absolute time, it could be a
> "microseconds since boot" kind of thing.
> 
The POSIX clocks & timers API defines CLOCK_MONOTONIC for
this sort of thing (CLOCK_MONOTONIC can not be set).  It
also defines an API for clock_nanosleep() that CAN use an
absolute time which is supposed to follow any clock setting
that is done.  Combine the two and you have a fixed time
definition.

AND, guess what, the high-res-timers patch does all this and
more.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
