Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVATOv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVATOv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 09:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVATOv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 09:51:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:13004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262118AbVATOvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 09:51:25 -0500
Date: Thu, 20 Jan 2005 06:43:38 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AOE: fix up the block device registration so that it actually works now.
Message-ID: <20050120144338.GC13036@kroah.com>
References: <20050119000935.GA22454@kroah.com> <87llap5x69.fsf@coraid.com> <20050119215620.GF4151@kroah.com> <87sm4wkyut.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sm4wkyut.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:35:06AM -0500, Ed L Cashin wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Wed, Jan 19, 2005 at 09:08:14AM -0500, Ed L Cashin wrote:
> >> > diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> >> > --- a/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
> >> > +++ b/drivers/block/aoe/aoeblk.c	2005-01-18 16:06:57 -08:00
> >> > @@ -249,6 +249,7 @@
> >> >  aoeblk_exit(void)
> >> >  {
> >> >  	kmem_cache_destroy(buf_pool_cache);
> >> > +	unregister_blkdev(AOE_MAJOR, DEVICE_NAME);
> >> >  }
> >> 
> >> The unregister_blkdev should already be in aoemain.c:aoe_exit.
> >
> > Why?  You do a register_blockdev() in this file, so if something fails,
> > you should also unregister here.  
> 
> No, the register_blkdev that you see in aoeblk.c is the artifact of a
> snafu I made in patch submission.  I submitted a small patch yesterday
> (ID below) that corrects the snafu and makes block-2.6 the same as the
> driver I have.
> 
>   Message-ID: <87mzv5m9pl.fsf@coraid.com>

Ah, missed that as you didn't CC: me...  I'll apply that one later on
today.

thanks,

greg k-h
