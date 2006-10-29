Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWJ2UIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWJ2UIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWJ2UH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:07:58 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:1803 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751907AbWJ2UHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:07:55 -0500
Subject: [PATCH] Re: [PATCH 3/4] Prep for paravirt: desc.h clearer
	parameter names, some code motion
From: Don Mullis <dwm@meer.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <1161920728.17807.39.camel@localhost.localdomain>
References: <1161920325.17807.29.camel@localhost.localdomain>
	 <1161920535.17807.33.camel@localhost.localdomain>
	 <1161920622.17807.36.camel@localhost.localdomain>
	 <1161920728.17807.39.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 29 Oct 2006 12:01:11 -0800
Message-Id: <1162152071.23311.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build where CONFIG_CC_OPTIMIZE_FOR_SIZE is not set.

Tested by build and boot.

Signed-off-by: Don Mullis <dwm@meer.net>

---
 include/asm-i386/desc.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: linux-trees/include/asm-i386/desc.h
===================================================================
--- linux-trees.orig/include/asm-i386/desc.h
+++ linux-trees/include/asm-i386/desc.h
@@ -78,6 +78,17 @@ static inline void load_TLS(struct threa
 #undef C
 }
 
+static inline void write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
+{
+	u32 *lp = (u32 *)((char *)dt + entry*8);
+	lp[0] = entry_low;
+	lp[1] = entry_high;
+}
+
+#define write_ldt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+#define write_gdt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+#define write_idt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+
 static inline void set_ldt(void *addr, unsigned int entries)
 {
 	if (likely(entries == 0))
@@ -94,17 +105,6 @@ static inline void set_ldt(void *addr, u
 	}
 }
 
-#define write_ldt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
-#define write_gdt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
-#define write_idt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
-
-static inline void write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
-{
-	u32 *lp = (u32 *)((char *)dt + entry*8);
-	lp[0] = entry_low;
-	lp[1] = entry_high;
-}
-
 static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
 {
 	u32 low, high;


