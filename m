Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVC2FjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVC2FjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 00:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVC2FjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 00:39:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:28376 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262341AbVC2Fir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 00:38:47 -0500
Date: Mon, 28 Mar 2005 21:03:45 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <abelay@novell.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       linux-pm@lists.osdl.org
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Message-ID: <20050329050345.GB7937@kroah.com>
References: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111951499.3503.87.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> One of the original design goals of sysfs was to provide a standardized
> location to keep driver configuration attributes.  Although sysfs
> handles this very well for bus devices and class devices, there isn't
> currently a method to export attributes for device drivers and their
> specific bound device instances to userspace.

Hm, what's device_create_file(), device_remove_file(), and DEVICE_ATTR()
for?  A number of drivers use these functions today to add their own
driver specific attributes to a device they control.

Then, userspace can just do a simple:
	ls /sys/bus/pci/drivers/my_foo_driver/
to see all devices on the PCI bus that are controlled by that driver.
Then it can go into those directories and cat out the specific
information if needed.

Is there something that is lacking in the current code that you would
like to see present?  I don't think that adding another layer on top of
a device would help out much here.

thanks,

greg k-h
