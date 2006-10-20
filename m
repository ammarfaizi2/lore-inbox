Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992717AbWJTTRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992717AbWJTTRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992721AbWJTTRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:17:20 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27918 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S2992717AbWJTTRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:17:19 -0400
Date: Fri, 20 Oct 2006 20:17:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: switch to new pci_get_bus_and_slot API
Message-ID: <20061020191711.GD8894@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <1161013790.24237.97.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161013790.24237.97.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 04:49:50PM +0100, Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>

Applied a while back, but just discovered these in the ARM kautobuild
logs...

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c
> --- linux.vanilla-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c	2006-10-13 15:06:14.000000000 +0100
> +++ linux-2.6.19-rc1-mm1/arch/arm/mach-ixp2000/ixdp2400.c	2006-10-13 17:14:23.000000000 +0100
> @@ -133,11 +133,13 @@
>  	struct pci_dev *dev;
>  
>  	if (ixdp2x00_master_npu()) {
> -		dev = pci_find_slot(1, IXDP2400_SLAVE_ENET_DEVFN);
> +		dev = pci_get_bus_and_slot(1, IXDP2400_SLAVE_ENET_DEVFN);
>  		pci_remove_bus_device(dev);
> +		pci_dev_put(dev)

Missing ;

>  	} else {
> -		dev = pci_find_slot(1, IXDP2400_MASTER_ENET_DEVFN);
> +		dev = pci_get_bus_and_slot(1, IXDP2400_MASTER_ENET_DEVFN);
>  		pci_remove_bus_device(dev);
> +		pci_dev_put(dev)

Missing ;

Now fixed in my tree.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
