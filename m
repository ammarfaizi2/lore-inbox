Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWFUNtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWFUNtb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWFUNtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:49:31 -0400
Received: from mail.gmx.net ([213.165.64.21]:50372 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750768AbWFUNta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:49:30 -0400
X-Authenticated: #704063
Subject: [Patch] Missing return in drivers/net/wan/pci200syn.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: khc@pm.waw.pl
Content-Type: text/plain
Date: Wed, 21 Jun 2006 15:49:27 +0200
Message-Id: <1150897767.306.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

if card->plxbase == NULL we call the cleanup function
pci200_pci_remove_one() but continue initializing
the driver and dereferencing the pointer. This
was found by coverity (bug id #195)

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/net/wan/pci200syn.c.orig	2006-06-21 15:45:52.000000000 +0200
+++ linux-2.6.17-git2/drivers/net/wan/pci200syn.c	2006-06-21 15:46:12.000000000 +0200
@@ -358,6 +358,7 @@ static int __devinit pci200_pci_init_one
 	    card->rambase == NULL) {
 		printk(KERN_ERR "pci200syn: ioremap() failed\n");
 		pci200_pci_remove_one(pdev);
+		return -EFAULT;
 	}
 
 	/* Reset PLX */


