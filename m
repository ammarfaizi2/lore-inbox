Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUEXULR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUEXULR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUEXULR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:11:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:12754 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264551AbUEXULG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:11:06 -0400
Date: Mon, 24 May 2004 13:08:05 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040524200805.GD4558@kroah.com>
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B22EED.4080808@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 01:20:45PM -0400, nardelli wrote:
> Greg KH wrote:
> >On Fri, May 21, 2004 at 06:04:46PM -0400, nardelli wrote:
> >
> >>Maybe I spoke too soon here.  We have 1 bulk in, 2 bulk out, and 1 
> >>interrupt
> >>in endpoint, which by the logic in usb-serial, translates to 2 ports.  
> >>Only
> >>one of those ports can have a read_urb associated with it, unless we want 
> >>to
> >>do some really fancy juggling.  This means that we're going to have a port
> >>that does not have a valid read_urb associated with it, even after open().
> >
> >
> >But the call to open() fails, which prevents any of the other tty calls
> >from happening on that port.  That's why we don't need to make that
> >check anywhere else.
> >
> >
> 
> The call to open() does not fail

Today, that call does fail:

        if (!port->read_urb) {
                /* this is needed for some brain dead Sony devices */
                dev_err(&port->dev, "Device lied about number of ports, please use a lower one.\n");
                return -ENODEV;
        }

Let's not change that logic please.


> - with only a write_urb associated with it,
> it's not a very interesting port, but data can be written to it, at least in
> small quantities (see below).

But why?  Do you know some kind of protocol that this endpoint can
accept that is valid for the device?  If not, let's not mess with it.

thanks,

greg k-h
