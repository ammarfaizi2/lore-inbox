Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWBNUDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWBNUDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422779AbWBNUDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:03:43 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:2226 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1422777AbWBNUDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:03:42 -0500
Date: Tue, 14 Feb 2006 13:03:40 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20060214200340.GN12822@parisc-linux.org>
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il> <adaslqlu76f.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaslqlu76f.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:27:52AM -0800, Roland Dreier wrote:
> Michael, now I'm not sure whether this will work for devices like the
> Mellanox PCI-X HCA, where the HCA device sits below a virtual PCI
> bridge.  In that case we need to propagate the NO_MSI flag from the
> 8131 bridge to the Tavor bridge, right?  And it has to work for
> systems like Sun V40Z where the PCI-X slots are hot-swappable (so the
> HCA and its bridge could be added later).

Michael's patch does this:

@@ -347,6 +347,7 @@ pci_alloc_child_bus(struct pci_bus *pare
        child->parent = parent;
        child->ops = parent->ops;
        child->sysdata = parent->sysdata;
+       child->bus_flags = parent->bus_flags;
        child->bridge = get_device(&bridge->dev);

        child->class_dev.class = &pcibus_class;

