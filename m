Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUDEJPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 05:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUDEJPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 05:15:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57521 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261156AbUDEJPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 05:15:37 -0400
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@ucw.cz>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <20040329231635.GA374@elf.ucw.cz>
	<20040402165440.GB24861@wohnheim.fh-wedel.de>
	<20040402180128.GA363@elf.ucw.cz>
	<20040402181707.GA28112@wohnheim.fh-wedel.de>
	<20040402182357.GB410@elf.ucw.cz>
	<20040402200921.GC653@mail.shareable.org>
	<20040402213933.GB246@elf.ucw.cz>
	<20040403010425.GJ653@mail.shareable.org>
	<m1n05soqh2.fsf@ebiederm.dsl.xmission.com>
	<20040403194344.GA5477@mail.shareable.org>
	<20040405083549.GD28924@wohnheim.fh-wedel.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2004 03:15:01 -0600
In-Reply-To: <20040405083549.GD28924@wohnheim.fh-wedel.de>
Message-ID: <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> On Sat, 3 April 2004 20:43:44 +0100, Jamie Lokier wrote:
> > 
> > Btw, I'm not suggesting sharing page cache entries.
> 
> But I am!!!
> 
> Sharing the page cache is more important to me than sharing disk
> space.  Disk space is cheap, but increasing memory beyond 1GiB in my
> notebook is not and 1GiB is too little, so memory is the real
> constraint.
>
> And it looks like Pavel already found the solution.  Whenever doing
> something fishy that would confuse the page cache, we
> 1. lock
> 2. invalidate page cache for all files belonging to that cow entity
> 3. copyfile(), write(), or whatever
> 4. unlock
> 
> This is always possibly, because page cache for cow-files is never
> read-write.  If it was, we would have done 1-4 before and now have a
> regular (non-cow) file.
> 
> Did I miss something?

I know a writable mmap needs to trigger a copy in that case.
And then are fun cases with MAP_FIXED which may mean invalidation
is not allowed.

As scheme that does not isolate the invalidate to the new copy worries me.

Eric


