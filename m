Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbUAPUer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUAPUer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:34:47 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:482 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265830AbUAPUel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:34:41 -0500
Date: Fri, 16 Jan 2004 12:34:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ravi Wijayaratne <ravi_wija@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Page Cache performance
Message-ID: <20040116203431.GQ1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Ravi Wijayaratne <ravi_wija@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20040116191102.98783.qmail@web40602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116191102.98783.qmail@web40602.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 11:11:02AM -0800, Ravi Wijayaratne wrote:
> Hi All.
> 
> We are running dbench on a machine with Dual Xeon (Hyper threading 

First off, dbench is a bad benchmark to tune for, it shows better numbers
for worse fairness.

Is yourworkload like dbench?  What will your workload be?

> turned off), 1GB RAM
> and 4 Drive software RAID5. The kernel is 2.4.29-xfs 1.2. We are using 
> LVM. However
> similar test done using ext2 on a disk partiotion (no md or LVM) shows 
> 
> The throughput is find till the number of clients are Around 16. At 
> that point the throughput
> plummets about 40%. We are trying to avoid that and see how we could 
> have a consistent throughput
> perhaps sacrificing some peak performance.
> 
> One could argue that at the point the performance drops we are actualy 
> beggining to see 
> I/O requests missing page cache and going to disk. That is our current 
> guess. We try to tune
> the buffer age and the interval page buffer daemon runs, but had no 
> effect on the curve.
> So transactional meta data operations seems not be causing the bottle 
> neck.
> 
> Are there any VM patches that smooths out the Page Cache dirty page 
> swapping process so that we

Of course, there's 2.4.24 which has XFS merged for you, and be sure to give
2.4.25-pre6 a try since it integrates part of the -aa VM for inodes in
highmem.

> wont see this sudden drop of through put, but could have a smoother 
> transition. I ran a 
> kernel profiler on the test and I dont see any dentry cache flushes or 
> inode cache flushes.
> 
> Similar test done using ext2 on a disk partiotion (no md or LVM) shows 
> us similar performances.
> However for ext2 when we tweak the bdflush parameters in /proc 
> (specifically the max age of meta
> data buffers) we can push the point where the data throughput falls to 
> around 40 clients. 
> 
> But we are more interested in finding out ways to solve the XFS case.
> 

There are options in XFS that change the layout of the filesystem that might
help (can't say more since I'm not too familiar with XFS).

Try without highmem, and see if that changes your results, and try with a
benchmark that behaves similair to how you expect from your workload.

Also, there's 2.6 which will give different characteristics, and especially
with the disk IO schedulers available there.
