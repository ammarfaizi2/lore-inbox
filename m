Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbQLEURM>; Tue, 5 Dec 2000 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLEURC>; Tue, 5 Dec 2000 15:17:02 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:49927 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129562AbQLEUQv>;
	Tue, 5 Dec 2000 15:16:51 -0500
Date: Tue, 5 Dec 2000 19:48:25 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: check_lock() in d_move() and switch_names()?
In-Reply-To: <Pine.GSO.4.21.0012051437430.12284-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012051944320.1493-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Alexander Viro wrote:
> > The check for BKL in d_move() and switch_names() seem to be unnecessary as
> > d_move() takes dcache_lock and switch_names() is only called by
> > d_move(). So, if the callers take BKL just for the sake of d_move() they
> > do not need to, but if, for other reasons, then that is fine. In any case,
> > the checks in both functions can be removed, imho. Opinions?
> 
> Tigran, _please_ stop it. d_move() needs BKL. Test in question is a
> sanity check _and_ reminder of that fact, so please leave it in place. 
> Microoptimizations are OK when they make the code cleaner, but here...

Alexander, in one point at least you are wrong. That one point is -- I did
_not_ suggest any optimizations (especially microoptimizations). I was
merely trying to see exactly _why_ d_move() needs a BKL since it takes
dcache_lock which already protects the lists which d_move manipulats. 

You did, however provide useful information, namely the statement "d_move
needs BKL", albeit, without any proof to the truth thereof. So, I'll look
closer and try to find the proof myself.

Thank you,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
