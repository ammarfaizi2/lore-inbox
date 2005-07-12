Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVGLDeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVGLDeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVGLDeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:34:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44448 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262307AbVGLDdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:33:23 -0400
Message-Id: <200507120153.j6C1rgUw007153@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Stefan Smietanowski <stesmi@stesmi.com>, Hans Reiser <reiser@namesys.com>,
       Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Mon, 11 Jul 2005 15:50:33 EST." <42D2DB99.9050307@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 11 Jul 2005 21:53:41 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:

[...]

> Both camps seem to want to allow easy access to the metadata of a
> file, whether we're given that file as an inode or as a pathname.
> That's why I suggested /meta/vfs and /meta/inode -- sometimes I want
> to look up a file by name, and sometimes by inode, but either way, I
> should be able to get its metadata.

You should /never/ give access just by inode, as that makes it very easy to
bypass security given by directory permissions.

> > I mean, editing something is easy and you don't have to "know" how
> > to navigate /meta

> But then you have to "know" how to navigate .meta, and more
> importantly, how to find .meta

And what the heck the format of the metadata is today/for this particular
file.

[...]

> Either way, the major challenge to this method is not so much whether
> it'd work, but how to choose a suitable delimiter?  The delimiter must
> be standard if we're going to have apps develop for it, and it must
> not be used in the name of any existing file or directory.

The only characters that aren't used in filenames today are '/' and '\0'.

> I had a long essay here on how '.meta' breaks every recursive
> operation on directories (rm -rf, tar, mkisofs), but I deleted it when
> I remembered that I played around with the alpha/beta reiser4 which
> had a 'metas' dir that did the same thing, but was hidden from the
> normal directory listing.  'cd metas' worked, 'ls metas' worked, but
> 'ls' showed no directory called 'metas'.

And if I try to create a file or directory called metas?

> I don't *think* there are any apps that will break if you tell them to
> open a path that doesn't exist in a directory listing.  That is,
> typing 'vim /home/metas/acl' should always let me edit the acl on
> /home, and vim should never complain about how /home/metas doesn't
> show up in /home.  A program would have to be pretty retarded to fail
> on something like that.

Think a GUI that reads the directory to find out what is available and
present them as icons for mousing around. Then there is no way to futz
around with your metadata.

Think filename completion, bash style. No, not just bash uses this.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
