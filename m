Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSJUDZg>; Sun, 20 Oct 2002 23:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSJUDZf>; Sun, 20 Oct 2002 23:25:35 -0400
Received: from waste.org ([209.173.204.2]:36273 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S264716AbSJUDYa>;
	Sun, 20 Oct 2002 23:24:30 -0400
Date: Sun, 20 Oct 2002 22:30:33 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: patch management scripts
Message-ID: <20021021033033.GL26443@waste.org>
References: <3DB30283.5CEEE032@digeo.com> <20021021023546.GK26443@waste.org> <3DB36C70.DFB52831@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB36C70.DFB52831@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 07:54:40PM -0700, Andrew Morton wrote:
> Oliver Xymoron wrote:
> > 
> > On Sun, Oct 20, 2002 at 12:22:43PM -0700, Andrew Morton wrote:
> > >
> > > I finally got around to documenting the scripts which I use
> > > for managing kernel patches.  See
> > >
> > > http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.1/
> > >
> > > These scripts are designed for managing a "stack" of patches against
> > > a rapidly-changing base tree. Because that's what I use them for.
> > >
> > > I've been using and evolving them over about six months.  They're
> > > pretty fast, and simple to use.  They can be used for non-kernel
> > > source trees.
> > 
> > Thanks for posting these - hopefully it will generate some discussion.
> > 
> > My own personal scripts (while obviously not getting nearly the
> > workout yours are) make at least one part noticeably simpler - I use a
> > complete 'cp -al' for the current "top of the applied stack" rather
> > than your foo.c~bar files.
> 
> That has always seemed unnatural to me.  By keeping everything
> in the one tree you can easily:
> 
> - collapse patches together:
> 
> 	pushpatch first-patch
> 	for i in $(cat pc/second-patch.pc)
> 		fpatch $i
> 	done
> 	patch -p1 < patches/second-patch.patch
> 	refpatch

Not sure if I follow you here. The above is not quite my definition of
easy - I'd probably sooner concat a pair of patches and rediff 'em.
 
> - Reorder patches (edit series file, poppatch 10; pushpatch 10)

I throw all my patches in a directory tree called patchset, ordering
implicit in filenames. Note the tree part, which allows me to reorder
series as directories or individual patches in series. My 'kapply'
script takes a regex matching last patch to apply.
 
> - Remove a patch which is partway down the stack:
> 
> 	rpatch patch-7-out-of-10

Just a filesystem op for me: mv patchset/a/07 patchset/a/07.skip

> - make changes to a not-topmost patch without having to do
>   anything special.

Unless of course you're touching that file somewhere else in the
stack. As I see it, I'm generally doing one of two things:

- doing serial changes on a few files for a rewrite
- doing a tree-wide search and replace

Both approaches lose for the first, mine wins for the second, yours
wins for a third that's practically unique to the VM work you're doing:

- tweak n file-orthogonal patches

I think there might be a way to combine the good points of both by
automating a don't-diff-list, but the first one is still a challenge. 

> Changelog tracking is fairly important to me also.

Not sure I see the connection? By the way, I keep my descriptions with
my patches, so I only have to keep track of the 'final product'.
Before I switched from bash to Python, I used something like this to
pull out the preamble:

    head -$((`grep -n "^diff -" ../$p | head -1 | cut -d : -f 1` - 1 )) \
      ../$p > .patchdesc.tmp

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
