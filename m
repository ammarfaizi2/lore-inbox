Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVC0Vce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVC0Vce (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVC0Vce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:32:34 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48294 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261592AbVC0Vcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:32:32 -0500
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
From: Adam Belay <abelay@novell.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
In-Reply-To: <20050327210853.GA18358@isilmar.linta.de>
References: <1111951499.3503.87.camel@localhost.localdomain>
	 <20050327210853.GA18358@isilmar.linta.de>
Content-Type: text/plain
Date: Sun, 27 Mar 2005 16:27:24 -0500
Message-Id: <1111958844.3503.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 23:08 +0200, Dominik Brodowski wrote:
> On Sun, Mar 27, 2005 at 02:24:59PM -0500, Adam Belay wrote:
> > One of the original design goals of sysfs was to provide a standardized
> > location to keep driver configuration attributes.  Although sysfs
> > handles this very well for bus devices and class devices, there isn't
> > currently a method to export attributes for device drivers and their
> > specific bound device instances to userspace.

You're right, I should have worded this differently.

> 
> Drivers can add (e.g. in ->probe) attributes for devices using
> extern int device_create_file(struct device *device, struct device_attribute
> * entry);
> and delete them (e.g. in ->remove) using
> extern void device_remove_file(struct device * dev, struct device_attribute
> * attr);
> 
> and there's also 
> 
> extern int driver_create_file(struct device_driver *, struct
> driver_attribute *);
> extern void driver_remove_file(struct device_driver *, struct
> driver_attribute *);
> 
> 
> 	Dominik

Yes, I'm aware of these functions but they pollute the bus level
namespace.  I'm interested in reactions to this alternative approach.  I
wanted to explore the possibility of making a device driver instance a
separate component with its own individual state and relationships.

Adam


