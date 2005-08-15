Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVHOVVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVHOVVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVHOVVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:21:49 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:38426 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S964974AbVHOVVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:21:48 -0400
Date: Mon, 15 Aug 2005 14:21:05 -0700 (PDT)
From: Naveen Gupta <ngupta@google.com>
To: wim@iguana.be, david@2gen.com, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH] set enable bit instead of lock bit of Watchdog Timer in
 Intel 6300 chipset  
Message-ID: <Pine.LNX.4.56.0508151416530.27145@krishna.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch sets the WDT_ENABLE bit of the Lock Register to enable the
watchdog and WDT_LOCK bit only if nowayout is set. The old code always
sets the WDT_LOCK bit of watchdog timer for Intel 6300ESB chipset. So, we
end up locking the watchdog instead of enabling it.

Signed-off-by: Naveen Gupta <ngupta@google.com>

Index: linux-2.6.12/drivers/char/watchdog/i6300esb.c
===================================================================
--- linux-2.6.12.orig/drivers/char/watchdog/i6300esb.c	2005-08-15 11:19:01.000000000 -0700
+++ linux-2.6.12/drivers/char/watchdog/i6300esb.c	2005-08-15 11:21:35.000000000 -0700
@@ -97,7 +97,7 @@
 	u8 val;
 
 	/* Enable or Enable + Lock? */
-	val = 0x02 | nowayout ? 0x01 : 0x00;
+	val = 0x02 | (nowayout ? 0x01 : 0x00);
 
         pci_write_config_byte(esb_pci, ESB_LOCK_REG, val);
 }
