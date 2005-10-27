Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVJ0REm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVJ0REm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVJ0REl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:04:41 -0400
Received: from colo.lackof.org ([198.49.126.79]:7585 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751087AbVJ0REl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:04:41 -0400
Date: Thu, 27 Oct 2005 11:11:55 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, mst@mellanox.co.il,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20051027171155.GA7258@colo.lackof.org>
References: <524q799p2t.fsf@cisco.com> <20051022233220.GA1463@parisc-linux.org> <52hdb3yp36.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52hdb3yp36.fsf@cisco.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 08:08:45AM -0700, Roland Dreier wrote:
>     Matthew> Perhaps the right thing to do is to change pad2 (in
>     Matthew> struct pci_bus) to bus_flags and make bit 0
>     Matthew> PCI_BRIDGE_FLAGS_NO_MSI ?
> 
> Seems reasonable, but I'm still not sure how to implement this.  Where
> does this bit get set and propagated to secondary buses?

Does it have to be propagate to secondary busses?
Can't the MSI init code walk up the tree until it hits a root node?


> To give a somewhat pathological real-world example, Mellanox PCI-X
> adapters have a PCI bridge in them; in other words, a single adapter
> looks like:
...
> Also, if someone hot-plugged such an adapter into a bus below an AMD
> 8131 host bridge (I believe eg Sun V40Zs have hot-pluggable slots like
> that), then the NO_MSI flag still needs to get propagated from the
> 8131 bridge to the Mellanox bridge and set no_msi on the final device.
> 
> Where in the PCI driver code is the right place to handle all this (I
> hope by writing the code only once)?

I expect this could be contained in msi.c.
ie changes to msi_init(), pci_enable_msi(), msi_capability_init().

The flag would have to be set by whatever code claims the AMD 8131
chip.

hth,
grant
