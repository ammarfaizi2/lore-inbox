Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130144AbRBVH3r>; Thu, 22 Feb 2001 02:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRBVH32>; Thu, 22 Feb 2001 02:29:28 -0500
Received: from hermes.mixx.net ([212.84.196.2]:63755 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130144AbRBVH3Z>;
	Thu, 22 Feb 2001 02:29:25 -0500
From: Daniel Phillips <phillips@innominate.de>
To: tytso@valinux.com, phillips@innominate.de
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
Date: Thu, 22 Feb 2001 08:24:08 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Linux-kernel@vger.kernel.org, adilger@turbolinux.com, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <01022020011905.18944@gimli> <E14Vp9h-0001IB-00@beefcake.hdqt.valinux.com>
In-Reply-To: <E14Vp9h-0001IB-00@beefcake.hdqt.valinux.com>
MIME-Version: 1.0
Message-Id: <01022208282404.25968@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, tytso@valinux.com wrote:
> A couple of comments.  If you make the beginning of each index block
> look like a an empty directory block (i.e, the first 8 blocks look like
> this):
> 
> 	32 bits: ino == 0
> 	16 bits: rec_len == blocksize
> 	16 bits: name_len = 0
> 
> ... then you will have full backwards compatibility, both for reading
> *and* writing.  When reading, old kernels will simply ignore the index
> blocks, since it looks like it has an unpopulated directory entry.  And
> if the kernel attempts to write into the directory, it will clear the
> BTREE_FL flag, in which case new kernels won't treat the directory as a
> tree anymore.  (Running a smart e2fsck which knows about directory trees
> will be able to restore the tree structure).

:-)  That's really nice, now I see what you were thinking about with
all those bit clears.

> Is it worth it?  Well, it means you lose an index entry from each
> directory block, thus reducing your fanout at each node of the tree by a
> worse case of 0.7% in the worst case (1k blocksize) and 0.2% if you're
> using 4k blocksizes.

I'll leave that up to somebody else - we now have two alternatives, the
100%, no-compromise INCOMPAT solution, and the slightly-bruised but
still largely intact forward compatible solution.  I'll maintain both
solutions for now code so it's just as easy to choose either in the end.

-- 
Daniel
