Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTFKO7B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTFKO7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:59:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58583 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262331AbTFKO6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:58:55 -0400
Date: Wed, 11 Jun 2003 16:12:38 +0100
From: Matthew Wilcox <willy@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <willy@debian.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030611151238.GA28581@parcelfarce.linux.theplanet.co.uk>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <1055343980.755.7.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055343980.755.7.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 05:06:20PM +0200, Benjamin Herrenschmidt wrote:
> Looks like nobody really understands it then ;)

Well, it keeps changing ;-)

> > Look in /sys/bus/pci/devices/  There you have all the PCI devices
> > lumped together in one place, and we obviously need the domain number
> > in the name.  I don't know where the 0 on the end of /sys/devices/pci0/
> > comes from, but if we could, I wouldn't say no to:
> 
> Nah, you are mixing up /sys/bus/* which is a flat list of busses in the
> machine, with /sys/devices/* which is the hierarchical device tree.

I'm not mixing them up, I'm just saying that the domain number has to be
part of the leafname.

> It's probably not, then it's a matter of properly renaming the pciN entries
> in /sys/devices to be /sys/devices/pciDD:NN where DD is the domain number
> and NN is the first bus on this domain, or just pciDD (though I like having
> the bus number there as well)

Yep.  Can you find where this happens, because it's not in pci-sysfs.c
where one might logically expect it to be ...

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
