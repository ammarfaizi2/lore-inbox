Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965593AbWKDS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965593AbWKDS3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbWKDS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:29:40 -0500
Received: from hosting.zipcon.net ([209.221.136.3]:57243 "EHLO
	hosting.zipcon.net") by vger.kernel.org with ESMTP id S965592AbWKDS3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:29:39 -0500
Message-ID: <454CDC11.5030708@beezmo.com>
Date: Sat, 04 Nov 2006 10:29:37 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IRQ: ease out-of-tree migration to new irq_handler prototype
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.zipcon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - beezmo.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: william.waddington@beezmo.com

Ease out-of-tree driver migration to new irq_handler prototype.
Define empty 3rd argument macro for use in multi kernel version
out-of-tree drivers going forward.  Backportable drives can do:

(in a header)
#ifndef __PT_REGS
# define __PT_REGS , struct pt_regs *regs
#endif

(in code body)
static irqreturn_t irq_handler(int irq, void *dev_id __PT_REGS)

Signed-off-by: Bill Waddington <william.waddington@beezmo.com>

---

Has this suggestion by Ingo Molnar been implemented?  May I
submit it?  Is this how it's done?

--- 2.6.19-rc3/include/linux/interrupt.h.ORIG	2006-11-04 
09:15:16.000000000 -0800
+++ 2.6.19-rc3/include/linux/interrupt.h	2006-11-04 09:23:18.000000000 -0800
@@ -66,6 +66,14 @@

  typedef irqreturn_t (*irq_handler_t)(int, void *);

+/*
+ * Irq handler migration helper - empty 3rd argument
+ * #define __PT_REGS , struct pt_regs *regs
+ * for older kernel versions
+ */
+
+#define __PT_REGS
+
  struct irqaction {
  	irq_handler_t handler;
  	unsigned long flags;


Bill
-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch
