Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132860AbRDZPqR>; Thu, 26 Apr 2001 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133062AbRDZPqH>; Thu, 26 Apr 2001 11:46:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:49944 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132860AbRDZPp7>; Thu, 26 Apr 2001 11:45:59 -0400
Date: Thu, 26 Apr 2001 17:45:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob McElrath <rsmcelrath@students.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: it isn't aa's rwsem-generic-6 bug but something else [Re: aa's rwsem-generic-6 bug?  Process stuck in 'R' state.]
Message-ID: <20010426174553.B819@athlon.random>
In-Reply-To: <20010425223939.A26763@draal.physics.wisc.edu> <20010426061110.A819@athlon.random> <20010426003802.A738@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010426003802.A738@draal.physics.wisc.edu>; from rsmcelrath@students.wisc.edu on Thu, Apr 26, 2001 at 12:38:02AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 12:38:02AM -0500, Bob McElrath wrote:
> When I posted this bug originally, you came right out and said it was
> probably the rwsemaphores.  I really have no idea how the rwsemaphores

You were talking about the ps table hang when I told you about the rwsem
races. I had the same trouble on my alpha and I reproduced the races
trivially by lanucing:

	make MAKE='make -j2' -j2 &

	while :; do ps xa ; sleep 1 ; done

After a few seconds ps deadlocked. Try that on the old asm semaphores.

It was 100% reproducible, and after I rewrote the rwsemaphores the
deadlock gone away completly.

Your X hanging in R state is completly unrelated to the rwsem ps table
hang problem as far I can tell.

> I'm running a debug X build at this point, and have identified at least

If you can reproduce without starting X I will be interested in fixing
the hang. Maybe you have a graphics card with a fb driver that doesn't
need VESA that maybe works on the alpha, then you could run X without
privilegies. (btw, in theory we could make the VESA thing working as
well using the x86 emulator in SRM but nobody attempted to implement
that yet)

> instead of gcc...then figured what the hell)  The rest were with egcs
> 1.1.2.  I'll use egcs 1.1.2 in the future.

good.

Andrea
