Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVFCVf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVFCVf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFCVf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:35:57 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:9953 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261381AbVFCVfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:35:50 -0400
Date: Fri, 3 Jun 2005 14:35:48 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/5] RapidIO support: core
Message-ID: <20050603143548.B32392@cox.net>
References: <20050602140359.B24818@cox.net> <20050603072027.GD30292@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050603072027.GD30292@kroah.com>; from greg@kroah.com on Fri, Jun 03, 2005 at 12:20:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 12:20:27AM -0700, Greg KH wrote:
> On Thu, Jun 02, 2005 at 02:03:59PM -0700, Matt Porter wrote:
> > +static struct device rio_bus = {
> > +	.bus_id = "rapidio",
> > +};
> 
> Why do you need this device?  You shouldn't have a static struct device
> to start with.  Or you just don't like having your root rio device
> showing up in /sys/devices/ ?

Exactly. There's no hierarchy in this interconnect. So it seemed
that having a static rio_bus device made the most sense. Everything
exists as peers since it works more like a network than a hierarchical
bus like PCI. Right now, you can't see the endpoint which actually
implements your port into the switch fabric...there's no device
created for it. I'm still trying to determine if that should change
but it's not critical to usability with the current generation
hardware.

One argument I have _for_ it is that it would be easy to show
and manipulate a network from userspace if all nodes had a device
associated with them.  That's not a real world problem yet so
I decided not to complicate things yet.

> If so, just create a kobject and put it there, and then base your
> devices off of it, no need for a real device.
> 
> Oh wait, that's what the platform and system code does.  bah,
> nevermind...

Ok. I did pull this part right from the platform code, in fact.

-Matt
