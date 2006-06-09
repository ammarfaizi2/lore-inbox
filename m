Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWFIBZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWFIBZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWFIBZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:25:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41192 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965106AbWFIBZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:25:03 -0400
Date: Thu, 08 Jun 2006 21:25:02 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
In-reply-to: <200606081644.47288.david-b@pacbell.net>
X-X-Sender: nico@localhost.localdomain
To: David Brownell <david-b@pacbell.net>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-usb-devel@lists.sourceforge.net,
       Pavel Machek <pavel@suse.cz>, Russell King <rmk+lkml@arm.linux.org.uk>,
       lenz@cs.wisc.edu, David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0606082116050.19403@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <447EB0DC.4040203@cogweb.net>
 <200606081440.43840.david-b@pacbell.net>
 <1149803365.11412.28.camel@localhost.localdomain>
 <200606081644.47288.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, David Brownell wrote:

> On Thursday 08 June 2006 2:49 pm, Richard Purdie wrote:
> > 
> > > One additional nuance:  if
> > > the kernel doesn't have that driver configured, that's another reason not
> > > to bother registering its device.
> > 
> > This is where you start to add ugly ifdefs and generally start making
> > the code look horrible. The device model separated the drivers and the
> > devices to deal with this issue as I see it. 
> 
> Enumeration is a separate issue.  You wouldn't argue that every potential
> PCI or USB device must get registered, right?  Only the ones that are
> actually _present_ get registered.

You are both saying the same thing so far.

> But here you argue that platform bus should not work that same way ... it
> should register devices that can't be present.  If nothing else, that's
> an inconsistent aproach.

That's not what Richard is saying.

He replied to your assertion where you said: "if the kernel doesn't have 
that driver configured, that's another reason not to bother registering 
its device" to which he disagreed, and I disagree too.

> Plus, consider the common situation that a given pin could potentially
> be used with several different devices.  On a given board, only one of
> those devices will be wired up.  It's counterproductive to register any
> of the others ... error prone, waste-of-kernel-address-space, etc.

No one disagreed with that AFAICS.

> > Generally I'd say its 
> > cleaner just to let the device register, then if a module comes along at
> > some later point, the device is there for it.
> 
> Whether the device is there or not is a hardware issue.  Board schematics
> will show which devices are relevant ... registering any others is just
> wastage.

But you originally talked about _driver_ configuration dictating if a 
_device_ should be registered or not.

The _device_ should indeed be registered based on _hardware_ config, not 
_driver_ config.


Nicolas
