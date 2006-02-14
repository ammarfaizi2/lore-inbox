Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWBNQ4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWBNQ4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWBNQ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:56:04 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:28102 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1422652AbWBNQ4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:56:03 -0500
Date: Tue, 14 Feb 2006 09:56:01 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20060214165601.GM12822@parisc-linux.org>
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214165222.GC12974@mellanox.co.il>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 06:52:22PM +0200, Michael S. Tsirkin wrote:
> The following should do this IMO. Roland, could you test this patch please?

Going a bit overboard on the type safety.  Please, leave bus_flags as an
unsigned short so as not to bloat the pci_bus structure unnecessarily.

> +typedef unsigned short __bitwise pci_bus_flags_t;
> +enum pci_bus_flags {
> +	PCI_BUS_FLAGS_NO_MSI = (pci_bus_flags_t) 1,
> +};
> +
>  /*
>   * The pci_dev structure is used to describe PCI devices.
>   */
> @@ -203,7 +208,7 @@ struct pci_bus {
>  	char		name[48];
>  
>  	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
> -	unsigned short  pad2;
> +	pci_bus_flags_t bus_flags;	/* Inherited by child busses */
>  	struct device		*bridge;
