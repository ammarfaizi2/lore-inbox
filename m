Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbUDFWWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDFWWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:22:54 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:43713 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S264032AbUDFWWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:22:52 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] don't offer GEN_RTC on ia64
Date: Tue, 6 Apr 2004 16:22:49 -0600
User-Agent: KMail/1.6.1
Cc: p_gortmaker@yahoo.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061622.49260.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gen_rtc.c doesn't work on ia64 (we don't have asm/rtc.h, for starters),
so don't offer it there.

===== drivers/char/Kconfig 1.32 vs edited =====
--- 1.32/drivers/char/Kconfig	Tue Mar 16 03:10:34 2004
+++ edited/drivers/char/Kconfig	Tue Apr  6 15:58:28 2004
@@ -768,7 +768,7 @@
 
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y
+	depends on RTC!=y && !IA64
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
