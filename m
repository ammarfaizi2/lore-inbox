Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVCVDo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVCVDo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVCVCXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:23:35 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:49547 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262351AbVCVBgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:20 -0500
Message-Id: <20050322013457.707786000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:58 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Francois Romieu <romieu@fr.zoreil.com>
Content-Disposition: inline; filename=dvb-saa7146-static-init.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 25/48] saa7146: static initialization
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Static initialization.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 saa7146_core.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/common/saa7146_core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/common/saa7146_core.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/common/saa7146_core.c	2005-03-22 00:18:04.000000000 +0100
@@ -20,11 +20,9 @@
 
 #include <media/saa7146.h>
 
-/* global variables */
-struct list_head saa7146_devices;
-struct semaphore saa7146_devices_lock;
+LIST_HEAD(saa7146_devices);
+DECLARE_MUTEX(saa7146_devices_lock);
 
-static int initialized = 0;
 static int saa7146_num = 0;
 
 unsigned int saa7146_debug = 0;
@@ -527,12 +525,6 @@ int saa7146_register_extension(struct sa
 {
 	DEB_EE(("ext:%p\n",ext));
 
-	if( 0 == initialized ) {
-		INIT_LIST_HEAD(&saa7146_devices);
-		init_MUTEX(&saa7146_devices_lock);
-		initialized = 1;
-	}
-
 	ext->driver.name = ext->name;
 	ext->driver.id_table = ext->pci_tbl;
 	ext->driver.probe = saa7146_init_one;
@@ -550,23 +542,6 @@ int saa7146_unregister_extension(struct 
 	return 0;
 }
 
-static int __init saa7146_init_module(void)
-{
-	if( 0 == initialized ) {
-		INIT_LIST_HEAD(&saa7146_devices);
-		init_MUTEX(&saa7146_devices_lock);
-		initialized = 1;
-	}
-	return 0;
-}
-
-static void __exit saa7146_cleanup_module(void)
-{
-}
-
-module_init(saa7146_init_module);
-module_exit(saa7146_cleanup_module);
-
 EXPORT_SYMBOL_GPL(saa7146_register_extension);
 EXPORT_SYMBOL_GPL(saa7146_unregister_extension);
 

--

