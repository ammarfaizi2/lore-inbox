Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281449AbRKFDtq>; Mon, 5 Nov 2001 22:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281453AbRKFDth>; Mon, 5 Nov 2001 22:49:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40597 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281449AbRKFDte>;
	Mon, 5 Nov 2001 22:49:34 -0500
Date: Mon, 5 Nov 2001 22:49:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.LNX.4.33.0111051748250.1710-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111052236001.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Linus Torvalds wrote:

> One such improvement has already been put on the table: remove the
> algorithm, and make it purely greedy.

OK, some digging had brought another one:

a) if it's first-level directory - get it the fsck out of root's cylinder
group.
b) if we just keep creating directories in a cylinder group and do not
create any files there - stop, it's no good (i.e. there's a limit on
number of back-to-back directory creations in the same group).
c) try putting it into the parent's CG, but reserve some number of inodes
and data blocks in it.  If we can't - tough, get the fsck out of there.

>From the first reading of the code (aside of general yuck wrt style,
but that's actually more about the older code in there) it seems to
be reasonable.  It should solve the problem with fast-growth scenario
and it puts some effort to avoid nastiness with slow-growth one.

