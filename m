Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUDZXM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUDZXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUDZXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 19:12:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:35969 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262837AbUDZXJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 19:09:43 -0400
Date: Mon, 26 Apr 2004 15:14:07 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
Subject: Re: [PATCH 1/9] USB usbfs: take a reference to the usb device
Message-ID: <20040426221407.GB22719@kroah.com>
References: <200404141229.26677.baldrick@free.fr> <20040423231811.GA10398@kroah.com> <200404261605.17486.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404261605.17486.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 04:05:17PM +0200, Duncan Sands wrote:
> diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> --- a/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> +++ b/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> @@ -350,8 +350,8 @@
>  	 * all pending I/O requests; 2.6 does that.
>  	 */
>  
> -	if (ifnum < 8*sizeof(ps->ifclaimed))
> -		clear_bit(ifnum, &ps->ifclaimed);
> +	BUG_ON(ifnum >= 8*sizeof(ps->ifclaimed));

I've changed that to a WARN_ON().  Yeah, writing over memory is bad, but
oopsing is worse.  Let's be a bit nicer than that.

thanks,

greg k-h
