Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWCUWoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWCUWoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWCUWoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:44:03 -0500
Received: from xenotime.net ([66.160.160.81]:62624 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964865AbWCUWoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:44:01 -0500
Date: Tue, 21 Mar 2006 14:46:07 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: clemens@ladisch.de, akpm <akpm@osdl.org>
Subject: [PATCH] hpet header sanitization
Message-Id: <20060321144607.153d1943.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add __KERNEL__ block.
Use __KERNEL__ to allow ioctl interface to be usable.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/hpet.h |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

--- linux-2616-work.orig/include/linux/hpet.h
+++ linux-2616-work/include/linux/hpet.h
@@ -3,6 +3,8 @@
 
 #include <linux/compiler.h>
 
+#ifdef __KERNEL__
+
 /*
  * Offsets into HPET Registers
  */
@@ -85,22 +87,6 @@ struct hpet {
 #define	Tn_FSB_INT_ADDR_SHIFT		(32UL)
 #define	Tn_FSB_INT_VAL_MASK		(0x00000000ffffffffULL)
 
-struct hpet_info {
-	unsigned long hi_ireqfreq;	/* Hz */
-	unsigned long hi_flags;	/* information */
-	unsigned short hi_hpet;
-	unsigned short hi_timer;
-};
-
-#define	HPET_INFO_PERIODIC	0x0001	/* timer is periodic */
-
-#define	HPET_IE_ON	_IO('h', 0x01)	/* interrupt on */
-#define	HPET_IE_OFF	_IO('h', 0x02)	/* interrupt off */
-#define	HPET_INFO	_IOR('h', 0x03, struct hpet_info)
-#define	HPET_EPI	_IO('h', 0x04)	/* enable periodic */
-#define	HPET_DPI	_IO('h', 0x05)	/* disable periodic */
-#define	HPET_IRQFREQ	_IOW('h', 0x6, unsigned long)	/* IRQFREQ usec */
-
 /*
  * exported interfaces
  */
@@ -133,4 +119,22 @@ int hpet_register(struct hpet_task *, in
 int hpet_unregister(struct hpet_task *);
 int hpet_control(struct hpet_task *, unsigned int, unsigned long);
 
+#endif /* __KERNEL__ */
+
+struct hpet_info {
+	unsigned long hi_ireqfreq;	/* Hz */
+	unsigned long hi_flags;	/* information */
+	unsigned short hi_hpet;
+	unsigned short hi_timer;
+};
+
+#define	HPET_INFO_PERIODIC	0x0001	/* timer is periodic */
+
+#define	HPET_IE_ON	_IO('h', 0x01)	/* interrupt on */
+#define	HPET_IE_OFF	_IO('h', 0x02)	/* interrupt off */
+#define	HPET_INFO	_IOR('h', 0x03, struct hpet_info)
+#define	HPET_EPI	_IO('h', 0x04)	/* enable periodic */
+#define	HPET_DPI	_IO('h', 0x05)	/* disable periodic */
+#define	HPET_IRQFREQ	_IOW('h', 0x6, unsigned long)	/* IRQFREQ usec */
+
 #endif				/* !__HPET__ */


---
