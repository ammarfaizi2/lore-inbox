Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbUCSSoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUCSSoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:44:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:19627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263076AbUCSSoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:44:09 -0500
Date: Fri, 19 Mar 2004 09:59:57 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting physical topology information
Message-ID: <20040319175957.GB10432@kroah.com>
References: <20040317213714.GD23195@localhost> <20040318232139.GA17586@kroah.com> <200403190951.52899.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403190951.52899.jbarnes@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 09:51:52AM -0800, Jesse Barnes wrote:
> On Thursday 18 March 2004 3:21 pm, Greg KH wrote:
> > > If we could physically locate a PCI bus, then it would be much easier
> > > to (for example) locate our defective SCSI disk that is target4 on the
> > > SCSI controller that is on pci bus 0000:20.
> > 
> > Um, what's wrong with the current /sys/class/pci_bus/*/cpuaffinity files
> > for determining this topology information?  That is why it was added.
> 
> Nothing, except that it only provides logical information.  In a large
> system, it's really useful to be able to physically locate a component
> somehow.  That was the idea behind adding 'physid'.  For example:
> 
> [jbarnes@spamtin pci0000:02]$ pwd
> /sys/devices/pci0000:02
> [jbarnes@spamtin pci0000:02]$ cat physid
> rack: 5
> module: 12
> slot: 3

Hm, that looks to violate the "one value per file" mandate of sysfs,
right?  Right now PCI Hotplug slots have a LED on them that you can
flash from userspace to help locate the physical slot that you want to
change.  I also know of large PCI drawers that have LEDs that flash to
locate them.

Also, this is _very_ hardware/platform specific.  If you want to try to
implement this, I'd be interested in what the patch would look like.

thanks,

greg k-h
