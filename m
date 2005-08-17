Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVHQA2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVHQA2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVHQA2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:28:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbVHQA2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:28:34 -0400
Date: Tue, 16 Aug 2005 17:27:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] PCI: fix quirk-6700-fix.patch
Message-Id: <20050816172711.56a67c43.akpm@osdl.org>
In-Reply-To: <20050816221605.GD28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
	<20050816221605.GD28619@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@suse.de> wrote:
>
> From: Andrew Morton <akpm@osdl.org>
> 
> drivers/built-in.o(.text+0x32c3): In function `quirk_pcie_pxh':
> /usr/src/25/drivers/pci/quirks.c:1312: undefined reference to `disable_msi_mode'
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/pci/pci.h |    6 ++++++
>  1 files changed, 6 insertions(+)
> 
> --- gregkh-2.6.orig/drivers/pci/pci.h	2005-08-16 14:57:46.000000000 -0700
> +++ gregkh-2.6/drivers/pci/pci.h	2005-08-16 14:57:47.000000000 -0700
> @@ -46,7 +46,13 @@ extern int pci_msi_quirk;
>  #else
>  #define pci_msi_quirk 0
>  #endif
> +
> +#ifdef CONFIG_PCI_MSI
>  void disable_msi_mode(struct pci_dev *dev, int pos, int type);
> +#else
> +static inline void disable_msi_mode(struct pci_dev *dev, int pos, int type) { }
> +#endif
> +
>  extern int pcie_mch_quirk;
>  extern struct device_attribute pci_dev_attrs[];
>  extern struct class_device_attribute class_device_attr_cpuaffinity;
> 

hm.  I normally fold crappy little patches like this into the main patch
before sending it Linuswards.  The submitter gets a mention in the s-o-b
record and perhaps a one-line description if the fix was less than utterly
trivial.

That's one advantage of the patch-scripts/quilt approach: these little
post-facto fixups don't pollute the upstream changelog record.

