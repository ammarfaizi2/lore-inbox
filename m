Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWFICDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWFICDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWFICDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:03:11 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:19096 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750928AbWFICDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:03:09 -0400
From: David Brownell <david-b@pacbell.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: [linux-usb-devel] [PATCH] limit power budget on spitz
Date: Thu, 8 Jun 2006 19:03:05 -0700
User-Agent: KMail/1.7.1
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-usb-devel@lists.sourceforge.net,
       Pavel Machek <pavel@suse.cz>, Russell King <rmk+lkml@arm.linux.org.uk>,
       lenz@cs.wisc.edu, David Liontooth <liontooth@cogweb.net>,
       Oliver Neukum <oliver@neukum.org>,
       kernel list <linux-kernel@vger.kernel.org>
References: <447EB0DC.4040203@cogweb.net> <200606081644.47288.david-b@pacbell.net> <Pine.LNX.4.64.0606082116050.19403@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0606082116050.19403@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081903.07203.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 6:25 pm, Nicolas Pitre wrote:
> 
> You are both saying the same thing so far.

Hey, violent agreement is half the fun!  :)


> > But here you argue that platform bus should not work that same way ... it
> > should register devices that can't be present.  If nothing else, that's
> > an inconsistent aproach.
> 
> That's not what Richard is saying.
> 
> He replied to your assertion where you said: "if the kernel doesn't have 
> that driver configured, that's another reason not to bother registering 
> its device" to which he disagreed, and I disagree too.

I see your point.  Yes, this is arguable ... there are multiple principles
that can be traded off against each other.


For example, "by default, make design choices that save memory" (what I was
using) versus:

> The _device_ should indeed be registered based on _hardware_ config, not 
> _driver_ config.

For a kernel without CONFIG_MODULES, that's pure wasted space.  Why bother?
Those are devices that "can't be present", so that's one of the cases where
that "ignore the driver config" policy will indeed register such devices.

Similarly, when the driver's not yet written, it can make trouble to try
sticking its config into the device tree ... it's very easy to get wrong!


It's clear to me there are some cases where software config will reasonably
be a subset of the hardware config.  Likewise, that memory usage should be
one of the factors considered when making design tradeoffs.

- Dave

