Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSGPVWG>; Tue, 16 Jul 2002 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSGPVWF>; Tue, 16 Jul 2002 17:22:05 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:2289 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318158AbSGPVWE>; Tue, 16 Jul 2002 17:22:04 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 16 Jul 2002 15:23:22 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716212322.GT442@clusterfs.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716193831.GC22053@merlin.emma.line.org> <Pine.LNX.4.44.0207161408270.3452-100000@hawkeye.luckynet.adm> <20020716210639.GC30235@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716210639.GC30235@merlin.emma.line.org>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 16, 2002  23:06 +0200, Matthias Andree wrote:
> On Tue, 16 Jul 2002, Thunder from the hill wrote:
> > On Tue, 16 Jul 2002, Matthias Andree wrote:
> > > That would require three atomic steps:
> > > 
> > > 1. mount read-only, flushing all pending updates
> > > 2. take snapshot
> > > 3. mount read-write
> > > 
> > > and then backup the snapshot. A snapshots of a live file system won't
> > > do, it can be as inconsistent as it desires -- if your corrupt target is
> > > moving or not, dumping it is not of much use.
> > 
> > Well, couldn't we just kindof lock the file system so that while backing 
> > up no writes get through to the real filesystem? This will possibly 
> > require a lot of memory (or another space to write to), but it might be 
> > done?
> 
> But you would want to backup a consistent file system, so when entering
> the freeze or snapshot mode, you must flush all pending data in such a
> way that the snapshot is consistent (i. e. needs not fsck action
> whatsoever).

This is all done already for both LVM and EVMS snapshots.  The filesystem
(ext3, reiserfs, XFS, JFS) flushes the outstanding operations and is
frozen, the snapshot is created, and the filesystem becomes active again.
It takes a second or less.  Then dump will guarantee 100% correct backups
of the snapshot filesystem.  You would have to do a backup on the snapshot
to guarantee 100% correctness even with tar.

Most people don't care, because they don't even do backups in the first
place, until they have lost a lot of their data and they learn.  Even
without snapshots, while dump isn't guaranteed to be 100% correct for
rapidly changing filesystems, I have been using it for years on both
2.2 and 2.4 without any problems on my home systems.  I have even
restored data from those same backups...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

