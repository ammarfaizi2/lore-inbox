Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWIHSWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWIHSWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWIHSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:22:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751147AbWIHSUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:20:42 -0400
Date: Fri, 8 Sep 2006 11:20:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-Id: <20060908112035.f7a83983.akpm@osdl.org>
In-Reply-To: <20060908031422.GA4549@lists.us.dell.com>
References: <20060908031422.GA4549@lists.us.dell.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 22:14:22 -0500
Matt Domsch <Matt_Domsch@dell.com> wrote:

> @@ -189,6 +189,8 @@ static int __init pcibios_init(void)
>  
>  	pcibios_resource_survey();
>  
> +	if (!(pci_probe & PCI_NO_SORT))
> +		pci_sort_breadthfirst();
>
> ...
>
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1055,3 +1055,95 @@ EXPORT_SYMBOL(pci_scan_bridge);
>  EXPORT_SYMBOL(pci_scan_single_device);
>  EXPORT_SYMBOL_GPL(pci_scan_child_bus);
>  #endif
> +
> +static int pci_sort_bf_cmp(const struct pci_dev *a, const struct pci_dev *b)
> +static void pci_insertion_sort_klist(struct pci_dev *a, struct list_head *list,
> +static void pci_sort_breadthfirst_klist(void)
> +static void pci_insertion_sort_devices(struct pci_dev *a, struct list_head *list,
> +static void pci_sort_breadthfirst_devices(void)
> +void pci_sort_breadthfirst(void)

I think all these functions can+should be __init?

> +extern void pci_sort_breadthfirst(void);

In which case this needs the __init tag too (new rule, due to frv (at least)).
