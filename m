Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318228AbSGQG3s>; Wed, 17 Jul 2002 02:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSGQG3r>; Wed, 17 Jul 2002 02:29:47 -0400
Received: from dsl-213-023-020-188.arcor-ip.net ([213.23.20.188]:24754 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318228AbSGQG3q>;
	Wed, 17 Jul 2002 02:29:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: spinlock assertion macros
Date: Wed, 17 Jul 2002 08:34:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17T4Qj-0002fN-00@starship> <20020717022213.GA734386@sgi.com>
In-Reply-To: <20020717022213.GA734386@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UiO0-0004Jn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 04:22, Jesse Barnes wrote:
> On Fri, Jul 12, 2002 at 07:42:09PM +0200, Daniel Phillips wrote:
> > So far, only the MUST_HOLD style of executable locking documentation has 
> > really survived scrutiny.  It needs some variants: MUST_HOLD_READ, 
> > MUST_HOLD_WRITE, MUST_HOLD_SEM, MUST_HOLD_READ_SEM and MUST_HOLD_WRITE_SEM, 
> > or names to that effect.
> 
> I'm not quite sure where to put the semaphore versions of the MUST_*
> macros, I guess they'd have to go in each of the arch-specific header
> files?

You could create linux/semaphore.h which includes asm/semaphore.h, making
the whole arrangement more similar to spinlocks.  That would be the manly
thing to do, however, manliness not necessarily being the fashion at the
moment, putting them in the arch-specific headers seems like the route of
least resistance.  One day, a prince on a white horse will come along and
clean up all the header files...

> Anyway, I've got spinlock and rwlock versions of them below,
> maybe they're useful enough to go in as a start?  I only coded the
> ia64 version of rwlock_is_*_locked since it was easy--the i386
> versions were a little intimidating...
> 
> I thought Oliver's suggestion for tracking the order of spinlock
> acquisition was good, hopefully someone will take a stab at it along
> with Dave's FUNCTION_SLEEPS() implementation.

Indeed, it's a nice realization of Dave's idea, very clever.

On the minor niggle side, I think "MUST_HOLD" scans better than
"MUST_HOLD_SPIN", since the former is closer to the way we say it when
we're talking amongst ourselves.

-- 
Daniel
