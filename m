Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWCSN3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWCSN3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 08:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCSN3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 08:29:23 -0500
Received: from mail1.kontent.de ([81.88.34.36]:5314 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932092AbWCSN3W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 08:29:22 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
Date: Sun, 19 Mar 2006 14:29:21 +0100
User-Agent: KMail/1.8
Cc: Matthew Wilcox <matthew@wil.cx>, viro@zeniv.linux.org.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de> <200603181144.10820.oliver@neukum.org> <1142679326.2889.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1142679326.2889.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603191429.21776.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 18. März 2006 11:55 schrieb Arjan van de Ven:
> On Sat, 2006-03-18 at 11:44 +0100, Oliver Neukum wrote:
> > Am Freitag, 17. März 2006 22:08 schrieb Matthew Wilcox:
> > > On Fri, Mar 17, 2006 at 09:58:14PM +0100, Oliver Neukum wrote:
> > > > --- a/fs/bio.c	2006-03-11 23:12:55.000000000 +0100
> > > > +++ b/fs/bio.c	2006-03-17 16:44:49.000000000 +0100
> > > > @@ -635,12 +635,10 @@
> > > >  		return ERR_PTR(-ENOMEM);
> > > >  
> > > >  	ret = -ENOMEM;
> > > > -	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> > > > +	pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> > > 
> > > Didn't we just discuss this one and conclude it needed to use kcalloc
> > > instead?
> > 
> > I've found some discussion in the archive, but no conclusion. Could you
> > elaborate?
> 
> kcalloc is the array allocator.
> Here.. you're allocating an array of nr_pages worth of pointers.
> kcalloc does extra checks because it KNOWS it's an array...

I see. A patch is coming.
Shouldn't this check from slab.h:

	if (n != 0 && size > INT_MAX / n)
		return NULL;

carry an "unlikely"?

	Regards
		Oliver
