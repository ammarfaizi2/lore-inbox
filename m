Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVASWPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVASWPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVASWPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:15:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37374 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261930AbVASWOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:14:23 -0500
Date: Wed, 19 Jan 2005 13:56:20 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AOE: fix up the block device registration so that it actually works now.
Message-ID: <20050119215620.GF4151@kroah.com>
References: <20050119000935.GA22454@kroah.com> <87llap5x69.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llap5x69.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:08:14AM -0500, Ed L Cashin wrote:
> > diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> > --- a/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
> > +++ b/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
> > @@ -249,6 +249,7 @@
> >  aoeblk_exit(void)
> >  {
> >  	kmem_cache_destroy(buf_pool_cache);
> > +	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
> >  }
> 
> The unregister_blkdev should already be in aoemain.c:aoe_exit.

Why?  You do a register_blockdev() in this file, so if something fails,
you should also unregister here.  The big problem is you were trying to
register the same major twice :(

thanks,

greg k-h
