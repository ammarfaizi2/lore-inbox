Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTICT50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbTICTze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:55:34 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:449 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264410AbTICTzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:55:11 -0400
Date: Wed, 3 Sep 2003 21:54:10 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Justin Cormack <justin@street-vision.com>
Cc: torvalds@osdl.org, Kernel mailing list <linux-kernel@vger.kernel.org>,
       Rob Radez <rob@osinvestor.com>
Subject: Re: [PATCH] 2.6.0-test4 - Watchdog patches
Message-ID: <20030903215410.F8811@infomag.infomag.iguana.be>
References: <20030831225236.A6938@infomag.infomag.iguana.be> <1062364509.30543.155.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1062364509.30543.155.camel@lotte.street-vision.com>; from justin@street-vision.com on Sun, Aug 31, 2003 at 10:15:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

> There is *no point* making these module parameters. There is no other
> watchdog that works in exactly the same way but using different io
> ports. If there was this still wouldnt be the sensible way to do it. 

Since I copied this part of Rob's watchdog-patch, I'll let Rob answer this one.

> > +	if (timeout < 1 || timeout > 63) {
> > +		timeout = WD_TIMO;
> > +		printk (KERN_INFO PFX "timeout value must be 1<=x<=255, using %d\n",
> > +			timeout);
> 
> where did that 63 come from? should be 255.

Thanks, I'll fix this (And I'll take out the module_param's for wdt_start and wdt_stop 
also).

> Also, generally, please cc authors when you send patches. And making the comments the
> same in the watchdog drivers is a complete  waste of time. If you want to reduce
> the amount of duplicated code in the drivers you could make a watchdog_ops interface
> for almost all of them.

Sorry Justin, I normally cc the authors, but this time I indeed overlooked it. Sorry 
for that. Concerning the duplicated code: this is done intentionally; Rob and myself
won't to get the watchdog-drivers all at the same level so that we can then remove the
duplicate code and have some generic watchdog code that can be used (I allready have 
code for it, but I'm redoing the temperature stuff). After that we plan to foresee sysfs
interfacing for the drivers (can be done easily if you use the generic watchdog code).
the generic code indeed uses a watchdog_ops like interface. Hope this clarifies things 
a bit more. (So I try to do everything via a "phased" approach rather then go directly 
for the generic watchdog model code).

Greetings,
Wim.

