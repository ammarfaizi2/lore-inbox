Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUHTHLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUHTHLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUHTHLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:11:02 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:37583 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267605AbUHTHIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:08:47 -0400
Date: Fri, 20 Aug 2004 09:09:00 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.8.1 watchdog-patches
Message-ID: <20040820070900.GI4908@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 Documentation/watchdog/pcwd-watchdog.txt |    3 ++-
 include/linux/compat_ioctl.h             |    6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

through these ChangeSets:

<arnd@arndb.de> (04/08/20 1.1838)
   [WATCHDOG] v2.6.8.1 compat_ioctl-patch
   
   The watchdog ioctl interface is defined correctly for 32 bit emulation,
   although WIOC_GETSUPPORT was not marked as such, for an unclear reason.
   WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT were added in may 2002 to the
   code but never to the ioctl list. This adds all three definitions.
   
   Signed-off-by: Arnd Bergmann <arnd@arndb.de>
   Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

<fl@fl.priv.at> (04/08/20 1.1839)
   [WATCHDOG] pcwd-watchdog.txt-patch
   
   Fix example program in pcwd-watchdog.txt document.


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/include/linux/compat_ioctl.h b/include/linux/compat_ioctl.h
--- a/include/linux/compat_ioctl.h	2004-08-20 09:06:54 +02:00
+++ b/include/linux/compat_ioctl.h	2004-08-20 09:06:54 +02:00
@@ -592,13 +592,15 @@
 COMPATIBLE_IOCTL(ATMTCP_REMOVE)
 COMPATIBLE_IOCTL(ATMMPC_CTRL)
 COMPATIBLE_IOCTL(ATMMPC_DATA)
-/* Big W */
-/* WIOC_GETSUPPORT not yet implemented -E */
+/* Watchdog */
+COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
 COMPATIBLE_IOCTL(WDIOC_GETBOOTSTATUS)
 COMPATIBLE_IOCTL(WDIOC_GETTEMP)
 COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
 COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
+COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
+COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 /* Big R */
 COMPATIBLE_IOCTL(RNDGETENTCNT)
 COMPATIBLE_IOCTL(RNDADDTOENTCNT)
diff -Nru a/Documentation/watchdog/pcwd-watchdog.txt b/Documentation/watchdog/pcwd-watchdog.txt
--- a/Documentation/watchdog/pcwd-watchdog.txt	2004-08-20 09:06:56 +02:00
+++ b/Documentation/watchdog/pcwd-watchdog.txt	2004-08-20 09:06:56 +02:00
@@ -35,7 +35,8 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
-#include <linux/pcwd.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
 
 int fd;
 
