Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUDWUJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUDWUJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUDWUJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:09:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:3015 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261244AbUDWUJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:09:45 -0400
Date: Fri, 23 Apr 2004 13:07:51 -0700
From: Greg KH <greg@kroah.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: lhcs-devel@lists.sourceforge.net, lhms-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net,
       pcihpd-discuss@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-largesys-devel@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [RFC] New sysfs tree for hotplug
Message-ID: <20040423200751.GA7990@kroah.com>
References: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com> <20040416223436.GB21701@kroah.com> <20040423211816.152dc326.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423211816.152dc326.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 09:18:16PM +0900, Keiichiro Tokunaga wrote:
> Greg KH wrote:
> > > 2. Problem
> > 
> > There is no problem :)
> > 
> > >  Recent large machines have many PCI devices and some boards that
> > > contain devices (e.g. CPU, memory, and/or I/O devices).  A certain PCI
> > > device (PCI1) might be connected with other one (PCI2), which means that
> > > there is a dependency between PCI1 and PCI2.
> > 
> > You have this today?  On what platform?  This is the first I have heard
> > of this.  If needed, we can merely change the pci hotplug core to allow
> > a hierarchy of pci slots.  Will that solve your problem?
> 
> 
> I meant that a P2P bridge (that has hotpluggable slots) and a PCI device would
> have such a dependency.

But you don't need to show that for any reason, right?   Today, pci
slots behind a pluggable P2P bridge work just fine.  I can remove the
entire drawer full of pci slots and they all go away properly, and if I
add a new drawer of pci slots, they all show up.

Why do you want to show that hierarchy?  Who cares about it?

> As you suggeted, if the PCI hotplug core is changed that way, the
> dependency would be represented in sysfs quite well:)

I don't think the PCI Hotplug core needs to change today to support
these kinds of devices based on the hardware I have seen.  I have spoken
to some people from other companies, and they also agree with me.  But
if you have some different kind of hardware that really needs this, I'm
open to ideas.

> However, a board that contains CPU, memory and/or I/O devices still
> doesn't have a directory in sysfs to represent dependencies...

Why would it need to?

Right now you can determine the CPU that a pci bus is attached to
through sysfs.  As for the CPU and memory depiction, talk to the NUMA
developers.  They have been trying for years now to come up with a way
to do this in a portable and proper manner, and so far have failed :(

> 
> That's right.  /sys/devices/hotplug/ACPI/ tree becomes hard-wired one.  I was
> thinking to define the board by using ACPI (as a "generic container device" in
> ACPI namespace).  Therefore, if there is the new tree I proposed in the kernel,
> it would be easy to represent the hierarchy, and a directory for the board
> appears in the new tree.  So I thought that we could put an control file to
> invoke the board hotplug and an information file under the directory.
> (Actually, I've made a rough patch for the new tree and it seems to work fine:)

Patches are better seen than spoken about in the abstract :)  Please
post them if you have them...

> I also thought that interface for hotplug could be unified so that it would become
> easier for user to use.

But the user doesn't care about ACPI.  Actually they want nothing to do
with ACPI namespaces :)  They just want to be able to add and remove
their different devices, be them memory, cpus, or pci slots, right?

I'd point you to the recent ACPI sysfs patches on linux-kernel for more
information on what people are trying to do in that area.

> However, it's a hard-wired way and the current sysfs trees work fine for all of
> devices as you mentioned.  Now I have just one thing necessary to sysfs.
> That's a directory and files for the board.  Should I abstract the "board" and
> introduce a new directory for board under /sys/devices/system/, like NUMA
> node directory? (e.g. /sys/devices/system/board/)  The control file, the
> information file, and etc could be created under the directory, like
> /sys/devices/hotplug/board/board0/eject.  If it's possible, there might be less
> impact to the kernel.  I'd appreciate it if you would comment on this :)

But writing to that "eject" file would not be able to go and turn off
the different CPU's, memory sticks, and pci slots, right?  That still
needs to be done from userspace.

thanks,

greg k-h
