Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285783AbRLHCrs>; Fri, 7 Dec 2001 21:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285784AbRLHCri>; Fri, 7 Dec 2001 21:47:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10115 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285783AbRLHCrY>; Fri, 7 Dec 2001 21:47:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Raise MAX_MP_BUSSES to 256 on SMP boxes
Date: Fri, 7 Dec 2001 18:46:07 -0800
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01120718460707.01494@w-jamesc.des.beaverton.ibm.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing a NUMA box some pretty extreme PCI-X expansion capability overflowed 
mp_bus_id_to_pci_bus[].  May as well raise MAX_MP_BUSSES to the max:


--- linux-2.4.16/include/asm-i386/mpspec.h	Thu Nov 22 11:46:18 2001
+++ kdb-2.4.16/include/asm-i386/mpspec.h	Fri Dec  7 15:37:08 2001
@@ -184,13 +185,14 @@
  *	7	2 CPU MCA+PCI
  */
 
-#ifdef CONFIG_MULTIQUAD
-#define MAX_IRQ_SOURCES 512
-#else /* !CONFIG_MULTIQUAD */
+#ifdef CONFIG_SMP
+#define MAX_MP_BUSSES 256	/* Need max PCI busses for hotplug. */
+#define MAX_IRQ_SOURCES 1024	/* Four intrs per PCI slot. */
+#else /* !CONFIG_SMP */
+#define MAX_MP_BUSSES 32
 #define MAX_IRQ_SOURCES 256
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_SMP */
 
-#define MAX_MP_BUSSES 32
 enum mp_bustype {
 	MP_BUS_ISA = 1,
 	MP_BUS_EISA,


-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

