Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbVJ0XHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbVJ0XHQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVJ0XHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:07:16 -0400
Received: from fmr23.intel.com ([143.183.121.15]:58786 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932681AbVJ0XHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:07:15 -0400
Date: Thu, 27 Oct 2005 16:06:59 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
Subject: Re: [patch 1/3] pci: store PCI_INTERRUPT_PIN in pci_dev
Message-ID: <20051027160658.A9674@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20051027192603.488616000@whizzy> <1130441409.5996.24.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1130441409.5996.24.camel@whizzy>; from kristen.c.accardi@intel.com on Thu, Oct 27, 2005 at 12:30:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 12:30:09PM -0700, Kristen Accardi wrote:
> --- linux-2.6.13.orig/drivers/pci/probe.c
> +++ linux-2.6.13/drivers/pci/probe.c
> @@ -571,6 +571,7 @@ static void pci_read_irq(struct pci_dev 
>  	unsigned char irq;
>  
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
> +	dev->pin = irq;

pci_read_irq() is not called for PCI bridges, but some of them
may need an interrupt (e.g. for shpchp, pciehp). Did you check
if this patchset broke such bridges? You should call this
function for PCI bridges too.

Rajesh

