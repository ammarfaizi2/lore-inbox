Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTIBSUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTIBRth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:49:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46019 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263870AbTIBRlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:41:50 -0400
Date: Tue, 2 Sep 2003 19:41:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>, torvalds@osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030902174126.GB14209@suse.de>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise> <20030825172737.E16790@flint.arm.linux.org.uk> <20030901120208.GC1358@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901120208.GC1358@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01 2003, Pavel Machek wrote:
> Hi!
> 
> > I think we need to expand the platform device support to include the
> > notion of platform drivers.  For example:
> > 
> > 	struct platform_driver {
> > 		int (*probe)(struct platform_device *);
> > 		int (*remove)(struct platform_device *);
> > 		int (*suspend)(struct platform_device *, u32);
> > 		int (*resume)(struct platform_device *);
> > 		struct device_driver drv;
> > 	};
> > 
> > (Aside: I like the movement of the suspend/resume methods to the bus_type,
> > and I'd like to see the probe/remove methods also move there.  For the
> > vast majority of cases, the probe/remove methods in struct device_driver
> > end up pointing at the same functions for any particular bus.)
> 
> But what about those few devices that need special handling? Like
> flush write cache on IDE disk but not on cdrom?

ide-cd should have a flush write cache as well, for mtr, dvd-ram, cd-rw
with packet writing, etc.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Mon, Sep 01 2003, Pavel Machek wrote:
> Hi!
> 
> > I think we need to expand the platform device support to include the
> > notion of platform drivers.  For example:
> > 
> > 	struct platform_driver {
> > 		int (*probe)(struct platform_device *);
> > 		int (*remove)(struct platform_device *);
> > 		int (*suspend)(struct platform_device *, u32);
> > 		int (*resume)(struct platform_device *);
> > 		struct device_driver drv;
> > 	};
> > 
> > (Aside: I like the movement of the suspend/resume methods to the bus_type,
> > and I'd like to see the probe/remove methods also move there.  For the
> > vast majority of cases, the probe/remove methods in struct device_driver
> > end up pointing at the same functions for any particular bus.)
> 
> But what about those few devices that need special handling? Like
> flush write cache on IDE disk but not on cdrom?

ide-cd should have a flush write cache as well, for mtr, dvd-ram, cd-rw
with packet writing, etc.

-- 
Jens Axboe

