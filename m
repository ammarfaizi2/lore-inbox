Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVCaCbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVCaCbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVCaCbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:31:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61669 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262492AbVCaCbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:31:50 -0500
Date: Thu, 31 Mar 2005 12:25:38 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Malone <dwmalone@maths.tcd.ie>, linux-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Directory link count wrapping on Linux/XFS/i386?
Message-ID: <20050331022538.GH867@frodo>
References: <200503302043.aa27223@salmon.maths.tcd.ie> <20050330200601.GG1753@schnapps.adilger.int> <20050331004258.GF867@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331004258.GF867@frodo>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 10:42:58AM +1000, Nathan Scott wrote:
> On Wed, Mar 30, 2005 at 01:06:01PM -0700, Andreas Dilger wrote:
> > The correct fix, used for reiserfs (and a patch for ext3 also) is to
> > set i_nlink = 1 in case the filesystem count has wrapped.  When nlink==1
> > the fts/find code no longer optimizes subdirectory traversal and checks
> > each entries filetype to see if it should recurse.
> 
> Ah, I see - the INC_DIR_INODE_NLINK/DEC_DIR_INODE_NLINK macros, right.
> I'll look into that too, thanks.

Hmm, since struct inode has an unsigned int as nlink, it'd
seem doing this sort of thing is only useful for filesystems
where the ondisk nlink is a 16 bit value (and ext2/3/reiserfs
do seem to be in that category, afaict).

So, Davids patch (and those one/two other cases) would seem
to be enough to get this resolved.  There isn't much using
nlink_t - looks like mainly the non-stat64 'stat' calls and
one or two other (possibly accidental?) uses like we had in
XFS.

cheers.

-- 
Nathan
