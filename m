Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTHaWpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbTHaWpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:45:35 -0400
Received: from [64.114.249.16] ([64.114.249.16]:22215 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263026AbTHaWpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:45:33 -0400
Date: Sun, 31 Aug 2003 16:44:48 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030831164448.O15623@schatzie.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030829172451.GA27023@matchmail.com> <20030829180957.GC27023@matchmail.com> <20030830131421.M15623@schatzie.adilger.int> <20030830235819.GD898@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030830235819.GD898@matchmail.com>; from mfedyk@matchmail.com on Sat, Aug 30, 2003 at 04:58:19PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2003  16:58 -0700, Mike Fedyk wrote:
> On Sat, Aug 30, 2003 at 01:14:21PM -0600, Andreas Dilger wrote:
> > On Aug 29, 2003  11:09 -0700, Mike Fedyk wrote:
> > > On Fri, Aug 29, 2003 at 10:24:51AM -0700, Mike Fedyk wrote:
> > >  o Find out that a directory is using htree?
> > 
> > "lsattr <dir>" will show it.  Note that it will only ever be set on
> > directories that are larger than a single disk block.
> > 
> > # lsattr -d d1
> > ----------I-- d1
> > 
> 
> Ok, now I only have htree enabled on one of my maildir folders.
> 
> > >  o Disable htree on my /?  (tune2fs -O ^dir_index), but then how do I get
> > >    my directories back to non-htree without running fsck from a rescue CD?
> > 
> > That's the great thing about htree - you don't need to do anything to turn
> > it off.  The on-disk format is exactly the same as without htree, and the
> > first time you modify the directory it will clear the per-directory htree
> > flag.
> 
> I'll do more testing to see if it fails only on that folder now.
> 
> But how do I re-enable htree on the directories (besides an fsck -D) in a
> live system?

You need to re-enable the dir_index feature, and then for directories which
are larger than a block in size you need something like:

	mkdir new_dir
	mv old_dir/* new_dir
	rmdir old_dir
	mv new_dir old_dir

The new directory will have htree enabled because it started out at 1 block
in size.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

