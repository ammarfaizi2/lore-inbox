Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWAWFpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWAWFpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWAWFpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:45:18 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:11401 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964806AbWAWFpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:45:16 -0500
Date: Sun, 22 Jan 2006 22:43:27 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, John Stoffel <john@stoffel.org>,
       Takashi Sato <sho@tnes.nec.co.jp>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [PATCH] ext3: Extends blocksize up to pagesize
Message-ID: <20060123054327.GN4124@schatzie.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	John Stoffel <john@stoffel.org>, Takashi Sato <sho@tnes.nec.co.jp>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp> <17358.25398.943860.755559@smtp.charter.net> <20060122182801.GA7082@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122182801.GA7082@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2006  13:28 -0500, Theodore Ts'o wrote:
> On Wed, Jan 18, 2006 at 10:48:06AM -0500, John Stoffel wrote:
> > In that size range, you really need a filesystem which doesn't need an
> > FSCK at all.  Not sure what the real answer is though...
> 
> Ext3 doesn't require a fsck under normal circumstances.  The only
> reason why it still requires a periodic fsck after some number of
> mounts is sheer paranoia about the reliability of PC class hardware.
> All filesystems need some kind of filesystem consistency checker to
> deal with filesystem corruptions caused by OS bugs or hardware
> corruption bugs.  The only question is whether or not the filesystem
> assumes at a fundamental level whether or not the hardware can be
> trusted to be reliable or not.  (People have claimed that XFS is much
> less robust in the face of hardware errors when compared to ext[23]; I
> haven't seen a definitive study on the issue, although that tends to
> correspond with my experience.  Other people would say it doesn't
> matter because that's why you pay $$$$$ for am EMC Symmetrix box or an
> IBM shark/DS6000/DS8000, or some other Really Expensive Storage
> Hardware.)

I think the work done by the U. Wisconsin group for IRON ext3 is the
way to go (namely checksumming of filesystem metadata, and possibly
some level of redundancy).  This gives us concrete checks on what metadata
is valid and the filesystem can avoid any (or further) corruption when
the hardware goes bad.  The existing ext3 code already has these checks,
but as filesystems get larger the validity of a block number of an inode
is harder to check because any value may be correct.  Given that CPU
speed is growing orders of magnitude faster than disk IO the overhead of
checksumming is a reasonable thing to do these days (optionally, of course).

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

