Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUAWVBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 16:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUAWVBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 16:01:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:41604 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262308AbUAWVBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 16:01:02 -0500
Date: Fri, 23 Jan 2004 12:41:35 -0800
From: Greg KH <greg@kroah.com>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspicious pointer usage in kobil_sct driver.
Message-ID: <20040123204135.GD23959@kroah.com>
References: <E1Ajuub-0000xh-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Ajuub-0000xh-00@hardwired>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 06:35:25AM +0000, davej@redhat.com wrote:
> Greg, is this what's intended here?

Yes, your patch is correct.  I'll go apply it, thanks.

greg k-h

> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/serial/kobil_sct.c linux-2.5/drivers/usb/serial/kobil_sct.c
> --- bk-linus/drivers/usb/serial/kobil_sct.c	2003-09-29 20:00:01.000000000 +0100
> +++ linux-2.5/drivers/usb/serial/kobil_sct.c	2004-01-23 05:06:40.000000000 +0000
> @@ -651,7 +651,7 @@ static int  kobil_ioctl(struct usb_seria
>  		return 0;
>  
>  	case TCSETS:   // 0x5402
> -		if (! &port->tty->termios) {
> +		if (!(port->tty->termios)) {
>  			dbg("%s - port %d Error: port->tty->termios is NULL", __FUNCTION__, port->number);
>  			return -ENOTTY;
>  		}
