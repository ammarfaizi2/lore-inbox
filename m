Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTIBQKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbTIBQKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:10:30 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:12531 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263956AbTIBQKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:10:24 -0400
Date: Tue, 2 Sep 2003 10:09:27 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030902100927.T15623@schatzie.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030830235819.GD898@matchmail.com> <20030831164448.O15623@schatzie.adilger.int> <20030901202729.GB31760@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030901202729.GB31760@matchmail.com>; from mfedyk@matchmail.com on Mon, Sep 01, 2003 at 01:27:29PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 01, 2003  13:27 -0700, Mike Fedyk wrote:
> On Sun, Aug 31, 2003 at 04:44:48PM -0600, Andreas Dilger wrote:
> > On Aug 30, 2003  16:58 -0700, Mike Fedyk wrote:
> > > But how do I re-enable htree on the directories (besides an fsck -D) in a
> > > live system?
> > 
> > You need to re-enable the dir_index feature, and then for directories which
> > are larger than a block in size you need something like:
> > 
> > 	mkdir new_dir
> > 	mv old_dir/* new_dir
> > 	rmdir old_dir
> > 	mv new_dir old_dir
> > 
> > The new directory will have htree enabled because it started out at 1 block
> > in size.
> 
> Ok I ended up doing this after a little thought.  Thanks.
> 
> But I am seeing segfaults in mutt under 2.6 ext3 with 1k blocks, that I
> don't see in 2.4, and didn't see under reiserfs.  I can try with 4k blocks,
> if you'd like, is there anything I can do to capture more information that
> could be happening to cause this?

Normally an application segfault is really caused by a kernel OOPS, so if
you look into your syslog file or dmesg output you should see an oops.

> And now mutt is segfaulting on non-htree directories too.

I couldn't comment on that, but either the directories are somehow corrupted
(e2fsck will know), or the problem is related either to 1kB blocks or not
related to the filesystem at all.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Sep 01, 2003  13:27 -0700, Mike Fedyk wrote:
> On Sun, Aug 31, 2003 at 04:44:48PM -0600, Andreas Dilger wrote:
> > On Aug 30, 2003  16:58 -0700, Mike Fedyk wrote:
> > > But how do I re-enable htree on the directories (besides an fsck -D) in a
> > > live system?
> > 
> > You need to re-enable the dir_index feature, and then for directories which
> > are larger than a block in size you need something like:
> > 
> > 	mkdir new_dir
> > 	mv old_dir/* new_dir
> > 	rmdir old_dir
> > 	mv new_dir old_dir
> > 
> > The new directory will have htree enabled because it started out at 1 block
> > in size.
> 
> Ok I ended up doing this after a little thought.  Thanks.
> 
> But I am seeing segfaults in mutt under 2.6 ext3 with 1k blocks, that I
> don't see in 2.4, and didn't see under reiserfs.  I can try with 4k blocks,
> if you'd like, is there anything I can do to capture more information that
> could be happening to cause this?

Normally an application segfault is really caused by a kernel OOPS, so if
you look into your syslog file or dmesg output you should see an oops.

> And now mutt is segfaulting on non-htree directories too.

I couldn't comment on that, but either the directories are somehow corrupted
(e2fsck will know), or the problem is related either to 1kB blocks or not
related to the filesystem at all.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

