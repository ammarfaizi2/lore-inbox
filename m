Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbWFVV1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWFVV1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWFVV1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:27:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:43126 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932645AbWFVV1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:27:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=BoYldoS0kmmt3q+iRMvb9PfrMdm7vj31ezYxEzgeThI6t3pAAyoHmA+WbjSs/cOB72DN2js40Z1aUTFxSZn/BJ9zDZLZnYJC6LXnTvep/XJw3cs4n96r/oJQAtH/uGRpTTXculzO/L87/Uns3iRI5+SmhsV/HiTZe3cx8qW50HU=
Message-ID: <449B0B19.9000901@gmail.com>
Date: Thu, 22 Jun 2006 23:26:26 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
References: <20060622202952.GA14135@kroah.com>
In-Reply-To: <20060622202952.GA14135@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH napsal(a):
> Mattai and Jiri, can you try the patch below to see if it fixes the USB
> suspend problem you are seeing with 2.6.17-mm1?
> 
> David, we really should not be caring about what the children of a USB
> device is doing here, as who knows what type of "device" might hang off
> of a struct usb_device.  This patch is just a band-aid around this area,
> until Alan's patches fix up everything "properly" :)
> 
> thanks,
> 
> greg k-h
> 
> -----------------------------
> Subject: USB: get USB suspend to work again
> 
> Yeah, it's a hack, but it is only temporary until Alan's patches
> reworking this area make it in.  We really should not care what devices
> below us are doing, especially when we do not really know what type of
> devices they are.  This patch relies on the fact that the endpoint
> devices do not have a driver assigned to us.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/usb/core/usb.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- gregkh-2.6.orig/drivers/usb/core/usb.c
> +++ gregkh-2.6/drivers/usb/core/usb.c
> @@ -991,6 +991,8 @@ void usb_buffer_unmap_sg (struct usb_dev
>  
>  static int verify_suspended(struct device *dev, void *unused)
>  {
> +	if (dev->driver == NULL)
> +		return 0;
>  	return (dev->power.power_state.event == PM_EVENT_ON) ? -EBUSY : 0;
>  }
>  

Yeah, it works just fine.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

