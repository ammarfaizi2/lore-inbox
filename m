Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131012AbRAJSeL>; Wed, 10 Jan 2001 13:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131453AbRAJSdv>; Wed, 10 Jan 2001 13:33:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19472 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131012AbRAJSdt>; Wed, 10 Jan 2001 13:33:49 -0500
Date: Wed, 10 Jan 2001 19:33:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010110193340.D29093@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10101092255510.3414-100000@penguin.transmeta.com> <18634.979127163@redhat.com> <20010110155624.D19503@athlon.random> <m1elybgv1c.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1elybgv1c.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Jan 10, 2001 at 10:46:07AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 10:46:07AM -0700, Eric W. Biederman wrote:
> Why do we even want to do reverse page tables?
> It seems everyone is assuming this is a good thing and except for being

I'm not assuming it's a good thing, but I believe it's something to try.

> My impression with the MM stuff is that everyone except linux is
> trying hard to clone BSD instead of thinking through the issues
> ourselves.

I wasn't even thinking about BSD and I always though about the issues myself,
no panic ;).

> And because of the extra overhead this doesn't look to be a win on a
> heavily loaded box with no swap.  And probably only glibc mmaped.

It can make sense also without swap. We could drop clean pages from the lru
directly that way without wasting time on pages that we don't have a chance to
free (incidentally it's exactly the optimization requested by David W. for
embedded systems).  Note that I'm not convinced that it would be worthwhile to
separate the anonymous and shm pages from the other mapped pages but in theory
we could do that.

I didn't meant that it is certainly the right way to go, but with reverse
lookup we could do very ""interesting"" things and I think it's worthwhile to
research and benchmark what happens (note also that depending on the
implementation very different things can happen at runtime)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
