Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269837AbRHDIPj>; Sat, 4 Aug 2001 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269838AbRHDIP3>; Sat, 4 Aug 2001 04:15:29 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51209 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269831AbRHDIPV>; Sat, 4 Aug 2001 04:15:21 -0400
Date: Sat, 4 Aug 2001 06:04:23 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804060423.I16516@emma1.emma.line.org>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Chris Wedgwood <cw@f00f.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Mason <mason@suse.com>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6B53A9.A9923E21@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B6B53A9.A9923E21@zip.com.au>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Andrew Morton wrote:

> > really, there is _some_ merit in the argument that
> > 
> >         open
> >         fsync
> >         close
> > <crash>
> > 
> > shouldn't loose the file...

...

> mmm... Holding i_sem across multiple revs of the disk will hurt.  It
> doesn't *need* to be held while we're waiting on IO, but fixing that
> would be a big change, and there has been little motivation to change
> things because it is for specialised apps.

I have no clues of the inode, dentry whatever kernel structure names of
Linux. However, aren't we already at the point that ext3 fsync() flushes
the corresponding dirents? How difficult would it be to have the inode
track changes to its dirents such as rename or link? Without breaking it
if someone renames a parent or grandparent? I mean, FFS + softupdates
can do it. The MTA doesn't really care for the implementation, it cares
that it never loses its files over a crash -- where finding it renamed
to /mount/point/lost+found is considered a loss. For people that want
the data synced and want to sync the meta data later, there is
fdatasync() as they go and either fsync()ing the files or fsync()ing
their directory as they finish.

unlink and particularly symlink will need separate consideration, but
that's left for later.

-- 
Matthias Andree
