Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277852AbRJIRQI>; Tue, 9 Oct 2001 13:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277854AbRJIRP4>; Tue, 9 Oct 2001 13:15:56 -0400
Received: from cs242719-203.austin.rr.com ([24.27.19.203]:57593 "EHLO
	snafu.haywired.net") by vger.kernel.org with ESMTP
	id <S277852AbRJIRPq>; Tue, 9 Oct 2001 13:15:46 -0400
Date: Tue, 9 Oct 2001 12:50:02 -0500 (CDT)
From: Paul B Schroeder <paulsch@haywired.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] mwave config fix and module tags
Message-ID: <Pine.LNX.4.33.0110091237120.25555-100000@screwy.haywired.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus..

This patch includes the necessary changes to allow folks to configure
Mwave support...  It seems that those changes didn't get merged
with the rest of the Mwave..  It also includes the MODULE_* tag changes from
a previous patch by Thomas Hood..
It applies against 2.4.11-pre6..

Cheers...Paul...


diff -urN -X dontdiff linux-2.4.11-pre6/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.11-pre6/Documentation/Configure.help	Tue Oct  9 10:13:39 2001
+++ linux/Documentation/Configure.help	Tue Oct  9 09:59:25 2001
@@ -2568,6 +2568,31 @@
   a module, say M here and read Documentation/modules.txt. If unsure,
   say N.

+ACP Modem (Mwave) support
+CONFIG_MWAVE
+  The ACP modem (Mwave) for Linux is a WinModem. It is composed of a
+  kernel driver and a user level application. Together these components
+  support direct attachment to public switched telephone networks (PSTNs)
+  and support selected world wide countries.
+
+  This version of the ACP Modem driver supports the IBM Thinkpad 600E,
+  600, and 770 that include on board ACP modem hardware.
+
+  The modem also supports the standard communications port interface
+  (ttySx) and is compatible with the Hayes AT Command Set.
+
+  The user level application needed to use this driver can be found at
+  the IBM Linux Technology Center (LTC) web site:
+  http://www.ibm.com/linux/ltc/
+
+  If you own one of the above IBM Thinkpads which has the Mwave chipset
+  in it, say Y.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called mwave.o. If you want to compile it as
+  a module, say M here and read Documentation/modules.txt.
+
 /dev/agpgart (AGP Support) (EXPERIMENTAL)
 CONFIG_AGP
   AGP (Accelerated Graphics Port) is a bus system mainly used to
diff -urN -X dontdiff linux-2.4.11-pre6/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.11-pre6/drivers/char/Config.in	Tue Oct  9 10:13:45 2001
+++ linux/drivers/char/Config.in	Tue Oct  9 10:01:42 2001
@@ -219,4 +219,7 @@
 if [ "$CONFIG_HOTPLUG" = "y" -a "$CONFIG_PCMCIA" != "n" ]; then
    source drivers/char/pcmcia/Config.in
 fi
+
+tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
+
 endmenu
diff -urN -X dontdiff linux-2.4.11-pre6/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-2.4.11-pre6/drivers/char/Makefile	Tue Oct  9 10:13:45 2001
+++ linux/drivers/char/Makefile	Tue Oct  9 10:00:30 2001
@@ -230,6 +230,10 @@
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o

+subdir-$(CONFIG_MWAVE) += mwave
+ifeq ($(CONFIG_MWAVE),y)
+  obj-y += mwave/mwave.o
+endif

 include $(TOPDIR)/Rules.make

diff -urN -X dontdiff linux-2.4.11-pre6/drivers/char/mwave/mwavedd.c linux/drivers/char/mwave/mwavedd.c
--- linux-2.4.11-pre6/drivers/char/mwave/mwavedd.c	Tue Oct  9 10:13:45 2001
+++ linux/drivers/char/mwave/mwavedd.c	Tue Oct  9 10:05:21 2001
@@ -71,6 +71,10 @@
 #define __exit
 #endif

+MODULE_DESCRIPTION("3780i Advanced Communications Processor (Mwave) driver");
+MODULE_AUTHOR("Mike Sullivan and Paul Schroeder");
+MODULE_LICENSE("GPL");
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static int mwave_get_info(char *buf, char **start, off_t offset, int len);
 #else


-- 

Paul B Schroeder
paulsch@haywired.net



