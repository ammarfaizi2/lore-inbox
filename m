Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751892AbWJMUht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbWJMUht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWJMUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:37:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751888AbWJMUhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:37:47 -0400
Date: Fri, 13 Oct 2006 13:37:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi, ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: Re: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
Message-Id: <20061013133722.d4f33ecb.akpm@osdl.org>
In-Reply-To: <20061013200705.GB31928@filer.fsl.cs.sunysb.edu>
References: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu>
	<ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
	<20061013122706.56970df2.akpm@osdl.org>
	<20061013200705.GB31928@filer.fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 16:07:05 -0400
Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:

> > > +static inline void __stackfs_copy_attr_all(struct inode *dest,
> > > +					   const struct inode *src,
> > > +					   int (*get_nlinks)(struct inode *))
> > > +{
> > > +	if (!get_nlinks)
> > > +		dest->i_nlink = src->i_nlink;
> > > +	else
> > > +		dest->i_nlink = get_nlinks(dest);
> > 
> > I cannot find a get_nlinks() in 2.6.19-rc2?
>  
> It is the last argument to the function. Perhaps the function name is
> deceiving.

doh.

That's why us old farts like to see

	dest->i_nlink = (*get_nlinks)(dest);

