Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWEGHhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWEGHhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 03:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWEGHhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 03:37:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56263 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751197AbWEGHhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 03:37:09 -0400
Date: Sun, 7 May 2006 08:37:08 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: minixfs bitmaps and associated lossage
Message-ID: <20060507073708.GW27946@ftp.linux.org.uk>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk> <20060506163737.GP27946@ftp.linux.org.uk> <20060506220451.GQ27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605061524420.16343@g5.osdl.org> <20060506231054.GR27946@ftp.linux.org.uk> <Pine.LNX.4.64.0605061633020.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605061633020.16343@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 04:42:27PM -0700, Linus Torvalds wrote:
> > If somebody wants to play with that code, they could just merge fs/minix
> > into fs/sysv - that might very well turn out to be the right thing and
> > a fun exercise.  Codebases are very close - minixfs is a derivative of
> > v7 filesystem, after all, and our fs/minix and fs/sysv had been kept
> > mostly in sync.
> 
> Heh. Yes. The physical filesystem layout of minix is close to the old sysv 
> one, and the implementation ends up being pretty closely related too, 
> although the genealogy there is the other way around.

Actually, some things (e.g. indirect block tree handling and directory
handling via pagecache) went the other way - from fs/sysv to fs/minix.

> However, I thought the direct sysv descendants used linked lists of 
> free-block lists, not bitmaps? So while a lot of the _other_ part of the 
> filesystem layout is similar, the actual free-block handling is very 
> different. No?

Yes and no - keep in mind that details of those lists are different for
various sysvfs flavours, so sysv_new_block() et.al. check sbi->s_type
anyway.  And the entry points into [ib]alloc are parallel, so it's not
hard to merge transparently for the rest of code.

Superblock layouts are very different, obviously, but they are just as
different among sysv flavours.  Again, no big deal...
 
BTW, there's a sysv flavour that uses bitmaps (EAFS); we only do it
read-only, so that's not an issue with the current fs/sysv code.

Again, what I'm saying is that figuring out details of doing it clean
way would make a good exercise, not that we can't live without that.
