Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbTIIHEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 03:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbTIIHEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 03:04:30 -0400
Received: from angband.namesys.com ([212.16.7.85]:12491 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263935AbTIIHEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 03:04:22 -0400
Date: Tue, 9 Sep 2003 11:04:21 +0400
From: Oleg Drokin <green@namesys.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030909070421.GJ10487@namesys.com>
References: <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com> <20030908222457.GB17441@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908222457.GB17441@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 08, 2003 at 03:24:57PM -0700, Mike Fedyk wrote:
> > You only can have as many inodes as number of blocks on the fs (at least that's the limit imposed on you
> > by mke2fs).
> True, but not exactly.  Each file will need one block to store even one byte
> on ext2/3.  But your inode tables have about 1/4-1/2 the number of inode entries to
> blocks.  This can be changed at mkfs time though.

Yes, I know this. But my experiments quickly shown that if you ask mkfs to create inode tables with
free inodes that exceed blocks count for the device, then mkfs will only create as much free inodes
as there are free blocks on the device (I was needing that when I experimented with 60 millions files
on ext2/reiserfs/xfs and stuff and I only had 20G partition.)

> Hmm, take ext3 with htree, reiser3 & reiser4 (choose the block size 1k, 2k or 4k) with

reiser4 does not have support for blocksize different from page size for now (sigh, same old problems
we finally solved for reiser3 recently).

> tail merging off, 1k files per directory and all files the same size as
> block size with 40M files.  How would the table look as far as space effency

Hm. I will probably try this once.
For reiserfs:
I can tell you that 60M+ empty files (cannot remember exact number, but I still have the script to create those)
took ~5.5G of space. Then 60M * 4k is 240G, all these blocks are referenced by leafnodes, ~1000 pointers fits into one node,
so we will spend ~245M for block pointers (extra 5 because there are more layers of indirections).

> look comparing them?  For that matter, how do JFS & XFS compare?

Unfortunatelly I never had the patience to wait until XFS creates 60M files. Have not tried jfs.

Bye,
    Oleg
