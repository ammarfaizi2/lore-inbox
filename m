Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268424AbTBNNF1>; Fri, 14 Feb 2003 08:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268416AbTBNNFN>; Fri, 14 Feb 2003 08:05:13 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:24846 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268414AbTBNMxI>;
	Fri, 14 Feb 2003 07:53:08 -0500
Date: Fri, 14 Feb 2003 15:58:21 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: add missing mach_apic.h file (7/13)
Message-ID: <20030214125821.GG8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8sldprk+5E/pDEv"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This patch adds misiing mach_apic.h file.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-mach_apic

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/include/asm-i386/mach-visws/mach_apic.h linux-2.5.60/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.5.60.vanilla/include/asm-i386/mach-visws/mach_apic.h	Thu Jan  1 03:00:00 1970
+++ linux-2.5.60/include/asm-i386/mach-visws/mach_apic.h	Thu Feb 13 20:42:02 2003
@@ -0,0 +1,80 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
+
+#define no_balance_irq (0)
+#define esr_disable (0)
+
+#define INT_DELIVERY_MODE dest_LowestPrio
+#define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
+
+#ifdef CONFIG_SMP
+ #define TARGET_CPUS cpu_online_map
+#else
+ #define TARGET_CPUS 0x01
+#endif
+
+#define APIC_BROADCAST_ID      0x0F
+#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
+#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
+
+static inline int apic_id_registered(void)
+{
+	return (test_bit(GET_APIC_ID(apic_read(APIC_ID)), 
+						&phys_cpu_present_map));
+}
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LDR and TPR before enabling
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static inline void init_apic_ldr(void)
+{
+	unsigned long val;
+
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val |= SET_APIC_LOGICAL_ID(1UL << smp_processor_id());
+	apic_write_around(APIC_LDR, val);
+}
+
+static inline void summit_check(char *oem, char *productid) 
+{
+}
+
+static inline void clustered_apic_check(void)
+{
+}
+
+/* Mapping from cpu number to logical apicid */
+static inline int cpu_to_logical_apicid(int cpu)
+{
+	return 1 << cpu;
+}
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	return mps_cpu;
+}
+
+static inline unsigned long apicid_to_cpu_present(int apicid)
+{
+	return (1ul << apicid);
+}
+
+#define WAKE_SECONDARY_VIA_INIT
+
+static inline void setup_portio_remap(void)
+{
+}
+
+static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
+{
+	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
+}
+
+#endif /* __ASM_MACH_APIC_H */

--a8sldprk+5E/pDEv--
