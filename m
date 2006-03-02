Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWCBPjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWCBPjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWCBPjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:39:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46865 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751548AbWCBPjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:39:53 -0500
Date: Thu, 2 Mar 2006 15:39:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: what's a platform device?
Message-ID: <20060302153945.GA28895@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <8B3A62DF-6991-4C46-A294-6DF314D24AF4@kernel.crashing.org> <Pine.LNX.4.44.0602231324110.12559-100000@gate.crashing.org> <20060224014251.GC25787@kroah.com> <B8F53A5C-A186-478E-A2A9-4797FE56EBE4@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8F53A5C-A186-478E-A2A9-4797FE56EBE4@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 04:25:52PM -0600, Kumar Gala wrote:
> >>>This makes sense, but you seem to be talking about hierarchy more  
> >>>the
> >>>functionality.  I agree in your description of hierarchy.
> >>>
> >>>I was looking at it from a functional point of view, maybe more from
> >>>the device view then from the bus.  I need a struct device type that
> >>>contains resources, a name, an id.  I'll do matching based on name.
> >>> From a functional point of view platform does all this.
> >>>
> >>>Based on your description would you say that a platform_device's
> >>>parent device should always be platform_bus? [I'm getting at the  
> >>>fact
> >>>that we allow pdev->dev.parent to be set by the caller of
> >>>platform_device_add].
> >>>
> >>>Hmm, as I think about this further, I think that its more  
> >>>coincidence
> >>>that the functionality for the "kumar" bus is equivalent to that of
> >>>the "platform" bus.
> >>>
> >>
> >>What about a new bus_type that uses all the sematics of the  
> >>platform_bus.
> >>Doing someting like the following which would allow the caller to  
> >>specify
> >>their own bus_type.
> >>
> >>I'm just trying to avoid duplicating alot of code that already  
> >>exists in
> >>base/platform.c
> >
> >I'm ok with this patch, Russell?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114072367307531&w=2
> 
> Russell, comments?

No particular opinion on this, other than maybe we want to move the
dev.bus/driver.bus initialisation out of these functions and inline
or something like that - just so there's some distinction between
real platform devices and these other types.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
