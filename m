Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVBBAsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVBBAsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 19:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVBBAsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 19:48:20 -0500
Received: from soundwarez.org ([217.160.171.123]:14790 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261948AbVBBAsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 19:48:15 -0500
Date: Wed, 2 Feb 2005 01:48:12 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] driver core: export MAJOR/MINOR to the hotplug env
Message-ID: <20050202004812.GA29888@vrfy.org>
References: <20050123041911.GA9209@vrfy.org> <20050201225625.GA14962@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201225625.GA14962@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 02:56:25PM -0800, Greg KH wrote:
> On Sun, Jan 23, 2005 at 05:19:11AM +0100, Kay Sievers wrote:
> > This patch sequence moves the creation of the sysfs "dev" file of the class
> > devices into the driver core. The struct class_device contains a dev_t
> > value now. If set, the driver core will create the "dev" file containing
> > the major/minor numbers automatically.
> > 
> > The MAJOR/MINOR values are also exported to the hotplug environment. This
> > makes it easy for userspace, especially udev to know if it should wait for
> > a "dev" file to create a device node or if it can just ignore the event.
> > We currently carry a compiled in blacklist around for that reason.
> > 
> > It would also be possible to run some "tiny udev" while sysfs is not
> > available - just by reading the hotplug call or the netlink-uevent.
> 
> This is great, thanks for doing this.  I've applied all of these patches
> to my trees, and they'll show up in the next -mm release.

Fine, thanks.

> Hm, that class_simple interface is looking like the way we should move
> toward, as it's "simple" to use, instead of the more complex class code.
> I'll have to look at migrating more code to use it over time, or move
> that interface back into the class code itself...

Nice idea! What about keeping a list of devices belonging to a
specific class in an own list in 'struct class' and maintaining that list
with class_device_add(), class_device_del()?

A class driver may use that list to keep track of its own devices if
wanted and class_simple would not be needed anymore as everything
would be available in the core.

Thanks,
Kay
