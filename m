Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317599AbSGLEfv>; Fri, 12 Jul 2002 00:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGLEfu>; Fri, 12 Jul 2002 00:35:50 -0400
Received: from zok.SGI.COM ([204.94.215.101]:15298 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317599AbSGLEft>;
	Fri, 12 Jul 2002 00:35:49 -0400
Date: Thu, 11 Jul 2002 21:38:34 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: pmenage@ensim.com
Cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Message-ID: <20020712043834.GA710558@sgi.com>
Mail-Followup-To: pmenage@ensim.com, Daniel Phillips <phillips@arcor.de>,
	linux-kernel@vger.kernel.org
References: <0C01A29FBAE24448A792F5C68F5EA47D2B0FDD@nasdaq.ms.ensim.com> <E17SpMA-0008OG-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17SpMA-0008OG-00@pmenage-dt.ensim.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 06:36:26PM -0700, pmenage@ensim.com wrote:
> The spin_assert_unlocked() macro in Jesse's patch doesn't cope with
> the fact that someone else might quite legitimately have the spinlock
> locked. You'd need debugging spinlocks that track the owner of the
> spinlock, and then check in MUST_NOT_HOLD() you'd check that
> lock->owner != current. You'd also have to have some special
> non-checking lock/unlock macros to handle situations where locks are
> taken in non-process context or released by someone other than the
> original locker (does the migration code still do that?).

You're right about that, it would be much more useful to add a
spin_assert_unlocked_all() or MUST_NOT_HOLD_ANY() macro, as Arnd
suggested.  I'll take the suggestions I've received and try to put
together a more complete patch early next week.  It'll include lock
checks for rwlocks, semaphores, and rwsems as well as the global
no-locks-held macro.  And as an added bonus, I'll even try to test it
:).

Thanks,
Jesse
