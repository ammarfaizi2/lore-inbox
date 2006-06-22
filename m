Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbWFVXve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWFVXve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWFVXve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:51:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56036 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932731AbWFVXvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:51:33 -0400
Date: Thu, 22 Jun 2006 16:51:12 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Message-ID: <20060622235112.GA30484@kroah.com>
References: <20060622202952.GA14135@kroah.com> <200606221624.03182.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606221624.03182.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 04:24:02PM -0700, David Brownell wrote:
> On Thursday 22 June 2006 1:29 pm, Greg KH wrote:
> > 
> > David, we really should not be caring about what the children of a USB
> > device is doing here, as who knows what type of "device" might hang off
> > of a struct usb_device. 
> 
> Should be _only_ interfaces; everything else descends from an interface.

Not anymore, and who knows what might hang off a USB device in the
future.  We can't necessarily control our children like this, as some
other subsystem might want to use a usb_device as a parent, and there's
nothing wrong with that.

> There was previously an invariant that the interfaces were marked
> as quiescent unless the interface (a) had a driver, and (b) that
> driver was not suspended.  Evidently that has been lost.  This patch
> may be insufficient; ISTR other places relying on that invariant.
> 
> And yes, we _should_ care about whether or not any interface is
> still active, until the pm core code starts to pay attention to
> the driver model tree at all times ... even outside of system-wide
> suspend transitions.  Today, the pm core code doesn't even use
> that tree directly, and all runtime state changes (like selective
> suspend with USB) completely bypass that pm tree.

Hm, ok, yes, we should care about interfaces, but we need some way to
only walk them, not anything else that might be attached to us...

thanks,

greg k-h
