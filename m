Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUKWTwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUKWTwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKWTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:50:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:63893 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261525AbUKWTrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:47:03 -0500
Date: Tue, 23 Nov 2004 11:45:58 -0800
From: Greg KH <greg@kroah.com>
To: Simon Fowler <simon@himi.org>, linux-kernel@vger.kernel.org
Cc: rl@hellgate.ch
Subject: Re: [2.6 PATCH] visor: Don't count outstanding URBs twice
Message-ID: <20041123194557.GB1196@kroah.com>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123193604.GA12605@k3.hellgate.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 08:36:04PM +0100, Roger Luethi wrote:
> Guys, can you please CC me when discussing patches of mine?

Your email client is putting headers in the messages that say not to do
this.  Please fix your client :)

> I don't read
> LKML religiously, and my procmail filters are pretty dumb. Thanks. So
> my previous patch fixed the oops, but the driver's still borked.
> 
> Incrementing the outstanding_urbs counter twice for the same URB can't
> be good. No wonder Simon didn't get far syncing his Palm.
> 
> Signed-off-by: Roger Luethi <rl@hellgate.ch>
> 
> --- linux-2.6.10-rc2-bk8/drivers/usb/serial/visor.c.orig	2004-11-23 20:23:27.592097112 +0100
> +++ linux-2.6.10-rc2-bk8/drivers/usb/serial/visor.c	2004-11-23 20:24:53.496037728 +0100
> @@ -497,7 +497,6 @@ static int visor_write (struct usb_seria
>  		dev_dbg(&port->dev, "write limit hit\n");
>  		return 0;
>  	}
> -	++priv->outstanding_urbs;
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
>  	buffer = kmalloc (count, GFP_ATOMIC);

Good catch.

But I'm not seeing people actually hit the write limit, according to the
logs that people are posting.

Can anyone test this patch to see if it fixes their issues?

thanks,

greg k-h
