Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRKFEEv>; Mon, 5 Nov 2001 23:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277728AbRKFEEl>; Mon, 5 Nov 2001 23:04:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47881 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277713AbRKFEE1>; Mon, 5 Nov 2001 23:04:27 -0500
Date: Mon, 5 Nov 2001 20:01:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.GSO.4.21.0111052236001.27713-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0111051953490.1006-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Nov 2001, Alexander Viro wrote:
>
> OK, some digging had brought another one:
>
> a) if it's first-level directory - get it the fsck out of root's cylinder
> group.

Hey, now that you've read it in a paper you like it, but when I suggest it
in email you shoot it down?

<Whiny mode on>  I thought you loved me, Al.  <Whiny mode off>

> b) if we just keep creating directories in a cylinder group and do not
> create any files there - stop, it's no good (i.e. there's a limit on
> number of back-to-back directory creations in the same group).

The current code actually has some vestiges that _seem_ to be trying to do
something like this: see the commented-out

	if (tmp && le16_to_cpu(tmp->bg_used_dirs_count) << 8) <
		   le16_to_cpu(tmp->bg_free_inodes_count)) {

which _seems_ to want to play games with "number of directories allocated
vs nr of free inodes".

But it's commented out with "I am not yet convinced that this next bit is
necessary". I don't know if the code has ever been active, or whether it
showed other problems.

> c) try putting it into the parent's CG, but reserve some number of inodes
> and data blocks in it.  If we can't - tough, get the fsck out of there.

Hmm.. Maybe this is actually closer to what we try to do above..

		Linus

