Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWFHXov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWFHXov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 19:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWFHXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 19:44:50 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:6332 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964868AbWFHXou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 19:44:50 -0400
From: David Brownell <david-b@pacbell.net>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
Date: Thu, 8 Jun 2006 16:44:45 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>,
       Russell King <rmk+lkml@arm.linux.org.uk>, lenz@cs.wisc.edu,
       David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <447EB0DC.4040203@cogweb.net> <200606081440.43840.david-b@pacbell.net> <1149803365.11412.28.camel@localhost.localdomain>
In-Reply-To: <1149803365.11412.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081644.47288.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 2:49 pm, Richard Purdie wrote:
> 
> > > The easiest solution might be to move the ohci device registration into
> > > pxa_set_ohci_info (in pxa27x.c). I gave in and appended a patch (compile
> > > tested only so far).
> > 
> > Looked OK to me.
> > 
> > That's the kind of approach now used with OMAP and AT91, and which IMO
> > would be appropriate to use for most platform devices ... that is, don't
> > register devices that the board doesn't have.  One additional nuance:  if
> > the kernel doesn't have that driver configured, that's another reason not
> > to bother registering its device.
> 
> This is where you start to add ugly ifdefs and generally start making
> the code look horrible. The device model separated the drivers and the
> devices to deal with this issue as I see it. 

Enumeration is a separate issue.  You wouldn't argue that every potential
PCI or USB device must get registered, right?  Only the ones that are
actually _present_ get registered.

But here you argue that platform bus should not work that same way ... it
should register devices that can't be present.  If nothing else, that's
an inconsistent aproach.

Plus, consider the common situation that a given pin could potentially
be used with several different devices.  On a given board, only one of
those devices will be wired up.  It's counterproductive to register any
of the others ... error prone, waste-of-kernel-address-space, etc.


> Generally I'd say its 
> cleaner just to let the device register, then if a module comes along at
> some later point, the device is there for it.

Whether the device is there or not is a hardware issue.  Board schematics
will show which devices are relevant ... registering any others is just
wastage.  "Clean" is somewhat in the eye of the beholder; in mine, wasting
system resources is not clean.

- Dave

