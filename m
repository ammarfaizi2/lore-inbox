Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288696AbSADRrz>; Fri, 4 Jan 2002 12:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbSADRrq>; Fri, 4 Jan 2002 12:47:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3347 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S281450AbSADRrc>;
	Fri, 4 Jan 2002 12:47:32 -0500
Message-ID: <3C35EAAF.17636C6E@mandrakesoft.com>
Date: Fri, 04 Jan 2002 12:47:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.2.7: io.h cleanup and userspace nudge
Content-Type: multipart/mixed;
 boundary="------------4587629E325627F4591F092F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4587629E325627F4591F092F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

As we are now in 2.5.x series I figured it might be a good time to push
this out...  The patch removes __KERNEL__ ifdefs from [only] io.h as a
nudge to userspace that they should not be including kernel headers.

MDK, RedHat, Caldera, and other distros already distribute a subset of
[sanitized?] kernel headers for glibc, so there is plenty of time to
notice and deal with any breakage this causes in userspace [which IMHO
should not have been including kernel headers in the first place...]

Finally, the patch includes a cosmetic cleanup to use standard
u8/u16/u32 types for {read,write}[bwl], similar to patches already
applied for sparc64, alpha, and other arches during 2.4.x series.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------4587629E325627F4591F092F
Content-Type: text/plain; charset=us-ascii;
 name="trouble.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trouble.patch"

--- /spare/tmp/linux-2.5.2-pre7/include/asm-i386/io.h	Sun Dec 16 18:43:31 2001
+++ linux_2_5/include/asm-i386/io.h	Fri Jan  4 12:32:07 2002
@@ -41,8 +41,6 @@
 #define XQUAD_PORTIO_BASE 0xfe400000
 #define XQUAD_PORTIO_LEN  0x40000   /* 256k per quad. Only remapping 1st */
 
-#ifdef __KERNEL__
-
 #include <linux/vmalloc.h>
 
 /*
@@ -108,16 +106,16 @@
  * memory location directly.
  */
 
-#define readb(addr) (*(volatile unsigned char *) __io_virt(addr))
-#define readw(addr) (*(volatile unsigned short *) __io_virt(addr))
-#define readl(addr) (*(volatile unsigned int *) __io_virt(addr))
+#define readb(addr) (*(volatile u8 *) __io_virt(addr))
+#define readw(addr) (*(volatile u16 *) __io_virt(addr))
+#define readl(addr) (*(volatile u32 *) __io_virt(addr))
 #define __raw_readb readb
 #define __raw_readw readw
 #define __raw_readl readl
 
-#define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
-#define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
-#define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
+#define writeb(b,addr) (*(volatile u8 *) __io_virt(addr) = (b))
+#define writew(b,addr) (*(volatile u16 *) __io_virt(addr) = (b))
+#define writel(b,addr) (*(volatile u32 *) __io_virt(addr) = (b))
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
@@ -215,8 +213,6 @@
 #define flush_write_buffers()
 
 #endif
-
-#endif /* __KERNEL__ */
 
 #ifdef SLOW_IO_BY_JUMPING
 #define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"

--------------4587629E325627F4591F092F--

