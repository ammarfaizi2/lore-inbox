Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288455AbSAHVoQ>; Tue, 8 Jan 2002 16:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288428AbSAHVoH>; Tue, 8 Jan 2002 16:44:07 -0500
Received: from zero.tech9.net ([209.61.188.187]:47368 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288402AbSAHVn5>;
	Tue, 8 Jan 2002 16:43:57 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201081920130.2985-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201081920130.2985-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 16:45:41 -0500
Message-Id: <1010526342.3225.133.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 16:24, Rik van Riel wrote:

> So what exactly _is_ the difference between an explicit
> preemption point and a place where we need to explicitly
> drop a spinlock ?

In that case nothing, except that when we drop the lock and check it is
the earliest place where preemption is allowed.  In the normal scenario,
however, we have a check for reschedule on return from interrupt (e.g.
the timer) and thus preempt in the same manner as with user space and
that is the key.

> > Future work would be to look into long-held locks and see what we can
> > do.
> 
> One thing we could do is download Andrew Morton's patch ;)

That is certainly one option, and Andrew's patch is very good. 
Nonetheless, I think we need a more general framework that tackles the
problem itself.  Preemptible kernel does this, yields results now, and
allows for greater return later on.

	Robert Love

