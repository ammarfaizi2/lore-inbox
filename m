Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264430AbRFIRp6>; Sat, 9 Jun 2001 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264442AbRFIRps>; Sat, 9 Jun 2001 13:45:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50913 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264430AbRFIRpb>;
	Sat, 9 Jun 2001 13:45:31 -0400
Date: Sat, 9 Jun 2001 13:45:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
In-Reply-To: <9ftmk0$pdh$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0106091341440.19361-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jun 2001, Linus Torvalds wrote:

> The big kernel lock rules are that it's a "normal spinlock" in many
> regards, BUT you can block while holding it, and the BKL will magically
> be released during the blocking.  This means, for example, that the BKL
> can never deadlock with a semaphore - if a BKL holder blocks on sombody
> elses semaphore (and that somebody else wants the BKL), then the act of
> blocking on the semaphore will release the BKL, and allow the original
> semaphore holder to continue. 

Another difference from spinlocks is that BKL is recursive. I'm
actually surprised that it didn't show up first.

