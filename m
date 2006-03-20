Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbWCTWIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbWCTWIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWCTWBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:56761 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030539AbWCTWBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:13 -0500
Cc: David Vrabel <dvrabel@arcom.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/23] driver core: platform_get_irq*(): return -ENXIO on error
In-Reply-To: <11428920373568-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920383013-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
platforms, return -ENXIO instead.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/platform.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 461554a..89b2683 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -61,7 +61,7 @@ int platform_get_irq(struct platform_dev
 {
 	struct resource *r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 
-	return r ? r->start : 0;
+	return r ? r->start : -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
@@ -98,7 +98,7 @@ int platform_get_irq_byname(struct platf
 {
 	struct resource *r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
 
-	return r ? r->start : 0;
+	return r ? r->start : -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
-- 
1.2.4


