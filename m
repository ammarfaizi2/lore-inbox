Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRKOWAJ>; Thu, 15 Nov 2001 17:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281093AbRKOV77>; Thu, 15 Nov 2001 16:59:59 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:38128 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281116AbRKOV7l>;
	Thu, 15 Nov 2001 16:59:41 -0500
Date: Thu, 15 Nov 2001 14:58:03 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115145803.R5739@lynx.no>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115160232.H329@visi.net>; from bcollins@debian.org on Thu, Nov 15, 2001 at 04:02:32PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  16:02 -0500, Ben Collins wrote:
> On Thu, Nov 15, 2001 at 12:48:26PM -0800, Andrew Morton wrote:
> > ext3 thinks that the filesystem's superblock has the
> > EXT3_FEATURE_COMPAT_HAS_JOURNAL bit set in the s_feature_compat
> > field of the on-disk superblock.
> > 
> > It's probable that that bit _is_ set.  ext2 will never notice it.
> > 
> > Please: the dumpe2fs output?
> 
> Seems it does have the field set. I guess the bug is then that if there
> is no journal, then it shoudl fail to mount it, so ext2 will take over.
> Is there any reason to mount a partition as ext3 if there is no journal
> to be found?

It _does_ fail to mount the filesystem as ext3, and the ext2 code properly
mounts it.  You can see this because the error message you got (in your
previous posting said "EXT2-fs: ..." so the error came from ext2.

Please run e2fsck (1.25) to clear this up.  It may be that you have other
corruption in your filesystem.  If you are sure you _never_ tried ext3
on this filesystem before, yet the has_journal bit is set, this could
be an indication of memory or cable problems.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

