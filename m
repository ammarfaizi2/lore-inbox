Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281201AbRKPDV1>; Thu, 15 Nov 2001 22:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRKPDVR>; Thu, 15 Nov 2001 22:21:17 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:35837 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281201AbRKPDVF>; Thu, 15 Nov 2001 22:21:05 -0500
Date: Thu, 15 Nov 2001 22:20:55 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115222055.S329@visi.net>
In-Reply-To: <20011115153442.A329@visi.net> <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no> <20011115183858.N329@visi.net> <20011115170742.W5739@lynx.no> <20011115195551.Q329@visi.net> <20011115200916.A5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115200916.A5739@lynx.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 08:09:16PM -0700, Andreas Dilger wrote:
> On Nov 15, 2001  19:55 -0500, Ben Collins wrote:
> > On Thu, Nov 15, 2001 at 05:07:42PM -0700, Andreas Dilger wrote:
> > > What would be interesting to correlate is what inode 48 is (probably a
> > > directory, or you wouldn't have noticed it at all), with the corruption
> > > problems you are having while ext3 is loaded.
> > 
> > 48 /usr/lib/perl5/5.005/File/Copy.pm
> > 
> > Since this file is pretty small, I can only assume that it overwrote
> > some adjacent files. There is some corruption in this file (luckily in
> > the comment area :) starting at the 25th byte, and extending 12 bytes in
> > length. Here's the values from hexedit:
> > 
> > 	00 00 00 01  00 00 00 00  00 00 00 00
> 
> No, this would be the only expected corruption - there are 3 32-bit
> fields that that get written to disk in journal_update_superblock(),
> and these are consistent with that.
> 
> That means the source of the other corruption is unknown.

The "other" corruption only occured while booted with the ext3-enabled
kernel. They haven't appeared under the non-ext3 kernel at all. Even
after it got mounted read-only, performing an fsck, and remounting
read-write, it would reoccur over and over. So this "other" corruption
doesn't even sound like it can be caused by the scenario you described
(which sounds like a one shot problem).



Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
