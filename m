Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135829AbRDTJAl>; Fri, 20 Apr 2001 05:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135830AbRDTJAZ>; Fri, 20 Apr 2001 05:00:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18679 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135829AbRDTJAK>;
	Fri, 20 Apr 2001 05:00:10 -0400
Date: Fri, 20 Apr 2001 05:00:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        autofs@linux.kernel.org
Subject: Re: Fix for SMP deadlock in autofs4
In-Reply-To: <20010420014940.F8578@goop.org>
Message-ID: <Pine.GSO.4.21.0104200457520.21455-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Jeremy Fitzhardinge wrote:

> This is a fix for a potential deadlock in autofs4's expire routine.
> It tries to use dput() while holding the dcache_lock.  This isn't a
> problem in principle since dput() should only try to take the dcache_lock
> when the counter makes a transition to zero, which can't happen in
> this case.  Unfortunately the generic (and only) implementation of
> atomic_dec_and_lock always takes the lock, so deadlocks.

Frankly, I'd rather add dput_locked() in dcache.c. The bug is real and
since autofs4 is not the only place like that... I'll look into that
stuff.
							Al

