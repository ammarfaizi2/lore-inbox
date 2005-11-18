Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVKRBk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVKRBk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVKRBk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:40:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59653 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932194AbVKRBk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:40:57 -0500
Date: Fri, 18 Nov 2005 02:40:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051118014055.GK11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
on i386.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Nov 2005

--- linux-2.6.14-mm2-full/include/asm-i386/io.h.old	2005-11-12 01:44:38.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-i386/io.h	2005-11-12 01:45:58.000000000 +0100
@@ -144,8 +144,14 @@
  *
  * Allow them on x86 for legacy drivers, though.
  */
-#define virt_to_bus virt_to_phys
-#define bus_to_virt phys_to_virt
+static inline unsigned long __deprecated virt_to_bus(volatile void * address)
+{
+	return __pa(address);
+}
+static inline void * __deprecated bus_to_virt(unsigned long address)
+{
+	return __va(address);
+}
 
 /*
  * readX/writeX() are used to access memory mapped devices. On some

