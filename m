Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRBZAlF>; Sun, 25 Feb 2001 19:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbRBZAk4>; Sun, 25 Feb 2001 19:40:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59542 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130073AbRBZAkn>;
	Sun, 25 Feb 2001 19:40:43 -0500
Date: Sun, 25 Feb 2001 19:40:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
In-Reply-To: <Pine.GSO.4.21.0102251935120.26808-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0102251939230.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Feb 2001, Alexander Viro wrote:

> 
> 
> On Mon, 26 Feb 2001, Jens Axboe wrote:
> 
> > On Sun, Feb 25 2001, Alexander Viro wrote:
> > > Erm... Jens, it really should be
> > > 	if (atomic_dec_and_test(...))
> > > 		up(...);
> > > not just
> > > 	atomic_dec(...);
> > > 	up(...);
> > > 
> > > Otherwise you can end up with too early exit of loop_thread. Normally
> > > it would not matter, but in pathological cases...
> > 
> > How so? We dec it and up the semaphore, loop_thread runs until it's
> > done and ups lo_sem.
> 
> You are risking an extra up() here. Think what happens if you already had a
> pending request.

Let me elaborate: the race is very narrow and takes deliberate efforts to
hit. It _can_ be triggered, unfortunately. This extra up() will mess your
life later on.

