Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTFPRqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTFPRqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:46:46 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:56072 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264069AbTFPRqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:46:31 -0400
Date: Mon, 16 Jun 2003 20:00:33 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Russell King <rmk@arm.linux.org.uk>
cc: Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
       Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030616182003.D13312@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306161937010.2079-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Russell King wrote:

> On Mon, Jun 16, 2003 at 10:08:26AM -0700, Greg KH wrote:
> > Then don't let your module unload until _all_ instances of your
> > structures are gone.  You can tell if this is true or not, it's just up
> > to the implementor :)
> 
> Greg, I believe Alan does have a valid concern.  Eg, how is the following
> handled?
> 
> - PCI device driver module is loaded
> - device driver gets handed a pci device
> - device driver attaches a file to the struct device corresponding to the
>   PCI device.

with old procfs one would like to set the owner field of the 
corresponding struct proc_dir_entry and/or file_operations at this point.

> - userspace opens new file (this does not increment the device drivers
>   use count.)

given owner=THIS_MODULE was set, this would bump the module's use count

> - device driver is rmmod'd

and this could never happen while the procfs file (or directory) is still 
referenced

> - device driver removes its references to the pci device
> - device driver unloads
> - user reads from opened file.

Admittedly I haven't looked deeper into sysfs yet, but I was under the
assumption/hope there would be a similar approach to make module 
refcounting working there?

Martin

