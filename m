Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262001AbSIYVFY>; Wed, 25 Sep 2002 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSIYVFY>; Wed, 25 Sep 2002 17:05:24 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:12783 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262001AbSIYVFX>; Wed, 25 Sep 2002 17:05:23 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 25 Sep 2002 15:08:24 -0600
To: Dave Jones <davej@codemonkey.org.uk>, tytso@mit.edu,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020925210824.GH22795@clusterfs.com>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, tytso@mit.edu,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <20020925204101.GA5420@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020925204101.GA5420@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 25, 2002  21:41 +0100, Dave Jones wrote:
> On Wed, Sep 25, 2002 at 04:03:44PM -0400, tytso@mit.edu wrote:
> 
>  > This patch significantly increases the speed of using large directories.
>  > Creating 100,000 files in a single directory took 38 minutes without
>  > directory indexing... and 11 seconds with the directory indexing turned on.
> 
> Just curious.. what measurable overhead (if any) is there of indexing
> dirs with smaller numbers of files vs non-indexed ?
> If so, where would be the break-even point ?

No overhead at all for directories 1 block in size.  The htree code uses
the existing "search leaf block" code for such a directory directly.
For directories > 1 block in size, you have the index (1 block
overhead), but also the benefit that you are only searching 1/N of the
blocks for an entry (the leaf block searching code remains the same,
just the "which block to search" code is activated.

So, in summary, htree is never slower than an un-indexed directory, so
there is never really a time when you wouldn't want to use it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

