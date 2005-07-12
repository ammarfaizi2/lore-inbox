Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVGLUPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVGLUPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGLUPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:15:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262333AbVGLUPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:15:35 -0400
Date: Tue, 12 Jul 2005 13:15:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Tomasz Lemiech <szpajder@staszic.waw.pl>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org, len.brown@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.2 acpi_register_gsi() patch causes problems on Asus A7V333 motherboard
Message-ID: <20050712201519.GB19052@shell0.pdx.osdl.net>
References: <Pine.LNX.4.63.0507121940170.11987@boss.staszic.waw.pl> <20050712182007.GX19052@shell0.pdx.osdl.net> <Pine.LNX.4.63.0507122153110.24219@boss.staszic.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507122153110.24219@boss.staszic.waw.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomasz Lemiech (szpajder@staszic.waw.pl) wrote:
> On Tue, 12 Jul 2005, Chris Wright wrote:
> 
> >>- 2.6.12.2 with acpi_register_gsi() one-line fix works without problems
> 
> My apologies - I meant: "_without_ acpi_register_gsi() one-line fix". That 
> is, _reverting_
> http://www.kernel.org/git/?p=linux/kernel/git/gregkh/linux-2.6.12.y.git;a=commit;h=1ef0867a529b222b8ff659d68140df8d5d6a45f2
> from 2.6.12.2 fixes the problem.

Can you verify that the patch below (w/out reverting that patch, apply
on top of) fixes it for you?

thanks,
-chris
--

---

 drivers/acpi/pci_irq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -433,7 +433,7 @@ acpi_pci_irq_enable (
 		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
+		if (dev->irq > 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
 			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
 			return_VALUE(0);


