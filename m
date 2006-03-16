Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWCPSU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWCPSU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCPSU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:20:28 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:32652
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932702AbWCPSU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:20:27 -0500
Date: Thu, 16 Mar 2006 10:20:18 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316182018.GA4301@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <4419A426.9080908@yandex.ru> <20060316175858.GA7124@kroah.com> <4419A9B8.8060102@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4419A9B8.8060102@yandex.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 09:08:56PM +0300, Artem B. Bityutskiy wrote:
> Greg KH wrote:
> >If you use decl_subsys(), you should be fine for this.  Use that instead
> >of trying to roll your own subsystem kobjects please.  That
> >infrastructure was written for a reason...
> Ok, I see, thanks. I just thought that this subsystem stuff will oblige 
> me to use the device/driver/bus model which does not suit me.

decl_subsys() is in the sysfs.h header file, not the device.h file.
Just stay away from anything in there if you hate the driver core so
much :)

> >Data (kobjects) have a different lifespan than code (modules).
> >Seperating them is a good idea, and if not, your reference counting
> >issues can be quite nasty.  See the recent EDAC fiasco for a good
> >example of how easy it is to mess things up in this manner.
> 
> My logic was that the lifetime of that kobject = lifetime of my module 
> because I cannot remove the module because every it's user increments 
> the module's refcount. So, if refcount of my module is zero then the 
> kobject's refcount is zero. Why this doesn't this work?

It "should" work in theory, but in real-life, the odds of getting all of
that lifetime logic correct...  :)

You can do it, but in general, it's easier to think about kobjects as
being dynamic devices, as that is what they are.  So making them dynamic
for real is a better thing to do to reinforce that principle.

Again, what are you doing that you can't use the driver core for?

thanks,

greg k-h
