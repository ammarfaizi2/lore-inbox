Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSCREgr>; Sun, 17 Mar 2002 23:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCREg1>; Sun, 17 Mar 2002 23:36:27 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:41467 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S288953AbSCREgU>; Sun, 17 Mar 2002 23:36:20 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 17 Mar 2002 20:03:17 -0700
To: Theodore Tso <tytso@mit.edu>, David Rees <dbr@greenhydrant.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020318030317.GC1150@turbolinux.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020313123114.A11658@greenhydrant.com> <20020313205537.GC429@turbolinux.com> <20020313133748.A12472@greenhydrant.com> <20020313215420.GD429@turbolinux.com> <20020315182355.A1123@thunk.org> <20020317072653.GB1150@turbolinux.com> <20020317183752.GB27249@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 17, 2002  10:37 -0800, Mike Fedyk wrote:
> On Sun, Mar 17, 2002 at 12:26:53AM -0700, Andreas Dilger wrote:
> > Yes, I have always considered this a kernel bug (introduced in 2.4.10),
> > but my (admittedly feeble) attempts to get it fixed were not accepted.
> > At one point I thought a fix went into 2.4.18-pre[12] or so, but I
> > guess not.  I haven't tried in a while, so maybe I should make another
> > attempt.
> > 
> 
> Was that part of the 2.4.10-pre11 -aa VM merge, or was it from another
> seperate patch?

Well, at the same time as Linus merged -aa VM, he also merged
blockdev-in-pagecache from -aa.  This caused this problem, among others.
With blockdev-in-pagecache, the kernel thinks block device access is the
same as reading a file, so it imposes file limits.  It also caused the
problem that the block device (pagecache) and the filesystem (buffer
cache) were not coherent, causing e2fsck, tune2fs, etc to not work.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

