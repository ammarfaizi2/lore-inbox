Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135906AbRDZULz>; Thu, 26 Apr 2001 16:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135909AbRDZULq>; Thu, 26 Apr 2001 16:11:46 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50962 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135905AbRDZULm>; Thu, 26 Apr 2001 16:11:42 -0400
Date: Thu, 26 Apr 2001 13:08:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0104261554050.15385-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Alexander Viro wrote:
> On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> >
> > how can the read in progress see a branch that we didn't spliced yet? We
>
> fd = open("/dev/hda1", O_RDONLY);
> read(fd, buf, sizeof(buf));

Note that I think all these arguments are fairly bogus.  Doing things like
"dump" on a live filesystem is stupid and dangerous (in my opinion it is
stupid and dangerous to use "dump" at _all_, but that's a whole 'nother
discussion in itself), and there really are no valid uses for opening a
block device that is already mounted. More importantly, I don't think
anybody actually does.

The fact that you _can_ do so makes the patch valid, and I do agree with
Al on the "least surprise" issue. I've already applied the patch, in fact.
But the fact is that nobody should ever do the thing that could cause
problems.

		Linus

