Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVFVPpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVFVPpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFVPmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:42:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39649 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261582AbVFVPl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:41:29 -0400
Date: Wed, 22 Jun 2005 11:41:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Stelian Pop <stelian@popies.net>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: usb sysfs intf files no longer created
 when probe fails
In-Reply-To: <1119452963.4787.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0506221133230.6938-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Stelian Pop wrote:

> Le mercredi 22 juin 2005 à 07:59 -0700, Greg KH a écrit :
> > On Wed, Jun 22, 2005 at 03:50:56PM +0200, Stelian Pop wrote:
> > > I use the 'atp' input driver from http://popies.net/atp/ to drive this
> > > touchpad. When removing the driver I also get an oops, possibly related
> > > to the previous failure to create the sysfs file:
> > 
> > Sounds like a bug in that driver, care to ask the authors of it about
> > this?
> 
> I am the author :)
> 
> That driver worked until yesterday, and I was not able to find out about
> any API change which would disrupt it now, that's why I reported this to
> the list... 

This is a curious aspect of the driver model core.  Should failure of a 
driver to bind be considered serious enough to cause device_add to fail?
The current answer is Yes unless the driver's probe routine returns 
-ENODEV or -ENXIO, in which case the failure is not considered serious.

IMO this is a perverse way of doing things.  The existence of a device has 
nothing to do with what driver is bound to it.  Either the device exists 
or it doesn't -- and if it exists, failure to bind a driver shouldn't 
prevent adding the device into sysfs.  Right now, however, it does.

Alan Stern

