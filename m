Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132575AbRDWXkm>; Mon, 23 Apr 2001 19:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDWXkY>; Mon, 23 Apr 2001 19:40:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35081 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132575AbRDWXkM>; Mon, 23 Apr 2001 19:40:12 -0400
Date: Tue, 24 Apr 2001 01:40:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010424014005.V19938@athlon.random>
In-Reply-To: <20010411125731.B6472@draal.physics.wisc.edu> <E14nOzo-0007Ew-00@the-village.bc.nu> <20010413084805.B3118@draal.physics.wisc.edu> <20010417170717.H2696@athlon.random> <20010417102840.B21824@draal.physics.wisc.edu> <20010419112117.E22687@draal.physics.wisc.edu> <20010419191706.D752@athlon.random> <20010423182722.B942@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010423182722.B942@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Mon, Apr 23, 2001 at 06:27:23PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 06:27:23PM -0500, Bob McElrath wrote:
> Well, take that back, I just got it to hang.  Again, this is 2.4.4pre3
> with alpha-numa-3 and rwsem-generic-4.  I saw it upon starting mozilla.
> I also saw some scary filesystem errors that may or may not be related:
>     Apr 23 18:09:40 draal kernel: EXT2-fs error (device sd(8,2)): 
>         ext2_new_block: Free blocks count corrupted for block group 252 

That is probably unrelated to the ps hang. I suspect you are been bitten by the
ext2 metadata corruption (2.4.4pre2 was just fixed but previous kernel wasn't).

> rwsem-generic-6 is the latest from Andrea, I'll build a new 2.4.4pre4
> kernel with these patches and let you know the results.  Have you made

Yes, that's safe.

> changes between rwsem-generic-4 and rwsem-generic-6 that would
> fix/prevent a deadlock?

No, but I think they are two separate issues.

> Let me know if there are any useful tests I could perform.  Would it be
> useful for me to run the rwsem benchmarks you've been using?  Could
> these detect a deadlock situation?

yes to be sure you can run it without my patch and see if it hangs (I never
tried that myself, but I was able to reproduce the ps hang quite easily and it
was quite obviously due the rwsemaphores and it gone away completly after I
used the generic semaphores).

Andrea
