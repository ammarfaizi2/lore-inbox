Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUDELnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDELnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:43:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1174 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262007AbUDELnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:43:14 -0400
Date: Mon, 5 Apr 2004 13:43:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Jamie Lokier <jamie@shareable.org>, mj@ucw.cz, jack@ucw.cz,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405114312.GA31036@atrey.karlin.mff.cuni.cz>
References: <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <m1n05soqh2.fsf@ebiederm.dsl.xmission.com> <20040403194344.GA5477@mail.shareable.org> <20040405083549.GD28924@wohnheim.fh-wedel.de> <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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
> I know a writable mmap needs to trigger a copy in that case.
> And then are fun cases with MAP_FIXED which may mean invalidation
> is not allowed.

How is "invalidation not allowed" for MAP_FIXED? Application will
never see the fault...

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
