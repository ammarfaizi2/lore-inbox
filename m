Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFCGyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFCGyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 02:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFCGyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 02:54:39 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:4557 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261154AbVFCGye convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 02:54:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nu3TYh6UqIeW2A5EX007l7OTKAYCFPgi5vglSuE/rkBDUDy/HRdsJlS4rbUxLKqpYQE0q88MHorHer/wj9RDlid91ucg14dLayxoMrzggi+up+8lIQnukBe5XMTKrRbjvvN9+vte3nbJNPKx3/32yuvlF3cBkUYOA1JxfMvIaeM=
Message-ID: <416f0858050602235455c6656@mail.gmail.com>
Date: Fri, 3 Jun 2005 09:54:33 +0300
From: Kiril Jovchev <jovchev@gmail.com>
Reply-To: Kiril Jovchev <jovchev@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Creative WebCam mini driver
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200506022016.03112.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <416f085805060208352de7e44e@mail.gmail.com>
	 <200506022016.03112.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments Alexey. 

The whitespaces came from the diff. I the only switch what I have used it -u.

About the VENDOR_ID and PRODUCT_ID, I have looked at the code of
stv680.c that was in 2.6.11.11 and there the variables were casted.
> @@ -1375,9 +1383,14 @@
>           (le16_to_cpu(dev->descriptor.idProduct) == USB_PENCAM_PRODUCT_ID)) {
Probably this code needs to be fixed as well.

And about the extra lines and bad formating of else clause I'll do
better next time.

Do I need to submit fixed patch or you have applied this one?

//Cyrilo

On 6/2/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Thursday 02 June 2005 19:35, Kiril Jovchev wrote:
> 
> > So now I'm sending the patch again for 2.6.11.11 kernel what is latest stable.
> 
> You're lucky it applies cleanly against 2.6.12-rc5-whatever. ;-)
> 
> There is no need to split the patch into two ones. Next time CC
> linux-usb-devel@lists.sourceforge.net. Add "-p" to your diff switches.
> 
> > --- linux-2.6.11.11/drivers/usb/media/stv680.c
> > +++ linux/drivers/usb/media/stv680.c
> 
> > + * Creative WebCam Go Mini Driver, modified by Kiril Jovchev
> 
> Trailing whitespace.
> 
> > + *
> > + * ver 0.26 Sep, 2004 (kjv)
> > + *                      Added support for Creative WebCam Go mini.
> > + *                      Camera is based on same chip.
> > + *
> 
> Trailing whitespace.
> 
> > @@ -1375,9 +1383,14 @@
> >           (le16_to_cpu(dev->descriptor.idProduct) == USB_PENCAM_PRODUCT_ID)) {
> >               camera_name = "STV0680";
> >               PDEBUG (0, "STV(i): STV0680 camera found.");
> > -     } else {
> > -             PDEBUG (0, "STV(e): Vendor/Product ID do not match STV0680 values.");
> > -             PDEBUG (0, "STV(e): Check that the STV0680 camera is connected to the computer.");
> > +     } else if ((le16_to_cpu(dev->descriptor.idVendor) == USB_CREATIVEGOMINI_VENDOR_ID) &&
> > +            (le16_to_cpu(dev->descriptor.idProduct) == USB_CREATIVEGOMINI_PRODUCT_ID)) {
> 
> VENDOR_ID and PRODUCT_ID are constants. You can do
> 
>         if ((dev->descriptor.idVendor == cpu_to_le16(VENDOR_ID)) &&
>             (dev->descriptor.idProduct == cpu_to_le16(PRODUCT_ID))) {
> 
> > +                camera_name = "Creative WebCam Go Mini";
> > +                PDEBUG (0, "STV(i): Creative WebCam Go Mini found.");
> > +     }
> > +     else {
> 
> "} else {", please.
> 
> > +             PDEBUG (0, "STV(e): Vendor/Product ID do not match STV0680 or Creative WebCam Go Mini values.");
> > +             PDEBUG (0, "STV(e): Check that the STV0680 or Creative WebCam Go Mini camera is connected to the computer.");
> 
> > --- linux-2.6.11.11/drivers/usb/media/stv680.h
> > +++ linux/drivers/usb/media/stv680.h
> 
> > +#define USB_CREATIVEGOMINI_VENDOR_ID 0x041e
> 
> Trailing whitespace.
> 
> >  static struct usb_device_id device_table[] = {
> >       {USB_DEVICE (USB_PENCAM_VENDOR_ID, USB_PENCAM_PRODUCT_ID)},
> > +     {USB_DEVICE (USB_CREATIVEGOMINI_VENDOR_ID, USB_CREATIVEGOMINI_PRODUCT_ID)},
> >       {}
> > +
> 
> Why add this line?
> 
> >  };
>
