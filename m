Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbWGJWPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbWGJWPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWGJWPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:15:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7863 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965266AbWGJWPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:15:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Olson <olson@unixfolk.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Add Hypertransport capability defines.
Date: Mon, 10 Jul 2006 16:14:17 -0600
Message-ID: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds defines for the hypertransport capability subtypes
and starts using them a little.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

This patch is against 2.6.18-rc1-mm1

 arch/powerpc/sysdev/mpic.c |    2 +-
 include/linux/pci_regs.h   |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9961eda..9be8c49 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -251,7 +251,7 @@ static void __init mpic_scan_ht_pic(stru
 		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
 		if (id == PCI_CAP_ID_HT) {
 			id = readb(devbase + pos + 3);
-			if (id == 0x80)
+			if (id == HT_CAPTYPE_IRQ)
 				break;
 		}
 	}
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index 05b893e..0ea629c 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -12,6 +12,11 @@
  *	PCI Local Bus Specification
  *	PCI to PCI Bridge Specification
  *	PCI System Design Guide
+ *
+ * 	For hypertransport information, please consult the following manuals 
+ * 	from http://www.hypertranposrt.org
+ *
+ *	The Hypertransport I/O Link Specification
  */
 
 #ifndef LINUX_PCI_REGS_H
@@ -447,4 +452,20 @@ #define  PCI_PWR_DATA_RAIL(x)	(((x) >> 1
 #define PCI_PWR_CAP		12	/* Capability */
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 
+/* Hypertransport sub capability types */
+#define HT_CAPTYPE_SLAVE	0x00	/* Slave/Primary link configuration */
+#define HT_CAPTYPE_HOST		0x20	/* Host/Secondary link configuration */
+#define HT_CAPTYPE_IRQ		0x80	/* IRQ Configuration */
+#define HT_CAPTYPE_REMAPPING_40	0xA0	/* 40 bit address remapping */
+#define HT_CAPTYPE_REMAPPING_64 0xA2	/* 64 bit address remapping */
+#define HT_CAPTYPE_UNITID_CLUMP	0x90	/* Unit ID clumping */
+#define HT_CAPTYPE_EXTCONF	0x98	/* Extended Configuration Space Access */
+#define HT_CAPTYPE_MSI_MAPPING	0xA8	/* MSI Mapping Capability */
+#define HT_CAPTYPE_DIRECT_ROUTE	0xB0	/* Direct routing configuration */
+#define HT_CAPTYPE_VCSET	0xB8	/* Virtual Channel configuration */
+#define HT_CAPTYPE_ERROR_RETRY	0xC0	/* Retry on error configuration */
+#define HT_CAPTYPE_GEN3		0xD0	/* Generation 3 hypertransport configuration */
+#define HT_CAPTYPE_PM		0xE0	/* Hypertransport powermanagement configuration */
+
+
 #endif /* LINUX_PCI_REGS_H */
-- 
1.4.1.gac83a

