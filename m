Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752062AbWCOMZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWCOMZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 07:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWCOMZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 07:25:37 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16088 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752062AbWCOMZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 07:25:36 -0500
Subject: PATCH: rio driver rework continued  #5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Mar 2006 12:31:55 +0000
Message-Id: <1142425915.5597.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Final polish. There is no more save_flags/cli type locking left. We also
no longer use the pcicopy function and file so they can go.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/Kconfig linux-2.6.16-rc6-mm1/drivers/char/Kconfig
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/Kconfig	2006-03-14 13:00:22.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/Kconfig	2006-03-14 14:48:08.000000000 +0000
@@ -290,7 +290,7 @@
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP && !64BIT
+	depends on SERIAL_NONSTANDARD && !64BIT
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/Makefile linux-2.6.16-rc6-mm1/drivers/char/rio/Makefile
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/Makefile	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/Makefile	2006-03-14 17:20:30.000000000 +0000
@@ -9,4 +9,4 @@
 obj-$(CONFIG_RIO) += rio.o
 
 rio-objs := rio_linux.o rioinit.o rioboot.o riocmd.o rioctrl.o riointr.o \
-            rioparam.o riopcicopy.o rioroute.o riotable.o riotty.o
+            rioparam.o rioroute.o riotable.o riotty.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riopcicopy.c linux-2.6.16-rc6-mm1/drivers/char/rio/riopcicopy.c
--- linux.vanilla-2.6.16-rc6-mm1/drivers/char/rio/riopcicopy.c	2006-03-14 12:59:37.000000000 +0000
+++ linux-2.6.16-rc6-mm1/drivers/char/rio/riopcicopy.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,8 +0,0 @@
-
-/* Yeah. We have copyright on this one. Sure. */
-
-void rio_pcicopy(char *from, char *to, int amount)
-{
-	while (amount--)
-		*to++ = *from++;
-}

