Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUE1RaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUE1RaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUE1RaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:30:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:6317 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263745AbUE1RaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:30:16 -0400
Date: Fri, 28 May 2004 10:29:12 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Todd Poynor <tpoynor@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Device runtime suspend/resume fixes try #2
Message-ID: <20040528172911.GA8576@kroah.com>
References: <20040526182955.GA7176@slurryseal.ddns.mvista.com> <Pine.LNX.4.50.0405281017290.4036-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0405281017290.4036-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 10:18:49AM -0700, Patrick Mochel wrote:
> 
> > --- linux-2.6.6-orig/drivers/base/power/runtime.c	2004-05-10 11:22:58.000000000 -0700
> > +++ linux-2.6.6-pm/drivers/base/power/runtime.c	2004-05-26 10:37:05.193449240 -0700
> > @@ -14,7 +14,10 @@
> >  {
> >  	if (!dev->power.power_state)
> >  		return;
> > -	resume_device(dev);
> > +	if (! resume_device(dev))
> > +		dev->power.power_state = 0;
> > +
> > +	return;
> 
> You don't need to explicitly return from a void function. :)

Oops, missed that.  I've fixed it up in my trees now.

thanks,

greg k-h
