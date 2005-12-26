Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVLZIx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVLZIx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 03:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVLZIx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 03:53:59 -0500
Received: from mailspool.ops.uunet.co.za ([196.7.0.140]:21258 "EHLO
	mailspool.ops.uunet.co.za") by vger.kernel.org with ESMTP
	id S1751063AbVLZIx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 03:53:59 -0500
From: "Jaco Kroon" <jkroon@kroon.co.za>
Date: Mon, 26 Dec 2005 10:53:11 +0200
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] ati-agp suspend/resume support (try 3)
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Reply-To: jaco@kroon.co.za
Message-Id: <20051226084653.5FAF986F7A@belrog.fns.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the patch at http://unixhead.org/docs/thinkpad/ati-agp/ati-agp.diff, add support for suspend/resume in the ati-agp module.

Signed-of-by: Jaco Kroon <jaco@kroon.co.za>
ACKed-by: Pavel Machek <pavel@suse.cz>

--- linux-2.6.15-rc6/drivers/char/agp/ati-agp.c.orig	2005-12-25 22:21:32.000000000 +0200
+++ linux-2.6.15-rc6/drivers/char/agp/ati-agp.c	2005-12-26 06:47:26.000000000 +0200
@@ -243,6 +243,10 @@
 	return 0;
 }
 
+static int agp_ati_resume(struct pci_dev *dev)
+{
+	return ati_configure();
+}
 
 /*
  *Since we don't need contigious memory we just try
@@ -525,6 +529,7 @@
 	.id_table	= agp_ati_pci_table,
 	.probe		= agp_ati_probe,
 	.remove		= agp_ati_remove,
+	.resume		= agp_ati_resume,
 };
 
 static int __init agp_ati_init(void)
