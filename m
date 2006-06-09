Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWFICeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWFICeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWFICeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:34:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65403 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751365AbWFICeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:34:16 -0400
Date: Thu, 08 Jun 2006 22:34:15 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
In-reply-to: <200606081903.07203.david-b@pacbell.net>
X-X-Sender: nico@localhost.localdomain
To: David Brownell <david-b@pacbell.net>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-usb-devel@lists.sourceforge.net,
       Pavel Machek <pavel@suse.cz>, Russell King <rmk+lkml@arm.linux.org.uk>,
       lenz@cs.wisc.edu, David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0606082217590.19403@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <447EB0DC.4040203@cogweb.net>
 <200606081644.47288.david-b@pacbell.net>
 <Pine.LNX.4.64.0606082116050.19403@localhost.localdomain>
 <200606081903.07203.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, David Brownell wrote:

> On Thursday 08 June 2006 6:25 pm, Nicolas Pitre wrote:
> > He replied to your assertion where you said: "if the kernel doesn't have 
> > that driver configured, that's another reason not to bother registering 
> > its device" to which he disagreed, and I disagree too.
> 
> I see your point.  Yes, this is arguable ... there are multiple principles
> that can be traded off against each other.
> 
> For example, "by default, make design choices that save memory" (what I was
> using) versus:
> 
> > The _device_ should indeed be registered based on _hardware_ config, not 
> > _driver_ config.
> 
> For a kernel without CONFIG_MODULES, that's pure wasted space.  Why bother?
> Those are devices that "can't be present", so that's one of the cases where
> that "ignore the driver config" policy will indeed register such devices.

But constrained hardware designs for which memory usage is important 
that have the device available are likely to make use of that device 
anyway.  So in those cases it is pretty unlikely that the kernel config 
won't include the corresponding driver.

The case where the hardware does support a device but someone decided 
not to use it may have its kernel config exclude the corresponding 
driver.  But since this is most probably not the common case I don't 
think we should go as far as uglifying the code with conditional device 
registrations based on #if !defined(CONFIG_MODULE) && !defined(CONFIG_FOO)
just for the sake of saving as many bytes as possible.  That someone may 
as well comment out that device registration in his own source tree 
himself.

It is more likely that some hardware design that is not 
expected to use a particular device will simply not register that device 
in the first place and its default kernel config won't have the driver 
selected either.  In that sense I think Richard's patch is all that is 
needed for mainline.


Nicolas
