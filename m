Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291231AbSBGTaM>; Thu, 7 Feb 2002 14:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291232AbSBGTaE>; Thu, 7 Feb 2002 14:30:04 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:63120 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291231AbSBGT3z>;
	Thu, 7 Feb 2002 14:29:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Christoph Hellwig <hch@ns.caldera.de>, Martin.Wirth@dlr.de (Martin Wirth)
Subject: Re: [RFC] New locking primitive for 2.5
Date: Thu, 7 Feb 2002 20:33:15 +0100
X-Mailer: KMail [version 1.3.2]
Cc: akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, rml@tech9.net,
        nigel@nrg.org, linux-kernel@vger.kernel.org
In-Reply-To: <200202071822.g17IMgS14802@ns.caldera.de>
In-Reply-To: <200202071822.g17IMgS14802@ns.caldera.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YuIF-00015P-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 07:22 pm, Christoph Hellwig wrote:
> In article <3C629F91.2869CB1F@dlr.de> you wrote:
> > If a spin_lock request is blocked by a mutex_lock call, the spin_lock
> > attempt also sleeps i.e. behaves like a semaphore.
> > If you gained ownership of the lock, you can switch between spin-mode
> > and mutex-(ie.e sleeping) mode by calling:
> >
> >         combi_to_mutex_mode(struct combilock *x)
> >         combi_to_spin_mode(struct combilock *x)
> >
> > without loosing the lock. So you may start with a spin-lock and relax
> > to a sleeping lock if for example you need to call a non-atomic kmalloc.
> 
> This looks really ugly.  I'd really prefer an automatic fallback from
> spinning to sleeping after some timeout like e.g. solaris adaptive
> mutices.

Look closer at what he said.  You'd take the lock, then you might decide you
had to do something on a slow/blocking path, for example, a copy to/from user,
so you could do that without leaving waiters spinning, or having to
acquire a different lock and re-establish the state.  It bears thinking
about.

-- 
Daniel
