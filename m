Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSJUCsm>; Sun, 20 Oct 2002 22:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264700AbSJUCsl>; Sun, 20 Oct 2002 22:48:41 -0400
Received: from packet.digeo.com ([12.110.80.53]:57342 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264699AbSJUCsl>;
	Sun, 20 Oct 2002 22:48:41 -0400
Message-ID: <3DB36C70.DFB52831@digeo.com>
Date: Sun, 20 Oct 2002 19:54:40 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: patch management scripts
References: <3DB30283.5CEEE032@digeo.com> <20021021023546.GK26443@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 02:54:40.0511 (UTC) FILETIME=[334C50F0:01C278AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Sun, Oct 20, 2002 at 12:22:43PM -0700, Andrew Morton wrote:
> >
> > I finally got around to documenting the scripts which I use
> > for managing kernel patches.  See
> >
> > http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.1/
> >
> > These scripts are designed for managing a "stack" of patches against
> > a rapidly-changing base tree. Because that's what I use them for.
> >
> > I've been using and evolving them over about six months.  They're
> > pretty fast, and simple to use.  They can be used for non-kernel
> > source trees.
> 
> Thanks for posting these - hopefully it will generate some discussion.
> 
> My own personal scripts (while obviously not getting nearly the
> workout yours are) make at least one part noticeably simpler - I use a
> complete 'cp -al' for the current "top of the applied stack" rather
> than your foo.c~bar files.

That has always seemed unnatural to me.  By keeping everything
in the one tree you can easily:

- collapse patches together:

	pushpatch first-patch
	for i in $(cat pc/second-patch.pc)
		fpatch $i
	done
	patch -p1 < patches/second-patch.patch
	refpatch

- Reorder patches (edit series file, poppatch 10; pushpatch 10)

- Remove a patch which is partway down the stack:

	rpatch patch-7-out-of-10

- make changes to a not-topmost patch without having to do
  anything special.

Dunno.  There are probably ways of doing all these things with a
whole-tree copy, but I haven't tried to plot it all out.

Changelog tracking is fairly important to me also.

mnm:/usr/src/25> ls -l txt|wc -l
    560
