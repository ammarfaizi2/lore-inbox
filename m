Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVCHDiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVCHDiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVCHDeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 22:34:23 -0500
Received: from mail.dif.dk ([193.138.115.101]:13769 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261304AbVCHDag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 22:30:36 -0500
Date: Tue, 8 Mar 2005 04:31:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "Edgar, Bob" <Bob.Edgar@commerzbankib.com>,
       Steve French <sfrench@us.ibm.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Luca Tettamanti <kronos@kronoz.cjb.net>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH] whitespace cleanups for fs/cifs/file.c
In-Reply-To: <20050307102846.GF27352@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.62.0503080425050.2941@dragon.hygekrogen.localhost>
References: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com>
 <20050307102846.GF27352@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005, Andreas Dilger wrote:

> On Mar 07, 2005  10:26 +0100, Edgar, Bob wrote:
> > I lurk on the list and didn't comment last time but there is one aspect
> > of this patch that I think is "bad" style. The function declaration should
> > not be on the same line with the type. Why? Try to find the file where a
> > function is defined instead of used. If you grep "^funcname" you'll find
> > it quite simply. The same is true in YFE (mine being vi) /^funcname gets
> > me there in one shot.
> > 
> > This may not seem an important thing but when you are coming into a
> > project cold and don't know how anything works or where it lives it
> > can be very important. Consider trying to find where some common
> > function from a library is defined in a project with sever 1000 files.
> 
> Tags is your friend.  See "make tags" (for vim) or "make TAGS" (for *emacs).
> This is far more efficient than "grep -r ^funcname linux" if you don't even
> know what file a function/struct is defined in.  Use CTRL-] to jump to the
> function/struct under the cursor and CTRL-T to pop back out.
> 
> 
> Ironically, the whitespace patch gets the small things right, but misses
> on the big readability issues, such as cifs_open() being 220 lines long
> and having a _really_ hard time staying inside 80 columns because of so
> many levels of nested conditionals.
> 
I wanted to stick to smaller changes initially. I can submit a patch for 
that function if Steve wants it.

> Judicious use of gotos and some helper functions would help a lot
> here (e.g.  after CIFSSMBOpen() "if (rc) { ... goto out; }" and
> "if (!file->private_data) goto out;", would avoid indenting the rest
> of the function 16 columns.  Adding a couple helper functions like
> "cifs_convert_flags()" to return desiredAccess and disposition, and
> "cifs_init_private_data()" to allocate ->private_data and initialize
> the masses of fields would be good.
> 
> Is it possible that pCifsInode can ever be NULL???  Similarly, "if (buf)"
> on line 196 is needless, as it has already been checked on line 153
> (and we abort in that case).  Also, kfree() can handle NULL pointers.
> 
I'm aware of those isues, and I am planning to submit patches for them, 
but I wanted to wait and get Steve's response to the smaller cleanups 
first.


-- 
Jesper 


