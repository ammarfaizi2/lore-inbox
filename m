Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSFDUWn>; Tue, 4 Jun 2002 16:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSFDUWm>; Tue, 4 Jun 2002 16:22:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46866 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316684AbSFDUWk>; Tue, 4 Jun 2002 16:22:40 -0400
Date: Tue, 4 Jun 2002 13:23:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CFD1FF0.4A02CE96@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206041320280.29100-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jun 2002, Andrew Morton wrote:
>
> But after the vma has been destroyed (the application did exit()),
> the dirty pagecache data against the sparse mapped file still
> hasn't been written, and still doesn't have a disk mapping.
>
> So in this case, we have an inode which still has pending block
> allocations which has no struct file's pointing at it.  Or
> am I wrong?

I think you're right..

> The current preallocation will screw up is when there's a
> large-and-sparse file which has blocks being allocated against it
> at two or more offsets.  And those allocations are for a large number
> of blocks, and they are proceeding slowly.

Sure. However, I don't think it should come as any surprise to anybody
that trying to write to two different points in the same file is a bad
idea. _regardless_ of whether you do pre-allocation or not, and whether
the pre-allocation is on the inode or file level.

I'd still love to see a "fast and slightly stupid" allocator for both
blocks and inodes, and have some infrastructure to do run-time defragging
in the background.

		Linus

