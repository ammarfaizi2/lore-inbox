Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVF1PRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVF1PRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVF1PRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:17:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44701 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262005AbVF1PR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:17:26 -0400
Message-Id: <200506281401.j5SE1ORW003589@laptop11.inf.utfsm.cl>
To: Alexander Zarochentsev <zam@namesys.com>
cc: Christoph Hellwig <hch@infradead.org>, David Masover <ninja@slaphack.com>,
       Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Alexander Zarochentsev <zam@namesys.com> 
   of "Mon, 27 Jun 2005 13:30:06 +0400." <200506271330.07451.zam@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 28 Jun 2005 10:01:24 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 28 Jun 2005 11:16:30 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Zarochentsev <zam@namesys.com> wrote:
> On Sunday 26 June 2005 21:02, Christoph Hellwig wrote:

[...]

> > David and Hans, I've read through my backlog a lot now, and I must say
> > it's pretty pointless - you're discussing lots of highlevel what if and
> > don't actually care about something as boring as actual technical details.
> >
> > Hans has lots of very skillfull technical people like zam and vs, and maybe
> > he should give them some freedom to sort out technical issues for a basic
> > reiser4 merge, and one that is done we can turn back to discussion of
> > advanced features and their implementation, hopefully with a few more
> > arguments on both sides and a real technical discussion.

> Unfortunately, this is not only a technical discussion...  it is about linux 
> development model too.

Then better separate the two, keeping the technical discussion on LKML and
taking the development model stuff elsewhere.

> Well, about the plugins.

First step: Axe them. They are (at most) /configuration options/, that will
have to get fixed meanings, available to all ReiserFS filesystems purely
for compatibility reasons. Sure, do get wild on new options in your own
experimental trees, and migrate what survives into the standard version
(and then it'll be ReiserFS 4.1, 4.2, ..., 4.25, ...).

>                          We can clean reiser4<->VFS interface up by setting 
> per-vfs-object inode/dentry/super ops instead using of our own dispatcher.  

Sounds reasonable.

> So different reiser4 inodes/files will have different i_ops/f_ops.  That 
> would be only visible-in-VFS part of reiser4 object plugins.   

How would that work out from the userland (system call) perspective? How
does that get handled from on-disk format?

> Would the help to solve "reiser4 plugins" question?  It is just as other
> FS do -- procfs has seq_file and sysconfig interfaces below the VFS and
> l-k people do not complain each day about layering violation ;-) Procfs
> is taken as an example because it deals with objects of different types,
> actually anybody may create own procfs objects more or less general way.

But procfs /is/ quite special, as it is supposed to be a window into the
kernel, not real files. Some layering violation is unavoidable there.

> I don't belive that you want to see all reiser4-specific things as item 
> plugins, disk format plugins in the VFS.

Only what makes sense. Plus many of those will probably have to go. Decide
on /one/ way of doing things, even if not perfect for all uses. Everything
else is useless bloat.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
