Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVC0VI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVC0VI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVC0VI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:08:56 -0500
Received: from isilmar.linta.de ([213.239.214.66]:12735 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261161AbVC0VIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:08:54 -0500
Date: Sun, 27 Mar 2005 23:08:53 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Adam Belay <abelay@novell.com>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Message-ID: <20050327210853.GA18358@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Adam Belay <abelay@novell.com>, Greg KH <greg@kroah.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
References: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111951499.3503.87.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> One of the original design goals of sysfs was to provide a standardized
> location to keep driver configuration attributes.  Although sysfs
> handles this very well for bus devices and class devices, there isn't
> currently a method to export attributes for device drivers and their
> specific bound device instances to userspace.

Drivers can add (e.g. in ->probe) attributes for devices using
extern int device_create_file(struct device *device, struct device_attribute
* entry);
and delete them (e.g. in ->remove) using
extern void device_remove_file(struct device * dev, struct device_attribute
* attr);

and there's also 

extern int driver_create_file(struct device_driver *, struct
driver_attribute *);
extern void driver_remove_file(struct device_driver *, struct
driver_attribute *);


	Dominik
