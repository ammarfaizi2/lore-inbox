Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130962AbRBXAdP>; Fri, 23 Feb 2001 19:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130955AbRBXAcz>; Fri, 23 Feb 2001 19:32:55 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:5117 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130949AbRBXAcu>; Fri, 23 Feb 2001 19:32:50 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102240032.f1O0WWC06492@webber.adilger.net>
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
In-Reply-To: <E14WOZ2-0006sK-00@beefcake.hdqt.valinux.com> from "Theodore Ts'o"
 at "Feb 23, 2001 12:11:40 pm"
To: "Theodore Ts'o" <tytso@valinux.com>
Date: Fri, 23 Feb 2001 17:32:32 -0700 (MST)
CC: phillips@innominate.de,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted writes:
> Note that in the long run, the fully comatible version should probably
> have a COMPAT feature flag set so that you're forced to use a new enough
> version of e2fsck.  Otherwise an old e2fsck may end up not noticing
> corruptions in an index block which might cause a new kernel to have
> serious heartburn.

Actually, having a COMPAT flag also helps in other ways:

1) Turning indexing on and off is not a mount option as it currently is
   (or automatically done) so it will quell Linus' fears about priniciple
   of least surprise (i.e. not converting a filesystem without user action).
   A superblock COMPAT flag is more in keeping with other ext2 features.

2) Running a new e2fsck on a COMPAT_INDEX filesystem could create the
   index for existing "large" directories that don't have the BTREE/INDEX
   flag set, so the kernel only ever has to deal with incremental indexing
   after the first block.  The kernel would just do linear access on
   existing multi-block directories until e2fsck is run.

3) Clearing the COMPAT flag would make e2fsck remove the indexes, if the
   user so desires.  I think this would be the behaviour of existing
   e2fsck anyways.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
