Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTJXHDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJXHDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:03:15 -0400
Received: from twin.jikos.cz ([213.151.79.26]:10625 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S262056AbTJXHDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:03:13 -0400
Date: Fri, 24 Oct 2003 09:03:01 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: Nathan Scott <nathans@sgi.com>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.0-test8 XFS bug
In-Reply-To: <20031024000951.GH858@frodo>
Message-ID: <Pine.LNX.4.58.0310240853500.30731@twin.jikos.cz>
References: <Pine.LNX.4.58.0310232336180.6971@twin.jikos.cz> <20031024000951.GH858@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003, Nathan Scott wrote:

> > I've installed 2.6.0-test8 on machine attached to HW raid, made 5.5TB 
> 5.5 Tb -- are you using the LBD option, or a 64 bit platform?

Using LBD.

> > partition (using LVM) and made XFS filesystem on this partition. This 
> > partittion was exported to cca 25 nodes. I started some stress tests 
> What does that mean?  (cca?)  thanks.

It means 'approximately'. To be more precise, there were 24 nodes copying 
data to and from the partition via NFS.

> > Oct 22 13:12:56 storage2 kernel: Filesystem "dm-0": XFS internal error xfs_alloc_read_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01e8f5c
> > Oct 22 13:12:56 storage2 kernel: Call Trace:
> > Oct 22 13:12:56 storage2 kernel:  [<c01e93d4>] xfs_alloc_read_agf+0x19e/0x214
> > Oct 22 13:12:56 storage2 kernel:  [<c01e8f5c>] xfs_alloc_fix_freelist+0x458/0x46e
> > Oct 22 13:12:56 storage2 last message repeated 2 times
> > Oct 22 13:12:56 storage2 kernel:  [<c023cdf8>] xfs_trans_log_buf+0x6e/0xa8
> > Oct 22 13:12:56 storage2 kernel:  [<c0204733>] xfs_bmbt_get_state+0x2f/0x3c
> > Oct 22 13:12:56 storage2 kernel:  [<c01e973e>] xfs_alloc_vextent+0x2f4/0x520
> > Oct 22 13:12:56 storage2 kernel:  [<c01f89d9>] xfs_bmap_alloc+0x8eb/0x1856
> > Oct 22 13:12:56 storage2 kernel:  [<c02515b0>] xfs_iomap_write_delay+0x35e/0x40a
> You're allocating real disk space for delayed allocate file data
> down this path, and the read of the allocation group header found
> something that didn't look at all like metadata on disk.
> So, you definately have corruption and will need to xfs_repair.
> Any ideas as to what operations triggered the initial problem?
> (is it reproducible for you?)

I can simply reproduce it - the only thing needed is to nfsmount this
partition from clients and start writing a file to it, as I've written
before. The crash occurs immediately after the transfer begins.

As I've said, I wouldn't blame HW failure or things like this, because 
ext3 does the job flawlessly, as far as I can see.

-- 
JiKos.
