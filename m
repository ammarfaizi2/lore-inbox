Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTHYQ53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTHYQ53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:57:29 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:45195 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261893AbTHYQ5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:57:22 -0400
Date: Mon, 25 Aug 2003 09:57:20 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030825095720.B28149@home.com>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise> <20030825172737.E16790@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030825172737.E16790@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Aug 25, 2003 at 05:27:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 05:27:37PM +0100, Russell King wrote:
> On Mon, Aug 25, 2003 at 08:47:16AM -0700, Patrick Mochel wrote:
> > > There is a hell of a lot of work which now needs to be done to re-fix
> > > everything which was working.  For example, there is no sign of any
> > > power management for platform devices currently.  Could you give some
> > > clues as to what you'd like to see there?
> > 
> > How about following the system device scheme: 1 call, with interrupts 
> > disabled? 
> 
> I don't think that's going to work well when you have more conventional
> devices below a platform device which need to be power managed (eg, a
> USB host.)
> 
> I think we need to expand the platform device support to include the
> notion of platform drivers.  For example:
> 
> 	struct platform_driver {
> 		int (*probe)(struct platform_device *);
> 		int (*remove)(struct platform_device *);
> 		int (*suspend)(struct platform_device *, u32);
> 		int (*resume)(struct platform_device *);
> 		struct device_driver drv;
> 	};

Alternatively, you could leave the platform model as is (it's only
for really dumb devices).  On PPC, we have an OCP (on chip peripheral)
model that is mostly integrated into the device model now.  OCP is
just another bus/driver type and so PM works in the normal fashion.
There's a driver API around it as well so we can cleanly share drivers
across various SoC implementations with different base address,
IRQ mappings, etc.  It might be more useful to extende this across
the architectures that need it.

-Matt
