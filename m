Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136816AbRASWBs>; Fri, 19 Jan 2001 17:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136814AbRASWB2>; Fri, 19 Jan 2001 17:01:28 -0500
Received: from [194.213.32.137] ([194.213.32.137]:8196 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S136808AbRASWB0>;
	Fri, 19 Jan 2001 17:01:26 -0500
Date: Sat, 1 Jan 2000 02:02:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
Message-ID: <20000101020220.A26@(none)>
In-Reply-To: <Pine.LNX.4.10.10101152056170.12667-100000@penguin.transmeta.com> <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 10:48:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	struct safe_kpointer {
> 		void *kaddr;
> 		unsigned long fingerprint[4];
> 	};
> 
> the kernel can validate kaddr by 1) validating the pointer via the master
> fingerprint (every valid kernel pointer must point to a structure that
> starts with the master fingerprint's copy). Then usage-permissions are
> validated by checking the file fingerprint (the per-object fingerprint).
> 
> this is a safe, very fast [ O(1) ] object-permission model. (it's a
> variation of a former idea of yours.) A process can pass object
> fingerprints and kernel pointers to other processes too - thus the other
> process can access the object too. Threads will 'naturally' share objects,
> because fingerprints are typically stored in memory.

I do not know if I'd trust this.

First, 

(fd < current->fdlimit && current->fdlist[fd])

if O(1), too. Sure, passing those is slightly hard, but we can do that already.
With your proposal, all hopes for fuser and revoke are out.

Ouch; you say process can pass it to other process. How will kernel know not
to free fd until _both_ freed it?

Plus, you are playing tricks with random numbers. Up to now, only ssh and 
similar depended on random numbers. Now kernel relies on them during boot.
Notice that most important "master fingerprint" is generated first. At that
timeyou might not have enough entropy in your pools.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
