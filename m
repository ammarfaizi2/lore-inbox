Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVATTsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVATTsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVATTsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:48:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261777AbVATTsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:48:04 -0500
Date: Thu, 20 Jan 2005 11:35:45 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: usbmon, usb core, ARM
Message-ID: <20050120113545.58ce18a3@localhost.localdomain>
In-Reply-To: <200501190908.35210.david-b@pacbell.net>
References: <20050118212033.26e1b6f0@localhost.localdomain>
	<200501182214.25273.david-b@pacbell.net>
	<20050119074208.3bfa6458@localhost.localdomain>
	<200501190908.35210.david-b@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005 09:08:34 -0800, David Brownell <david-b@pacbell.net> wrote:

> On Wednesday 19 January 2005 7:42 am, Pete Zaitcev wrote:
> > 		Relying on pipe makes
> > tests dependant on URB only. No references to bus or HCD, therefore no
> > extra refcounts or worries about oopses. Also, HC drivers zero out the
> > urb->dev in giveback sequence which is a royal pain when trying to identify
> > a root hub.
> 
> That was a 2.4-ism, it should now be gone.  So an inlined function to
> test whether urb->dev is the root hub should suffice; I know there's
> code that does that already.

I do not like to refer to a dev because I do not quite understand where
the necessary usb_dev_get/_put are now. But if you guarantee that the
urb->dev is refcounted properly while urb is processed by usb_hcd_giveback_urb,
I do not mind an extra indirection.

What would be the right test in usb_hcd_giveback_urb, then?
It looks to me that you want me to use this:

urb_is_for_root_hub(urb) {
     return urb->dev == urb->dev->bus->hcpriv->self.root_hub;
}

This is just ... ewwwww. Can we use pipe for now or do you have
a better idea?

-- Pete
