Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTEEUw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbTEEUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:52:25 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:56782 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261369AbTEEUwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:52:23 -0400
Date: Mon, 5 May 2003 23:04:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add a config option for drivers/char/raw.o
Message-ID: <20030505210458.GB7049@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch is basically a backport of 2.5, works for me and applies
cleanly to 2.4.20, -rc1 and -rc1-ac4.

Comments?

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."

--- linux-2.4.20/drivers/char/Makefile~remove_charraw	2002-11-29 00:53:12.000000000 +0100
+++ linux-2.4.20/drivers/char/Makefile	2003-04-14 15:16:17.000000000 +0200
@@ -16,7 +16,7 @@
 
 O_TARGET := char.o
 
-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o random.o
+obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
@@ -197,6 +197,7 @@
 obj-$(CONFIG_HVC_CONSOLE) += hvc_console.o
 obj-$(CONFIG_SERIAL_TX3912) += generic_serial.o serial_tx3912.o
 obj-$(CONFIG_TXX927_SERIAL) += serial_txx927.o
+obj-$(CONFIG_RAW_DRIVER) += raw.o
 
 subdir-$(CONFIG_RIO) += rio
 subdir-$(CONFIG_INPUT) += joystick
--- linux-2.4.20/drivers/char/Config.in~remove_charraw	2002-11-29 00:53:12.000000000 +0100
+++ linux-2.4.20/drivers/char/Config.in	2003-04-14 15:18:33.000000000 +0200
@@ -321,4 +321,6 @@
    tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
 fi
 
+tristate "RAW driver (/dev/raw/rawN)" CONFIG_RAW_DRIVER
+
 endmenu
--- linux-2.4.20/Documentation/Configure.help~remove_charraw	2002-11-29 00:53:08.000000000 +0100
+++ linux-2.4.20/Documentation/Configure.help	2003-04-14 15:20:04.000000000 +0200
@@ -3478,6 +3478,13 @@
   The module will be called mwave.o. If you want to compile it as
   a module, say M here and read Documentation/modules.txt.
 
+RAW driver (/dev/raw/rawN)
+CONFIG_RAW_DRIVER
+  The raw driver permits block devices to be bound to /dev/raw/rawN. 
+  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O.
+  See the raw(8) manpage for more details.
+
+
 /dev/agpgart (AGP Support)
 CONFIG_AGP
   AGP (Accelerated Graphics Port) is a bus system mainly used to
