Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTLAHQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTLAHQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:16:58 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:1286 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263463AbTLAHQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:16:57 -0500
Date: Mon, 1 Dec 2003 18:16:44 +1100
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB] Fix connect/disconnect race
Message-ID: <20031201071644.GA15389@gondor.apana.org.au>
References: <mailman.1070178780.32610.linux-kernel2news@redhat.com> <200312010203.hB123YQr002367@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312010203.hB123YQr002367@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 09:03:34PM -0500, Pete Zaitcev wrote:
> > This patch was integrated by you in 2.4 six months ago.  Unfortunately
> > it never got into 2.5.  Without it you can end up with crashes such
> > as http://bugs.debian.org/218670
> 
> > --- kernel-source-2.5/drivers/usb/core/hub.c	28 Sep 2003 04:44:16 -0000	1.1.1.15
> > +++ kernel-source-2.5/drivers/usb/core/hub.c	30 Nov 2003 07:44:40 -0000
> >  			break;
> >  		}
> >  
> > -		hub->children[port] = dev;
> >  		dev->state = USB_STATE_POWERED;
> >[...]
> >  		/* Run it through the hoops (find a driver, etc) */
> > -		if (!usb_new_device(dev, &hub->dev))
> > +		if (!usb_new_device(dev, &hub->dev)) {
> > +			hub->children[port] = dev;
> >  			goto done;
> > +		}
> 
> I'm surprised you need it. The updated usbfs is supposed
> to be immune. This is probably the reason it wasn't ported.

Well the race occurs between usb_disconnect() initiated by rmmod
uhci-hcd and this function.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
