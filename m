Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266783AbUHCSRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266783AbUHCSRo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 14:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266789AbUHCSRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 14:17:44 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:34266 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266783AbUHCSRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 14:17:41 -0400
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
From: Alex Williamson <alex.williamson@hp.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091554271.27397.5327.camel@nighthawk>
References: <1091552426.4981.103.camel@tdi>
	 <1091554271.27397.5327.camel@nighthawk>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 03 Aug 2004 12:17:29 -0600
Message-Id: <1091557050.4981.135.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 10:31 -0700, Dave Hansen wrote:
> On Tue, 2004-08-03 at 10:00, Alex Williamson wrote:
> >    This is by no means ready for release, but I wanted to get a sanity
> > check.  I'm still stuck on this idea that userspace needs access to ACPI
> > namespace.  Manageability apps might use this taking inventory of
> > devices not exposed by other means, things like X can locate chipset
> > components that don't live in PCI space, there's even the possibility of
> > making user space drivers.
> 
> The only thing that worries me about a patch like this is that it
> encourages people to write arch-specific tools that have no chance of
> working on multiple platforms.  
> 
> Right now, on ppc64, we have a system for making direct calls into the
> firmware, as well as a copy of the firmware's device-tree exported to
> userspace.  This means that we have userspace applications that do very
> generic things like counting CPUs, or activating memory in very
> arch-specific ways.  
> 
> Creating more of these interfaces encourages more of these arch-specific
> applications, and what we end up with are lots of tools that only work
> on Intel platforms or IBM ppc, but not Linux in general.
> 
> So, what kinds of generic, arch-independent interfaces should we
> implement in the kernel that would reduce the need for something like
> your driver?

   I agree with your intent, but I'm not sure a common kernel interface
is feasible or desired.  This driver would be much more useful if it was
cleverly abstracted by a userspace library.  Should we try to make the
common layer be the library interface?  Obviously the more similar the
kernel interface, the easier, but I'm not ready to sign-up to architect
a generic interface.

   The ACPI interface could be used to do everything from switching a
laptop display between the interfaces to listing and configuring/de-
configuring specific pieces of hardware.  There will be a set of
functionality that's common across multiple interfaces, but I don't want
to prevent the usage that is very specific to the underlying
implementation.

	Alex  

-- 
Alex Williamson                             HP Linux & Open Source Lab

