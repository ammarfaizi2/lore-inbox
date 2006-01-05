Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWAESHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWAESHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAESHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:07:48 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:62349 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932133AbWAESHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:07:47 -0500
Date: Thu, 5 Jan 2006 10:08:15 -0800
From: Greg KH <gregkh@suse.de>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [DRIVER CORE] platform_get_irq*(): return   NO_IRQ on error
Message-ID: <20060105180815.GB13317@suse.de>
References: <43BD534E.8050701@arcom.com> <20060105173717.GA11279@suse.de> <43BD5F5E.1070108@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BD5F5E.1070108@arcom.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 06:03:10PM +0000, David Vrabel wrote:
> Greg KH wrote:
> > On Thu, Jan 05, 2006 at 05:11:42PM +0000, David Vrabel wrote:
> > 
> >>platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
> >>platforms, return NO_IRQ (-1) instead.
> >>
> >>Signed-off-by: David Vrabel <dvrabel@arcom.com>
> >>
> >>--- linux-2.6-working.orig/drivers/base/platform.c	2006-01-05 16:49:23.000000000 +0000
> >>+++ linux-2.6-working/drivers/base/platform.c	2006-01-05 17:10:18.000000000 +0000
> >>@@ -59,7 +59,7 @@
> >> {
> >> 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> >> 
> >>-	return r ? r->start : 0;
> >>+	return r ? r->start : NO_IRQ;
> > 
> > 
> > No, I think the whole NO_IRQ stuff has been given up on, see the lkml
> > archives for details.
> 
> Now that you mention it I remember that thread[1].
> 
> How about returning -ENXIO (or similar) then?

That would be fine as long as you fix up all callers to not pass that
value to request_irq() :)

thanks,

greg k-h
