Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVBAW4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVBAW4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVBAW4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:56:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:16083 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262149AbVBAW4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:56:40 -0500
Date: Tue, 1 Feb 2005 14:56:25 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] driver core: export MAJOR/MINOR to the hotplug env
Message-ID: <20050201225625.GA14962@kroah.com>
References: <20050123041911.GA9209@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123041911.GA9209@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 05:19:11AM +0100, Kay Sievers wrote:
> This patch sequence moves the creation of the sysfs "dev" file of the class
> devices into the driver core. The struct class_device contains a dev_t
> value now. If set, the driver core will create the "dev" file containing
> the major/minor numbers automatically.
> 
> The MAJOR/MINOR values are also exported to the hotplug environment. This
> makes it easy for userspace, especially udev to know if it should wait for
> a "dev" file to create a device node or if it can just ignore the event.
> We currently carry a compiled in blacklist around for that reason.
> 
> It would also be possible to run some "tiny udev" while sysfs is not
> available - just by reading the hotplug call or the netlink-uevent.

This is great, thanks for doing this.  I've applied all of these patches
to my trees, and they'll show up in the next -mm release.

Hm, that class_simple interface is looking like the way we should move
toward, as it's "simple" to use, instead of the more complex class code.
I'll have to look at migrating more code to use it over time, or move
that interface back into the class code itself...

thanks,

greg k-h
