Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLEXCb>; Tue, 5 Dec 2000 18:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbQLEXCV>; Tue, 5 Dec 2000 18:02:21 -0500
Received: from 194-73-188-168.btconnect.com ([194.73.188.168]:19721 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129257AbQLEXCF>;
	Tue, 5 Dec 2000 18:02:05 -0500
Date: Tue, 5 Dec 2000 22:32:49 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre5] optimized get_empty_filp()
In-Reply-To: <20001205160014.G6567@cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012052229190.1683-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Peter Samuelson wrote:
> [Tigran Aivazian]
> > The only reason one could think of was to "hold the lock for as short
> > time as possible" but a minute's thought reveals that such reason is
> > invalid (i.e. one is more likely to waste time spinning on the lock
> > than to save it by dropping/retaking it, given the relative duration
> > of the instructions we execute there without the lock).
> 
> If there is no contention, you do not spin, no time wasted

wrong -- time is wasted -- 1 decb for lock and 1 movb for unlock. No time
is wasted on spinning but 2 instructions wasted for taking/dropping the
lock.

> 
> If there *is* contention, you deserialize the routine just a little
> bit, which is generally a Good Thing.
> 
> Whether a memset of 92 bytes (on 32-bit arch), plus an atomic_set(),
> are worth deserializing, I do not know.
> 

Of course, they are worth it. Actually, I don't understand how can you
even doubt it? Even a single cycle of code executed for _no reason_ must
be removed, if for no other reason than to make the code easier to
understand and prevent people from asking questions like "why does X do Y
for no reason?" -- if there are no such items "Y" then the questions will
also cease.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
