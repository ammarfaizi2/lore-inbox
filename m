Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTJMUbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTJMUbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 16:31:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:45717 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261939AbTJMUbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 16:31:06 -0400
Date: Mon, 13 Oct 2003 13:31:05 -0700
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: greg@kroah.com
Subject: Re: 2.6.0-test7 USB and Palm Tungsten problem
Message-Id: <20031013133105.68f71b99.cliffw@osdl.org>
In-Reply-To: <20031013194616.GA11679@kroah.com>
References: <Pine.LNX.4.58.0310131855060.2551@moje.vabo.cz>
	<20031013194616.GA11679@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003 12:46:16 -0700
Greg KH <greg@kroah.com> wrote:

> On Mon, Oct 13, 2003 at 07:06:49PM -0400, Tomas Konir wrote:
> > 
> > Hi
> > I tried 2.6.0-test7, but new USB problem found. I tried to synchronize the 
> > palm Tungsten T over USB cradle. None happend, only short message about 
> > palm connected in log. Plug out the palm, but the visor module remained 
> > busy (count=1) and when i tried to rmmod uhci-hcd the rmmod stay in D 
> > state.
> 
> Try the patch below.  It should fix the problem for you.  If not, please
> let me know.
> 

This fixes the HotSync problem i reported on the Sony CLIE PEG-SJ22
thanks!
cliffw


> thanks,
> 
> greg k-h
> 
> 
> # USB: fix visor driver to work with Palm OS 4+ devices
> # For some reason, they do not like the reset_config calls anymore.
> 
> diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
> --- a/drivers/usb/serial/visor.c	Mon Oct 13 12:45:25 2003
> +++ b/drivers/usb/serial/visor.c	Mon Oct 13 12:45:25 2003
> @@ -778,9 +778,6 @@
>  			serial->dev->actconfig->desc.bConfigurationValue);
>  		return -ENODEV;
>  	}
> -	dbg("%s - reset config", __FUNCTION__);
> -	retval = usb_reset_configuration (serial->dev);
> -
>  
>  	if (id->driver_info) {
>  		startup = (void *)id->driver_info;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
