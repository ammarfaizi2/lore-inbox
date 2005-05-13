Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVEMWkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVEMWkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVEMWjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:39:52 -0400
Received: from coderock.org ([193.77.147.115]:56725 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262578AbVEMWZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:25:24 -0400
Message-Id: <20050513222410.074609000@nd47.coderock.org>
Date: Sat, 14 May 2005 00:24:08 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Ismail Donmez <ismail@kde.org.tr>,
       domen@coderock.org
Subject: [patch 3/3] Documentation/networking/dmfe.txt: Make documentation nicer
Content-Disposition: inline; filename=documentation-Documentation_networking_dmfe.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ismail Donmez <ismail@kde.org.tr>


Patch indents dmfe.txt to look like other docs. It adds a tip
about CNET cards using Davicom chipsets. Also it removes parts where it
refers to how to build driver out-of-kernel which seems to be cruft from
times where the driver was out of the kernel.

Signed-off-by: Ismail Donmez <ismail@kde.org.tr>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 dmfe.txt |   82 +++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 44 insertions(+), 38 deletions(-)

Index: quilt/Documentation/networking/dmfe.txt
===================================================================
--- quilt.orig/Documentation/networking/dmfe.txt
+++ quilt/Documentation/networking/dmfe.txt
@@ -1,59 +1,65 @@
-  dmfe.c: Version 1.28        01/18/2000
+Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver for Linux.
 
-        A Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver for Linux. 
-        Copyright (C) 1997  Sten Wang
+This program is free software; you can redistribute it and/or
+modify it under the terms of the GNU General   Public License
+as published by the Free Software Foundation; either version 2
+of the License, or (at your option) any later version.
 
-        This program is free software; you can redistribute it and/or
-        modify it under the terms of the GNU General Public License
-        as published by the Free Software Foundation; either version 2
-        of the License, or (at your option) any later version.
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
 
-        This program is distributed in the hope that it will be useful,
-        but WITHOUT ANY WARRANTY; without even the implied warranty of
-        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-        GNU General Public License for more details.
 
+This driver provides kernel support for Davicom DM9102(A)/DM9132/DM9801 ethernet cards ( CNET
+10/100 ethernet cards uses Davicom chipset too, so this driver supports CNET cards too ).If you
+didn't compile this driver as a module, it will automatically load itself on boot and print a
+line similar to :
 
-  A. Compiler command:
+	dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
 
-     A-1: For normal single or multiple processor kernel
-          "gcc -DMODULE -D__KERNEL__ -I/usr/src/linux/net/inet -Wall 
-            -Wstrict-prototypes -O6 -c dmfe.c"
+If you compiled this driver as a module, you have to load it on boot.You can load it with command :
 
-     A-2: For single or multiple processor with kernel module version function
-          "gcc -DMODULE -DMODVERSIONS -D__KERNEL__ -I/usr/src/linux/net/inet 
-            -Wall -Wstrict-prototypes -O6 -c dmfe.c"
+	insmod dmfe
 
+This way it will autodetect the device mode.This is the suggested way to load the module.Or you can pass
+a mode= setting to module while loading, like :
 
-  B. The following steps teach you how to activate a DM9102 board:
+	insmod dmfe mode=0 # Force 10M Half Duplex
+	insmod dmfe mode=1 # Force 100M Half Duplex
+	insmod dmfe mode=4 # Force 10M Full Duplex
+	insmod dmfe mode=5 # Force 100M Full Duplex
 
-        1. Used the upper compiler command to compile dmfe.c
+Next you should configure your network interface with a command similar to :
 
-        2. Insert dmfe module into kernel
-           "insmod dmfe"        ;;Auto Detection Mode (Suggest)
-           "insmod dmfe mode=0" ;;Force 10M Half Duplex
-           "insmod dmfe mode=1" ;;Force 100M Half Duplex
-           "insmod dmfe mode=4" ;;Force 10M Full Duplex
-           "insmod dmfe mode=5" ;;Force 100M Full Duplex
+	ifconfig eth0 172.22.3.18
+                      ^^^^^^^^^^^
+		     Your IP Adress
 
-        3. Config a dm9102 network interface
-           "ifconfig eth0 172.22.3.18"
-                          ^^^^^^^^^^^ Your IP address
+Then you may have to modify the default routing table with command :
 
-        4. Activate the IP routing table. For some distributions, it is not
-           necessary. You can type "route" to check.
+	route add default eth0
 
-           "route add default eth0"
 
+Now your ethernet card should be up and running.
 
-        5. Well done. Your DM9102 adapter is now activated.
 
+TODO:
 
-   C. Object files description:
-        1. dmfe_rh61.o:       	For Redhat 6.1
+Implement pci_driver::suspend() and pci_driver::resume() power management methods.
+Check on 64 bit boxes.
+Check and fix on big endian boxes.
+Test and make sure PCI latency is now correct for all cases.
 
-        If you can make sure your kernel version, you can rename
-        to dmfe.o and directly use it without re-compiling.
 
+Authors:
 
-  Author: Sten Wang, 886-3-5798797-8517, E-mail: sten_wang@davicom.com.tw
+Sten Wang <sten_wang@davicom.com.tw >   : Original Author
+Tobias Ringstrom <tori@unhappy.mine.nu> : Current Maintainer
+
+Contributors:
+
+Marcelo Tosatti <marcelo@conectiva.com.br>
+Alan Cox <alan@redhat.com>
+Jeff Garzik <jgarzik@pobox.com>
+Vojtech Pavlik <vojtech@suse.cz>

--
