Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288274AbSAOQhy>; Tue, 15 Jan 2002 11:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSAOQhp>; Tue, 15 Jan 2002 11:37:45 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:29715 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S288274AbSAOQhh>; Tue, 15 Jan 2002 11:37:37 -0500
Date: Tue, 15 Jan 2002 16:37:28 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: New CRC32 fails to build
Message-ID: <20020115163728.D1822@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.2, the new CRC stuff fails to build because the cleanup function
isn't marked with __exit:

/home/rmk/v2.5/linux-ebsa285/lib/lib.a(crc32.o): In function `cleanup_crc32':
crc32.o(.text+0x98): relocation truncated to fit: R_ARM_PC24 text.exit
crc32.o(.text+0x9c): relocation truncated to fit: R_ARM_PC24 text.exit

The following patch fixes the problem:

--- orig/lib/crc32.c	Tue Jan 15 14:16:27 2002
+++ linux/lib/crc32.c	Tue Jan 15 16:36:15 2002
@@ -558,7 +558,7 @@
 /**
  * cleanup_crc32(): frees crc32 data when no longer needed
  */
-static void cleanup_crc32(void)
+static void __exit cleanup_crc32(void)
 {
 	crc32cleanup_le();
 	crc32cleanup_be();


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

