Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270688AbTGNRgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTGNRgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:36:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:40599 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270688AbTGNRfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:35:39 -0400
Date: Mon, 14 Jul 2003 10:38:13 -0700
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /proc/bus/pci* changes
Message-ID: <20030714173812.GA24142@kroah.com>
References: <1058154708.747.1391.camel@cube> <20030714045304.GB19392@kroah.com> <1058161200.749.1454.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058161200.749.1454.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 01:40:01AM -0400, Albert Cahalan wrote:
> 
> The directory structure may well be finished,
> at least until it is time to remove the old
> interfaces. (in a few years I guess)
> 
> What's missing is the ability to pass cache-control
> info through the mmap() interface. This is useful
> for non-PCI purposes as well. Some thought will be
> required, as there is a set of commonly useful
> settings among all the arch-specific features.

Why would userspace want to do this?  Any examples?

> > And are you prepared to patch all of
> > the userspace programs that currently rely on the existing interface
> > (like XFree86 for one)?
> 
> The existing interface STILL WORKS. Apps can
> transition over time, in part or in whole.
> ("in part" meaning to use the old hacks on
> the new pathname, gaining PCI domain support)
> 
> It's important to get the new interface in
> ASAP, so that all the obscure (in-house, etc.)
> user-space drivers can start to transition.
> The X server is less of a worry, because it
> is a very active project.
> 
> > Also, I don't think you are handling the pci domain space in your patch,
> > or am I just missing it?
> 
> You missed it: third paragraph, first email
> 
> Example:
> You have two devices with the same bus
> number (5), device number (4), and function
> number (2). One is in domain 0, and the
> other is in domain 42. You get:
> 
> pci0/bus5/dev4/fn2/config-space
> pci42/bus5/dev4/fn2/config-space
> 
> Depending on what pci_name_bus does with
> the conflict, you'll get one or two symlinks
> from the old name(s). You'll also get some
> correctly-sized files to represent the
> resources. For example:
> 
> pci0/bus5/dev4/fn2/bar0
> pci0/bus5/dev4/fn2/bar1
> pci0/bus5/dev4/fn2/bar2
> pci42/bus5/dev4/fn2/bar0

Any reason for not using the same sysfs naming scheme to keep things
universal?

> Here's an attachment:

Which can't be quoted :(

Anyway, I really don't like the huge array you are declaring if we have
pci domains.  And I really don't want to apply this until someone shows
me a real use for it.  Maybe we should add mmap functions to sysfs?  :)

thanks,

greg k-h
