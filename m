Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315263AbSEQBRm>; Thu, 16 May 2002 21:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSEQBRl>; Thu, 16 May 2002 21:17:41 -0400
Received: from dsl-213-023-040-248.arcor-ip.net ([213.23.40.248]:17129 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315263AbSEQBRk>;
	Thu, 16 May 2002 21:17:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [PATCH] remove 2TB block device limit
Date: Fri, 17 May 2002 03:17:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: davidm@hpl.hp.com, Peter Chubb <peter@chubb.wattle.id.au>,
        Jeremy Andrews <jeremy@kerneltrap.org>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au> <E178Rlf-0008Tj-00@starship> <20020516225451.GO12975@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178WMx-0008W1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 May 2002 00:54, Andreas Dilger wrote:
> A minor question is whether to cap it at 65536 blocks/group or 65528?
> (The number of blocks per group must be a multiple of 8).
> 
> The current layout is such that you will _always_ have at least 3
> blocks in use for each group.  However, if we implement Ted's
> "metagroup" layout (which puts all of a group's bitmaps/itable blocks
> in the first group of its block of group descriptors) then there could
> be cases where a group has no blocks in use, and the free count will
> overflow.
> 
> Having the upper limit at 65536 is aesthetically pleasing, and it aligns
> nicely with LVM (which allocates chunks in power-of-two sizes), but may
> preclude changing such a filesystem to the metagroup layout without a
> larger effort on the resizer's part.  I'll go with 65528 I guess.

I like 65536 as well, but it's easy to relax your slightly lower limit
later if the metagroup design changes, and would not require a compatibility
flag, while tightening it would be a major pain.

> Note that going to a metagroup layout would also grow the distance
> between the itable and possible blocks quadratically (the number of
> group descriptors that fit into a block also grows with blocksize),
> but at least it is not cubic growth.  That said, the metagroup layout
> is probably only useful for cases where you _know_ you want huge files
> (in the multi-GB range) and locality of blocks to the single inode block
> is irrelevant.

-- 
Daniel
