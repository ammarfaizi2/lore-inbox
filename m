Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUDCJJh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 04:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUDCJJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 04:09:37 -0500
Received: from gprs214-57.eurotel.cz ([160.218.214.57]:64128 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261654AbUDCJJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 04:09:35 -0500
Date: Sat, 3 Apr 2004 11:09:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: andersen@codepoet.org,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403090917.GD1316@elf.ucw.cz>
References: <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <20040403012112.GA6499@codepoet.org> <20040403015920.GA2857@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403015920.GA2857@mail.shareable.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Erik Andersen wrote:
> > > Here's a tricky situation:
> > > 
> > >    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> > > 
> > >    2. At this point both mappings share the same pages in RAM.
> > > 
> > >    3. Then one of the cowlinks is written to...
> > 
> > Using mmap with PROT_WRITE on a cowlink must preemptively
> > break the link.
> 
> I forget to mention, they are PROT_READ shared mappings.

I'm not mm guru, but... with rmap, we should be able to find all the
users of that shared memory, and unmap their pages, right?

Until copy is done, we don't do anything, because write is not allowed
to progress until copy is done. When copy is done we should unmap all
the pages that still point to "old" copy, let write progress, and make
users fault in. 
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
