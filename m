Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTDPPxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTDPPxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:53:03 -0400
Received: from havoc.daloft.com ([64.213.145.173]:7889 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264485AbTDPPxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:53:02 -0400
Date: Wed, 16 Apr 2003 12:04:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: linux-kernel@vger.kernel.org, "Cameron, Steve" <Steve.Cameron@hp.com>
Subject: Re: cciss patches for 2.4.21pre7
Message-ID: <20030416160449.GC13488@gtf.org>
References: <D4CFB69C345C394284E4B78B876C1CF102399B32@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF102399B32@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 10:53:48AM -0500, Miller, Mike (OS Dev) wrote:
> -	for (i=0; i<6; i++) {
> +	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
>  		/* is this an IO range */
>  		if (pdev->resource[i].flags & 0x01) {
>  			c->io_mem_addr = pdev->resource[i].start;
> @@ -2492,6 +2521,7 @@
>  			printk("IO value found base_addr[%d] %lx %lx\n", i,
>  				c->io_mem_addr, c->io_mem_length);
>  #endif /* CCISS_DEBUG */
> +			printk(KERN_DEBUG "IO range: %lx\n", c->io_mem_addr);
>  			/* register the IO range */
>  			if (!request_region( c->io_mem_addr,
>                                          c->io_mem_length, "cciss")) {
> @@ -2511,7 +2541,7 @@
>  	printk("device_id = %x\n", device_id);
>  	printk("command = %x\n", command);
>  	for(i=0; i<6; i++)
> -		printk("addr[%d] = %x\n", i, addr[i]);
> +		printk("addr[%d] = %x\n", i, pdev->resource[i].start);

FWIW, if you care about source compatibility, or just like the
convenient wrappers, you can use

	pci_resource_start(pdev, BAR#)

in place of

	pdev->resource[i].start.

Ditto for .len and pci_resource_len() wrapper.

If you don't care, just ignore this message, the code otherwise looks ok.

	Jeff



