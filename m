Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbSJWDFI>; Tue, 22 Oct 2002 23:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSJWDFI>; Tue, 22 Oct 2002 23:05:08 -0400
Received: from fmr01.intel.com ([192.55.52.18]:56016 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262791AbSJWDFG>;
	Tue, 22 Oct 2002 23:05:06 -0400
Subject: [BUG] e100 driver fails to initialize NIC on 2.5.44
From: Rob Rhoads <errhoads@linux.co.intel.com>
To: scott.feldman@intel.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Oct 2002 20:10:54 -0700
Message-Id: <1035342654.676.368.camel@beer.co.intel.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting the 2.5.44 kernel & configured with the Intel e100 driver,
I get the follow error:

kernel: e100: hw init failed
kernel: e100: Failed to initialize, instance #0

I'm running this on an Intel STL2 server motherboard w/ 2 PIII's and 2.5
GB RAM. If you need more info I can provide it.

The patch below fixes my problem by increasing the maximum number of
retries that the SCB command field is checked in the e100_wait_scb()
function.

diff -ruN linux-2.5.44/drivers/net/e100/e100.h linux-2.5.44-new/drivers/net/e100/e100.h
--- linux-2.5.44/drivers/net/e100/e100.h	2002-10-18 21:01:20.000000000 -0700
+++ linux-2.5.44-new/drivers/net/e100/e100.h	2002-10-22 14:25:24.000000000 -0700
@@ -100,7 +100,7 @@
 
 #define E100_MAX_NIC 16
 
-#define E100_MAX_SCB_WAIT	100	/* Max udelays in wait_scb */
+#define E100_MAX_SCB_WAIT	2000	/* Max udelays in wait_scb */
 #define E100_MAX_CU_IDLE_WAIT	50	/* Max udelays in wait_cus_idle */
 
 /* HWI feature related constant */

-- 
Rob Rhoads                     mailto:errhoads@linux.intel.com
Telecom Software Platforms
Intel Communications Group

<disclaimer value="pointless">
This email message solely contains my own personal views, 
and not necessarily those of my employer.
</disclaimer>

