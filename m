Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSFZESY>; Wed, 26 Jun 2002 00:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316195AbSFZESX>; Wed, 26 Jun 2002 00:18:23 -0400
Received: from gold.Math.Berkeley.EDU ([169.229.58.61]:2452 "EHLO
	Math.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S316187AbSFZESW>; Wed, 26 Jun 2002 00:18:22 -0400
From: Paul Vojta <vojta@Math.Berkeley.EDU>
Date: Tue, 25 Jun 2002 21:18:20 -0700 (PDT)
Message-Id: <200206260418.VAA10648@blue3.math.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Subject: [patch] fix .text.exit error in dmfe.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks:

When I compile dmfe.o statically into the 2.5.24 kernel, I get:

drivers/built-in.o(.data+0xba34): undefined reference to `local symbols in discarded section .text.exit'

The following patch seems to fix the problem:

--- drivers/net/tulip/dmfe.c	Thu Jun 20 15:53:56 2002
+++ drivers/net/tulip/dmfe.c.new	Tue Jun 25 20:50:57 2002
@@ -461,7 +461,7 @@
 }
 
 
-static void __exit dmfe_remove_one (struct pci_dev *pdev)
+static void __devexit dmfe_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct dmfe_board_info *db = dev->priv;


I'm not (usually) a kernel hacker; I'm just mimicking what others are doing
to fix similar errors.  However, it is working for me right now.

--Paul Vojta, vojta@math.berkeley.edu
