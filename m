Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275624AbSIUBgR>; Fri, 20 Sep 2002 21:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275645AbSIUBgR>; Fri, 20 Sep 2002 21:36:17 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:17933 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275624AbSIUBgP>;
	Fri, 20 Sep 2002 21:36:15 -0400
Date: Fri, 20 Sep 2002 18:40:54 -0700
From: Greg KH <greg@kroah.com>
To: "Rhoads, Rob" <rob.rhoads@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
Message-ID: <20020921014054.GA25665@kroah.com>
References: <D9223EB959A5D511A98F00508B68C20C0A53899F@orsmsx108.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0A53899F@orsmsx108.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just started to read over the published spec, and will reserve
comment on it, and the example code you've created after I'm done
reading it.  But I'll make a few comments right now on your
announcement:


On Fri, Sep 20, 2002 at 05:26:47PM -0700, Rhoads, Rob wrote:
> 
> Project Announcement:
> --------------------
> We've started a new project on sourceforge.net w/ focus 
> on hardening Linux device drivers for highly available 
> systems. This project is being worked on with folks from 
> OSDL's CGL and DCL projects as well.

Who is "we"?

> Hardened Driver Project Overview:
> --------------------------------
> Device drivers have traditionally been a significant source 
> of software faults. For this reason, they are of key concern
> in improving the availability and stability of the operating
> system. A critical element in creating Highly Available (HA)
> environment is to reduce the likelihood of faults in key 
> drivers, a methodology called driver hardening. 

Or in simpler terms, making drivers that work, right?
Do you have any statistics that show that existing Linux drivers are a
problem with HA systems?  If so, which drivers?

> A device driver is typically implemented with emphasis on 
> the proper operation of the hardware. Attention to how it 
> will function in the event of hardware faults is often 
> minimal.

Ah, a broad generalization, very nice to set up for the reasoning behind
your project.  But is this really true?  Lots of existing kernel drivers
can handle a wide range of hardware faults, and user faults.  Again, do
people have any specific problems with existing drivers, or driver
subsystems?

> The goal of a hardened driver is to provide an environment 
> in which hardware and software failures are transparent to 
> the applications using their services, where possible. The 
> way to effectively achieve this goal is to analyze a 
> driver's software design and implement appropriate changes
> to improve stability, reliability and availability, and 
> to provide instrumentation for management middleware.

So in order to achieve reliable drivers, we want to add more lines of
code to the driver to allow for instrumentation?  What happens when the
fault happens in the instrumentation interface?  And what is watching
this interface for problems in it's handling of data?

> We believe that improving driver stability and reliability 
> includes such measures as ensuring that all wait loops are
> limited with a timeout, validating input and output data and
> structuring the driver to anticipate hardware errors. 

All good things to achieve.  Have you looked at the kernel-janitors
project?  There are lots of places where you all can jump in to achieve
this right now in the existing code.  Patches for these items are always
welcome, a spec is not needed :)

> Improving availability includes adding support for device
> hot swapping and validating the driver with fault injection.

Hot-swap needs to have hardware that can support this.  Linux currently
supports these kinds of hardware configurations (USB, IEEE1294, PCI
Hotplug, cPCI Hotplug, hotplug CPU, etc.)  Are there existing types of
hardware that is present in your systems that do not have support on
Linux?  And if so, creating drivers for this hardware would be greatly
appreciated.

As for "fault injection", this traditionally requires hardware test
setups that are beyond the means of most kernel programmers.  Will your
group be providing access to this kind of hardware for kernel developers
to test their drivers with?

> Instrumentation for management middleware includes functions
> such as reporting of statistical indicators and logging of 
> pertinent events to enable postmortem analysis in the event
> of a failure.

Um, about this middleware management layer, are you talking about
RAS-style kernel logging?  If so, please see the archives about why the
current implementation of this has been rejected by the kernel
community.

> We've identified four areas in which drivers can be hardened:
> o Hardening with code robustness

You mean the driver core?  That should be a requirement of any Linux
kernel driver today, hardened or not.  So all Linux drivers already meet
this, right?  If not, please let us know and they will be fixed.

> o Hardening with event logging

See the above comment about RAS.

> o Hardening with diagnostics

Ah, but most hardware does not support diagnostics.  What do you do
suggest be done for this?

> o Hardening with resource monitoring and statistics

The middle management layer, right?  I'll get into my response of this
once I've gone over the spec.

> We've also identified some key areas we feel are most critical
> to overall system stability and plan to focus initial hardening 
> efforts on drivers for network interface cards, physical storage, 
> and logical storage.

In a quick look at your example code and documentation, this is all for
the 2.4 kernel.  As the 2.5 deadline is almost a month away, do you have
any intention of trying to get these features and layers into the 2.5
kernel?  And if not, are you willing to wait until the 2.7 kernel is
opened up?

That's probably enough questions for now :)

thanks,

greg k-h
