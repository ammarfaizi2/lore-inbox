Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSJYRNd>; Fri, 25 Oct 2002 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbSJYRNc>; Fri, 25 Oct 2002 13:13:32 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11780 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261495AbSJYRNc>;
	Fri, 25 Oct 2002 13:13:32 -0400
Date: Fri, 25 Oct 2002 10:17:58 -0700
From: Greg KH <greg@kroah.com>
To: Josh Myer <jbm@joshisanerd.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] KB Gear JamStudio USB Tablet
Message-ID: <20021025171758.GB29874@kroah.com>
References: <Pine.LNX.4.44.0210250200290.25878-200000@blessed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210250200290.25878-200000@blessed>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 02:04:25AM -0500, Josh Myer wrote:
> +static void kbtab_irq(struct urb *urb)
> +{
> +
> +  struct kbtab *tab = urb->context;
> +  unsigned char *data = tab->data;
> +  struct input_dev *dev = &tab->dev;
> +
> +  if(urb->status)
> +    return;

Please use tabs instead of spaces.  Documentation/CodingStyle has these
rules if you haven't read it yet.

> +  FILL_INT_URB(&kbtab->irq, dev, usb_rcvintpipe(dev, endpoint->bEndpointAddress),
> +	       kbtab->data, 8, kbtab_irq, kbtab, endpoint->bInterval);

Please use usb_fill_int_urb() for all new code, and don't use the
"old-style" macros.

> +static struct usb_driver kbtab_driver = {
> +	name:		"kbtab",
> +	probe:		kbtab_probe,
> +	disconnect:	kbtab_disconnect,
> +	id_table:	kbtab_ids,
> +};

C99 style initializers are a good idea:

> +static struct usb_driver kbtab_driver = {
> +	.name =		"kbtab",
> +	.probe =	kbtab_probe,
> +	.disconnect =	kbtab_disconnect,
> +	.id_table =	kbtab_ids,
> +};

Other than those minor things, looks good.

thanks,

greg k-h
