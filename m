Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267198AbUFZRhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267198AbUFZRhD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267200AbUFZRhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:37:03 -0400
Received: from [62.29.0.8] ([62.29.0.8]:1920 "EHLO localhost")
	by vger.kernel.org with ESMTP id S267198AbUFZRg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:36:56 -0400
From: ismail donmez <kde@myrealbox.com>
Organization: Bogazici University
To: trivial@rustcorp.com.au
Subject: [PATCH] Better documentation for Davicom ethernet cards
Date: Sun, 20 Jun 2004 13:34:05 +0300
User-Agent: KMail/1.6.82
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200406201334.05568.kde@myrealbox.com>
Reply-To: kde@myrealbox.com
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dgW1AVlX3/3NlTY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_dgW1AVlX3/3NlTY
Content-Type: text/plain;
  charset="us-ascii";
  boundary=""
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Actually this is not a rewrite of old documentation. But I removed useless 
parts ( like GPL decleration is not needed in documentation ) and make it 
more readable. Also added hint that CNET 10/100 Ethernet card uses Davicom 
chipset.

Don't know if its necessary for small patches like this but I added a 
Signed-off part in case.

Regards,
ismail donmez

P.S : I am not subscribed CC me in case.

Signed-off-by: ismail donmez <ismail.donmez@boun.edu.tr>

-- 
Time is what you make of it.

--Boundary-00=_dgW1AVlX3/3NlTY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dmfe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dmfe.patch"

--- linux/Documentation/networking/dmfe.txt	2004-06-20 12:17:24.000000000 +0300
+++ linux/Documentation/networking/dmfe-new.txt	2004-06-20 12:18:45.000000000 +0300
@@ -1,59 +1,54 @@
-  dmfe.c: Version 1.28        01/18/2000
+Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver for Linux. 
 
-        A Davicom DM9102(A)/DM9132/DM9801 fast ethernet driver for Linux. 
-        Copyright (C) 1997  Sten Wang
+This driver provides kernel support for Davicom DM9102(A)/DM9132/DM9801 ethernet cards ( CNET
+10/100 ethernet cards uses Davicom chipset too, so this driver supports CNET cards too ).If you
+didn't compile this driver as a module, it will automatically load itself on boot and print a 
+line similar to :
 
-        This program is free software; you can redistribute it and/or
-        modify it under the terms of the GNU General Public License
-        as published by the Free Software Foundation; either version 2
-        of the License, or (at your option) any later version.
+	dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
 
-        This program is distributed in the hope that it will be useful,
-        but WITHOUT ANY WARRANTY; without even the implied warranty of
-        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-        GNU General Public License for more details.
+If you compiled this driver as a module, you have to load it on boot.You can load it with command :
 
+	insmod dmfe
 
-  A. Compiler command:
+This way it will autodetect the device mode.This is the suggested way to load the module.Or you can pass
+a mode= setting to module while loading, like :
 
-     A-1: For normal single or multiple processor kernel
-          "gcc -DMODULE -D__KERNEL__ -I/usr/src/linux/net/inet -Wall 
-            -Wstrict-prototypes -O6 -c dmfe.c"
+	insmod dmfe mode=0 # Force 10M Half Duplex
+        insmod dmfe mode=1 # Force 100M Half Duplex
+        insmod dmfe mode=4 # Force 10M Full Duplex
+        insmod dmfe mode=5 # Force 100M Full Duplex
 
-     A-2: For single or multiple processor with kernel module version function
-          "gcc -DMODULE -DMODVERSIONS -D__KERNEL__ -I/usr/src/linux/net/inet 
-            -Wall -Wstrict-prototypes -O6 -c dmfe.c"
+Next you should configure your network interface with a command similar to :
 
+	ifconfig eth0 172.22.3.18
+                      ^^^^^^^^^^^
+		     Your IP Adress
 
-  B. The following steps teach you how to activate a DM9102 board:
+Then you may have to modify the default routing table with command :
 
-        1. Used the upper compiler command to compile dmfe.c
+	route add default eth0
 
-        2. Insert dmfe module into kernel
-           "insmod dmfe"        ;;Auto Detection Mode (Suggest)
-           "insmod dmfe mode=0" ;;Force 10M Half Duplex
-           "insmod dmfe mode=1" ;;Force 100M Half Duplex
-           "insmod dmfe mode=4" ;;Force 10M Full Duplex
-           "insmod dmfe mode=5" ;;Force 100M Full Duplex
 
-        3. Config a dm9102 network interface
-           "ifconfig eth0 172.22.3.18"
-                          ^^^^^^^^^^^ Your IP address
+Now your ethernet card should be up and running.
 
-        4. Activate the IP routing table. For some distributions, it is not
-           necessary. You can type "route" to check.
 
-           "route add default eth0"
+TODO:
 
+Implement pci_driver::suspend() and pci_driver::resume() power management methods.
+Check on 64 bit boxes.
+Check and fix on big endian boxes.
+Test and make sure PCI latency is now correct for all cases.
 
-        5. Well done. Your DM9102 adapter is now activated.
 
+Authors:
 
-   C. Object files description:
-        1. dmfe_rh61.o:       	For Redhat 6.1
+Sten Wang <sten_wang@davicom.com.tw >   : Original Author
+Tobias Ringstrom <tori@unhappy.mine.nu> : Current Maintainer
 
-        If you can make sure your kernel version, you can rename
-        to dmfe.o and directly use it without re-compiling.
+Contributors:
 
-
-  Author: Sten Wang, 886-3-5798797-8517, E-mail: sten_wang@davicom.com.tw
+Marcelo Tosatti <marcelo@conectiva.com.br>
+Alan Cox <alan@redhat.com>
+Jeff Garzik <jgarzik@pobox.com>
+Vojtech Pavlik <vojtech@suse.cz>

--Boundary-00=_dgW1AVlX3/3NlTY--
