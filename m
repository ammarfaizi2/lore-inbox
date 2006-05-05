Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWEEW3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWEEW3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWEEW3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:29:21 -0400
Received: from mail.suse.de ([195.135.220.2]:7600 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932348AbWEEW3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:29:20 -0400
Date: Fri, 5 May 2006 15:27:38 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060505222738.GA8985@kroah.com>
References: <mj+md-20060504.211425.25445.atrey@ucw.cz> <1146778197.27727.26.camel@localhost.localdomain> <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com> <1146784923.4581.3.camel@localhost.localdomain> <445BA584.40309@us.ibm.com> <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com> <20060505202603.GB6413@kroah.com> <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com> <20060505210614.GB7365@kroah.com> <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 05:15:02PM -0400, Jon Smirl wrote:
> On 5/5/06, Greg KH <greg@kroah.com> wrote:
> >On Fri, May 05, 2006 at 04:35:17PM -0400, Jon Smirl wrote:
> >> On 5/5/06, Greg KH <greg@kroah.com> wrote:
> >> >On Fri, May 05, 2006 at 04:14:00PM -0400, Jon Smirl wrote:
> >> >> I would like to see other design alternatives considered on this
> >> >> issue. The 'enable' attribute has a clear problem in that you can't
> >> >> tell which user space program is trying to control the device.
> >> >> Multiple programs accessing the video hardware with poor coordination
> >> >> is already the source of many problems.
> >> >
> >> >Who cares who "enabled" the device.  Remember, the majority of PCI
> >> >devices in the system are not video ones.  Lots of other types of
> >> >devices want this ability to enable PCI devices from userspace.  I've
> >> >been talking with some people about how to properly write PCI drivers in
> >> >userspace, and this attribute is a needed part of it.
> >>
> >> User space program enables the device.
> >> Next I load a device driver
> >> next I rmmod the device driver and it disables the device
> >> user space program trys to use the device
> >> No coordination and user space program faults
> >
> >Gun.  Foot.  Shoot.
> 
> Why do we want to create problem like this when there is a simple
> solution to preventing them. All it takes is a couple of rules:
> 
> 1) To use a device it must have a device driver. It may be as simple
> as a couple of lines of code. This driver will cause a device node to
> be created.
> 
> 2) If a user app want to use the device it opens the device node.
> 
> This builds a system where everybody knows what is going on. The
> driver knows that user space is using the device. Multiple user space
> users are blocked from conflicting because of the open. There is no
> way to shoot yourself in the foot.

That sounds like a nice way to mediate userspace usages of PCI devices,
yes.  Much like a dot lockfile is done for tty devices today, all in
userspace (which hints that this too can be done in userspace with no
kernel involvement...)

But it still has nothing to do with this enable sysfs file :)

thanks,

greg k-h
