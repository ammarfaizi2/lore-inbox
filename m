Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbRBVOcu>; Thu, 22 Feb 2001 09:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRBVOca>; Thu, 22 Feb 2001 09:32:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12550 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129761AbRBVOc2>;
	Thu, 22 Feb 2001 09:32:28 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102221353.f1MDrfq30420@flint.arm.linux.org.uk>
Subject: [Patch] 2.4.2: af_unix.c warnings
To: linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2001 13:53:40 +0000 (GMT)
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.4.2 with CONFIG_SYSCTL=n, I'm seeing the following warnings
while compiling af_unix.c:

gcc -D__KERNEL__ -I/usr/src/v2.4/linux-p720t/include -Wall -Wstrict-prototypes -O2  -fno-strict-aliasing -fno-common -pipe -mapcs-32 -march=armv4 -mtune=arm7tdmi -mshort-load-bytes -msoft-float    -c -o af_unix.o af_unix.c
af_unix.c:1855: warning: return-type defaults to `int'
af_unix.c:1855: warning: function declaration isn't a prototype
af_unix.c: In function `unix_sysctl_register':
af_unix.c:1855: warning: control reaches end of non-void function
af_unix.c: At top level:
af_unix.c:1856: warning: return-type defaults to `int'
af_unix.c:1856: warning: function declaration isn't a prototype
af_unix.c: In function `unix_sysctl_unregister':
af_unix.c:1856: warning: control reaches end of non-void function

The following patch fixes these warnings:

--- orig/net/unix/af_unix.c	Thu Feb 22 11:25:50 2001
+++ linux/net/unix/af_unix.c	Thu Feb 22 13:54:41 2001
@@ -1852,8 +1852,8 @@
 extern void unix_sysctl_register(void);
 extern void unix_sysctl_unregister(void);
 #else
-static inline unix_sysctl_register() {};
-static inline unix_sysctl_unregister() {};
+static inline void unix_sysctl_register(void) {}
+static inline void unix_sysctl_unregister(void) {}
 #endif
 
 static const char banner[] __initdata = KERN_INFO "NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.\n";
 

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

