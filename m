Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263255AbVFXLjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbVFXLjC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbVFXLjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:39:02 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:63927 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263255AbVFXLhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:37:10 -0400
Subject: Re: reiser4 plugins
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42BB7B32.4010100@slaphack.com>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <42BB31E9.50805@slaphack.com>
	 <1119570225.18655.75.camel@localhost.localdomain>
	 <42BB7B32.4010100@slaphack.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119612849.17063.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Jun 2005 12:34:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-24 at 04:17, David Masover wrote:
> > False argument. So does the pen, so do hinges on doors. Do you still
> > have hinges on your doors - probably.
> 
> Indeed.  Because there's nothing better -- not because I "like it the
> way it is".

I chose hinges carefully - there are better technologies than the
generic hinge and there have been for many many years (plus cool stuff
like magnetic doors). You of course aren't a door geek (nor am I I'd
point out) but a computing one...

> Although resilience to disk errors isn't a design decision.  That's what
> SMART and new hard drives are for.  And if you're stubborn enough to
> keep the same FS around, there's dm-bbr.

Its very much a file system design consideration. If you get a small
amount of corruption or lost blocks which is the usual drive failure
case you want a high probability of getting the data back. BSD style
bitmap/inode table file systems based on FFS concepts (UFS, ext2, ext3
etc) are very good in that respect and your loss is usually minimal.

> I think Hans (or someone) decided that when hardware stops working, it's
> not the job of the FS to compensate, it's the job of lower layers, or
> better, the job of the admin to replace the disk and restore from backups.

Most desktop users today don't have backups because there is no credible
backup technology for 500Gb of data. They may have partial backups. Some
things the fs can't deal with - if the disk goes boom then thats a lower
level concern. Also certain bits like writing to spare blocks on a
problem write are indeed handled drive level nowdays.

> > Entirely or bad blocks ? The latter should have a minimal cost on a well
> > designed fs.
> 
> I was able to recover from bad blocks, though of course no Reiser that I
> know of has had bad block relocation built in...  But I got all my files
> off of it, fortunately.

Thats a good sign. reiser3 was very fragile when blocks of disk went for
a walk. If you got most of your data back thats a positive sign, not
statistically a valid sample but a positive sign

> the issues are fixed, an entirely different crowd of benevolent
> dictators will come around and say that we can't get in because we
> change the VFS.  At least some people on this list have said things to
> that effect.

There are four important issues I see here

1. It must work
2. It must be clean code that follows the kernel style
3. It must not break other stuff
4. It needs a maintainer who won't get bored 12 months later and only
support reiser5

#3 is the VFS stuff and getting the VFS locking wrong or unclean is a
*very* big deal because you'll cause corruption to non reiser4 users.

Alan

