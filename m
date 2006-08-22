Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWHVR4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWHVR4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWHVR4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:56:18 -0400
Received: from tim.rpsys.net ([194.106.48.114]:8146 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751426AbWHVR4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:56:17 -0400
Subject: [PATCH for 2.6.18] spectrum_cs: Fix firmware uploading errors
From: Richard Purdie <rpurdie@rpsys.net>
To: Jeff Garzik <jgarzik@pobox.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 18:55:44 +0100
Message-Id: <1156269344.5920.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spectrum_cs: Fix the logic so we error when the device is *not* present!

This fixes firmware upload failures which prevent the driver from
working (the bug is also present in 2.6.17).

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

---
 drivers/net/wireless/spectrum_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17/drivers/net/wireless/spectrum_cs.c
===================================================================
--- linux-2.6.17.orig/drivers/net/wireless/spectrum_cs.c	2006-08-22 17:27:28.000000000 +0100
+++ linux-2.6.17/drivers/net/wireless/spectrum_cs.c	2006-08-22 17:27:58.000000000 +0100
@@ -245,7 +245,7 @@ spectrum_reset(struct pcmcia_device *lin
 	u_int save_cor;
 
 	/* Doing it if hardware is gone is guaranteed crash */
-	if (pcmcia_dev_present(link))
+	if (!pcmcia_dev_present(link))
 		return -ENODEV;
 
 	/* Save original COR value */


