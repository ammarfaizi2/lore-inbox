Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262189AbSJNVvj>; Mon, 14 Oct 2002 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbSJNVvi>; Mon, 14 Oct 2002 17:51:38 -0400
Received: from ns0.cobite.com ([208.222.80.10]:44295 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S262189AbSJNVvh>;
	Mon, 14 Oct 2002 17:51:37 -0400
Date: Mon, 14 Oct 2002 17:57:27 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] raw over raid5: BUG at drivers/block/ll_rw_blk.c:1967
In-Reply-To: <3DAB2DD9.B78639C5@digeo.com>
Message-ID: <Pine.LNX.4.44.0210141755340.2876-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Andrew Morton wrote:

> David Mansfield wrote:
> > 
> > Hi everyone,
> > 
> > I haven't been able to run raw over raid5 since 2.5.30 or so, but every
> > time I'm about to report it, a new kernel comes out and the problem
> > changes completely :-( Now I'm finally going to start getting out the info
> > it the hopes someone can fix it.  The oops was triggered by attempting to
> > read from /dev/raw/raw1 (bound to /dev/md0) using dd.  System info
> > follows oops:
> > 
> > ------------[ cut here ]------------
> > kernel BUG at drivers/block/ll_rw_blk.c:1967!
> 
> I don't think you told us the kernel version?

Arrgh.  It was 2.5.42 vanilla.

> There have been recent fixes wrt sizing of the BIOs which the
> direct-io layer sends down.  So please make sure that you're
> testing Linus's current -bk, or 2.5.42 plus
> 
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.42/2.5.42-mm2/broken-out/dio-bio-add-fix-1.patch

I've applied this patch and retested.  I was able to run dd once this 
time, hit ctrl-c, all ok.  But I hit up-arrow and re-did it and it gave 
the same oops.  I'm going to try with the full (latest) mm patch.

> Either that, or raid5 is bust ;)
> 

I guess so.

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

