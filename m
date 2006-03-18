Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWCRKzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWCRKzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 05:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbWCRKzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 05:55:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750952AbWCRKzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 05:55:41 -0500
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
From: Arjan van de Ven <arjan@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>,
       viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603181144.10820.oliver@neukum.org>
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de>
	 <20060317210823.GA8980@parisc-linux.org>
	 <200603181144.10820.oliver@neukum.org>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Mar 2006 11:55:25 +0100
Message-Id: <1142679326.2889.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 11:44 +0100, Oliver Neukum wrote:
> Am Freitag, 17. März 2006 22:08 schrieb Matthew Wilcox:
> > On Fri, Mar 17, 2006 at 09:58:14PM +0100, Oliver Neukum wrote:
> > > --- a/fs/bio.c	2006-03-11 23:12:55.000000000 +0100
> > > +++ b/fs/bio.c	2006-03-17 16:44:49.000000000 +0100
> > > @@ -635,12 +635,10 @@
> > >  		return ERR_PTR(-ENOMEM);
> > >  
> > >  	ret = -ENOMEM;
> > > -	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> > > +	pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> > 
> > Didn't we just discuss this one and conclude it needed to use kcalloc
> > instead?
> 
> I've found some discussion in the archive, but no conclusion. Could you
> elaborate?

kcalloc is the array allocator.
Here.. you're allocating an array of nr_pages worth of pointers.
kcalloc does extra checks because it KNOWS it's an array...


