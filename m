Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVG3Auj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVG3Auj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVG2TSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:18:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:19119 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262757AbVG2TRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:01 -0400
Date: Fri, 29 Jul 2005 12:16:27 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, galak@freescale.com
Subject: [patch 16/29] PCI: fix up errors after dma bursting patch and CONFIG_PCI=n -- bug?
Message-ID: <20050729191627.GR5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kumar Gala <galak@freescale.com>

In the patch from:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0506.3/0985.html

Is the the following line suppose inside the if CONFIG_PCI=n

  #define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/pci.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--- gregkh-2.6.orig/include/linux/pci.h	2005-07-29 11:29:50.000000000 -0700
+++ gregkh-2.6/include/linux/pci.h	2005-07-29 11:36:24.000000000 -0700
@@ -971,6 +971,8 @@
 
 #define	isa_bridge	((struct pci_dev *)NULL)
 
+#define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
+
 #else
 
 /*
@@ -985,9 +987,6 @@
 	return 0;
 }
 #endif
-
-#define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
-
 #endif /* !CONFIG_PCI */
 
 /* these helpers provide future and backwards compatibility

--
