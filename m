Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbVFYD1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbVFYD1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 23:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbVFYD1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 23:27:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:21177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263309AbVFYD1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 23:27:30 -0400
Date: Fri, 24 Jun 2005 20:26:39 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Message-ID: <20050625032639.GA3934@kroah.com>
References: <20050624051229.GA24621@kroah.com> <20050625030553.GB7380@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625030553.GB7380@nostromo.devel.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 11:05:53PM -0400, Bill Nottingham wrote:
> Greg KH (greg@kroah.com) said: 
> > Even so, with these two patches, people should be able to do things that
> > they have been wanting to do for a while (like take over the what driver
> > to what device logic in userspace, as I know some distro installers
> > really want to do.)
> 
> Playing devils advocate, with this, the process flow is:
> 
> - kernel sees a new device
> - kernel sends hotplug event for bus with slot, address, vendor id, etc.
> - userspace loads a module based on that info
>   <some sort of synchronization here waiting for driver to initialize>
> - userspace echos to sysfs to bind device
> - kernel sends hotplug device event
> - userspace creates device node, then continues with device

Yeah, I'm not saying I think it's a good process flow for people to
implement.  But if they want to, they now can.

The main reason for this is for drivers that replace built in drivers,
or multiple modules for the same device (think of new rev of driver,
both loaded at once, some devices should bind to the new one, other
devices you want staying with the old one due to it controlling your
root partition.)  Now userspace has a chance to unbind and bind devices
to drivers in those situations, which it never could before.

But remember, I'm not changing the way things bind to devices here, like
requiring userspace to pick the driver for the device, so no one lives
will change at all, if they don't want to.

Hope this helps explain it.

greg k-h
