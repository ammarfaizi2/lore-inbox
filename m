Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWBQAJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWBQAJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWBQAJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:09:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:47811
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750813AbWBQAJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:09:46 -0500
Date: Thu, 16 Feb 2006 16:09:27 -0800
From: Greg KH <greg@kroah.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20060217000927.GA22149@kroah.com>
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214165222.GC12974@mellanox.co.il>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 06:52:22PM +0200, Michael S. Tsirkin wrote:
> Quoting r. Roland Dreier <rolandd@cisco.com>:
> > Subject: AMD 8131 and MSI quirk
> > 
> > The current quirk_amd_8131_ioapic() function sets a global
> > pci_msi_quirk flag, which disables MSI/MSI-X for all devices in the
> > system.  This is safe but suboptimal, because there may be devices on
> > other buses not related to the AMD 8131 bridge, for which MSI would
> > work fine.  As an example, see the end of this email for a lspci -t
> > from a real Opteron system that has PCI-X buses coming from an AMD
> > 8131 and PCI Express buses coming from an Nforce4 bridge -- MSI works
> > fine for the Mellanox InfiniBand adapter on the PCIe bus, if we allow
> > it to be enabled.
> 
> The following should do this IMO. Roland, could you test this patch please?
> 
> ---
> 
> It turns out AMD 8131 quirk only affects MSI for devices behind the 8131 bridge.
> Handle this by adding a flags field in pci_bus, inherited from parent to child.
> 
> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Roland, did you ever verify that this patch worked or not for you?

thanks,

greg k-h
