Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUDCAqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUDCAqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:46:47 -0500
Received: from mail.shareable.org ([81.29.64.88]:22166 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261505AbUDCAqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:46:42 -0500
Date: Sat, 3 Apr 2004 01:46:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403004635.GH653@mail.shareable.org>
References: <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402213933.GB246@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Actually, my solution has one weirdness...
> 
> > a
> copyfile a b
> rm a
> 
> ...now b has pointer to cowid with usage count of 1. Which is slightly
> ugly (and wastes one cowid entry), but should be harmless.

That's necessary, unless the cowid object has a linked list of all the
inodes which point to it, a bit like inodes having a linke list of all
parent directories which point to them.  That's not impossible, but
leaving the unnecessary cowid object is much simpler and will result
in less I/O (no doubly-linked list to update).  It can be garbage
collected when the last reference is followed to it.

> > get_data_id() is one way to detect equivalent files.  Another would be
> > a function files_equal(fd1, fd2) which returns a boolean.
> 
> files_equal(...) would lead to quadratic number of calls, no?

Yes. </blush>

-- Jamie
