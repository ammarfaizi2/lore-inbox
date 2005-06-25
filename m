Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVFYPlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVFYPlu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 11:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVFYPlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 11:41:49 -0400
Received: from mail.linicks.net ([217.204.244.146]:22797 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261269AbVFYPlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 11:41:44 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow number of IDE interfaces to be selected (X86)
Date: Sat, 25 Jun 2005 16:41:40 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251641.40922.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small patch I done to allow X86 users to select the max number of IDE 
interfaces they have - this eliminates the need for passing idex=noprobe on 
the command line and/or stops the needless probes at boot on non-existant IDE 
interfaces.

I have done this as I assume the majority of X86 users will only have 2 IDE 
interfaces, and therefore it allows the option to specify this.

ALPHA and SUPERH users need to select this to continue as per the way it works 
for them.

For X86 people, not selecting this allows the kernel to use the defaults 'as 
was'.


By making a contribution to this project, I certify that:
The contribution was created in whole or in part by me and
I have the right to submit it under the open source license
indicated in the file.

Signed-off-by: Nick Warne<nick@linicks.net>



 drivers/ide/Kconfig    |   17 ++++++++++++++++-
 include/asm-i386/ide.h |    4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)


--- linux-2.6.12n/include/asm-i386/ide.h        2005-06-17 20:48:29.000000000 
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

--- linux-2.6.12n/drivers/ide/Kconfig   2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.12/drivers/ide/Kconfig    2005-06-25 14:11:17.000000000 +0100
@@ -52,14 +52,29 @@

 if IDE

+config IDE_HWIFS_NUM
+        bool "Specify the number of IDE Interfaces"
+       depends on (ALPHA || SUPERH || X86)
+        default n
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
