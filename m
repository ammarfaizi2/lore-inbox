Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVGMV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVGMV5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVGMVzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:55:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:29155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262348AbVGMSpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:45:06 -0400
Date: Wed, 13 Jul 2005 11:43:02 -0700
From: Greg KH <gregkh@suse.de>
To: alexn@telia.com, len.brown@intel.com, acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [01/11] If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
Message-ID: <20050713184302.GE9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resend to get threading correct, sorry]

-stable review patch.  If anyone has any objections, please let us know.

------------------

If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
That zero just means that nothing else found any irq information either.

Fixes http://bugme.osdl.org/show_bug.cgi?id=4824

Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/acpi/pci_irq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12.2.orig/drivers/acpi/pci_irq.c	2005-07-13 10:53:01.000000000 -0700
+++ linux-2.6.12.2/drivers/acpi/pci_irq.c	2005-07-13 10:56:30.000000000 -0700
@@ -433,7 +433,7 @@
 		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
 			pci_name(dev), ('A' + pin));
 		/* Interrupt Line values above 0xF are forbidden */
-		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
+		if (dev->irq > 0 && (dev->irq <= 0xF)) {
 			printk(" - using IRQ %d\n", dev->irq);
 			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
 			return_VALUE(0);
