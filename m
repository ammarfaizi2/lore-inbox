Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbUKUXYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUKUXYA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUKUXYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:24:00 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:9438 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261842AbUKUXX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:23:57 -0500
Date: Mon, 22 Nov 2004 09:21:23 +1100
From: Nathan Scott <nathans@sgi.com>
To: tridge@samba.org
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: performance of filesystem xattrs with Samba4
Message-ID: <20041121222123.GB704@frodo>
References: <1098383538.987.359.camel@new.localdomain> <16797.41728.984065.479474@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16797.41728.984065.479474@samba.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Nov 19, 2004 at 06:38:40PM +1100, tridge@samba.org wrote:
> ...
> The biggest change from the kernels point of view is that Samba4 makes
> extensive use of filesystem xattrs. Almost every file with have a
> ...
> I started some simple benchmarking today using the BENCH-NBENCH
> smbtorture benchmark, with 10 simulated clients and loopback
> networking on a dual Xeon server with 2G ram and a 50G scsi partition.
> I used a 2.6.10-rc2 kernel. This benchmark only involves a
> user.DosAttrib xattr of size 44 on every file (that will be the most
> common situation in production use).
> ...
> xfs                 62 MB/sec
> xfs+xattr           40 MB/sec
> xfs+2Kinode         63 MB/sec
> xfs+xattr+2Kinode   58 MB/sec
> ...
> The XFS results with default options are rather disappointing, as XFS
> has usually been a good performer for Samba workloads. Increasing the
> inode size to 2k brought it back to a more reasonable level.

Interesting.  There's been on-and-off discussion for some time
as to whether the default mkfs parameters should be changed,
this will add more fuel to that debate I expect.

I'm curious why you went to 2K inodes instead of 512 - I guess
because thats the largest inode size with a 4K blocksize?  If
the defaults were changed, I expect it would be to switch over
to 512 byte inodes - do you have numbers for that?

> To make it easier to benchmark with xattrs, I'm planning on doing a
> new version of dbench with optional xattr support. That will allow
> others to play with xattr performance for the above workload without

Ah great, thanks, I'll be keen to try that when its available.

cheers.

-- 
Nathan
