Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUB0WXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbUB0WXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:23:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:45755 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263167AbUB0WW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:22:57 -0500
Subject: Re: ppc64: fix non-iSeries build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200402271911.i1RJBhnA031450@hera.kernel.org>
References: <200402271911.i1RJBhnA031450@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1077920035.23344.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 09:13:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Nru a/arch/ppc64/kernel/iSeries_iommu.c b/arch/ppc64/kernel/iSeries_iommu.c
> --- a/arch/ppc64/kernel/iSeries_iommu.c	Fri Feb 27 11:11:47 2004
> +++ b/arch/ppc64/kernel/iSeries_iommu.c	Fri Feb 27 11:11:47 2004
> @@ -58,8 +58,16 @@
>  static struct pci_dev _veth_dev = { .sysdata = &veth_dev_node };
>  static struct pci_dev _vio_dev  = { .sysdata = &vio_dev_node, .dev.bus = &pci_bus_type  };
>  
> +/*
> + * I wonder what the deal is with these.  Nobody uses them.  Why do they
> + * exist? Why do we export them to modules? Why is this comment here, and
> + * why didn't I just delete them?
> + */

They are, I think, used by iSeries virtual ethernet & virtual disk
drivers. I'll heck with Stephen on monday what's up exactly.
 
Note, there's also that small hash table management fix for iSeries
that i posted yesterday that should get in. Withiout it, iSeries will
blow up on moderate load rather quickly.

Ben.

