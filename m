Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVJVXcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVJVXcc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJVXcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 19:32:32 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:53122 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751306AbVJVXcc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 19:32:32 -0400
Date: Sat, 22 Oct 2005 17:32:20 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Roland Dreier <rolandd@cisco.com>
Cc: gregkh@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20051022233220.GA1463@parisc-linux.org>
References: <524q799p2t.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524q799p2t.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 03:14:34PM -0700, Roland Dreier wrote:
> The current quirk_amd_8131_ioapic() function sets a global
> pci_msi_quirk flag, which disables MSI/MSI-X for all devices in the
> system.  This is safe but suboptimal, because there may be devices on
> other buses not related to the AMD 8131 bridge, for which MSI would
> work fine.  As an example, see the end of this email for a lspci -t
> from a real Opteron system that has PCI-X buses coming from an AMD
> 8131 and PCI Express buses coming from an Nforce4 bridge -- MSI works
> fine for the Mellanox InfiniBand adapter on the PCIe bus, if we allow
> it to be enabled.
> 
> I guess what we really should be doing is setting the dev->no_msi flag
> for all devices below the AMD 8131 PCI-X bridge rather than turning
> off MSI globally.  Of course this is somewhat tricky, since a device
> could be hotplugged onto a bus below the AMD 8131.  Greg, any thoughts
> about the proper way to use the driver model infrastructure to handle
> this?

Perhaps the right thing to do is to change pad2 (in struct pci_bus) to
bus_flags and make bit 0 PCI_BRIDGE_FLAGS_NO_MSI ?
