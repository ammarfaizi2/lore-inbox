Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130117AbQLZMcp>; Tue, 26 Dec 2000 07:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130196AbQLZMcf>; Tue, 26 Dec 2000 07:32:35 -0500
Received: from colorfullife.com ([216.156.138.34]:64526 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130117AbQLZMc1>;
	Tue, 26 Dec 2000 07:32:27 -0500
Message-ID: <3A4889B7.D13DD3@colorfullife.com>
Date: Tue, 26 Dec 2000 13:06:15 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org,
        tytso@mit.edu, torvalds@transmeta.com
Subject: Re: minor bugs around fork_init
In-Reply-To: <3A44D3F3.522AD08A@colorfullife.com> <20001223233806.A886@veritas.com> <20001224212331.A531@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > * get_pid causes a deadlock when all pid numbers are in use.
> > > In the worst case, only 10900 threads are required to exhaust
> > > the 15 bit pid space.
> >
> > Yes. I posted a patch for 31-bit pids once or twice.
> > There is no great hurry, but on the other hand, it is always
> > better to make these changes long before it is really urgent.
> 
> On 2Gig machine, you should be able to overflow 16 bits. So it is
> quite urgent.

That's another problem!
31 bit uid would be a nice feature for 2.4, but the last time I asked
Linus he answered that the high bits are still reserved.

My patch fixes bugs in the current, 15 bit implementation:
* we don't reserve any threads for root as 2.2 did
* if a user limit allows for > 10900 threads, then that user can cause a
deadlock by using all pid values (one thread can block 3 pid values).
get_pid() will loop forever.
* in theory, 2 threads could get the same pid.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
