Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWIOQy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWIOQy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWIOQy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:54:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbWIOQyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:54:25 -0400
Date: Fri, 15 Sep 2006 09:54:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] piix: Use refcounted interface when searching for a
 450NX
Message-Id: <20060915095409.d0171431.akpm@osdl.org>
In-Reply-To: <1158329678.29932.41.camel@localhost.localdomain>
References: <1158329678.29932.41.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 15:14:38 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Simple conversion
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c
> --- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-11 17:00:09.000000000 +0100
> +++ linux-2.6.18-rc6-mm1/drivers/ide/pci/piix.c	2006-09-14 17:19:12.000000000 +0100
> @@ -602,7 +602,7 @@
>  	struct pci_dev *pdev = NULL;
>  	u16 cfg;
>  	u8 rev;
> -	while((pdev=pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
> +	while((pdev=pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev))!=NULL)
>  	{
>  		/* Look for 450NX PXB. Check for problem configurations
>  		   A PCI quirk checks bit 6 already */

fwiw, I have an ad450nx server upon which I occasionally test kernels.
