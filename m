Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbULPEOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbULPEOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 23:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbULPEOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 23:14:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:34024 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261924AbULPEOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 23:14:19 -0500
Date: Wed, 15 Dec 2004 20:14:05 -0800
From: Greg KH <greg@kroah.com>
To: ambx1@neo.rr.com, linux-kernel@vger.kernel.org, rml@ximian.com,
       mochel@digitalimplant.org, len.brown@intel.com, shaohua.li@intel.com,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] Device Resource Management
Message-ID: <20041216041405.GA23223@kroah.com>
References: <20041211054509.GA2661@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211054509.GA2661@neo.rr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 12:45:09AM -0500, Adam Belay wrote:
> 
> Hi All,
> 
> This patch is a draft for the core infustructure of driver model based
> resource management.  Buses capable of dynamically allocating resources (such
> as PCI or pcmcia), and recent developments with linux ACPI support have
> incited the need for the kernel to keep track of system resources, and assist
> in the allocation process.  Eventually I'd like to move on to more complex
> problems like resource rebalancing.  This patch simply lays out some
> foundation.
> 
> We currently have some infustructure, but it is more or less incomplete.  For
> example, it doesn't show how resources and the devices that consume them are
> related.  Also it isn't flexable enough to track all types of bus resources.
> ACPI, PnP, and PCI have to allocate interrupts somewhat blindly because
> request_irq happens too late in the game, and really is used to register
> interrupt handlers, not track interrupt usage.

But the interrupts are assigned early in the process, right?  We still
need to do that.

> My implementation is not based on the existing "struct resource" stuff because
> quite frankly, even making small changes would break a large number of
> drivers.  Instead it uses "struct iores"  My hope is that we can gradually
> phase the old implementation out.

Ah, what's wrong with a little breakage :)

> With that in mind, I'd like to work out a solid new API, and would appreciate
> any comments or suggestions, both on the code in this patch and the overall
> design of the API.
> 
> A few issues need to be discussed.  The most important is probably how sysfs
> will display resource usage?  "struct kobject" is actually larger then "struct
> iores" so I don't feel very comfortable embedding it.  But, if a kobject based
> sysfs resource tree would be needed, then I'd be happy to implement it.  If
> not what would be a good alternative?  Does the user have to read resources
> from each device like one would with this current patch?

Why would it matter if we export this info to userspace?  Do any
userspace programs care about this information?

> This patch was only tested for compilation so it may have a few bugs/typos.
> Once again I'd really appreciate any comments or suggestions.

It looks good.  What's the main goals of this redesign (for those of us
who are old and forgot what you said at the last kernel summit...)

thanks,

greg k-h
