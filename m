Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133047AbRDLFpe>; Thu, 12 Apr 2001 01:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133054AbRDLFpZ>; Thu, 12 Apr 2001 01:45:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10475 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133047AbRDLFpK>;
	Thu, 12 Apr 2001 01:45:10 -0400
Date: Thu, 12 Apr 2001 01:45:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: kowalski@datrix.co.za, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <200104120448.f3C4mtlD016247@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0104120110210.18135-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Apr 2001, Andreas Dilger wrote:

> I just discovered a similar problem when testing Daniel Philip's new ext2
> directory indexing code with bonnie++.  I was running bonnie under single
> user mode (basically nothing else running) to create 100k files with 1 data
> block each (in a single directory).  This would create a directory about
> 8MB in size, 32MB of dirty inode tables, and about 400M of dirty buffers.
> I have 128MB RAM, no swap for the testing.
> 
> In short order, my single user shell was OOM killed, and in another test
> bonnie was OOM-killed (even though the process itself is only 8MB in size).
> There were 80k entries each of icache and dcache (38MB and 10MB respectively)
> and only dirty buffers otherwise.  Clearly we need some VM pressure on the
> icache and dcache in this case.  Probably also need more agressive flushing
> of dirty buffers before invoking OOM.

We _have_ VM pressure there. However, such loads had never been used, so
there's no wonder that system gets unbalanced under them.

I suspect that simple replacement of goto next; with continue; in the
fs/dcache.c::prune_dcache() may make situation seriously better.

								Al

