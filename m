Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTISX3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTISX3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:29:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:60061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261799AbTISX3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:29:45 -0400
Date: Fri, 19 Sep 2003 16:29:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI/ACPI related boot hang with 2.6.0-test5-bk3 on KT266A mobo
Message-ID: <20030919162937.B16516@osdlab.pdx.osdl.net>
References: <1063982354.17540.173.camel@tesla.mmt.bellhowell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1063982354.17540.173.camel@tesla.mmt.bellhowell.com>; from jtlayton@poochiereds.net on Fri, Sep 19, 2003 at 10:39:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeffrey Layton (jtlayton@poochiereds.net) wrote:
> 
> I'll happily provide more info or test patches for this if you can tell

Does this patch fix it for you?
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


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
