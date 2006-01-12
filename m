Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWALPOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWALPOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbWALPOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:14:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3554 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030440AbWALPOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:14:34 -0500
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Dave Hansen <haveblue@us.ibm.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, "Mike D. Day" <ncmike@us.ibm.com>
In-Reply-To: <00466d4b0eb7fe1603cd7f54448d37ff@cl.cam.ac.uk>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
	 <43C5A199.1080708@us.ibm.com>
	 <1137029574.11331.11.camel@localhost.localdomain>
	 <00466d4b0eb7fe1603cd7f54448d37ff@cl.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 07:14:23 -0800
Message-Id: <1137078863.5397.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 10:04 +0000, Keir Fraser wrote:
> On 12 Jan 2006, at 01:32, Dave Hansen wrote:
> 
> > Do you have a definitive list of things that you want to export?  Are
> > they things that come and go, or are they static?  Do you want hotplug
> > events for them?  Some of those things may be better fit platform
> > devices.  Notice that ACPI has entries in /sys/firmware/acpi
> > and /sys/devices/system/acpi.
> 
> This is a good set of questions. We have about half dozen files in 
> /proc/xen right now. One is an obvious canididate to stick in /dev, as 
> it has primarily an ioctl() interface.

Actually, anything with an ioctl interface is probably a good cantidate
for a writable sysfs file.  The basic idea is that we prefer something
in sysfs with a discrete, unique name.  It also makes it a lot easier to
develop with because you can look at the values from scripts, and you
don't have to worry about synchronizing any headers.

So, what kind of ioctls are we talking about?

> The remainder are static, are 
> read-only or read-write with ascii text, and we don't want hotplug 
> events and other baggage.

There really isn't much "baggage" that a static file carries around.
All you have to do is omit filling in a function pointer.  Hotplug
events are one of those "for free" things that you get.

> Maybe making these attributes of a Xen system device makes sense. Are 
> there examples in the kernel of other subsystems/modules with a similar 
> miscellaneous set of files?

drivers/base/memory.c has a couple of little things.  A writable probe
file, and a somewhat miscellaneous file for representing the units that
are being dealt with.  Might be a place to start.  I can certainly
answer questions about it.  I would also suggest just doing a "find" or
"tree" on a few of your systems and looking for people that do similar
things to what you want.

I know I struggled to get the memory hotplug sysfs code to work at
first, but the code has been very, very low maintenance.

-- Dave

