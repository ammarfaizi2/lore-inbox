Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbUJ0OxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUJ0OxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUJ0OxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:53:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262470AbUJ0Ow6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:52:58 -0400
Date: Wed, 27 Oct 2004 10:52:40 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <linux-acpi@intel.com>
Subject: Re: 2.6.10-rc1-mm1
In-Reply-To: <20041027022031.1567fe98.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0410271049210.9447-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Andrew Morton wrote:

> > Here's some debugging of the last few drivers to be registered before the 
> > oops is seen:
> > 
> > name=hpet node=c03ee9a0 acpi_bus_drivers.prev=c03ea6a0
> > name=i8042 node=c03eeda0 acpi_bus_drivers.prev=c03ee9a0
> > name=floppy node=c03f24c0 acpi_bus_drivers.prev=c03ee9a0
> > 
> > 
> > Note acpi_bus_drivers.prev for floppy was not set to c03eeda0, which you 
> > would normally expect?
> 
> Not too sure what I'm looking at there.

Debugging in acpi_bus_register_driver():


printk("name=%s node=%p acpi_bus_drivers.prev=%p\n", driver->name, &driver->node, acpi_bus_drivers.prev);

> ah.  the acpi floppy scanning code seems to be misinterpreting the
> acpi_bus_register_driver() return value, so if it returns zero we think
> that the driver was registered, only it wasn't.  floppy_init() then
> proceeds to unregister a not-registered driver.  I think.  Does this help?

No, it seems that the floppy code is registering fine (it gets return of 1 
from acpi_bus_register_driver()).

> If so, I wonder why acpi_bus_register_driver() is returning zero.

It's not.

Given that this is disappearing when enabling debug info, perhaps it's a 
compilation or similarly obsucure bug.

- James
-- 
James Morris
<jmorris@redhat.com>


