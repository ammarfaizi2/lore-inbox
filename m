Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVLOQvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVLOQvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLOQvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:51:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:31621 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750804AbVLOQvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:51:04 -0500
Date: Thu, 15 Dec 2005 08:44:44 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Message-ID: <20051215164444.GA14870@kroah.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com> <200512141102.53599.david-b@pacbell.net> <43A1118E.9040608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A1118E.9040608@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 09:47:42AM +0300, Vitaly Wool wrote:
> David Brownell wrote:
> 
> >No, "stupid drivers will suffer"; nothing new.  Just observe
> >how the ads7846 touchscreen driver does small async transfers.
> > 
> >
> One cannot allocate memory in interrupt context, so the way to go is 
> allocating it on stack, thus the buffer is not DMA-safe.
> Making it DMA-safe in thread that does the very message processing is a 
> good way of overcoming this.
> Using preallocated buffer is not a good way, since it may well be
> already used by another interrupt or not yet processed by the worker
> thread (or tasklet, or whatever).

Yes it is a good way.  That's the way USB currently works in the kernel,
and it works just fine.  It keeps the rules simple and everyone knows
what needs to be done.

thanks,

greg k-h
