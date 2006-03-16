Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWCPV0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWCPV0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbWCPV0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:26:37 -0500
Received: from thunk.org ([69.25.196.29]:8835 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750845AbWCPV0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:26:37 -0500
Date: Thu, 16 Mar 2006 16:26:32 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060316212632.GA21004@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp> <1142475556.3764.133.camel@dyn9047017067.beaverton.ibm.com> <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316183549.GK30801@schatzie.adilger.int>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 11:35:49AM -0700, Andreas Dilger wrote:
> Beyond that, we need a format change and may as well have something
> like extents, but even extents still need to allow a larger i_blocks,

As a side note, one of the things that we've been talking about doing
is bundling a number of small changes together into a single INCOMPAT
flag.  Changing i_blocks so its units are in blocks rather than
512-byte sectors was one such change.

Another was guaranteeing that for large inodes (> 128 bytes) that at
least some number of bytes (probably on the order of 32 bytes or so)
would be reserved for things like the high resolution portion of
ctime/mtime/atime, high watermark, and other inode extensions.  (One
of the problems with doing high res timestamps right is how to handle
the case where you can't make room for the high res timestamps, due to
too much space being taken up by extended attributes.  The make(1)
program gets really confused unless all files are either using or not
using high res timestamps.)

The idea was to do a quick easy strike of all of the ideas which could
be implemented quickly, and perhaps try to get them done before RHEL 5
snapshots.  Even if RHEL5 doesn't enable use of these features by
default, having it supported by RHEL5 would be extremely convenient.

> so that patch would be useful in any case...  though it needs some
> cleanup to remove all users of i_frag and i_faddr (which have never
> ever been used).

One of the things which we need to consider is whether we think we
will never support tail packing or other forms of fragments, which is
related to whether we think we will ever support large blocks (i.e.,
32k, 64k, and up).  If we do, we might want to keep those fields
around.

						- Ted
