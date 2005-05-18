Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVERH1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVERH1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVERH1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:27:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:42675 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262079AbVERH0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:26:35 -0400
Date: Wed, 18 May 2005 00:32:30 -0700
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Kay Sievers <Kay.Sievers@vrfy.org>
Subject: Re: [PATCH] fix error handling in bus_add_device
Message-ID: <20050518073230.GA12155@kroah.com>
References: <428365EC.80906@suse.de> <20050518055602.GA11123@kroah.com> <428AEC89.5040301@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428AEC89.5040301@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 09:19:37AM +0200, Hannes Reinecke wrote:
> Greg KH wrote:
> > On Thu, May 12, 2005 at 04:19:24PM +0200, Hannes Reinecke wrote:
> >>Hi Greg,
> >>
> >>this patch fixes the error handling in bus_add_device() and
> >>device_attach(). Previously it was 'interesting'.
> >>And totally confusing to boot.
> > 
> > I agree, that's why it has been rewritten in the -mm tree :)
> > 
> > Anyway, your patch doesn't take into account that device_attach()'s
> > return value is tested in the bus_rescan_devices_helper(), so if you
> > change the return value, that also needs to be changed.
> > 
> > But even in the -mm tree, the bus_add_devices() function has not had the
> > error handling added to it that you provided, is there any devices that
> > you are seeing that need this?
> > 
> Not yet :-)
> 
> I'm just doing some cleanups here which me and Kay Sievers will be
> exploiting in the near future.
> My main point is:
> either we do an error check in bus_add_device and return a proper
> status, or we don't and fix bus_add_device to be of type 'void'.
> And as some functions called by bus_add_device may fail I thought it
> reasonable to evaluate the return status properly.
> Unless you tell me that bus_add_device is a fire-and-forget procedure
> and we don't care at all for any failures. But then we should at least
> set the type of bus_add_device() to 'void'.
> You're the maintainer, you have to decide :-).
> I don't care either way, I just want to have it consistent.
> 
> But you're correct about the bus_rescan_devices_helper. Fixed and new
> patch attached.

Ok, I agree that we should have error checks in there.  Now, could you
make your patch against the latest -mm tree instead due to all of the
changes involved in that area in my trees?  That way I can apply it :)

thanks,

greg k-h
