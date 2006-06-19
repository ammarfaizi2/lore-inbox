Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWFSThH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWFSThH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFSThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:37:06 -0400
Received: from thunk.org ([69.25.196.29]:29652 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751245AbWFSThF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:37:05 -0400
Date: Mon, 19 Jun 2006 15:37:06 -0400
From: Theodore Tso <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux390@de.ibm.com
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with inode.i_private
Message-ID: <20060619193706.GA16594@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux390@de.ibm.com
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.418349000@candygram.thunk.org> <20060619190921.GA16959@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619190921.GA16959@infradead.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:09:22PM +0100, Christoph Hellwig wrote:
> > Index: linux-2.6.17/arch/s390/kernel/debug.c
> > ===================================================================
> > --- linux-2.6.17.orig/arch/s390/kernel/debug.c	2006-06-18 18:58:51.000000000 -0400
> > +++ linux-2.6.17/arch/s390/kernel/debug.c	2006-06-18 18:58:55.000000000 -0400
> > @@ -604,7 +604,7 @@
> >  	debug_info_t *debug_info, *debug_info_snapshot;
> >  
> >  	down(&debug_lock);
> > -	debug_info = (struct debug_info*)file->f_dentry->d_inode->u.generic_ip;
> > +	debug_info = (struct debug_info*)file->f_dentry->d_inode->i_private;
> 
> is this actually okay?  who owns the private data in debugfs inodes?

debugfs allows the caller of debugfs_create_file() to pass in private
data.  So this in fact the intended way it's supposed to work AFAIK.
The s/390 debug facility passed in a struct debug_info * in
debug_register_view()'s call to debugfs_create_file, and it pulls it
out again in debug_open() (in the above referenced patch).

						- Ted
