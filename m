Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVI0MWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVI0MWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVI0MWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:22:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:6112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932327AbVI0MWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:22:49 -0400
Date: Tue, 27 Sep 2005 05:22:18 -0700
From: Greg KH <greg@kroah.com>
To: vendor-sec@lst.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org
Subject: Re: [vendor-sec] Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050927122218.GA9971@kroah.com>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <20050927080413.GA13149@kroah.com> <20050927091337.GA9117@kroah.com> <20050927110319.GD1980@piware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927110319.GD1980@piware.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 01:03:19PM +0200, Martin Pitt wrote:
> Hi!
> 
> Greg KH [2005-09-27  2:13 -0700]:
> > On Tue, Sep 27, 2005 at 01:04:15AM -0700, Greg KH wrote:
> > > First off, thanks for providing a patch for this problem, it is real,
> > > and has been known for a while (thanks to your debugging :)
> > > 
> > > On Sun, Sep 25, 2005 at 05:13:30PM +0200, Harald Welte wrote:
> > > > 
> > > > I suggest this (or any other) fix to be applied to both 2.6.14 final and
> > > > the stable series.  I didn't yet investigate 2.4.x, but I think it is
> > > > likely to have the same problem.
> > > 
> > > I agree, but I think we need an EXPORT_SYMBOL_GPL() for your newly
> > > exported symbol, otherwise the kernel will not build if you have USB
> > > built as a module.
> > 
> > Hm, it's even messier.  With your patch, we get:
> > 	*** Warning: "__send_sig_info" [drivers/usb/core/usbcore.ko] undefined!
> > 	*** Warning: "__put_task_struct" [drivers/usb/core/usbcore.ko] undefined!
> > when the USB core is a module.
> > 
> > I can't pass judgement if we want to export both of these functions to
> > modules...  Anyone else know?
> 
> FWIW, our kernel maintainer just added
> 
> EXPORT_SYMBOL_GPL(__send_sig_info);
> 
> and it worked fine (we modularize as much as possible).

Yes, that would work, that's not an issue.  The issue is if this is the
best solution or not (generally exporting functions that start with "__"
is not a good idea...)

thanks,

greg k-h
