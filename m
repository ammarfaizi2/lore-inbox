Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbTD2V0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbTD2V0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:26:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30653 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261854AbTD2V0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:26:06 -0400
Date: Tue, 29 Apr 2003 14:40:04 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030429214004.GA8891@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <20030429211550.GA8669@kroah.com> <200304292334.19447.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304292334.19447.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 11:34:19PM +0200, Oliver Neukum wrote:
> 
> > +int usb_init_urb(struct urb *urb)
> > +{
> > +	if (!urb)
> > +		return -EINVAL;
> > +	memset(urb, 0, sizeof(*urb));
> > +	urb->count = (atomic_t)ATOMIC_INIT(1);
> > +	spin_lock_init(&urb->lock);
> > +
> > +	return 0;
> > +}
> 
> Greg, please don't do it this way. Somebody will
> try to free this urb. If the urb is part of a structure
> this must not lead to a kfree. Please init it to some
> insanely high dummy value in this case.

We can't init it to a high value, if we want to use it ourself in
usb_alloc_urb().

And yes, I agree this is a very dangerous function to use on your own,
I thought I conveyed that in the documentation for the function.

But if we don't have such a function, then people like Max will just
roll their own, like he just did :)

Might as well make it easy for him to shoot himself in the foot if he
really wants to...

thanks,

greg k-h
