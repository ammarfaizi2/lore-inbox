Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290126AbSAKVvu>; Fri, 11 Jan 2002 16:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290127AbSAKVvk>; Fri, 11 Jan 2002 16:51:40 -0500
Received: from svr3.applink.net ([206.50.88.3]:1041 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290126AbSAKVvW>;
	Fri, 11 Jan 2002 16:51:22 -0500
Message-Id: <200201112150.g0BLoESr004177@svr3.applink.net>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: =?iso-8859-15?q?Fran=E7ois=20Cami?= <stilgar2k@wanadoo.fr>, mingo@elte.hu
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
Date: Fri, 11 Jan 2002 15:46:24 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0201110142160.12174-100000@localhost.localdomain> <3C3F5C43.7060300@wanadoo.fr>
In-Reply-To: <3C3F5C43.7060300@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 15:42, François Cami wrote:
> Ingo Molnar wrote:
> > On Thu, 10 Jan 2002, Mike Kravetz wrote:
> >>If I run 3 cpu-hog tasks on a 2 CPU system, then 1 task will get an
> >>entire CPU while the other 2 tasks share the other CPU (easily
> >>verified by a simple test program). On previous versions of the
> >>scheduler 'balancing' this load was achieved by the global nature of
> >>time slices. No task was given a new time slice until the time slices
> >>of all runnable tasks had expired.  In the current scheduler, the
> >>decision to replenish time slices is made at a local (pre-CPU) level.
> >>I assume the load balancing code should take care of the above
> >>workload?  OR is this the behavior we desire? [...]
> >
> > Arguably this is the most extreme situation - every other distribution
> > (2:3, 3:4) is much less problematic. Will this cause problems? We could
> > make the fairness-balancer more 'sharp' so that it will oscillate the
> > length of the two runqueues at a slow pace, but it's still caching loss.
> >
> >>We certainly have optimal cache use.
> >
> > indeed. The question is, should we migrate processes around just to get
> > 100% fairness in 'top' output? The (implicit) cost of a task migration
> > (caused by the destruction & rebuilding of cache state) can be 10
> > milliseconds easily on a system with big caches.
> >
> > 	Ingo
>
> I do vote for optimal cache use. Using squid (200MB process in my case)
> can be much faster if squid stays on the same CPU for a while, instead
> of hopping from one CPU to another (dual PII350 machine).
>
> François Cami

But, given the above case, what happens when you have Sendmail on
the first CPU and Squid is sharing the second CPU?  This is not optimal
either, or am I missing something?

-- 
timothy.covell@ashavan.org.
