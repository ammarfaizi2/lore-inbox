Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRC2WKP>; Thu, 29 Mar 2001 17:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRC2WKG>; Thu, 29 Mar 2001 17:10:06 -0500
Received: from chromium11.wia.com ([207.66.214.139]:36624 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S129166AbRC2WJq>; Thu, 29 Mar 2001 17:09:46 -0500
Message-ID: <3AC3B35D.FC010700@chromium.com>
Date: Thu, 29 Mar 2001 14:12:45 -0800
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux scheduler limitations?
In-Reply-To: <3AC3A6C9.991472C0@chromium.com> <20010329233521.C6053@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apache uses a pre-fork "threading" mechanism, it spawns (fork()s) new instances
of itself whenever it finds out that the number of idle "threads" is below a
certain (configurable) threshold.

Despite of all apparences this method performs beautifully on Linux, pthreads are
actually slower in many cases, since you will incur some additional overhead due
to thread synchronization and scheduling.

The problem is that beyond a certain number of processes the scheduler just goes
bananas, or so it seems to me.

Since Linux threads are mapped on processes, I don't think that (p)threads woud
help in any way, unless it is the VM context switch overhead that is playing a
role here, which I wouldn't think is the case.

 - Fabio

"J . A . Magallon" wrote:

> On 03.29 Fabio Riccardi wrote:
> >
> > I've found a (to me) unexplicable system behaviour when the number of
> > Apache forked instances goes somewhere beyond 1050, the machine
> > suddently slows down almost top a halt and becomes totally unresponsive,
> > until I stop the test (SpecWeb).
> >
>
> Have you though about pthreads (when you talk about fork, I suppose you
> say literally 'fork()') ?
>
> I give a course on Parallel Programming at the university and the practical
> work was done with POSIX threads. One of my students caught the idea and
> used it to modify his assignment from one other matter on Networks, and
> changed the traditional 'fork()' in a simple ftp server he had to implement
> by 'pthread_create' and got a 10-30 speedup (conns per second).
>
> And you will get rid of some process-per-user limit. But you will fall into
> an threads-per-user limit, if there is any.
>
> And you cal also control its scheduling, to make each thread fight against
> the whole system or only its siblings.
>
> --
> J.A. Magallon                                          #  Let the source
> mailto:jamagallon@able.es                              #  be with you, Luke...
>
> Linux werewolf 2.4.2-ac28 #1 SMP Thu Mar 29 16:41:17 CEST 2001 i686

