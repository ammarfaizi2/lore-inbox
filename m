Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136051AbRAJR7W>; Wed, 10 Jan 2001 12:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136050AbRAJR7L>; Wed, 10 Jan 2001 12:59:11 -0500
Received: from slc743.modem.xmission.com ([166.70.7.235]:21771 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S135335AbRAJR7C>; Wed, 10 Jan 2001 12:59:02 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101092255510.3414-100000@penguin.transmeta.com> <18634.979127163@redhat.com> <20010110155624.D19503@athlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Jan 2001 10:46:07 -0700
In-Reply-To: Andrea Arcangeli's message of "Wed, 10 Jan 2001 15:56:24 +0100"
Message-ID: <m1elybgv1c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Wed, Jan 10, 2001 at 11:46:03AM +0000, David Woodhouse wrote:
> > So the VM code spends a fair amount of time scanning lists of pages which 
> > it really can't do anything about?
> 
> Yes.
> 
> > Would it be possible to put such pages on different list, so that the VM
> 
> Currently to unmap the other pages we have to waste time on those unfreeable
> pages as well.
> 
> Once I or other developer finishes with the reverse lookup from page to
> pte-chain (an implementation from DaveM just exists) we'll be able to put them
> in a separate lru, but it's certainly not a 2.4.1-pre2 thing.

Why do we even want to do reverse page tables?
It seems everyone is assuming this is a good thing and except for being
a touch more flexible I don't see what this buys us (besides more locked memory).

My impression with the MM stuff is that everyone except linux is
trying hard to clone BSD instead of thinking through the issues
ourselves.

And because of the extra overhead this doesn't look to be a win on a
heavily loaded box with no swap.  And probably only glibc mmaped.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
