Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281193AbRKPA4Y>; Thu, 15 Nov 2001 19:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281194AbRKPA4O>; Thu, 15 Nov 2001 19:56:14 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:61692 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281193AbRKPA4B>; Thu, 15 Nov 2001 19:56:01 -0500
Date: Thu, 15 Nov 2001 19:55:51 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115195551.Q329@visi.net>
In-Reply-To: <3BF3F9ED.17D55B35@zip.com.au>, <3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no> <20011115183858.N329@visi.net> <20011115170742.W5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115170742.W5739@lynx.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 05:07:42PM -0700, Andreas Dilger wrote:
> On Nov 15, 2001  18:38 -0500, Ben Collins wrote:
> > I wont say that I am absolutely 100% sure that ext3 was never tried on
> > this filesystem. I am pretty certain, but I'm guessing it doesn't really
> > make much difference at this point. Your scenario of the corruption
> > makes sense. I'll see if I can test your patch at some point (but I most
> > likely cannot).
> > 
> > Filesystem features:      has_journal filetype sparse_super
> > ...
> > Journal inode:            48
> 
> What I'm thinking happened here is at some point long ago (maybe before
> the server was put into production, who knows) someone tested ext3 on
> it.  When they were done, they deleted the .journal file (inode #48)
> but e2fsck didn't clean up the superblock journal fields, and it went
> unnoticed until now.
> 
> The other alternative is that you have some sort of random single-bit
> data corruption going on (the journal inode is also a single bit set,
> 48 = 0x30, but a different bit than has_journal, = 0x0004).
> 
> In any case, with e2fsprogs 1.18 (and probably _only_ that version)
> it doesn't complain about has_journal, but it also doesn't check if the
> journal is bad and clean it up.  When you try to start with an ext3-aware
> kernel, it conspires to corrupt inode 48 when it tries to unload the
> journal, even when it knows the journal is bad.
> 
> What would be interesting to correlate is what inode 48 is (probably a
> directory, or you wouldn't have noticed it at all), with the corruption
> problems you are having while ext3 is loaded.

48 /usr/lib/perl5/5.005/File/Copy.pm

Since this file is pretty small, I can only assume that it overwrote
some adjacent files. There is some corruption in this file (luckily in
the comment area :) starting at the 25th byte, and extending 12 bytes in
length. Here's the values from hexedit:

	00 00 00 01  00 00 00 00  00 00 00 00



-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
