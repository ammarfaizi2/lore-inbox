Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTIITKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTIITKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:10:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59148
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264271AbTIITKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:10:25 -0400
Date: Tue, 9 Sep 2003 12:10:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030909191044.GB28279@matchmail.com>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Nikita Danilov <god@namesys.com>
References: <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com> <20030908222457.GB17441@matchmail.com> <20030909070421.GJ10487@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909070421.GJ10487@namesys.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 11:04:21AM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Sep 08, 2003 at 03:24:57PM -0700, Mike Fedyk wrote:
> > > You only can have as many inodes as number of blocks on the fs (at least that's the limit imposed on you
> > > by mke2fs).
> > True, but not exactly.  Each file will need one block to store even one byte
> > on ext2/3.  But your inode tables have about 1/4-1/2 the number of inode entries to
> > blocks.  This can be changed at mkfs time though.
> 
> Yes, I know this. 

I figured you did, as the explanation was mostly for people who don't.

> But my experiments quickly shown that if you ask mkfs to create inode tables with
> free inodes that exceed blocks count for the device, then mkfs will only create as much free inodes
> as there are free blocks on the device (I was needing that when I experimented with 60 millions files
> on ext2/reiserfs/xfs and stuff and I only had 20G partition.)
> 

Hmm, didn't know this, but it makes sence for ext2/3 since they use 1 block
per file/directory.  It wouldn't do much good to waste more space for inode
tables than you could even theoretically use.

> > Hmm, take ext3 with htree, reiser3 & reiser4 (choose the block size 1k, 2k or 4k) with
> 
> reiser4 does not have support for blocksize different from page size for now (sigh, same old problems
> we finally solved for reiser3 recently).
> 

Interesting, somewhere I think I saw that it was using 512 byte blocks, but
don't ask me where I saw that or who said it.

> > tail merging off, 1k files per directory and all files the same size as
> > block size with 40M files.  How would the table look as far as space effency
> 
> Hm. I will probably try this once.
> For reiserfs:
> I can tell you that 60M+ empty files (cannot remember exact number, but I still have the script to create those)
> took ~5.5G of space. 

With how many directories?  Do you run into drive speed limitations with
that much meta-data, or are there still bottlenecks in the
journaling/hashing to deal with? How big are the reiser3/4 equivalents to
inodes?  In ext2/3 they're currently 128 bytes I believe plus some static
bitmaps in the block groups.  The only thing variable in ext2/3 are the
directory sizes (and they don't shrink... :( )

> Then 60M * 4k is 240G, all these blocks are referenced by leafnodes, ~1000 pointers fits into one node,
> so we will spend ~245M for block pointers (extra 5 because there are more layers of indirections).
> 
> > look comparing them?  For that matter, how do JFS & XFS compare?
> 
> Unfortunatelly I never had the patience to wait until XFS creates 60M files. Have not tried jfs.
> 

Hmm, isn't XFS slower than ext2/3 in that regard?
