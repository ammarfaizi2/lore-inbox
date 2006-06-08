Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWFHVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWFHVkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWFHVkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:40:47 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:2172 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965027AbWFHVkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:40:46 -0400
From: David Brownell <david-b@pacbell.net>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
Date: Thu, 8 Jun 2006 14:40:42 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>,
       Russell King <rmk+lkml@arm.linux.org.uk>, lenz@cs.wisc.edu,
       David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <447EB0DC.4040203@cogweb.net> <200606081338.07489.david-b@pacbell.net> <1149801774.11412.22.camel@localhost.localdomain>
In-Reply-To: <1149801774.11412.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081440.43840.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 2:22 pm, Richard Purdie wrote:
> On Thu, 2006-06-08 at 13:38 -0700, David Brownell wrote: 
> > > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3547/1
> > 
> > OK, I see now.  Simple enough, better than the original.  Go for it.
> > 
> > There was a PXA issue I was alluding to that's still open, though.
> > It's the way there's no selectivity about what platform devices are
> > registered ... even kernels running on boards where OHCI isn't hooked
> > up to anything will be registering an OHCI controller, as one of many
> > examples.  Won't affect this particular case, but in general that'd
> > be nice to see fixed.
> 
> As I understood the code, if you don't have platform_data set, it will
> abort in the probe function so it depends what you mean by register. An
> OHCI controller never gets created without platform_data.
> 
> You're right that the PXA platform device is always registered. FWIW,
> there is no platform in mainline that doesn't have OHCI present so this
> isn't a major problem at the moment.

Right.  OHCI was just an example though ... there are lots of other
platform drivers for PXA.  I'm not sure they all check for platform_data
before succeeding in their probe() methods.


> The easiest solution might be to move the ohci device registration into
> pxa_set_ohci_info (in pxa27x.c). I gave in and appended a patch (compile
> tested only so far).

Looked OK to me.

That's the kind of approach now used with OMAP and AT91, and which IMO
would be appropriate to use for most platform devices ... that is, don't
register devices that the board doesn't have.  One additional nuance:  if
the kernel doesn't have that driver configured, that's another reason not
to bother registering its device.

- Dave

