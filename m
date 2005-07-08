Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVGHUes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVGHUes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVGHUdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:33:50 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:64730 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262821AbVGHU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:28:03 -0400
Date: Fri, 8 Jul 2005 22:27:53 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: Re: 2.6.12-ck3
Message-ID: <20050708202753.GA32317@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>
References: <200506301241.00593.kernel@kolivas.org> <20050704091648.GA14759@ss1000.ms.mff.cuni.cz> <20050707213034.GA9306@ss1000.ms.mff.cuni.cz> <200507081352.55660.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081352.55660.kernel@kolivas.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Time seems to pass very fast with this kernel.
> >
> > Am I the only one who gets this strange behaviour? Kernel's notion of
> > time seems to be about 30 times faster than real time.
> 
> Sorry I really have no idea. If you can retest with latest stable mainline 
> that this kernel is based on (2.6.12.2) and reproduce the problem

The following one-liner (from 2.6.12.2) seems to be the problem:

diff -urN linux-2.6.12-ck2-rudo/drivers/acpi/pci_irq.c linux-2.6.12-ck-rudo/drivers/acpi/pci_irq.c
--- linux-2.6.12-ck2-rudo/drivers/acpi/pci_irq.c        2005-07-08 10:16:53.000000000 +0200
+++ linux-2.6.12-ck-rudo/drivers/acpi/pci_irq.c 2005-07-03 21:06:10.000000000 +0200
@@ -435,6 +435,7 @@
                /* Interrupt Line values above 0xF are forbidden */
                if (dev->irq >= 0 && (dev->irq <= 0xF)) {
                        printk(" - using IRQ %d\n", dev->irq);
+                       acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
                        return_VALUE(0);
                }
                else {

I will report this to the lkml shortly.

Rudo.
