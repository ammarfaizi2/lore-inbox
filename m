Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbSIXJ5I>; Tue, 24 Sep 2002 05:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbSIXJ5I>; Tue, 24 Sep 2002 05:57:08 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:52233 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261631AbSIXJ5H>; Tue, 24 Sep 2002 05:57:07 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15760.14375.613276.807913@laputa.namesys.com>
Date: Tue, 24 Sep 2002 14:02:15 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Larry McVoy <lm@bitmover.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Peter Waechtler <pwaechtler@mac.com>,
       linux-kernel@vger.kernel.org, ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020923083004.B14944@work.bitmover.com>
References: <20020922143257.A8397@work.bitmover.com>
	<Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com>
	<20020923083004.B14944@work.bitmover.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Meat: Ptarmigan
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy writes:
 > > > Instead of taking the traditional "we've screwed up the normal system 
 > > > primitives so we'll event new lightweight ones" try this:
 > > > 
 > > > We depend on the system primitives to not be broken or slow.
 > > > 
 > > > If that's a true statement, and in Linux it tends to be far more true
 > > > than other operating systems, then there is no reason to have M:N.
 > > 
 > > No matter how fast you do context switch in and out of kernel and a sched
 > > to see what runs next, it can't be done as fast as it can be avoided.
 > 
 > You are arguing about how many angels can dance on the head of a pin.
 > Sure, there are lotso benchmarks which show how fast user level threads
 > can context switch amongst each other and it is always faster than going
 > into the kernel.  So what?  What do you think causes a context switch in
 > a threaded program?  What?  Could it be blocking on I/O?  Like 99.999%
 > of the time?  And doesn't that mean you already went into the kernel to
 > see if the I/O was ready?  And doesn't that mean that in all the real
 > world applications they are already doing all the work you are arguing
 > to avoid?

M:N threads are supposed to have other advantages beside fast context
switches. Original paper on scheduler activations mentioned case when
kernel thread is preempted while user level thread it runs held spin
lock. When kernel notifies user level scheduler about preemption
(through upcall) it can de-schedule all user level threads spinning on
this lock, so that they will not waste their time slices burning CPU.

 > -- 
 > ---
 > Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

Nikita.

 > -
