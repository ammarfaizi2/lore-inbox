Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTILQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbTILQ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:27:37 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:29250 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261761AbTILQ1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:27:36 -0400
Date: Fri, 12 Sep 2003 09:27:13 -0700
To: Anthony Dominic Truong <anthony.truong@mascorp.com>
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       willy@debian.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912162713.GA4852@sgi.com>
Mail-Followup-To: Anthony Dominic Truong <anthony.truong@mascorp.com>,
	linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
	willy@debian.org
References: <20030911192550.7dfaf08c.ak@suse.de> <1063308053.4430.37.camel@huykhoi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063308053.4430.37.camel@huykhoi>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 09:10:25AM -0700, Anthony Dominic Truong wrote:
> Andi Kleen wrote:
> > #ifdef CONFIG_MMIO
> >         writel(... )
> >         readl(...)
> > #else
> >         outl( ... ) 
> >         inl ( ...) 
> > #endif
> > 
> > to 
> >         if (dev->mmio) { 
> >                 writel(); 
> >                 real();
> >         } else { 
> >                 outl();
> >                 inl();
> >         } 
> > 
> > and you will have a hard time to benchmark the difference on any non
> > ancient system
> > in actual driver operation.
> > 
> > -Andi
> > 
> Hello,
> Wouldn't it be better if we set the IN and OUT function pointers to the
> right functions during driver init. based on the setting of dev->mmio.
> And throughout the driver, we just call the IN and OUT functions by
> their pointers.  Then we don't have to do if (dev->mmio) every time.
> It's similar to the concept of virtual member function in C++.

I'd rather not see any more pointer dereferences or even branches than
absolutely necessary.  Right now, readX/writeX and inX/outX are usually
inlines, and outX and writeX can be very fast.  So I'd prefer either a
global CONFIG_MMIO option or consistent driver specific options that
explain what the difference between MMIO and port I/O actually is.

Jesse
