Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSKEPfo>; Tue, 5 Nov 2002 10:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSKEPfo>; Tue, 5 Nov 2002 10:35:44 -0500
Received: from mhost.enel.ucalgary.ca ([136.159.102.8]:52148 "EHLO
	mhost.enel.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262291AbSKEPfn>; Tue, 5 Nov 2002 10:35:43 -0500
Date: Tue, 5 Nov 2002 08:42:18 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jim Lawson <jim+linux-kernel@jimlawson.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] How to flush disk cache w/read-only filesystem w/o unmount&remount? (shared SAN filesystem)
Message-ID: <20021105084218.A15258@munet-d.enel.ucalgary.ca>
Mail-Followup-To: Jim Lawson <jim+linux-kernel@jimlawson.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211051014110.24422-100000@infocalypse.jimlawson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211051014110.24422-100000@infocalypse.jimlawson.org>; from jim+linux-kernel@jimlawson.org on Tue, Nov 05, 2002 at 10:18:11AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05, 2002  10:18 -0500, Jim Lawson wrote:
> I'm looking for a way to flush or invalidate the cache on the block
> device/filesystem, so that the system is forced to go all the way to the
> disk.  Unmounting and remounting would accomplish this, of course, but
> that's tough to do in production.
> 
> I've tried blockdev --flushbufs, which appears to do a BLKFLSBUF, but that
> seems to be equivalent to "sync" - just pushes the dirty buffers to disk,
> which doesn't help me.
> 
> Looking in fs/dcache.c, I see shrink_dcache_sb(struct super_block *),
> which *might* do what I want, but there doesn't seem to be any way to call
> that from user-land.  And that probably just updates the dentries - I
> don't know if that has any effect on the file data.

You may be in luck - we likely need to have an ioctl to do this from
e2fsck because the ext3 htree repacking of bad directories is causing
a bunch of problems.  In theory, the startup scripts should reboot the
system in this case, but there have also been cases reported where
people ran "e2fsck -D" on an ro-mounted root and then read-write mounted
it again.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
