Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTFZW7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTFZW6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:58:51 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:35544 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264201AbTFZWzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:55:32 -0400
Date: Fri, 27 Jun 2003 01:09:33 +0200
From: Manuel Estrada Sainz <ranty-bulk@ranty.pantax.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       orinoco-devel@lists.sf.net, jt@hpl.hp.com
Subject: Re: orinoco_usb Request For Comments
Message-ID: <20030626230933.GB4703@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20030626205811.GA25783@ranty.pantax.net> <200306262341.19110.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306262341.19110.oliver@neukum.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 11:41:18PM +0200, Oliver Neukum wrote:
> 
> >  Please comment, how much of that or what else needs to be done to get
> >  it in the kernel?
> 
> 	if(dev->read.urb->status == -EINPROGRESS){
> 		warn("%s: Unlinking pending IN urb", __FUNCTION__);
> 		retval = bridge_remove_in_urb(dev);
> 		if(retval){
> 			dbg("retval %d status %d", retval,
> 			    dev->read.urb->status);
> 		}
> 	}
> 
> Unlink unconditionally.

 OK, done.

> 		/* We don't like racing :) */
> 		ctx->outurb->transfer_flags &= ~URB_ASYNC_UNLINK;
> 		usb_unlink_urb(ctx->outurb);
> 		del_timer_sync(&ctx->timer);
> 
> But neither do we like sleeping in interrupt. You can't simply unset the flag
> if somebody else may be needing it.

 mmm, but the problem is that the interrupt handler can rearm the timer.
 And it can also complete the request_context freeing the memory, and we
 don't want to free the memory twice or access freed memory.

 Suggestions on how to get this right would be greatly appreciated.

 Maybe more paranoid refcounting?

> More when I am rested :-)

 Thanks a lot, I was really missing some peer review.

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
