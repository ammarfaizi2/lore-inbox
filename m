Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289067AbSA1A1A>; Sun, 27 Jan 2002 19:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289069AbSA1A0v>; Sun, 27 Jan 2002 19:26:51 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:65214 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S289067AbSA1A0j>; Sun, 27 Jan 2002 19:26:39 -0500
Message-ID: <3C549AEC.D79A95FC@didntduck.org>
Date: Sun, 27 Jan 2002 19:27:24 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix NR_IRQS when no IO apic
Content-Type: multipart/mixed;
 boundary="------------8702CE4CB7F0BCA41CBB3B10"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8702CE4CB7F0BCA41CBB3B10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

NR_IRQS should be 16 when the IO apic is not configured, as the 8259 PIC
cannot generate any more interrupts.  It also fixes a bug where the IDT
gets populated with random addresses, since only 16 entry stubs are
created.

-- 

						Brian Gerst
--------------8702CE4CB7F0BCA41CBB3B10
Content-Type: text/plain; charset=us-ascii;
 name="nrirqs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nrirqs-1"

diff -urN linux-2.5.3-pre5/include/asm-i386/irq.h linux/include/asm-i386/irq.h
--- linux-2.5.3-pre5/include/asm-i386/irq.h	Fri Jan 25 02:25:47 2002
+++ linux/include/asm-i386/irq.h	Fri Jan 25 11:30:44 2002
@@ -23,7 +23,11 @@
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
  * the usable vector space is 0x20-0xff (224 vectors)
  */
+#ifdef CONFIG_X86_IO_APIC
 #define NR_IRQS 224
+#else
+#define NR_IRQS 16
+#endif
 
 static __inline__ int irq_cannonicalize(int irq)
 {


--------------8702CE4CB7F0BCA41CBB3B10--

