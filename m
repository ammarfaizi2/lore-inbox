Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWCCLKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWCCLKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWCCLKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:10:35 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:11721 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751403AbWCCLKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:10:35 -0500
Message-ID: <440823AA.6000405@metro.cx>
Date: Fri, 03 Mar 2006 12:08:26 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 14/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added cpu detection for s3c2412.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/include/asm-arm/arch-s3c2410/uncompress.h    
2006-02-10 08:22:48.000000000 +0100
+++ golinux/include/asm-arm/arch-s3c2410/uncompress.h    2006-02-28 
13:19:36.000000000 +0100
@@ -17,6 +17,7 @@
  *  15-Nov-2004 BJD  Fixed uart configuration
  *  22-Feb-2005 BJD  Added watchdog to uncompress
  *  04-Apr-2005 LCVR Added support to S3C2400 (no cpuid at GSTATUS1)
+ *  28-Feb-2006 KM   Added support for S3C2412/13 (cpuid moved to 
different addr)
 */
 
 #ifndef __ASM_ARCH_UNCOMPRESS_H
@@ -75,6 +76,14 @@
 #ifndef CONFIG_CPU_S3C2400
     cpuid = *((volatile unsigned int *)S3C2410_GSTATUS1);
     cpuid &= S3C2410_GSTATUS1_IDMASK;
+
+#ifdef CONFIG_CPU_S3C2412
+        if (cpuid!=S3C2410_GSTATUS1_2440 && cpuid!=S3C2410_GSTATUS1_2410) {
+          cpuid = *((volatile unsigned int *)S3C2412_GSTATUS1);
+          cpuid &= S3C2410_GSTATUS1_IDMASK;
+        }
+#endif
+
 #endif
 
     if (ch == '\n')

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

