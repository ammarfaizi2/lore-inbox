Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTFPSJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTFPSJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:09:19 -0400
Received: from ida.rowland.org ([192.131.102.52]:50180 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264085AbTFPSJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:09:14 -0400
Date: Mon, 16 Jun 2003 14:23:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030616180344.GP6754@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44L0.0306161413510.1350-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Mon, Jun 16, 2003 at 01:54:34PM -0400, Alan Stern wrote:
> 
> > That's not practical.  How else can a device driver provide 
> > device-specific configuration options or information in sysfs?  In many 
> > cases the device is owned by the bus, not the device driver.
> 
> Practical or not, when you put sysfs object into a structure, you take
> full responsibility for the lifetime of that structure.  Period.

I agree.  The problem here is that the sysfs/driver-model core is putting
an object into a structure (i.e., a pointer to the device_attribute
structure is being stored in the dentry for a user-owned file) without
taking the corresponding responsibility for the lifetime of the driver
code that the attribute refers to.  The struct driver's reference count is 
_not_ incremented; in fact device_create_file() doesn't even _have_ a 
struct driver argument to say who the caller is.

You could make a good case that this ought to be fixed by changing either
the sysfs or the driver model code.  But in either case, the fault lies in
the core implementation, not in the driver.

> Note that problems exist even when kernel is non-modular.  Even if code
> stays in place, the data getting freed under you is just as bad.  And
> that can trivially happen without any modules.

Of course.

Alan Stern

