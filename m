Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVAJRjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVAJRjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVAJRjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:39:01 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:18055 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262342AbVAJRVA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:00 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <1105377657272@kroah.com>
Date: Mon, 10 Jan 2005 09:20:57 -0800
Message-Id: <11053776572169@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.3, 2004/12/16 15:59:03-08:00, bunk@stusta.de

[PATCH] PCI Hotplug: drivers/pci/hotplug/ : simply use MODULE

The patch below lets five files under drivers/pci/hotplug/ simply use
MODULE to check whether they are compiled as part of a module.

MODULE is the common idiom for checking whether a file is built as part
of a module.

In theory, my patch shouldn't have made any difference, but if you look
closely, the previous #if's in cpcihp_generic.c and cpci_hotplug_pci.c
weren't correct.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpci_hotplug_pci.c |    2 +-
 drivers/pci/hotplug/cpcihp_generic.c   |    2 +-
 drivers/pci/hotplug/fakephp.c          |    2 +-
 drivers/pci/hotplug/ibmphp.h           |    2 +-
 drivers/pci/hotplug/shpchp.h           |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c	2005-01-10 09:05:51 -08:00
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c	2005-01-10 09:05:51 -08:00
@@ -32,7 +32,7 @@
 #include "pci_hotplug.h"
 #include "cpci_hotplug.h"
 
-#if !defined(CONFIG_HOTPLUG_CPCI_MODULE)
+#if !defined(MODULE)
 #define MY_NAME	"cpci_hotplug"
 #else
 #define MY_NAME	THIS_MODULE->name
diff -Nru a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
--- a/drivers/pci/hotplug/cpcihp_generic.c	2005-01-10 09:05:51 -08:00
+++ b/drivers/pci/hotplug/cpcihp_generic.c	2005-01-10 09:05:51 -08:00
@@ -45,7 +45,7 @@
 #define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
 #define DRIVER_DESC	"Generic port I/O CompactPCI Hot Plug Driver"
 
-#if !defined(CONFIG_HOTPLUG_CPCI_GENERIC_MODULE)
+#if !defined(MODULE)
 #define MY_NAME	"cpcihp_generic"
 #else
 #define MY_NAME	THIS_MODULE->name
diff -Nru a/drivers/pci/hotplug/fakephp.c b/drivers/pci/hotplug/fakephp.c
--- a/drivers/pci/hotplug/fakephp.c	2005-01-10 09:05:51 -08:00
+++ b/drivers/pci/hotplug/fakephp.c	2005-01-10 09:05:51 -08:00
@@ -40,7 +40,7 @@
 #include "pci_hotplug.h"
 #include "../pci.h"
 
-#if !defined(CONFIG_HOTPLUG_PCI_FAKE_MODULE)
+#if !defined(MODULE)
 	#define MY_NAME	"fakephp"
 #else
 	#define MY_NAME	THIS_MODULE->name
diff -Nru a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
--- a/drivers/pci/hotplug/ibmphp.h	2005-01-10 09:05:51 -08:00
+++ b/drivers/pci/hotplug/ibmphp.h	2005-01-10 09:05:51 -08:00
@@ -34,7 +34,7 @@
 
 extern int ibmphp_debug;
 
-#if !defined(CONFIG_HOTPLUG_PCI_IBM_MODULE)
+#if !defined(MODULE)
 	#define MY_NAME "ibmphpd"
 #else
 	#define MY_NAME THIS_MODULE->name
diff -Nru a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
--- a/drivers/pci/hotplug/shpchp.h	2005-01-10 09:05:51 -08:00
+++ b/drivers/pci/hotplug/shpchp.h	2005-01-10 09:05:51 -08:00
@@ -36,7 +36,7 @@
 #include <asm/io.h>		
 #include "pci_hotplug.h"
 
-#if !defined(CONFIG_HOTPLUG_PCI_SHPC_MODULE)
+#if !defined(MODULE)
 	#define MY_NAME	"shpchp"
 #else
 	#define MY_NAME	THIS_MODULE->name

