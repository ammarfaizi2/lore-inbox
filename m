Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264079AbTJOS5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTJOSzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:55:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61918 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264046AbTJOSuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:50:55 -0400
Date: Wed, 15 Oct 2003 19:50:53 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_get_slot()
Message-ID: <20031015185053.GH16535@parcelfarce.linux.theplanet.co.uk>
References: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk> <20031015184104.GA22373@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015184104.GA22373@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:41:04AM -0700, Greg KH wrote:
> The check of:
> 	if (dev->bus->number == bus && dev->devfn == devfn)
> in pci_find_slot() doesn't check for the domain?

No, it would also need to check pci_domain_nr(dev->bus) .. and it doesn't
have anything to check it against as that information isn't passed into
the function.

> Anyway, is there any other way you can fix this in the tg3 driver only
> for right now?  I agree adding the pci function is "cleaner", but a bit
> late for right now.

The only real way to do it is to inline pci_get_slot() into tg3.  Since I
also have a need for it in sym2, that doesn't seem like a sensible idea.
It would also be racy since it wouldn't take the pci_bus_lock.

> How does this differ from pci_find_slot()?  (becides the pci_dev_get()
> call)?  pci_find_slot() asks for the bus number, which can be determined
> from the pci_bus structure, right?

The pci_bus knows which domain it's in.  We don't have to check it since
we only walk its children.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
