Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUDESDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUDESDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:03:25 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:1410 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263062AbUDESDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:03:14 -0400
Date: Mon, 5 Apr 2004 20:03:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>,
       mj@ucw.cz, jack@ucw.cz,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405180301.GA31149@wohnheim.fh-wedel.de>
References: <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <m1n05soqh2.fsf@ebiederm.dsl.xmission.com> <20040403194344.GA5477@mail.shareable.org> <20040405083549.GD28924@wohnheim.fh-wedel.de> <20040405124158.GD19842@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040405124158.GD19842@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 April 2004 13:41:58 +0100, Jamie Lokier wrote:
> Jörn Engel wrote:
> > Sharing the page cache is more important to me than sharing disk
> > space.  Disk space is cheap, but increasing memory beyond 1GiB in my
> > notebook is not and 1GiB is too little, so memory is the real
> > constraint.
> 
> Lucky you!  I have 192MB, that's as much as it can take.

I know your pain, last month my machine had just 160MiB.

That month I also didn't care much about page cache awareness of cow.
A grep over one kernel tree would thrash the cache just as a grep over
ten.  Now I can tell the difference again.

> > And it looks like Pavel already found the solution.  Whenever doing
> > something fishy that would confuse the page cache, we
> > 1. lock
> > 2. invalidate page cache for all files belonging to that cow entity
> > 3. copyfile(), write(), or whatever
> > 4. unlock
> > 
> > This is always possibly, because page cache for cow-files is never
> > read-write.  If it was, we would have done 1-4 before and now have a
> > regular (non-cow) file.
> > 
> > Did I miss something?
> 
> Just some interesting indirection or substitution of address_space
> objects needed in the vmas, to map the right pages.

That is already covered by the nonexistent invalidate_inode() function
in point 2. :)

You are right, implementation is more interesting, but it *should*
work.

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
