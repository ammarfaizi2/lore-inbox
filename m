Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbTBRRr2>; Tue, 18 Feb 2003 12:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267910AbTBRRr2>; Tue, 18 Feb 2003 12:47:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16137 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267879AbTBRRrE>; Tue, 18 Feb 2003 12:47:04 -0500
Subject: PATCH: add generic ide iops
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 17:57:26 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lBzi-00066W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This abstracts out the mmio copies as PPC at least has better ways to
this and there are other issues on other platforms. It keeps DaveM happy
too 8)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/asm-generic/ide_iops.h linux-2.5.61-ac2/include/asm-generic/ide_iops.h
--- linux-2.5.61/include/asm-generic/ide_iops.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.61-ac2/include/asm-generic/ide_iops.h	2003-02-18 14:31:01.000000000 +0000
@@ -0,0 +1,38 @@
+/* Generic I/O and MEMIO string operations.  */
+
+#define __ide_insw	insw
+#define __ide_insl	insl
+#define __ide_outsw	outsw
+#define __ide_outsl	outsl
+
+static __inline__ void __ide_mm_insw(unsigned long port, void *addr, u32 count)
+{
+	while (count--) {
+		*(u16 *)addr = readw(port);
+		addr += 2;
+	}
+}
+
+static __inline__ void __ide_mm_insl(unsigned long port, void *addr, u32 count)
+{
+	while (count--) {
+		*(u32 *)addr = readl(port);
+		addr += 4;
+	}
+}
+
+static __inline__ void __ide_mm_outsw(unsigned long port, void *addr, u32 count)
+{
+	while (count--) {
+		writew(*(u16 *)addr, port);
+		addr += 2;
+	}
+}
+
+static __inline__ void __ide_mm_outsl(unsigned long port, void *addr, u32 count)
+{
+	while (count--) {
+		writel(*(u32 *)addr, port);
+		addr += 4;
+	}
+}
