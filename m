Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTJXAN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTJXAN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:13:26 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:28157 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261889AbTJXANZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:13:25 -0400
Date: Fri, 24 Oct 2003 10:09:51 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.6.0-test8 XFS bug
Message-ID: <20031024000951.GH858@frodo>
References: <Pine.LNX.4.58.0310232336180.6971@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310232336180.6971@twin.jikos.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 11:49:59PM +0200, Jirka Kosina wrote:
> Hi,
> 
> I've installed 2.6.0-test8 on machine attached to HW raid, made 5.5TB 

5.5 Tb -- are you using the LBD option, or a 64 bit platform?

> partition (using LVM) and made XFS filesystem on this partition. This 
> partittion was exported to cca 25 nodes. I started some stress tests 
                 ^^^^^^^^^^^^^^^^^^^^^^^^
What does that mean?  (cca?)  thanks.

> ...
> Oct 22 13:12:56 storage2 kernel: Filesystem "dm-0": XFS internal error xfs_alloc_read_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01e8f5c
> Oct 22 13:12:56 storage2 kernel: Call Trace:
> Oct 22 13:12:56 storage2 kernel:  [<c01e93d4>] xfs_alloc_read_agf+0x19e/0x214
> Oct 22 13:12:56 storage2 kernel:  [<c01e8f5c>] xfs_alloc_fix_freelist+0x458/0x46e
> Oct 22 13:12:56 storage2 last message repeated 2 times
> Oct 22 13:12:56 storage2 kernel:  [<c023cdf8>] xfs_trans_log_buf+0x6e/0xa8
> Oct 22 13:12:56 storage2 kernel:  [<c0204733>] xfs_bmbt_get_state+0x2f/0x3c
> Oct 22 13:12:56 storage2 kernel:  [<c01e973e>] xfs_alloc_vextent+0x2f4/0x520
> Oct 22 13:12:56 storage2 kernel:  [<c01f89d9>] xfs_bmap_alloc+0x8eb/0x1856
> Oct 22 13:12:56 storage2 kernel:  [<c02515b0>] xfs_iomap_write_delay+0x35e/0x40a

You're allocating real disk space for delayed allocate file data
down this path, and the read of the allocation group header found
something that didn't look at all like metadata on disk.

So, you definately have corruption and will need to xfs_repair.
Any ideas as to what operations triggered the initial problem?
(is it reproducible for you?)

thanks.

-- 
Nathan
