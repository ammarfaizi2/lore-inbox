Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUDCTnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUDCTnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:43:50 -0500
Received: from mail.shareable.org ([81.29.64.88]:57494 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261900AbUDCTnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:43:49 -0500
Date: Sat, 3 Apr 2004 20:43:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403194344.GA5477@mail.shareable.org>
References: <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <m1n05soqh2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1n05soqh2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> > Here's a tricky situation:
> > 
> >    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> > 
> >    2. At this point both mappings share the same pages in RAM.
> 
> Why they have different inodes?

Did you miss the last 20 or so messages in this thread?

We'd like cowlinks that are an invisible filesystem optimisation.
That means you "copy" a file and it behaves the same as if you copy a file.

> >    3. Then one of the cowlinks is written to...
> 
> I would not worry about sharing page cache entries unless this becomes
> a common case.  If you want to avoid the hit of rereading the file when
> you have a cow copy it should be simple enough to walk through the list
> of cow copies and see if anyone else has it open.

It is not a question of performance, it's correctness.  Either you
have cowlinks that behave like copied files, or you accept that when
cowlinked files are mmapped and written to, they don't behave like
regular files (not even the original file prior to cowlinking does).

Btw, I'm not suggesting sharing page cache entries.

-- Jamie
