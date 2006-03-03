Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWCCLCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWCCLCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCCLCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:02:36 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:22726 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751263AbWCCLCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:02:35 -0500
Message-ID: <4408223B.2060605@metro.cx>
Date: Fri, 03 Mar 2006 12:02:19 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 5/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added function to get s3c2412 pll.
Added extra/changed CLKDIV register bits for s3c2412.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/regs-clock.h    
2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/regs-clock.h    2006-03-03 
11:02:19.000000000 +0100
@@ -112,6 +112,29 @@
     return (unsigned int)fvco;
 }
 
+#ifdef CONFIG_CPU_S3C2412
+static inline unsigned int
+s3c2412_get_pll(int pllval, int baseclk)
+{
+       int mdiv, pdiv, sdiv;
+       uint64_t fvco;
+
+       mdiv = pllval >> S3C2410_PLLCON_MDIVSHIFT;
+       pdiv = pllval >> S3C2410_PLLCON_PDIVSHIFT;
+       sdiv = pllval >> S3C2410_PLLCON_SDIVSHIFT;
+
+       mdiv &= S3C2410_PLLCON_MDIVMASK;
+       pdiv &= S3C2410_PLLCON_PDIVMASK;
+       sdiv &= S3C2410_PLLCON_SDIVMASK;
+
+       fvco = (uint64_t)baseclk * ((mdiv + 8)<<1);
+       do_div(fvco, (pdiv + 2) << sdiv);
+
+       return (unsigned int)fvco;
+}
+#endif /* CONFIG_CPU_S3C2412 */
+
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_CPU_S3C2440
@@ -138,5 +161,21 @@
 
 #endif /* CONFIG_CPU_S3C2440 */
 
+#ifdef CONFIG_CPU_S3C2412
+
+#define S3C2412_CLKDIVN_HCLKDIV_MASK (3<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_1_2  (0<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_2_4  (1<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_3_6  (2<<0)
+#define S3C2412_CLKDIVN_HCLKDIV_4_8  (3<<0)
+#define S3C2412_CLKDIVN_PCLKDIV      (1<<2)
+#define S3C2412_CLKDIVN_ARMDIV       (1<<3)
+#define S3C2412_CLKDIVN_DVSEN        (1<<4)
+#define S3C2412_CLKDIVN_HALFHCLK     (1<<5)
+#define S3C2412_CLKDIVN_USB48DIV     (1<<6)
+#define S3C2412_CLKDIVN_UARTCLK_MASK (15<<8)
+#define S3C2412_CLKDIVN_I2SCLK_MASK  (15<<12)
+
+#endif /* CONFIG_CPU_S3C2412 */
 
 #endif /* __ASM_ARM_REGS_CLOCK */


-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

