Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWFHVuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWFHVuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWFHVuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:50:23 -0400
Received: from tim.rpsys.net ([194.106.48.114]:63645 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964987AbWFHVuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:50:22 -0400
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
From: Richard Purdie <rpurdie@rpsys.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>,
       Russell King <rmk+lkml@arm.linux.org.uk>, lenz@cs.wisc.edu,
       David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200606081440.43840.david-b@pacbell.net>
References: <447EB0DC.4040203@cogweb.net>
	 <200606081338.07489.david-b@pacbell.net>
	 <1149801774.11412.22.camel@localhost.localdomain>
	 <200606081440.43840.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 22:49:24 +0100
Message-Id: <1149803365.11412.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 14:40 -0700, David Brownell wrote:
> Right.  OHCI was just an example though ... there are lots of other
> platform drivers for PXA.  I'm not sure they all check for platform_data
> before succeeding in their probe() methods.

The implementations in mainline generally use all the bits or they'd
have been fixed by now so its not really a problem. I'm sure Russell
would take patches :)

> > The easiest solution might be to move the ohci device registration into
> > pxa_set_ohci_info (in pxa27x.c). I gave in and appended a patch (compile
> > tested only so far).
> 
> Looked OK to me.
> 
> That's the kind of approach now used with OMAP and AT91, and which IMO
> would be appropriate to use for most platform devices ... that is, don't
> register devices that the board doesn't have.  One additional nuance:  if
> the kernel doesn't have that driver configured, that's another reason not
> to bother registering its device.

This is where you start to add ugly ifdefs and generally start making
the code look horrible. The device model separated the drivers and the
devices to deal with this issue as I see it. Generally I'd say its
cleaner just to let the device register, then if a module comes along at
some later point, the device is there for it.

Cheers,

Richard

