Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281012AbRKOWH7>; Thu, 15 Nov 2001 17:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281093AbRKOWHw>; Thu, 15 Nov 2001 17:07:52 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:15100 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281012AbRKOWGh>; Thu, 15 Nov 2001 17:06:37 -0500
Date: Thu, 15 Nov 2001 17:06:28 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115170628.J329@visi.net>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115145803.R5739@lynx.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 02:58:03PM -0700, Andreas Dilger wrote:
> On Nov 15, 2001  16:02 -0500, Ben Collins wrote:
> > On Thu, Nov 15, 2001 at 12:48:26PM -0800, Andrew Morton wrote:
> > > ext3 thinks that the filesystem's superblock has the
> > > EXT3_FEATURE_COMPAT_HAS_JOURNAL bit set in the s_feature_compat
> > > field of the on-disk superblock.
> > > 
> > > It's probable that that bit _is_ set.  ext2 will never notice it.
> > > 
> > > Please: the dumpe2fs output?
> > 
> > Seems it does have the field set. I guess the bug is then that if there
> > is no journal, then it shoudl fail to mount it, so ext2 will take over.
> > Is there any reason to mount a partition as ext3 if there is no journal
> > to be found?
> 
> It _does_ fail to mount the filesystem as ext3, and the ext2 code properly
> mounts it.  You can see this because the error message you got (in your
> previous posting said "EXT2-fs: ..." so the error came from ext2.
> 
> Please run e2fsck (1.25) to clear this up.  It may be that you have other
> corruption in your filesystem.  If you are sure you _never_ tried ext3
> on this filesystem before, yet the has_journal bit is set, this could
> be an indication of memory or cable problems.

Uh, something corrupted it. Believe me, there is no other corruption.
I've reverted to a non-ext3 kernel, and after a day of serious IO, no
problems have shown. So something is wrong, and it isn't my filesystem
(the erroneous flag needs to be cleared, yes, but the fact remains that
there is a problem in this case).


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
