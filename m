Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288242AbSAHSzz>; Tue, 8 Jan 2002 13:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288249AbSAHSzh>; Tue, 8 Jan 2002 13:55:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:2568 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288242AbSAHSzW>;
	Tue, 8 Jan 2002 13:55:22 -0500
Subject: Re: [PATCH] preempt abstraction
From: Robert Love <rml@tech9.net>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, hch@caldera.com, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com>
In-Reply-To: <10940.1010511619@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 13:57:28 -0500
Message-Id: <1010516250.3229.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 12:40, David Howells wrote:
> 
> The following patch abstracts access to need_resched:
> 
> 	ftp://infradead.org/pub/people/dwh/preempt-252p10.diff.bz2
> 
> It replaces most C-source read accesses to it with need_preempt() which
> returns true if rescheduling is necessary.

Nice patch!

A couple of points:

Why not use the more commonly named conditional_schedule instead of
preempt() ?  In addition to being more in-use (low-latency, lock-break,
and Andrea's aa patch all use it) I think it better conveys its meaning,
which is a schedule() but only conditionally.

I'm sure it is just being pedantic, but why not just make need_preempt
and preempt (which I would rename need_schedule and
conditional_schedule, personally) defines?  Example:

	#define need_schedule() (unlikely(current->need_resched))
	#define conditional_schedule() do { \
		if (need_schedule()) \
			schedule(); \
	} while(0);

Next, in kernel/sched.c you wrap need_preempt in an unlikey() but note
it is unlikely by design ... Same in mm/vmscan.c a couple times.

Oh, and the patch is confusingly similar to preempt-kernel in name, but
I guess that is my problem. :-)

Anyhow, I like.  2.5 _and_ 2.4?

	Robert Love

