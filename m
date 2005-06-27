Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVF0XKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVF0XKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVF0XJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:09:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262081AbVF0XGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:06:09 -0400
Date: Mon, 27 Jun 2005 16:03:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       Randy Dunlap <rdunlap@xenotime.net>, torvalds@osdl.org,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       jgarzik@pobox.com
Subject: [06/07] ACPI: Make sure we call acpi_register_gsi() even for default PCI interrupt assignment
Message-ID: <20050627230329.GO9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


From: Linus Torvalds <torvalds@ppc970.osdl.org>

ACPI: Make sure we call acpi_register_gsi() even for default PCI interrupt assignment

That's the part that keeps track of the ELCR register, and we want to
make sure that the PCI interrupts are properly marked level/low.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 drivers/acpi/pci_irq.c |    1 +
 1 files changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -435,6 +435,7 @@ acpi_pci_irq_enable (
 		/* Interrupt Line values above 0xF are forbidden */
 		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
+			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
 			return_VALUE(0);
 		}
 		else {
