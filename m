Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRKFCSV>; Mon, 5 Nov 2001 21:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKFCSB>; Mon, 5 Nov 2001 21:18:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56838 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277514AbRKFCRy>; Mon, 5 Nov 2001 21:17:54 -0500
Date: Mon, 5 Nov 2001 18:14:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: David Dyck <dcd@tc.fluke.com>, <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: 2.4.14 doesn't compile: deactivate_page not defined in loop.c
In-Reply-To: <20011106025056.D31912@athlon.random>
Message-ID: <Pine.LNX.4.33.0111051811560.1710-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Nov 2001, Andrea Arcangeli wrote:
>
> no idea why deactivate_page disappeared, it made sense to deactivate the
> lower level cache

Answer me this:

How would it get activated in the first place?

Right. By being accessed multiple times, that's how. Which you claim it
won't be - in which case de-activating it is a no-op, and unnecessary.

Now, there's another possibility: that it _does_ get accessed multiple
times, _despite_ being the lower-level cache. In which case de-activating
it is the wrong thing to do.

So we basically have two cases. And in neither case does it make sense to
de-activate the page. Eh?

		Linus

