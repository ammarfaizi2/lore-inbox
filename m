Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVFBQMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVFBQMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFBQMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:12:12 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:28527 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261177AbVFBQLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:11:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OVniOHXJ/OX7LR9HZUaAVgyA8JWqFojsiZvNLFmp98R/48+WeNdzKdYrwxZLStM5d2rOEoC9qXS5v9eaTOt6c/BZPvf/4hEMWLSXfflAa4RJU4Hc6q2pHPIoaEw/u33084m7a3QBwsf+5HdU4C5gzZ4lWmGTY73OAtl2Hqy0168=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kiril Jovchev <jovchev@gmail.com>
Subject: Re: [PATCH] Creative WebCam mini driver
Date: Thu, 2 Jun 2005 20:16:02 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <416f085805060208352de7e44e@mail.gmail.com>
In-Reply-To: <416f085805060208352de7e44e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506022016.03112.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 June 2005 19:35, Kiril Jovchev wrote:

> So now I'm sending the patch again for 2.6.11.11 kernel what is latest stable.

You're lucky it applies cleanly against 2.6.12-rc5-whatever. ;-)

There is no need to split the patch into two ones. Next time CC
linux-usb-devel@lists.sourceforge.net. Add "-p" to your diff switches.

> --- linux-2.6.11.11/drivers/usb/media/stv680.c
> +++ linux/drivers/usb/media/stv680.c

> + * Creative WebCam Go Mini Driver, modified by Kiril Jovchev 

Trailing whitespace.

> + *
> + * ver 0.26 Sep, 2004 (kjv) 
> + * 			   Added support for Creative WebCam Go mini. 
> + * 			   Camera is based on same chip. 
> + * 

Trailing whitespace.

> @@ -1375,9 +1383,14 @@
>  	    (le16_to_cpu(dev->descriptor.idProduct) == USB_PENCAM_PRODUCT_ID)) {
>  		camera_name = "STV0680";
>  		PDEBUG (0, "STV(i): STV0680 camera found.");
> -	} else {
> -		PDEBUG (0, "STV(e): Vendor/Product ID do not match STV0680 values.");
> -		PDEBUG (0, "STV(e): Check that the STV0680 camera is connected to the computer.");
> +	} else if ((le16_to_cpu(dev->descriptor.idVendor) == USB_CREATIVEGOMINI_VENDOR_ID) &&
> +            (le16_to_cpu(dev->descriptor.idProduct) == USB_CREATIVEGOMINI_PRODUCT_ID)) {

VENDOR_ID and PRODUCT_ID are constants. You can do

	if ((dev->descriptor.idVendor == cpu_to_le16(VENDOR_ID)) &&
	    (dev->descriptor.idProduct == cpu_to_le16(PRODUCT_ID))) {

> +                camera_name = "Creative WebCam Go Mini";
> +                PDEBUG (0, "STV(i): Creative WebCam Go Mini found.");
> +	} 
> +	else {

"} else {", please.

> +		PDEBUG (0, "STV(e): Vendor/Product ID do not match STV0680 or Creative WebCam Go Mini values.");
> +		PDEBUG (0, "STV(e): Check that the STV0680 or Creative WebCam Go Mini camera is connected to the computer.");

> --- linux-2.6.11.11/drivers/usb/media/stv680.h
> +++ linux/drivers/usb/media/stv680.h

> +#define USB_CREATIVEGOMINI_VENDOR_ID 0x041e 

Trailing whitespace.

>  static struct usb_device_id device_table[] = {
>  	{USB_DEVICE (USB_PENCAM_VENDOR_ID, USB_PENCAM_PRODUCT_ID)},
> +	{USB_DEVICE (USB_CREATIVEGOMINI_VENDOR_ID, USB_CREATIVEGOMINI_PRODUCT_ID)},
>  	{}
> +	

Why add this line?

>  };
