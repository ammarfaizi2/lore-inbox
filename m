Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281179AbRKOXjb>; Thu, 15 Nov 2001 18:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRKOXjW>; Thu, 15 Nov 2001 18:39:22 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:44284 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281179AbRKOXjL>; Thu, 15 Nov 2001 18:39:11 -0500
Date: Thu, 15 Nov 2001 18:38:58 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115183858.N329@visi.net>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115162149.U5739@lynx.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 04:21:49PM -0700, Andreas Dilger wrote:
> On Nov 15, 2001  17:06 -0500, Ben Collins wrote:
> > On Thu, Nov 15, 2001 at 02:58:03PM -0700, Andreas Dilger wrote:
> > > Please run e2fsck (1.25) to clear this up.  It may be that you have other
> > > corruption in your filesystem.  If you are sure you _never_ tried ext3
> > > on this filesystem before, yet the has_journal bit is set, this could
> > > be an indication of memory or cable problems.
> > 
> > Uh, something corrupted it. Believe me, there is no other corruption.
> > I've reverted to a non-ext3 kernel, and after a day of serious IO, no
> > problems have shown. So something is wrong, and it isn't my filesystem
> > (the erroneous flag needs to be cleared, yes, but the fact remains that
> > there is a problem in this case).
> 
> I don't disagree that something corrupted it, but it is hard to tell from
> here what it could be.  Looking at ext3_read_super(), it is pretty much
> a read-only path, except journal recovery.  If, for some reason, you had
> an old, unrecovered ext3 journal in the fs, it is possible that recovering
> from it would corrupt your fs by writing old data into the fs.
> 
> This _shouldn't_ happen with newer kernels, but with old 2.2 ext3 code
> this was a possibility.  Also, with old e2fsck code (1.18 was right at the
> very beginning when ext3 support was being added) it is possible that it
> didn't fail because of the has_journal flag, but it wasn't smart enough
> to detect and remove an old corrupt journal.  I'm not saying this is a
> likely scenario either, but we don't have much to go on.

I wont say that I am absolutely 100% sure that ext3 was never tried on
this filesystem. I am pretty certain, but I'm guessing it doesn't really
make much difference at this point. Your scenario of the corruption
makes sense. I'll see if I can test your patch at some point (but I most
likely cannot).

Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          <none>
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype sparse_super
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              1015808
Block count:              2028288
Reserved block count:     101414
Free blocks:              368490
Free inodes:              688732
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
Last mount time:          Thu Nov 15 10:07:12 2001
Last write time:          Thu Nov 15 18:29:55 2001
Mount count:              2
Maximum mount count:      20
Last checked:             Thu Nov 15 08:48:40 2001
Check interval:           15552000 (6 months)
Next check after:         Tue May 14 09:48:40 2002
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             <none>
Journal inode:            48
Journal device:           0x0000
First orphan inode:       0


-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
