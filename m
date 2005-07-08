Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVGHVdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVGHVdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVGHVZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:25:50 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:65412 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262892AbVGHVZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:25:31 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12.2 -- time passes faster; related to the
	acpi_register_gsi() call
From: Alexander Nyberg <alexn@telia.com>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050708211203.GC382@ss1000.ms.mff.cuni.cz>
References: <20050708211203.GC382@ss1000.ms.mff.cuni.cz>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 23:25:08 +0200
Message-Id: <1120857908.25294.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre 2005-07-08 klockan 23:12 +0200 skrev Rudo Thomas:
> Hello, guys.
> 
> Time started to pass faster with 2.6.12.2 (actually, it was 2.6.12-ck3
> which is based on it). I have isolated the cause of the problem:

I bet you this fixes it (already in mainline)

tree e6a38b3d6bf434f08054562113bb660c4227769f
parent 4a89a04f1ee21a7c1f4413f1ad7dcfac50ff9b63
author Linus Torvalds <torvalds@g5.osdl.org> Sun, 03 Jul 2005 00:35:33 -0700
committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 03 Jul 2005 00:35:33 -0700

If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.

That zero just means that nothing else found any irq information either.

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


