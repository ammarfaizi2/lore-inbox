Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbTEGF2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTEGF2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:28:53 -0400
Received: from granite.he.net ([216.218.226.66]:38160 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262869AbTEGF2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:28:51 -0400
Date: Tue, 6 May 2003 22:40:59 -0700
From: Greg KH <greg@kroah.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Max Krasnyansky'" <maxk@qualcomm.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI U SB.
Message-ID: <20030507054059.GA6138@kroah.com>
References: <A46BBDB345A7D5118EC90002A5072C780C8FDF50@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C8FDF50@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 10:06:22PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> 
> > From: Greg KH [mailto:greg@kroah.com]
> >
> > +int usb_init_urb(struct urb *urb)
> > +{
> > +	if (!urb)
> > +		return -EINVAL;
> > ...
> > ...
> > ...
> > @@ -38,13 +61,14 @@
> >  		mem_flags);
> >  	if (!urb) {
> >  		err("alloc_urb: kmalloc failed");
> > -		return NULL;
> > +		goto exit;
> > +	}
> > +	if (usb_init_urb(urb)) {
> > +		kfree(urb);
> > +		urb = NULL;
> >  	}
> 
> If usb_init_urb() is already testing for !urb, why
> test it again? No doubt the compiler will probably
> catch it if inlining ... but I think the best is
> for usb_init_urb() to assume that urb is not NULL.
> Let the caller make that sure.

Because people other than usb_alloc_urb() can call usb_init_urb().
Yeah, I can remove the check, then any invalid caller will oops on the
first line of usb_init_urb().  I don't mind, was just trying to program
a bit more defensibly.  You know, make it a "hardened driver"  :)

thanks,

greg k-h
