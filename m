Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264587AbSIVWpr>; Sun, 22 Sep 2002 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264588AbSIVWpr>; Sun, 22 Sep 2002 18:45:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9889 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264587AbSIVWpq>;
	Sun, 22 Sep 2002 18:45:46 -0400
Date: Mon, 23 Sep 2002 00:59:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <3D8E470D.C76C459E@opersys.com>
Message-ID: <Pine.LNX.4.44.0209230057150.31803-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, Karim Yaghmour wrote:

> Ingo Molnar wrote:
> > +int trace_event(u8 pm_event_id,
> > +               void *pm_event_struct)
> > [...]
> > +       read_lock(&tracer_register_lock);
> > 
> > ie. it's using a global spinlock. (sure, it can be made lockless, as other
> > tracers have done it.)
> 
> It is, but this is separate from the trace driver. [...]

it does not matter, it's called for every event.

> [...] This global spinlock is only used to avoid a race condition in the
> registration/ unregistration of the tracing function with the trace
> infrastructure.

(here you make the incorrect assumption that read-locking a rwlock is a
lightweight operation.)

	Ingo

