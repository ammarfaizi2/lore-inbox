Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVCWVtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVCWVtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVCWVta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:49:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:16298 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262931AbVCWVsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:48:16 -0500
Date: Wed, 23 Mar 2005 22:50:06 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Richard Gooch <rgooch@atnf.csiro.au>
Subject: Re: [PATCH] devfs: remove a redundant NULL pointer check prior to
 kfree()
In-Reply-To: <200503231104.10704.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.62.0503232246080.2501@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503222351350.2683@dragon.hyggekrogen.localhost>
 <200503231104.10704.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Denis Vlasenko wrote:

> On Wednesday 23 March 2005 00:55, Jesper Juhl wrote:
> > 
> > Remove a redundant NULL pointer check prior to kfree(). kfree() has no 
> > problem with NULL pointers.
> > 
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> > 
> > --- linux-2.6.12-rc1-mm1-orig/fs/devfs/base.c	2005-03-02 08:37:49.000000000 +0100
> > +++ linux-2.6.12-rc1-mm1/fs/devfs/base.c	2005-03-22 23:51:23.000000000 +0100
> > @@ -2738,10 +2738,8 @@ static int devfsd_close(struct inode *in
> >  	entry = fs_info->devfsd_first_event;
> >  	fs_info->devfsd_first_event = NULL;
> >  	fs_info->devfsd_last_event = NULL;
> > -	if (fs_info->devfsd_info) {
> > -		kfree(fs_info->devfsd_info);
> > -		fs_info->devfsd_info = NULL;
> > -	}
> > +	kfree(fs_info->devfsd_info);
> > +	fs_info->devfsd_info = NULL;
> >  	spin_unlock(&fs_info->devfsd_buffer_lock);
> >  	fs_info->devfsd_pgrp = 0;
> >  	fs_info->devfsd_task = NULL;
> 
> IIRC devfs is deprecated and has less than a year to live.

Yes, it's going to go away soon, but it /is/ still in the kernel.
As I see it, as long as something is in the kernel there's no reason to 
not keep improving it if someone is willing to do the work. And since the 
patch is already done why not use it?
For every kernel that has devfs build in this patch will save a few bytes 
of kernel memory, and why not give people that tiny bennefit?


-- 
Jesper Juhl


