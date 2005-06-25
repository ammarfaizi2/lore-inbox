Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVFYRWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFYRWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 13:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFYRWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 13:22:32 -0400
Received: from mail.linicks.net ([217.204.244.146]:43273 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261297AbVFYRWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 13:22:22 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow number of IDE interfaces to be selected (X86)
Date: Sat, 25 Jun 2005 18:22:18 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251822.18717.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh well.... so much for my first patch - this needs to be allowed to set the 
default value correctly for ALPHA and SUPERH.

Here is the fixed patch of the patch...


By making a contribution to this project, I certify that:
The contribution was created in whole or in part by me and
I have the right to submit it under the open source license
indicated in the file.

Signed-off-by: Nick Warne<nick@linicks.net>




 drivers/ide/Kconfig    |   17 ++++++++++++++++-
 include/asm-i386/ide.h |    4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)


--- linux-2.6.12orig/include/asm-i386/ide.h     2005-06-17 20:48:29.000000000 
+0100
+++ linux-2.6.12/include/asm-i386/ide.h 2005-06-25 14:13:43.000000000 +0100
@@ -16,11 +16,15 @@
 #include <linux/config.h>

 #ifndef MAX_HWIFS
+#ifndef CONFIG_IDE_HWIFS_NUM
 # ifdef CONFIG_BLK_DEV_IDEPCI
 #define MAX_HWIFS      10
 # else
 #define MAX_HWIFS      6
 # endif
+#else
+#define MAX_HWIFS       CONFIG_IDE_MAX_HWIFS
+#endif
 #endif

 #define IDE_ARCH_OBSOLETE_DEFAULTS


--- linux-2.6.12orig/drivers/ide/Kconfig        2005-06-17 20:48:29.000000000 
+0100
+++ linux-2.6.12/drivers/ide/Kconfig    2005-06-25 18:01:07.000000000 +0100
@@ -52,14 +52,29 @@

 if IDE

+config IDE_HWIFS_NUM
+        bool "Specify the number of IDE Interfaces"
+       depends on (ALPHA || SUPERH || X86)
+       default y if !(X86)
+       help
+
+         ALPHA and SUPERH say 'y' here.
+
+         X86 say 'y' to this if you wish to specify the number of IDE
+         interfaces on your system.  If unsure, say 'n' to use
+         the kernel default options (6 or 10).
+
 config IDE_MAX_HWIFS
        int "Max IDE interfaces"
-       depends on ALPHA || SUPERH
+       depends on IDE_HWIFS_NUM
        default 4
        help
          This is the maximum number of IDE hardware interfaces that will
          be supported by the driver. Make sure it is at least as high as
          the number of IDE interfaces in your system.
+
+         On X86 architecture default is (6 or 10) IDE interfaces if this
+         is not used (IDE_HWIFS_NUM = n)

 config BLK_DEV_IDE
        tristate "Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support"


Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
