Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbULBOUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbULBOUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbULBOUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:20:48 -0500
Received: from dialup-4.246.93.254.Dial1.SanJose1.Level3.net ([4.246.93.254]:8065
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S261631AbULBOUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:20:41 -0500
Message-ID: <41AF24F4.5040800@syphir.sytes.net>
Date: Thu, 02 Dec 2004 06:21:40 -0800
From: "C.Y.M" <syphir@syphir.sytes.net>
Reply-To: syphir@syphir.sytes.net
Organization: CooLNeT
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: bt8xx cleanup 
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you just applied those other cleanups from 2.6.10-rc2-bk15, here 
is one more you might want to add.  Thanks.

diff -Nru a/drivers/media/dvb/bt8xx/bt878.h 
b/drivers/media/dvb/bt8xx/bt878.h
--- a/drivers/media/dvb/bt8xx/bt878.h   2004-10-20 08:19:52 -07:00
+++ b/drivers/media/dvb/bt8xx/bt878.h   2004-11-19 05:52:47 -08:00
@@ -102,7 +102,7 @@
         unsigned char revision;
         unsigned int irq;
         unsigned long bt878_adr;
-       unsigned char *bt878_mem; /* function 1 */
+       volatile void __iomem *bt878_mem; /* function 1 */

         volatile u32 finished_block;
         volatile u32 last_block;
@@ -129,17 +129,17 @@
  void bt878_stop(struct bt878 *bt);

  #if defined(__powerpc__)       /* big-endian */
-extern __inline__ void io_st_le32(volatile unsigned *addr, unsigned val)
+extern __inline__ void io_st_le32(volatile unsigned __iomem *addr, 
unsigned val)
  {
         __asm__ __volatile__("stwbrx %1,0,%2":"=m"(*addr):"r"(val),
                              "r"(addr));
         __asm__ __volatile__("eieio":::"memory");
  }

-#define bmtwrite(dat,adr)  io_st_le32((unsigned *)(adr),(dat))
-#define bmtread(adr)       ld_le32((unsigned *)(adr))
+#define bmtwrite(dat,adr)  io_st_le32((adr),(dat))
+#define bmtread(adr)       ld_le32((adr))
  #else
-#define bmtwrite(dat,adr)  writel((dat), (char *) (adr))
+#define bmtwrite(dat,adr)  writel((dat), (adr))
  #define bmtread(adr)       readl(adr)
  #endif
