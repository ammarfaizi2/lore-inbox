Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268695AbUJTQ4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbUJTQ4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUJTQyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:54:39 -0400
Received: from 62-3-251-85.dyn.gotadsl.co.uk ([62.3.251.85]:39042 "EHLO
	talia.fluff.org") by vger.kernel.org with ESMTP id S268677AbUJTQlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:41:18 -0400
Date: Wed, 20 Oct 2004 18:40:15 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] platform_get_irq() return for no IRQ
Message-ID: <20041020174015.GA13087@fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

in drivers/base/platform.c, platform_get_irq() returns 0 if
there is no IRQ found in the resources, however 0 is a valid
IRQ on at least some of the ARM architectures.

This patch changes the return code to be -ENOENT instead.

Signed-of-by: Ben Dooks <ben-linux@fluff.org>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="plat-irq-fix.patch"

--- linux-2.6.9-bk4-orig/drivers/base/platform.c	2004-10-20 15:50:29.000000000 +0100
+++ linux-2.6.9-bk4/drivers/base/platform.c	2004-10-20 18:37:12.000000000 +0100
@@ -54,7 +54,7 @@
 {
 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 
-	return r ? r->start : 0;
+	return r ? r->start : -ENOENT;
 }
 
 /**

--6c2NcOVqGQ03X4Wi--
