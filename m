Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbVIBEJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbVIBEJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030670AbVIBEJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:09:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030596AbVIBEJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:09:36 -0400
Date: Thu, 1 Sep 2005 21:07:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml-z@robsims.com, linux-kernel@vger.kernel.org
Subject: Re: Change in NFS client behavior
Message-Id: <20050901210755.607f3e4d.akpm@osdl.org>
In-Reply-To: <1125633145.8635.11.camel@lade.trondhjem.org>
References: <20050831145545.GA8426@robsims.com>
	<1125617897.7627.14.camel@lade.trondhjem.org>
	<1125632597.8635.9.camel@lade.trondhjem.org>
	<20050901204520.58f07230.akpm@osdl.org>
	<1125633145.8635.11.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> to den 01.09.2005 Klokka 20:45 (-0700) skreiv Andrew Morton:
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > >
> > >  +static inline int do_posix_truncate(struct dentry *dentry, loff_t length)
> > >  +{
> > >  +	/* In SuS/Posix lore, truncate to the current file size is a no-op */
> > >  +	if (length == i_size_read(dentry->d_inode))
> > >  +		return 0;
> > >  +	return do_truncate(dentry, length);
> > >  +}
> > 
> > We have the same optimisation in inode_setattr()...
> 
> Look again. The two are NOT the same.
> 
> The code in inode_setattr() will cause truncate() to erroneously update
> the ctime/mtime.

Of course.  But with your patch, the optimisation in inode_setattr() is
redundant (except for O_TRUNC, perhaps).
