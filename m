Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTD2WML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTD2WML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:12:11 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:37597 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261320AbTD2WMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:12:10 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Date: Wed, 30 Apr 2003 00:24:26 +0200
User-Agent: KMail/1.5
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304292334.19447.oliver@neukum.org> <20030429214004.GA8891@kroah.com>
In-Reply-To: <20030429214004.GA8891@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304300024.26133.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 29. April 2003 23:40 schrieb Greg KH:
> On Tue, Apr 29, 2003 at 11:34:19PM +0200, Oliver Neukum wrote:
> > > +int usb_init_urb(struct urb *urb)
> > > +{
> > > +	if (!urb)
> > > +		return -EINVAL;
> > > +	memset(urb, 0, sizeof(*urb));
> > > +	urb->count = (atomic_t)ATOMIC_INIT(1);
> > > +	spin_lock_init(&urb->lock);
> > > +
> > > +	return 0;
> > > +}
> >
> > Greg, please don't do it this way. Somebody will
> > try to free this urb. If the urb is part of a structure
> > this must not lead to a kfree. Please init it to some
> > insanely high dummy value in this case.
>
> We can't init it to a high value, if we want to use it ourself in
> usb_alloc_urb().

So don't or make that value a parameter. 

> And yes, I agree this is a very dangerous function to use on your own,
> I thought I conveyed that in the documentation for the function.

It's not any more dangerous than what worked quite well for 2.4.

> But if we don't have such a function, then people like Max will just
> roll their own, like he just did :)
>
> Might as well make it easy for him to shoot himself in the foot if he
> really wants to...

Sure, why not.

	Regards
		Oliver

