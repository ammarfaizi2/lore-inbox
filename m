Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWCCLF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWCCLF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCCLF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:05:27 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:1228 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751264AbWCCLF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:05:27 -0500
Message-ID: <440822DA.8030201@metro.cx>
Date: Fri, 03 Mar 2006 12:04:58 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 8/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added s3c2412 registers and bits.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-iis.h    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-iis.h    2006-02-28 
13:08:22.000000000 +0100
@@ -18,6 +18,7 @@
  *    18-07-2005     DA      Change IISCON_MPLL to IISMOD_MPLL
  *                           Correct IISMOD_256FS and IISMOD_384FS
  *                           Add IISCON_PSCEN
+ *    17-02-2006     KM      Added definitions for S3C2412/S3C2413
  */
 
 #ifndef __ASM_ARCH_REGS_IIS_H
@@ -84,4 +85,100 @@
 #define S3C2400_IISFCON_RXSHIFT      (0)
 
 #define S3C2410_IISFIFO  (0x10)
+
+/*
+ * S3C2412/13 has different IIS architecture,
+ * this information should not be in this file
+ * but it is because we (TomTom) do (does) not
+ * wish to create a seperate kernel for just
+ * S3C2412/13 architecture - KM
+ */
+
+// TODO: check whether S3C24XX_VA_IIS is correct for
+//       S3C2412/S3C2413 (final documentation from
+//       Samsung is not available yet) - KM
+
+#ifdef CONFIG_CPU_S3C2412
+
+//#define S3C2412_IISFCON  (0x00)
+#define S3C2412_IISCON   (S3C24XX_VA_IIS + 0x00)
+
+#define S3C2412_IISCON_LRI              (1<<11)
+#define S3C2412_IISCON_FTXEMPT          (1<<10)
+#define S3C2412_IISCON_FRXEMPT          (1<<9)
+#define S3C2412_IISCON_FTXFULL          (1<<8)
+#define S3C2412_IISCON_FRXFULL          (1<<7)
+#define S3C2412_IISCON_TXDMAPAUSE       (1<<6)
+#define S3C2412_IISCON_RXDMAPAUSE       (1<<5)
+#define S3C2412_IISCON_TXCHPAUSE        (1<<4)
+#define S3C2412_IISCON_RXCHPAUSE        (1<<3)
+#define S3C2412_IISCON_TXDMACTIVE       (1<<2)
+#define S3C2412_IISCON_RXDMACTIVE       (1<<1)
+#define S3C2412_IISCON_I2SACTIVE        (1<<0)
+
+//#define S3C2412_IISMOD   (0x04)
+#define S3C2412_IISMOD   (S3C24XX_VA_IIS + 0x04)
+
+#define S3C2412_IISMOD_IMSMASK          (3<<10)
+#define S3C2412_IISMOD_IMASTER          (0<<10)
+#define S3C2412_IISMOD_EMASTER          (1<<10)
+#define S3C2412_IISMOD_SLAVE            (2<<10)
+
+#define S3C2412_IISMOD_TXRMASK          (3<<8)
+#define S3C2412_IISMOD_XMIT             (0<<8)
+#define S3C2412_IISMOD_RECV             (1<<8)
+#define S3C2412_IISMOD_XMITRECV         (2<<8)
+
+#define S3C2412_IISMOD_LOCLKL           (0<<7)
+#define S3C2412_IISMOD_LOCLKR           (1<<7)
+
+#define S3C2412_IISMOD_SDFMASK          (3<<5)
+#define S3C2412_IISMOD_FMTI2S           (0<<5)
+#define S3C2412_IISMOD_FMTMSB           (1<<5)
+#define S3C2412_IISMOD_FMTLSB           (2<<5)
+
+#define S3C2412_IISMOD_RFSMASK          (3<<3)
+#define S3C2412_IISMOD_256FS            (0<<3)
+#define S3C2412_IISMOD_512FS            (1<<3)
+#define S3C2412_IISMOD_384FS            (2<<3)
+#define S3C2412_IISMOD_768FS            (3<<3)
+
+#define S3C2412_IISMOD_BFSMASK          (3<<1)
+#define S3C2412_IISMOD_BFS32FS          (0<<1)
+#define S3C2412_IISMOD_BFS48FS          (1<<1)
+#define S3C2412_IISMOD_BFS16FS          (2<<1)
+
+#define S3C2412_IISMOD_16BIT            (0<<0)
+#define S3C2412_IISMOD_8BIT             (1<<0)
+
+
+//#define S3C2412_IISFIC   (0x08)
+#define S3C2412_IISFIC   (S3C24XX_VA_IIS + 0x08)
+
+#define S3C2412_IISFIC_TFLUSH           (1<<15)
+#define S3C2412_IISFIC_FTXCNTMASK       (0x1f << 8)
+#define S3C2412_IISFIC_RFLUSH           (1<<7)
+#define S3C2412_IISFIC_FRXCNTMASK       (0x1f << 0)
+
+//#define S3C2412_IISPSR   (0x0c)
+#define S3C2412_IISPSR   (S3C24XX_VA_IIS + 0x0c)
+
+#define S3C2412_IISPSR_PSRAEN           (1<<15)
+#define S3C2412_IISPSR_PSVALAMASK       (0x3f << 15)
+
+//#define S3C2412_IISTXD   (0x10)
+#define S3C2412_IISTXD   (S3C24XX_VA_IIS + 0x10)
+
+
+//#define S3C2412_IISRXD   (0x14)
+#define S3C2412_IISRXD   (S3C24XX_VA_IIS + 0x14)
+
+
+#define S3C2412_DATA_L8MASK             (0xff << 16)
+#define S3C2412_DATA_R8MASK             (0xff << 0)
+#define S3C2412_DATA_L16MASK            (0xffff << 16)
+#define S3C2412_DATA_R16MASK            (0xffff << 0)
+
+#endif /* CONFIG_CPU_S3C2412 */
+
 #endif /* __ASM_ARCH_REGS_IIS_H */

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

