Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUJ0LTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUJ0LTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUJ0LTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:19:52 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:28686 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262380AbUJ0LTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:19:36 -0400
Date: Wed, 27 Oct 2004 12:19:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-ID: <20041027111929.GA27318@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org> <20041022103910.GB17526@infradead.org> <20041022035400.28131d76.akpm@osdl.org> <20041022110846.GA17866@infradead.org> <Pine.LNX.4.61.0410222124240.17266@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410222124240.17266@scrub.home>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 09:34:35PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 22 Oct 2004, Christoph Hellwig wrote:
> 
> > > > > +hfs-export-type-creator-via-xattr.patch
> > > > 
> > > > I haven't heard an answer on the comments on this on on -fsdevel yet..
> > > 
> > > To use the generic xattr code?  Yes, we're waiting to hear back on that.
> > 
> > I'm more concerned about the lacking xattr name prefix as that's a
> > published API.
> 
> Below I only added the prefix. The generic code doesn't seem to have that 
> many advantages if you have only a single prefix anyway, does it?

It has the advantage that we can move the permission check into sooner,
and maybe we can get rid of the old entry point completely one day,
simplifying the xattr subsystem.

> +int hfs_setxattr(struct dentry *dentry, const char *name,
> +		 const void *value, size_t size, int flags)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	struct hfs_find_data fd;
> +	hfs_cat_rec rec;
> +	struct hfs_cat_file *file;
> +	int res;
> +
> +	if (!S_ISREG(inode->i_mode) || HFS_IS_RSRC(inode))
> +		return -EOPNOTSUPP;

You don't have any permission checks here, or did I miss something?

