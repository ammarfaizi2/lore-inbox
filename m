Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUJVVoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUJVVoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUJVVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:42:04 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:47780
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267746AbUJVVgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:36:03 -0400
Subject: [PATCH] rtl8139too.c: Fix missing pci_disable_dev
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 22 Oct 2004 23:28:00 +0200
Message-Id: <1098480480.3306.53.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple fix to make pci_enable/disable symetric and avoid the warning on
module unload.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff -urN --exclude='*~' 2.6.9-mm1-U10/drivers/net/8139too.c
2.6.9-mm1-U10.work/drivers/net/8139too.c
--- 2.6.9-mm1-U10/drivers/net/8139too.c	2004-10-22 19:10:44.000000000
+0200
+++ 2.6.9-mm1-U10.work/drivers/net/8139too.c	2004-10-22
21:52:19.000000000 +0200
@@ -749,7 +749,7 @@
 	pci_release_regions (pdev);
 
 	free_netdev(dev);
-
+	pci_disable_device(pdev);
 	pci_set_drvdata (pdev, NULL);
 }
 


