Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWCaGmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWCaGmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWCaGmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:42:13 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:34754 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751119AbWCaGmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:42:12 -0500
Date: Thu, 30 Mar 2006 23:42:09 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060331064209.GH17364@schatzie.adilger.int>
Mail-Followup-To: Mingming Cao <cmm@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
	Laurent Vivier <Laurent.Vivier@bull.net>,
	linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com> <20060330174008.GW5030@schatzie.adilger.int> <1143746202.3896.32.camel@dyn9047017067.beaverton.ibm.com> <1143746561.3896.35.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143746561.3896.35.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 30, 2006  11:22 -0800, Mingming Cao wrote:
> I made a kernel patch to allow a file to specify which block group it
> wants it's blocks to allocate from(using ioctl to set the goal
> allocation block group). I set the goal block group falls to somewhere
> >8TB, and did dd tests on that file. Verified this with debugfs, the
> allocated block numbers are beyond 2**31.
> 
> Also before run fsx tests, created many directories (32768 at most:) and
> verified one directory's inode is located in block group >8TB space. So
> when we do fsx test on files under that directory, we are
> creating/testing files >8TB.

While useful, I don't think it is critical.  As you mention, it is possible
to do this by creating a lot of directories, though it might be tedious
(need over 16k directories for a 2TB filesystem, 64k for an 8TB fs).

Also, since this increases the allocation for each inode's reservation from
16 bytes to 20 (really 32 because it is in a slab), it might have a small
performance hit.

If it was available under some sort of compile-time configuration option
it might make sense for developers.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

