Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVBVOo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVBVOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVBVOo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:44:28 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:26575 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262319AbVBVOoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:44:16 -0500
Date: Tue, 22 Feb 2005 15:44:16 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 6/6] Bind Mount Extensions 0.06
Message-ID: <20050222144415.GA8945@mail.13thfloor.at>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050222121333.GG3682@mail.13thfloor.at> <1109082871.9839.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109082871.9839.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 09:34:31AM -0500, Trond Myklebust wrote:
> ty den 22.02.2005 Klokka 13:13 (+0100) skreiv Herbert Poetzl:
> > 
> > diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfs/dir.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfs/dir.c
> > --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfs/dir.c	2005-02-13 17:16:55 +0100
> > +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfs/dir.c	2005-02-19 06:32:05 +0100
> > @@ -771,7 +771,8 @@ static int is_atomic_open(struct inode *
> >  	if (nd->flags & LOOKUP_DIRECTORY)
> >  		return 0;
> >  	/* Are we trying to write to a read only partition? */
> > -	if (IS_RDONLY(dir) && (nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
> > +	if ((IS_RDONLY(dir) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
> > +		(nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
> >  		return 0;
> >  	return 1;
> >  }
> 
> The check for nd != NULL is redundant. See 5 lines further up...

indeed, thanks!

> Cheers,
>   Trond
> 
> -- 
> Trond Myklebust <trond.myklebust@fys.uio.no>
