Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbVCDXIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbVCDXIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbVCDXEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:04:09 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:13712 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263218AbVCDVJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:09:03 -0500
Message-ID: <4228CE68.5040101@us.ltcfwd.linux.ibm.com>
Date: Fri, 04 Mar 2005 16:08:56 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 7/7] drivers/serial/jsm: new serial device driver
References: <42225A74.3040404@us.ltcfwd.linux.ibm.com> <20050228032356.GC5300@infradead.org>
In-Reply-To: <20050228032356.GC5300@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------070303040407070304090203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303040407070304090203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:

>>+config SERIAL_JSM
>>+        tristate "Digi International NEO PCI Support"
>>+        select SERIAL_CORE
>>    
>>
>
>shouldn't this depend on CONFIG_PCI?
>
>  
>
>>diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/Makefile linux-2.6.9.new/drivers/serial/jsm/Makefile
>>--- linux-2.6.9.orig/drivers/serial/jsm/Makefile	1969-12-31 18:00:00.000000000 -0600
>>+++ linux-2.6.9.new/drivers/serial/jsm/Makefile	2005-02-27 17:01:43.725941288 -0600
>>@@ -0,0 +1,36 @@
>>+##################################################################
>>+# Copyright 2003 Digi International (www.digi.com)
>>+# Scott H Kilau <Scott_Kilau at digi dot com>
>>+# 
>>+# This program is free software; you can redistribute it and/or modify
>>+# it under the terms of the GNU General Public License as published by
>>+# the Free Software Foundation; either version 2, or (at your option)
>>+# any later version.
>>+# 
>>+# This program is distributed in the hope that it will be useful,
>>+# but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
>>+# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
>>+# PURPOSE.  See the GNU General Public License for more details.
>>+# 
>>+# You should have received a copy of the GNU General Public License
>>+# along with this program; if not, write to the Free Software
>>+# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>+# 
>>+# 
>>+#       NOTE TO LINUX KERNEL HACKERS:  DO NOT REFORMAT THIS CODE!
>>+# 
>>+#       Send any bug fixes/changes to:  Eng.Linux at digi dot com.
>>+#       Thank you.
>>+# 
>>+# 
>>+##################################################################
>>+
>>+#
>>+# Makefile for Jasmine adapter
>>+#
>>+
>>+obj-$(CONFIG_SERIAL_JSM) += jsm.o
>>+
>>+jsm-objs :=    jsm_driver.o jsm_mgmt.o jsm_neo.o\
>>+               jsm_proc.o jsm_tty.o
>>+
>>    
>>
>
>I doubt anyone can register a copyright on a trivial three-line makefile.
>Also please use jsm-y instead of jsm-objs.
>
>
>  
>
Hi Christoph,

Thanks for your comments here!
wendy

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>



--------------070303040407070304090203
Content-Type: text/plain;
 name="patch7.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch7.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/Kconfig linux-2.6.11.new/drivers/serial/Kconfig
--- linux-2.6.11.org/drivers/serial/Kconfig	2005-03-04 14:58:19.650874384 -0600
+++ linux-2.6.11.new/drivers/serial/Kconfig	2005-03-04 14:53:06.598937400 -0600
@@ -810,4 +810,19 @@
 	bool "TX39XX/49XX SIO act as standard serial"
 	depends on !SERIAL_8250 && SERIAL_TXX9
 
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
+          <file:Documentation/jsm.txt>.
+
+          To compile this driver as a module, choose M here: the
+          module will be called jsm.
+
 endmenu
diff -Nuar linux-2.6.11.org/drivers/serial/Makefile linux-2.6.11.new/drivers/serial/Makefile
--- linux-2.6.11.org/drivers/serial/Makefile	2005-03-04 14:58:11.681887760 -0600
+++ linux-2.6.11.new/drivers/serial/Makefile	2005-03-04 14:53:16.985954944 -0600
@@ -49,3 +49,4 @@
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
 obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
+obj-$(CONFIG_SERIAL_JSM) += jsm/
diff -Nuar linux-2.6.11.org/drivers/serial/jsm/Makefile linux-2.6.11.new/drivers/serial/jsm/Makefile
--- linux-2.6.11.org/drivers/serial/jsm/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/Makefile	2005-03-04 14:56:26.655878032 -0600
@@ -0,0 +1,10 @@
+# #######################################################################/
+#
+# Makefile for Jasmine adapter
+#
+
+obj-$(CONFIG_SERIAL_JSM) += jsm.o
+
+jsm-objs :=    jsm_driver.o jsm_mgmt.o jsm_neo.o\
+               jsm_tty.o jsm_sysfs.o
+
diff -Nuar linux-2.6.11.org/include/linux/pci_ids.h linux-2.6.11.new/include/linux/pci_ids.h
--- linux-2.6.11.org/include/linux/pci_ids.h	2005-03-04 14:57:38.115931232 -0600
+++ linux-2.6.11.new/include/linux/pci_ids.h	2005-03-04 15:00:11.796998872 -0600
@@ -1418,6 +1418,15 @@
 #define PCI_DEVICE_ID_DIGI_DF_M_E	0x0071
 #define PCI_DEVICE_ID_DIGI_DF_M_IOM2_A	0x0072
 #define PCI_DEVICE_ID_DIGI_DF_M_A	0x0073
+#define PCI_DEVICE_ID_NEO_4             0x00B0
+#define PCI_DEVICE_ID_NEO_8             0x00B1
+#define PCI_DEVICE_ID_NEO_2DB9          0x00C8
+#define PCI_DEVICE_ID_NEO_2DB9PRI       0x00C9
+#define PCI_DEVICE_ID_NEO_2RJ45         0x00CA
+#define PCI_DEVICE_ID_NEO_2RJ45PRI      0x00CB
+#define PCI_DEVICE_ID_NEO_1_422         0x00CC
+#define PCI_DEVICE_ID_NEO_1_422_485     0x00CD
+#define PCI_DEVICE_ID_NEO_2_422_485     0x00CE
 
 #define PCI_VENDOR_ID_MUTECH		0x1159
 #define PCI_DEVICE_ID_MUTECH_MV1000	0x0001
diff -Nuar linux-2.6.11.org/include/linux/serial_core.h linux-2.6.11.new/include/linux/serial_core.h
--- linux-2.6.11.org/include/linux/serial_core.h	2005-03-04 14:57:26.320993400 -0600
+++ linux-2.6.11.new/include/linux/serial_core.h	2005-03-04 15:00:40.654872952 -0600
@@ -106,6 +106,9 @@
 /* TXX9 type number */
 #define PORT_TXX9       64
 
+/* Digi jsm */
+#define PORT_JSM	65
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>

--------------070303040407070304090203--

