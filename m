Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUIXF5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUIXF5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUIXFyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:54:45 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:22516 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S268470AbUIXFwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:52:33 -0400
Date: Fri, 24 Sep 2004 14:52:29 +0900 (JST)
Message-Id: <20040924.145229.108814142.t-kochi@bq.jp.nec.com>
To: kaneshige.kenji@jp.fujitsu.com
Cc: bjorn.helgaas@hp.com, acpi-devel@lists.sourceforge.net,
       kaneshige.kenji@soft.fujitsu.com, akpm@osdl.org, greg@kroah.com,
       len.brown@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [ACPI] [PATCH] PCI IRQ resource deallocation support [2/3]
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
In-Reply-To: <4150D458.3050400@jp.fujitsu.com>
References: <414FEBDB.2050201@soft.fujitsu.com>
	<200409210857.59457.bjorn.helgaas@hp.com>
	<4150D458.3050400@jp.fujitsu.com>
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] PCI IRQ resource deallocation support [2/3]
Date: Wed, 22 Sep 2004 10:24:40 +0900

> >> +  * dev->irq is cleared by BIOS-assigned IRQ set during boot.
> >> +  */
> >> + pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
> >> + if (irq)
> >> +  pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> >> + dev->irq = irq;
> > 
> > Why do we need to fiddle with dev->irq?  I think it should
> > just be undefined after acpi_pci_irq_disable().
> 
> I had been considering what the "undefined dev->irq" was.
> In fact, I had other ideas that was clearing it by zero or
> -1 (0xffffffff). But I didn't know if we can use these values
> as a undefined IRQ number. So I'm clearing it by the value
> which was assigned by PCI core code (pci_read_irq()) before
> acpi_pci_irq_enable() was called. 

I think it has little sense in restoring value from the configuration
space to dev->irq or clearing it.

If we do preventive programming, it may be worth
trying to define some magic constant (e.g. PCI_UNDEFINED_IRQ) and
panic/BUG when the irq is being enabled.
Otherwise, leaving dev->irq as it is would be ok.

---
Takayoshi Kochi <t-kochi@bq.jp.nec.com>
