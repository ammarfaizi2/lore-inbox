Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265210AbSJaINn>; Thu, 31 Oct 2002 03:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265217AbSJaINn>; Thu, 31 Oct 2002 03:13:43 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:11721 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265210AbSJaINm>; Thu, 31 Oct 2002 03:13:42 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Htree ate my hard drive, was: post-halloween 0.2
Date: Thu, 31 Oct 2002 09:20:17 +0100
User-Agent: KMail/1.4.7
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
References: <20021030171149.GA15007@suse.de> <200210310727.52636.baldrick@wanadoo.fr> <20021031080717.GF28982@clusterfs.com>
In-Reply-To: <20021031080717.GF28982@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210310920.17587.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 09:07, Andreas Dilger wrote:
> On Oct 31, 2002  07:27 +0100, Duncan Sands wrote:
> > > EXT3 Htree support.
> > > ~~~~~~~~~~~~~~~~~~~
> > > The ext3 filesystem has gained indexed directory support, which offers
> > > considerable performance gains when used on filesystems with large
> > > directories. In order to use the htree feature, you need at least
> > > version 1.29 of e2fsprogs. Existing filesystems can be converted using
> > > the command "tune2fs -O dir_index /dev/hdXXX" The latest e2fsprogs can
> > > be found at http://prdownloads.sourceforge.net/e2fsprogs
> >
> > I ran this (tune2fs -O dir_index /dev/hdXXX).
> >
> > After a bit of switching back and forth between 2.4.19 and 2.5.44,
> > fsck was run while booting 2.4.19 (the usual check because of >30
> > mounts).  There was a message about optimizing directories.  Booting
> > continued but (big surprise) X refused to run.  It turned out that some
> > device files had vanished.  Very strange.  On rebooting, fsck found a
> > gazillion bad inodes.  They all turned out to be from the 2.5.44 tree -
> > poetic justice I suppose!  But this did not suffice.  Rebooting, I got
> > "optimizing directories" again.  Next fsck showed up more dud inodes.
> > After a few cycles of this, I ran
> >
> > tune2fs -O ^dir_index /dev/hdXXX
> >
> > to remove htree support.  No problems since then.
> >
> > tune2fs 1.30-WIP (30-Sep-2002)
>
> I wonder if there is still a bug in the e2fsck code for re-hashing
> directories?  It shouldn't be possible to have e2fsck complete and
> there still be an error in the filesystem (ok, sometimes it happens,
> but in those cases it spews a lot of warnings about the filesystem
> not being fixed yet and to run manually).

It is possible that the filesystem was fine when fsck completed, but
was damaged afterwards, i.e. in the time between fsck completing
and the reboot.

Duncan.

> What else is strange (at least to me) is e2fsck "optimizing directories"
> on a reboot.  My understanding at least is that this would be done only
> when explicitly asked for, otherwise it might slow down booting a lot,
> and as you can see it adds to the possibility of corrupting the fs when
> e2fsck should only be fixing it.
