Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135941AbREDTRS>; Fri, 4 May 2001 15:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135759AbREDTQb>; Fri, 4 May 2001 15:16:31 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:25071 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S135775AbREDTQO>; Fri, 4 May 2001 15:16:14 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105041915.f44JFNeM024068@webber.adilger.int>
Subject: Re: Maximum files per Directory
In-Reply-To: <145290000.988984174@tiny> "from Chris Mason at May 4, 2001 09:49:34
 am"
To: Chris Mason <mason@suse.com>
Date: Fri, 4 May 2001 13:15:22 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris writes:
> On Tuesday, May 01, 2001 04:57:02 PM -0600 Andreas Dilger
> <adilger@turbolinux.com> wrote:
> > I see that reiserfs plays some tricks with the directory i_nlink count.
> > If you exceed 64536 links in a directory, it reverts to "1" and no longer
> > tracks the link count.
> 
> Correct.  The link count isn't used at all when deciding if the directory
> is empty (we use the size instead), so we can just lie to VFS if someone
> tries to make tons of subdirs.

For that matter, ext2 doesn't use the link count on directories to determine
if they are empty either, so it shouldn't be too hard to do the same with
the ext2 indexed-directory code.  Is there a reason that reiserfs chose to
have "large number of directories" represented by "1" and not "LINK_MAX+1"?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
