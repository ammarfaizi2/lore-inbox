Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbUCTUQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbUCTUQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:16:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:25753 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263525AbUCTUQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:16:52 -0500
Date: Sat, 20 Mar 2004 12:16:36 -0800
From: Greg KH <greg@kroah.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-usb-users@lists.sourceforge.net
Subject: Re: [PATCH 2.6.5-rc2] CAN-2004-0075 still valid for 2.6?
Message-ID: <20040320201636.GC14667@kroah.com>
References: <200403202059.33039@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403202059.33039@WOLK>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 08:59:33PM +0100, Marc-Christian Petersen wrote:
> Hi Greg,
> 
> seems $subject is still valid for 2.6, no? - 2.4 got a fix 11 weeks ago.
> 
> See this: 
> http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/usb/vicam.c@1.15?nav=index.html|
> src/|src/drivers|src/drivers/usb|hist/drivers/usb/vicam.c
> 
> Please apply.
> 
> ciao, Marc

> # drivers/usb/media/vicam.c |   13 ++++++++++---
> # 1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff -urN linux-old/drivers/usb/media/vicam.c linux-wolk-for-2.6drivers/usb/media/vicam.c
> --- linux-old/drivers/usb/media/vicam.c	2003-11-28 10:26:20.000000000 -0800
> +++ linux-wolk-for-2.6drivers/usb/media/vicam.c	2004-01-15 12:10:23.000000000 -0800
> @@ -653,12 +653,19 @@
>  	case VIDIOCSWIN:
>  		{
>  
> -			struct video_window *vw = (struct video_window *) arg;
> -			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
> +			struct video_window vw;
>  
> -			if ( vw->width != 320 || vw->height != 240 )
> +			if (copy_from_user(&vw, arg, sizeof(vw)))
> +			{

Care to implement proper coding style here?

And for some reason I thought this was already fixed in 2.6...  guess
not.

thanks,

greg k-h
