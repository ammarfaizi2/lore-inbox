Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280986AbRKLUnJ>; Mon, 12 Nov 2001 15:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280988AbRKLUm5>; Mon, 12 Nov 2001 15:42:57 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:50960 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280982AbRKLUmO>; Mon, 12 Nov 2001 15:42:14 -0500
Message-ID: <3BF03402.87D44589@zip.com.au>
Date: Mon, 12 Nov 2001 12:41:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <3BF02702.34C21E75@zip.com.au>,
		<00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
		<3BEFF9D1.3CC01AB3@zip.com.au>
		<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> 
		<3BF02702.34C21E75@zip.com.au> <1005595583.13307.5.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> ...
> This all works OK when the filesystem is not bursting at the seams,
> and when there is some correspondence between logical block numbers
> in the filesystem and physical drives underneath. I believe that once
> you get into complex filesystems using raid devices and smart caching
> drives it gets very hard for the filesystem to predict anything
> about latency of access for two blocks which it things are next
> to each other in the filesystem.
> 

Well, file systems have for all time made efforts to write things
out contiguously.  If an IO system were to come along and deoptimise
that case it'd be pretty broken?
  
> ...
> 
> There is a lot of difference between doing a raw read of data from
> the device, and copying a large directory tree. The raw read is
> purely sequential, the tree copy is basically random access since
> the kernel is being asked to read and then write a lot of small
> chunks of disk space.

hum. Yes.  Copying a tree from and to the same disk won't
achieve disk bandwidth.  If they're different disks then
ext2+Orlov will actually get there.

We in fact do extremely well on IDE with Orlov for this workload,
even though we're not doing inter-inode readahead.  This will be because
the disk is doing the readhead for us.   It's going to be highly dependent
upon the disk cache size, readahead cache partitioning algorithm, etc.

BTW, I've been trying to hunt down a suitable file system aging tool.
We're not very happy with Keith Smith's workload because the directory
infomation was lost (he was purely studying FFS algorithmic differences
- the load isn't 100% suitable for testing other filesystems / algorithms).  Constantin Loizides' tools are proving to be rather complex to compile,
drive and understand.  Does the XFS team have anything like this in the
kitbag?

-
