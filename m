Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVB1AI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVB1AI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVB1AG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:06:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50327 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261199AbVB0Xkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:40:37 -0500
Message-ID: <42225A74.3040404@us.ltcfwd.linux.ibm.com>
Date: Sun, 27 Feb 2005 18:40:36 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [ patch 7/7] drivers/serial/jsm: new serial device driver
Content-Type: multipart/mixed;
 boundary="------------000107090603000405020802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000107090603000405020802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch includes drivers/serial/Kconfig, drivers/serial/Makefile, 
serial_core.h and Makefile for jsm device driver.

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>

--------------000107090603000405020802
Content-Type: text/plain;
 name="patch7.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch7.jasmine"

diff -Nuar linux-2.6.9.orig/drivers/serial/Kconfig linux-2.6.9.new/drivers/serial/Kconfig
--- linux-2.6.9.orig/drivers/serial/Kconfig	2005-02-18 09:08:04.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/Kconfig	2005-02-27 17:03:04.597029080 -0600
@@ -572,5 +572,20 @@
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called icom.
+
+config SERIAL_JSM
+        tristate "Digi International NEO PCI Support"
+        select SERIAL_CORE
+        help
+          This is a driver for Digi International's Neo series
+          of cards which provide multiple serial ports. You would need
+          something like this to connect more than two modems to your Linux
+          box, for instance in order to become a dial-in server. This driver
+          supports PCI boards only.
+          If you have a card like this, say Y here and read the file
+          <file:Documentation/digidgnc.txt>.
+
+          To compile this driver as a module, choose M here: the
+          module will be called jsm.
 endmenu
 
diff -Nuar linux-2.6.9.orig/drivers/serial/Makefile linux-2.6.9.new/drivers/serial/Makefile
--- linux-2.6.9.orig/drivers/serial/Makefile	2005-02-18 09:08:10.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/Makefile	2005-02-27 17:03:32.251950560 -0600
@@ -37,3 +37,4 @@
 obj-$(CONFIG_SERIAL_DZ) += dz.o
 obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
 obj-$(CONFIG_SERIAL_ICOM) += icom.o
+obj-$(CONFIG_SERIAL_JSM) += jsm/
diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/Makefile linux-2.6.9.new/drivers/serial/jsm/Makefile
--- linux-2.6.9.orig/drivers/serial/jsm/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.9.new/drivers/serial/jsm/Makefile	2005-02-27 17:01:43.725941288 -0600
@@ -0,0 +1,36 @@
+##################################################################
+# Copyright 2003 Digi International (www.digi.com)
+# Scott H Kilau <Scott_Kilau at digi dot com>
+# 
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2, or (at your option)
+# any later version.
+# 
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
+# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+# PURPOSE.  See the GNU General Public License for more details.
+# 
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+# 
+# 
+#       NOTE TO LINUX KERNEL HACKERS:  DO NOT REFORMAT THIS CODE!
+# 
+#       Send any bug fixes/changes to:  Eng.Linux at digi dot com.
+#       Thank you.
+# 
+# 
+##################################################################
+
+#
+# Makefile for Jasmine adapter
+#
+
+obj-$(CONFIG_SERIAL_JSM) += jsm.o
+
+jsm-objs :=    jsm_driver.o jsm_mgmt.o jsm_neo.o\
+               jsm_proc.o jsm_tty.o
+
diff -Nuar linux-2.6.9.orig/include/linux/serial_core.h linux-2.6.9.new/include/linux/serial_core.h
--- linux-2.6.9.orig/include/linux/serial_core.h	2005-02-18 09:31:07.000000000 -0600
+++ linux-2.6.9.new/include/linux/serial_core.h	2005-02-18 09:09:59.000000000 -0600
@@ -86,6 +86,9 @@
 /* IBM icom */
 #define PORT_ICOM	55
 
+/*Digi dgnc */
+#define PORT_JSM	56
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>

--------------000107090603000405020802--

