Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUJNOcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUJNOcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUJNOaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:30:11 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:33926 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265331AbUJNO1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:27:25 -0400
Date: Thu, 14 Oct 2004 18:27:04 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041014182704.A13971@jurassic.park.msu.ru>
References: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Thu, Oct 14, 2004 at 01:47:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 01:47:37PM +0100, Matthew Wilcox wrote:
> Some machines have a different address space on the PCI bus from the
> CPU's bus.  This is currently fixed up in pcibios_fixup_bus().  However,
> this is not called for hotplug devices.  Calling pcibios_fixup_bus() when
> a device is hotplugged onto a bus is also wrong as it would attempt to
> fixup devices that have already been fixed up with potentially horrific
> consequences.

This logic makes sense only if you have sort of firmware which
properly initializes the hotplug devices, so I think that the fixup
should belong in that particular hotplug driver (or architecture).
In general case the newly inserted device will have 0s in the BARs,
so there is no point for bus to CPU conversion. You have to use
pci_assign_resource() which does know about different address
spaces.

> This patch teaches the generic PCI layer that there may be different
> address spaces, and converts from bus views to cpu views when reading
> from BARs.  Some drivers (eg sym2, acpiphp) need to go back the other
> way, so it also introduces the inverse operation.

This one already exists - pcibios_resource_to_bus().

Ivan.
