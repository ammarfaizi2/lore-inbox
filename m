Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUALPxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUALPxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:53:16 -0500
Received: from ida.rowland.org ([192.131.102.52]:19460 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265607AbUALPxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:53:04 -0500
Date: Mon, 12 Jan 2004 10:53:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
In-Reply-To: <200401120029.26971.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0401121024161.1327-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Oliver Neukum wrote:

> diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
> --- a/drivers/usb/usb.c	Mon Jan 12 00:27:37 2004
> +++ b/drivers/usb/usb.c	Mon Jan 12 00:27:37 2004
> @@ -1198,7 +1198,7 @@
>  int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request, __u8 requesttype,
>  			 __u16 value, __u16 index, void *data, __u16 size, int timeout)
>  {
> -	struct usb_ctrlrequest *dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL);
> +	struct usb_ctrlrequest *dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_NOIO);
>  	int ret;
>  	
>  	if (!dr)
> @@ -1958,7 +1958,7 @@
>  	if (result < 0)
>  		return result;
>  
> -	buffer = kmalloc(sizeof(status), GFP_KERNEL);
> +	buffer = kmalloc(sizeof(status), GFP_NOIO);
>  	if (!buffer) {
>  		err("unable to allocate memory for configuration descriptors");
>  		return -ENOMEM;

Note that these changes have essentially already been incorporated into 
2.6, so only 2.4 needs updating.

Alan Stern


