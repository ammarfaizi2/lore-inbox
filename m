Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbTI3SYj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTI3SYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 14:24:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:5061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261647AbTI3SYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 14:24:36 -0400
Date: Tue, 30 Sep 2003 11:24:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: Martin Pitt <martin@piware.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call traces due to lost IRQ
Message-ID: <20030930112429.A722@osdlab.pdx.osdl.net>
References: <20030930154032.GA795@donald.balu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030930154032.GA795@donald.balu5>; from martin@piware.de on Tue, Sep 30, 2003 at 05:40:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Pitt (martin@piware.de) wrote:
> Hi!
> 
> [1.] Kernel boot yields lost IRQ with some call traces

Can you try the following patch?

===== drivers/acpi/pci_link.c 1.17 vs edited =====
--- 1.17/drivers/acpi/pci_link.c	Sun Aug 31 16:14:25 2003
+++ edited/drivers/acpi/pci_link.c	Tue Sep 16 16:59:46 2003
@@ -456,7 +456,6 @@
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
-	}
 
 		/* 
 		 * Select the best IRQ.  This is done in reverse to promote 
@@ -466,6 +465,7 @@
 			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
 				irq = link->irq.possible[i];
 		}
+	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {

