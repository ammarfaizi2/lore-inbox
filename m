Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWHQOrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWHQOrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWHQOrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:47:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:13746 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965082AbWHQOrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:47:09 -0400
Message-ID: <44E48162.1050104@pobox.com>
Date: Thu, 17 Aug 2006 10:46:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 3/6] IP100A Remove CONFIG_SUNDANCE_MMIO, mask of mapping
 address
References: <1155841561.4532.13.camel@localhost.localdomain>
In-Reply-To: <1155841561.4532.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> -/* Work-around for Kendin chip bugs. */
> -#ifndef CONFIG_SUNDANCE_MMIO
> -#define USE_IO_OPS 1
> -#endif

Why?  This simply eliminates the ability of the user to set the driver 
configuration at Kconfig time, requiring them to edit the driver to 
achieve the same functionality.


> @@ -491,10 +487,13 @@ #endif
>  	if (pci_request_regions(pdev, DRV_NAME))
>  		goto err_out_netdev;
>  
> -	ioaddr = pci_iomap(pdev, bar, netdev_io_size);
> +	ioaddr =(void __iomem *)
> +		 ((unsigned long)pci_iomap(pdev, bar, netdev_io_size) & 
> +	          0xffffff80);

NAK, this is very wrong.  pci_iomap() returns a "cookie", which you are 
not allowed to modify in any way.

	Jeff


