Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130062AbRBZAgf>; Sun, 25 Feb 2001 19:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130064AbRBZAgZ>; Sun, 25 Feb 2001 19:36:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38799 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130062AbRBZAgM>;
	Sun, 25 Feb 2001 19:36:12 -0500
Date: Sun, 25 Feb 2001 19:36:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Nate Eldredge <neldredge@hmc.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac3: loop threads in D state
In-Reply-To: <20010226013326.X7830@suse.de>
Message-ID: <Pine.GSO.4.21.0102251935120.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Feb 2001, Jens Axboe wrote:

> On Sun, Feb 25 2001, Alexander Viro wrote:
> > Erm... Jens, it really should be
> > 	if (atomic_dec_and_test(...))
> > 		up(...);
> > not just
> > 	atomic_dec(...);
> > 	up(...);
> > 
> > Otherwise you can end up with too early exit of loop_thread. Normally
> > it would not matter, but in pathological cases...
> 
> How so? We dec it and up the semaphore, loop_thread runs until it's
> done and ups lo_sem.

You are risking an extra up() here. Think what happens if you already had a
pending request.


