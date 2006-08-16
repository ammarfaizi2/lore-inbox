Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWHPUvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWHPUvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWHPUvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:51:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:36554 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932215AbWHPUvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:51:45 -0400
From: Oliver Bock <o.bock@fh-wolfenbuettel.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: drivers/usb/misc/cypress_cy7c63.c: NULL dereference
Date: Wed, 16 Aug 2006 22:51:43 +0200
User-Agent: KMail/1.9.3
Cc: Adrian Bunk <bunk@stusta.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20060815000442.GB3543@stusta.de> <20060815005749.GA24238@suse.de>
In-Reply-To: <20060815005749.GA24238@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608162251.43269.o.bock@fh-wolfenbuettel.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dd33dd6c1d5f49fc970db4042b12446b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks guys!
Sorry for that blunder...

Oliver

On Tuesday 15 August 2006 02:57, Greg KH wrote:
> On Tue, Aug 15, 2006 at 02:04:42AM +0200, Adrian Bunk wrote:
> > The Coverity Checker spotted the following obvious NULL dereference:
> >
> > <--  snip  -->
> >
> > ...
> > static int cypress_probe(struct usb_interface *interface,
> >                          const struct usb_device_id *id)
> > {
> > ...
> >         if (dev == NULL) {
> >                 dev_err(&dev->udev->dev, "Out of memory!\n");
> >                 goto error;
> >         }
> > ...
> > }
> > ...
> >
> > <--  snip  -->
>
> Thanks for letting me know, the patch below should fix this.
>
> greg k-h
>
> ------------
>
> From: Greg Kroah-Hartman <gregkh@suse.de>
> Subject: USB: fix bug in cypress_cy7c63.c driver
>
> This was pointed out by Adrian Bunk <bunk@stusta.de>, as found by the
> Coverity Checker.
>
>
> Cc: Adrian Bunk <bunk@stusta.de>
> Cc: Oliver Bock <o.bock@fh-wolfenbuettel.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> ---
>  drivers/usb/misc/cypress_cy7c63.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- gregkh-2.6.orig/drivers/usb/misc/cypress_cy7c63.c
> +++ gregkh-2.6/drivers/usb/misc/cypress_cy7c63.c
> @@ -208,7 +208,7 @@ static int cypress_probe(struct usb_inte
>  	/* allocate memory for our device state and initialize it */
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (dev == NULL) {
> -		dev_err(&dev->udev->dev, "Out of memory!\n");
> +		dev_err(&interface->dev, "Out of memory!\n");
>  		goto error;
>  	}
