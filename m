Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWD1Epf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWD1Epf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 00:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWD1Epf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 00:45:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751720AbWD1Epe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 00:45:34 -0400
Date: Thu, 27 Apr 2006 21:43:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][UPDATE] PCI: Add pci_assign_resource_fixed -- allow
 fixed address assignments
Message-Id: <20060427214357.4eacd58f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0604272328380.5047-100000@gate.crashing.org>
References: <20060428001758.GA18917@kroah.com>
	<Pine.LNX.4.44.0604272328380.5047-100000@gate.crashing.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@kernel.crashing.org> wrote:
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2329f94..955a96e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -947,6 +947,9 @@ EXPORT_SYMBOL_GPL(pci_intx);
>  EXPORT_SYMBOL(pci_set_dma_mask);
>  EXPORT_SYMBOL(pci_set_consistent_dma_mask);
>  EXPORT_SYMBOL(pci_assign_resource);
> +#ifdef CONFIG_EMBEDDED
> +EXPORT_SYMBOL(pci_assign_resource_fixed);
> +#endif

This is a good argument for putting the export at the definition site ;)

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -496,6 +496,9 @@ int pci_set_dma_mask(struct pci_dev *dev
>  int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
>  void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
>  int pci_assign_resource(struct pci_dev *dev, int i);
> +#ifdef CONFIG_EMBEDDED
> +int pci_assign_resource_fixed(struct pci_dev *dev, int i);
> +#endif

Debatable - if we omit the ifdefs, it fails at link time or depmod time. 
The ifdefs will make it warn (but not fail) at compile-time.  Given that
the warning is non-fatal, the ifdefs don't add much value and are best
omitted.

