Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUHYWQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUHYWQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHYWQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:16:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:17826 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268834AbUHYVNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:13:53 -0400
Date: Wed, 25 Aug 2004 23:13:15 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP kernel 2.6 does not work with my network cards. UP kernel works nice.
Message-ID: <20040825211315.GA31397@electric-eye.fr.zoreil.com>
References: <1093460668.2461.46.camel@genipapo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093460668.2461.46.camel@genipapo>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br> :
[...]
> I am currently not able to use the 2.6 SMP kernel, because the network
> card drivers seem not to be working. UP kernel works fine. I have tried
> the latest www.kernel.org kernel, and is has the same problem as the
> latest Fedora Core 2.

Can you try 2.6.8.1 with the hideous hack below ?

--- linux-2.6.8.1-mm4.orig/drivers/acpi/pci_irq.c	2004-08-25 23:05:18.000000000 +0200
+++ linux-2.6.8.1-mm4/drivers/acpi/pci_irq.c	2004-08-25 23:08:03.000000000 +0200
@@ -360,6 +360,10 @@ acpi_pci_irq_enable (
 	 */
 	if (!irq)
  		irq = acpi_pci_irq_derive(dev, pin, &edge_level, &active_high_low);
+
+	edge_level = ACPI_LEVEL_SENSITIVE;
+	active_high_low = ACPI_ACTIVE_LOW;
+	irq = dev->irq;	
  
 	/*
 	 * No IRQ known to the ACPI subsystem - maybe the BIOS / 
