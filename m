Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281065AbRKOVDI>; Thu, 15 Nov 2001 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281062AbRKOVC6>; Thu, 15 Nov 2001 16:02:58 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:1532 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281065AbRKOVCw>; Thu, 15 Nov 2001 16:02:52 -0500
Date: Thu, 15 Nov 2001 16:02:32 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115160232.H329@visi.net>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF42A1A.5AE96A78@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 12:48:26PM -0800, Andrew Morton wrote:
> Ben Collins wrote:
> > 
> > > Please send the output of dumpe2fs, and of `fsck -fy'.
> > 
> > No, it has always been an ext2 filesystem, and never was ext3. Fsck
> > shows no errors. The point being that I do _not_ want my root filesystem
> > to be ext3, but I do want ext3 built into the kernel. That case should
> > not cause a problem like I have seen.
> > 
> 
> ext3 thinks that the filesystem's superblock has the
> EXT3_FEATURE_COMPAT_HAS_JOURNAL bit set in the s_feature_compat
> field of the on-disk superblock.
> 
> It's probable that that bit _is_ set.  ext2 will never notice it.
> 
> Please: the dumpe2fs output?

Seems it does have the field set. I guess the bug is then that if there
is no journal, then it shoudl fail to mount it, so ext2 will take over.
Is there any reason to mount a partition as ext3 if there is no journal
to be found?

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
Free blocks:              372624
Free inodes:              690438
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
Last mount time:          Thu Nov 15 10:07:12 2001
Last write time:          Thu Nov 15 15:55:23 2001
Mount count:              2
Maximum mount count:      20
Last checked:             Thu Nov 15 08:48:40 2001
Check interval:           15552000 (6 months)
Next check after:         Tue May 14 09:48:40 2002
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128


-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
