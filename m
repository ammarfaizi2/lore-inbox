Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVGFUXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVGFUXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGFUUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:20:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:28614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262358AbVGFUTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:19:41 -0400
Date: Wed, 6 Jul 2005 13:19:17 -0700
From: Greg KH <greg@kroah.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] add securityfs for all LSMs to use
Message-ID: <20050706201917.GB18969@kroah.com>
References: <20050706081725.GA15544@kroah.com> <200507062213.05337.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507062213.05337.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 10:12:59PM +0200, Ingo Oeser wrote:
> Hi Greg,
> 
> On Wednesday 06 July 2005 10:17, Greg KH wrote:
> > + * TODO:
> > + *   I think I can get rid of these default_file_ops, but not quite sure...
> > + */
> > +static ssize_t default_read_file(struct file *file, char __user *buf,
> > +				 size_t count, loff_t *ppos)
> > +{
> > +	return 0;
> > +}
> > +
> > +static ssize_t default_write_file(struct file *file, const char __user *buf,
> > +				   size_t count, loff_t *ppos)
> > +{
> > +	return count;
> > +}
> 
> Yes, you can get rid of both, if you move read_null and write_null from 
> drivers/char/mem.c to fs/libfs.c and export them.

That's not really necessary.

> But for what do you need a successful dummy read/write?

I don't.  I need a file_ops structure to give to my newly created dentry
before I assign the one passed in by the caller to it.  That's all.  I
could probably just pass it up the function stack to do it properly,
haven't really looked into it...

thanks,

greg k-h
