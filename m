Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVHHWYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVHHWYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVHHWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:24:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:44243 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932294AbVHHWYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:24:47 -0400
Date: Mon, 8 Aug 2005 15:24:23 -0700
From: Greg KH <greg@kroah.com>
To: Horst Schirmeier <horst@schirmeier.com>
Cc: gregkh@suse.de, trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc3-git9] pl2303: pl2303_update_line_status data length fix
Message-ID: <20050808222423.GA4550@kroah.com>
References: <20050728133220.GJ25889@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728133220.GJ25889@quickstop.soohrt.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 03:32:20PM +0200, Horst Schirmeier wrote:
> Minimum data length must be UART_STATE + 1, as data[UART_STATE] is being
> accessed for the new line_state. Although PL-2303 hardware is not
> expected to send data with exactly UART_STATE length, this keeps it on
> the safe side.
> 
> Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
> ---
> 
> --- linux-2.6.13-rc3-git9/drivers/usb/serial/pl2303.c.orig	2005-07-28 14:42:58.000000000 +0200
> +++ linux-2.6.13-rc3-git9/drivers/usb/serial/pl2303.c	2005-07-28 14:43:16.000000000 +0200
> @@ -826,7 +826,7 @@ static void pl2303_update_line_status(st
>  	struct pl2303_private *priv = usb_get_serial_port_data(port);
>  	unsigned long flags;
>  	u8 status_idx = UART_STATE;
> -	u8 length = UART_STATE;
> +	u8 length = UART_STATE + 1;

"safe side" yes, but this will just prevent any line changes from going
back to the user, right?

Hm, how is this working at all, it looks like we overflow the buffer...

Have you tested this change?

thanks,

greg k-h
