Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbULKQ5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbULKQ5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbULKQzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:55:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45575 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261968AbULKQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:55:07 -0500
Date: Sat, 11 Dec 2004 17:54:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: scottm@somanetworks.com, pcihpd-discuss@lists.sourceforge.net,
       greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pci/hotplug/ : simply use MODULE
Message-ID: <20041211165459.GV22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below lets five files under drivers/pci/hotplug/ simply use 
MODULE to check whether they are compiled as part of a module.

MODULE is the common idiom for checking whether a file is built as part 
of a module.

In theory, my patch shouldn't have made any difference, but if you look 
closely, the previous #if's in cpcihp_generic.c and cpci_hotplug_pci.c 
weren't correct.


diffstat output:
 drivers/pci/hotplug/cpci_hotplug_pci.c |    2 +-
 drivers/pci/hotplug/cpcihp_generic.c   |    2 +-
 drivers/pci/hotplug/fakephp.c          |    2 +-
 drivers/pci/hotplug/ibmphp.h           |    2 +-
 drivers/pci/hotplug/shpchp.h           |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/ibmphp.h.old	2004-12-11 17:35:11.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/ibmphp.h	2004-12-11 17:35:26.000000000 +0100
@@ -34,7 +34,7 @@
 
 extern int ibmphp_debug;
 
-#if !defined(CONFIG_HOTPLUG_PCI_IBM_MODULE)
+#if !defined(MODULE)
 	#define MY_NAME "ibmphpd"
 #else
 	#define MY_NAME THIS_MODULE->name
--- linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/cpcihp_generic.c.old	2004-12-11 17:35:45.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/cpcihp_generic.c	2004-12-11 17:35:56.000000000 +0100
@@ -45,7 +45,7 @@
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"Generic port I/O CompactPCI Hot Plug Driver"
 
-#if !defined(CONFIG_HOTPLUG_CPCI_GENERIC_MODULE)
+#if !defined(MODULE)
 #define MY_NAME	"cpcihp_generic"
 #else
 #define MY_NAME	THIS_MODULE->name
--- linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/cpci_hotplug_pci.c.old	2004-12-11 17:38:45.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/cpci_hotplug_pci.c	2004-12-11 17:38:58.000000000 +0100
@@ -32,7 +32,7 @@
 #include "pci_hotplug.h"
 #include "cpci_hotplug.h"
 
-#if !defined(CONFIG_HOTPLUG_CPCI_MODULE)
+#if !defined(MODULE)
 #define MY_NAME	"cpci_hotplug"
 #else
 #define MY_NAME	THIS_MODULE->name
--- linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/fakephp.c.old	2004-12-11 17:39:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/fakephp.c	2004-12-11 17:39:23.000000000 +0100
@@ -40,7 +40,7 @@
 #include "pci_hotplug.h"
 #include "../pci.h"
 
-#if !defined(CONFIG_HOTPLUG_PCI_FAKE_MODULE)
+#if !defined(MODULE)
 	#define MY_NAME	"fakephp"
 #else
 	#define MY_NAME	THIS_MODULE->name
--- linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/shpchp.h.old	2004-12-11 17:39:49.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/pci/hotplug/shpchp.h	2004-12-11 17:40:03.000000000 +0100
@@ -36,7 +36,7 @@
 #include <asm/io.h>		
 #include "pci_hotplug.h"
 
-#if !defined(CONFIG_HOTPLUG_PCI_SHPC_MODULE)
+#if !defined(MODULE)
 	#define MY_NAME	"shpchp"
 #else
 	#define MY_NAME	THIS_MODULE->name

