Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTFKOeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTFKOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:34:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36565 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262148AbTFKOeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:34:19 -0400
Date: Wed, 11 Jun 2003 15:48:01 +0100
From: Matthew Wilcox <willy@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk>
References: <1055341842.754.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055341842.754.3.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 04:30:42PM +0200, Benjamin Herrenschmidt wrote:
> The new pci_domain_nr() is good for adding the PCI domain number to
> the /sys/devices/pciN/* names, but I think that's not the proper
> representation. It should really be
> 
>   /sys/devices/pci-domainN/pciN/*
> 
> So we can pave the way for when we'll stop play bus number tricks and
> actually have overlapping PCI bus numbers between domains. (I don't plan
> to do that immediately because that would break userland & /proc/bus/pci
> backward compatiblity)
> 
> What do you think ?

I don't think sysfs works like that (please correct me if I've
misunderstood, mochel..)

Look in /sys/bus/pci/devices/  There you have all the PCI devices
lumped together in one place, and we obviously need the domain number
in the name.  I don't know where the 0 on the end of /sys/devices/pci0/
comes from, but if we could, I wouldn't say no to:

/sys/devices/pciDDDD/DDDD:BB:SS.F
or
/sys/devices/pciDDDD:BB/DDDD:BB:SS.F
(Domain,Bus,Slot,Func)

I don't think the extra level of hierarchy in your suggestion is necessary
or particularly desirable.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
