Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWCCXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWCCXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWCCXu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:50:59 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:10416 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751055AbWCCXu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:50:58 -0500
Date: Fri, 3 Mar 2006 18:50:56 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
X-X-Sender: scottm@godzilla.spiteful.org
To: Kumar Gala <galak@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
In-Reply-To: <B559AC6B-A9C9-425E-9288-EE7F9C99D8EB@kernel.crashing.org>
Message-ID: <Pine.LNX.4.58.0603031841290.31840@godzilla.spiteful.org>
References: <20060303220741.GA22298@kroah.com>
 <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org>
 <20060303231807.GA28055@kroah.com> <B559AC6B-A9C9-425E-9288-EE7F9C99D8EB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006, Kumar Gala wrote:

> 
> On Mar 3, 2006, at 5:18 PM, Greg KH wrote:
> 
> > On Fri, Mar 03, 2006 at 04:39:52PM -0600, Kumar Gala wrote:
> >> On Fri, 3 Mar 2006, Greg KH wrote:
> >>
> >>> On Fri, Mar 03, 2006 at 11:42:03AM -0600, Kumar Gala wrote:
> >>>> I was wondering what the proper way to assign and setup a single  
> >>>> PCI
> >>>> device that comes into existence after the system has booted.  I  
> >>>> have
> >>>> an FPGA that we load from user space at which time it shows up  
> >>>> on the
> >>>> PCI bus.
> >>>
> >>> Idealy your BIOS would set up this information :)
> >>
> >> How would my BIOS know about a device that didn't exist when it  
> >> booted.
> >
> > According to the PCI Hotplug spec, your BIOS needs to take that into
> > consideration at boot time.  Yeah, it's a wierd thing, I agree, but is
> > how this works for x86 systems.  The space and resources are reserved
> > at boot time by the pci hotplug controller in anticipation of a device
> > being added sometime in the future.
> >
> > Other arches do this differently (ppc64 has the stuff reserverd by the
> > hypervisor), and then compat pci does it by just plain guessing.  It
> > sounds like your situation is just like this one.
> 
> Well I reserve space for the device in my "BIOS".  However this is an  
> embedded system so there isn't any calling out to the "BIOS" after  
> linux has booted.  Is there some additional "work" that the x86  
> systems do beyond ensure proper holes in the memory map exist for  
> future devices to be placed into?

For CompactPCI, most boards I've encountered actually do not reserve any 
extra resources on the bridge to the hotplug bus.  I have had a patch for
a while that allows reallocating the resources for a specified bridge and 
all its children at boot time, and recently ported it to 2.6.  It doesn't
sound like you need it since you've got your own bootloader, but let me
know if you want to take a look at it.

> Ahh, looked at cpqphp_* and only found cpqhp_configure_device() of  
> any use.  I'll take a look at cpcihp*.c

Just a warning, cpci_configure_slot in cpci_hotplug_pci.c is somewhat
broken atm, I've got a small patch I was going to clean up and send to 
Greg for 2.6.17.  I can provide it if you want to compare a working 
cpci_configure_slot against cpqhp_configure_device.

Scott


-- 
==============================================================================
Scott Murray, scott@spiteful.org

     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"
