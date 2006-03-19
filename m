Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWCSPem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWCSPem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWCSPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:34:42 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:12268 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932129AbWCSPel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:34:41 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Date: Mon, 20 Mar 2006 02:34:00 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       "Rafael Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 746
Subject: [PATCH][3/3] mm: swsusp post resume aggressive swap prefetch
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200603200234.01472.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Swsusp reclaims a lot of memory during the suspend cycle and can benefit
from the aggressive_swap_prefetch mode immediately upon resuming.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 kernel/power/swsusp.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.16-rc6-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/swsusp.c	2006-03-20 02:15:47.000000000 +1100
+++ linux-2.6.16-rc6-mm2/kernel/power/swsusp.c	2006-03-20 02:20:35.000000000 +1100
@@ -49,6 +49,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/highmem.h>
+#include <linux/swap-prefetch.h>
 
 #include "power.h"
 
@@ -239,6 +240,8 @@ Restore_highmem:
 	device_power_up();
 Enable_irqs:
 	local_irq_enable();
+	if (!in_suspend)
+		aggressive_swap_prefetch();
 	return error;
 }
 

