Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUEUI4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUEUI4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265459AbUEUI4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:56:54 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35281
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265454AbUEUI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:56:32 -0400
Date: Fri, 21 May 2004 10:56:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ramfs lfs limit
Message-ID: <20040521085630.GO3044@dualathlon.random>
References: <20040521073702.GM3044@dualathlon.random> <20040521074112.GA29558@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521074112.GA29558@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 03:41:12AM -0400, Jeff Garzik wrote:
> On Fri, May 21, 2004 at 09:37:02AM +0200, Andrea Arcangeli wrote:
> > Hi Andrew,
> > 
> > this fixes the 2G limit on ramfs
> > 
> > --- sles/fs/ramfs/inode.c.~1~	2003-10-31 05:54:29.000000000 +0100
> > +++ sles/fs/ramfs/inode.c	2004-05-21 07:55:07.394369104 +0200
> > @@ -181,6 +181,7 @@ static int ramfs_fill_super(struct super
> >  	struct inode * inode;
> >  	struct dentry * root;
> >  
> > +	sb->s_maxbytes = MAX_LFS_FILESIZE;
> 
> 
> Why don't we change the default in alloc_super() instead?
> 
> We should not default to "lame" :)

we default to "lame" to protect the lame filesystems from
malfunctioning ;), this was extremely intentional in the early days, now
less but it's still intentional. We may change that someday but
defaulting to safe when there's no downside doesn't sound that urgent to
change.
