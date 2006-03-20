Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWCTToo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWCTToo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWCTToo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:44:44 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:46286 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964858AbWCTTon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:44:43 -0500
Date: Mon, 20 Mar 2006 12:44:41 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Mark Maule <maule@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, gregkh@suse.de,
       akpm@osdl.org, j-nomura@ce.jp.nec.com
Subject: Re: [PATCH 2.6.16-rc6-mm1] fix ia64 MSI build problems
Message-ID: <20060320194441.GK8980@parisc-linux.org>
References: <20060320193638.GH31238@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320193638.GH31238@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:36:38PM -0600, Mark Maule wrote:
> Index: maule/drivers/pci/Makefile
> ===================================================================
> --- maule.orig/drivers/pci/Makefile	2006-03-20 11:07:30.602099680 -0600
> +++ maule/drivers/pci/Makefile	2006-03-20 11:08:08.130604825 -0600
> @@ -26,7 +26,19 @@
>  obj-$(CONFIG_PPC64) += setup-bus.o
>  obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
>  obj-$(CONFIG_X86_VISWS) += setup-irq.o
> -obj-$(CONFIG_PCI_MSI) += msi.o msi-apic.o
> +
> +ifdef CONFIG_PCI_MSI
> +obj-y += msi.o msi-apic.o
> +
> +ifdef CONFIG_IA64_GENERIC
> +obj-y += msi-altix.o
> +else
> +ifdef CONFIG_IA64_SGI_SN2
> +obj-y += msi-altix.o
> +endif
> +endif
> +
> +endif #CONFIG_PCI_MSI

The right way to do this kind of Makefile jiggery-pokery is:

msi-y := msi.o msi-apic.o
msi-$(CONFIG_IA64_GENERIC) += msi-altix.o
msi-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
obj-$(CONFIG_PCI_MSI) += $(msi-y)

yay for declarative programming ;-)
