Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUDCUbB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUDCUbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:31:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52395 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261937AbUDCUa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:30:58 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <s5g7jx31int.fsf@patl=users.sf.net>
	<20040329231635.GA374@elf.ucw.cz>
	<20040402165440.GB24861@wohnheim.fh-wedel.de>
	<20040402180128.GA363@elf.ucw.cz>
	<20040402181707.GA28112@wohnheim.fh-wedel.de>
	<20040402182357.GB410@elf.ucw.cz>
	<20040402200921.GC653@mail.shareable.org>
	<20040402213933.GB246@elf.ucw.cz>
	<20040403010425.GJ653@mail.shareable.org>
	<m1n05soqh2.fsf@ebiederm.dsl.xmission.com>
	<20040403194344.GA5477@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2004 13:30:24 -0700
In-Reply-To: <20040403194344.GA5477@mail.shareable.org>
Message-ID: <m1ekr4olcv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > > Here's a tricky situation:
> > > 
> > >    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> > > 
> > >    2. At this point both mappings share the same pages in RAM.
> > 
> > Why they have different inodes?
> 
> Did you miss the last 20 or so messages in this thread?
> 
> We'd like cowlinks that are an invisible filesystem optimisation.
> That means you "copy" a file and it behaves the same as if you copy a file.

Exactly so they would not share the same pages in RAM.
 
> > >    3. Then one of the cowlinks is written to...
> > 
> > I would not worry about sharing page cache entries unless this becomes
> > a common case.  If you want to avoid the hit of rereading the file when
> > you have a cow copy it should be simple enough to walk through the list
> > of cow copies and see if anyone else has it open.
> 
> It is not a question of performance, it's correctness.  Either you
> have cowlinks that behave like copied files, or you accept that when
> cowlinked files are mmapped and written to, they don't behave like
> regular files (not even the original file prior to cowlinking does).
> 
> Btw, I'm not suggesting sharing page cache entries.

It sounded like you assumed sharing of page cache entries above.  
How do you get to step 2 if the cow copies don't share the same page
cache entries?

Eric

