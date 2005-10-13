Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVJMJwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVJMJwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVJMJwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 05:52:24 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:48616 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750785AbVJMJwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 05:52:23 -0400
Subject: Re: [PATCH] [BLUETOOTH] kmalloc + memset -> kzalloc conversion
From: Marcel Holtmann <marcel@holtmann.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: dsaxena@plexity.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <434CFF51.1070709@grupopie.com>
References: <20051001065121.GC25424@plexity.net>
	 <20051011151805.0d32c840.akpm@osdl.org>
	 <1129071122.6487.6.camel@localhost.localdomain>
	 <20051011230440.GA26330@plexity.net>  <434CFF51.1070709@grupopie.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 11:52:57 +0200
Message-Id: <1129197177.6543.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

> >>>Confused.  This patch changes lots of block code, not bluetooth.
> >>
> >>I know. This is what I already mailed Deepak, but he never replied.
> > 
> > Sorry, got lost in the mailbox. I think I was not paying attention to
> > my tab completion and included the wrong patch. Proper patch follows.
> > 
> [...]
> > --- a/drivers/bluetooth/hci_usb.c
> > +++ b/drivers/bluetooth/hci_usb.c
> > @@ -134,10 +134,9 @@ static struct usb_device_id blacklist_id
> >  
> >  static struct _urb *_urb_alloc(int isoc, unsigned int __nocast gfp)
> >  {
> > -	struct _urb *_urb = kmalloc(sizeof(struct _urb) +
> > +	struct _urb *_urb = kzalloc(sizeof(struct _urb) +
> >  				sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
> >  	if (_urb) {
> > -		memset(_urb, 0, sizeof(*_urb));
> >  		usb_init_urb(&_urb->urb);
> >  	}
> >  	return _urb;
> 
> This one doesn't keep the exact same behavior as before, as it is 
> zeroing more memory than it did.
> 
> If this is not a performance critical path, then I guess it's ok (code 
> size reduction, and all).
> 
> I just wanted to call some attention on this so that someone more 
> knowledgeable than me in the bluetooth ways can make sure it's ok.

the current hci_usb URB shim layer is crap anyhow. We need to replace it
at some point with better code, but so far I haven't had the time to do
this properly.

Regards

Marcel


