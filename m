Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbTDEPLP (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 10:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTDEPLP (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 10:11:15 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:25521 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261393AbTDEPLN (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 10:11:13 -0500
Date: Sat, 5 Apr 2003 17:22:44 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: Linux 2.4.21-pre7 agpgart_be.c warnings fix
Message-ID: <Pine.LNX.4.51.0304051721170.3047@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Shortly.
To fix this:
agpgart_be.c: In function `agp_generic_create_gatt_table':
agpgart_be.c:580: warning: assignment from incompatible pointer type
agpgart_be.c: In function `amd_create_gatt_table':
agpgart_be.c:2453: warning: assignment from incompatible pointer type
agpgart_be.c:2454: warning: assignment from incompatible pointer type
agpgart_be.c: In function `amd_free_gatt_table':
agpgart_be.c:2480: warning: assignment from incompatible pointer type
agpgart_be.c:2481: warning: assignment from incompatible pointer type

I recommend this patch.

Regards,
Maciej

diff -Nru linux-2.4.20.orig/drivers/char/agp/agpgart_be.c linux-2.4.20/drivers/char/agp/agpgart_be.c
--- linux-2.4.20.orig/drivers/char/agp/agpgart_be.c	2003-04-05 17:02:17.000000000 +0200
+++ linux-2.4.20/drivers/char/agp/agpgart_be.c	2003-04-05 17:19:07.000000000 +0200
@@ -577,7 +577,7 @@
 	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
 		SetPageReserved(page);

-	agp_bridge.gatt_table_real = (unsigned long *) table;
+	agp_bridge.gatt_table_real = (u32 *) table;
 	agp_gatt_table = (void *)table;
 #ifdef CONFIG_X86
 	err = change_page_attr(virt_to_page(table), 1<<page_order, PAGE_KERNEL_NOCACHE);
@@ -2315,8 +2315,8 @@
 #ifdef CONFIG_AGP_AMD

 typedef struct _amd_page_map {
-	unsigned long *real;
-	unsigned long *remapped;
+	u32 *real;
+	u32 *remapped;
 } amd_page_map;

 static struct _amd_irongate_private {
@@ -2330,7 +2330,7 @@
 	int i;
 	int err = 0;

-	page_map->real = (unsigned long *) __get_free_page(GFP_KERNEL);
+	page_map->real = (u32 *) __get_free_page(GFP_KERNEL);
 	if (page_map->real == NULL) {
 		return -ENOMEM;
 	}
@@ -2590,7 +2590,7 @@
 			     off_t pg_start, int type)
 {
 	int i, j, num_entries;
-	unsigned long *cur_gatt;
+	u32 *cur_gatt;
 	unsigned long addr;

 	num_entries = A_SIZE_LVL2(agp_bridge.current_size)->num_entries;
@@ -2631,7 +2631,7 @@
 			     int type)
 {
 	int i;
-	unsigned long *cur_gatt;
+	u32 *cur_gatt;
 	unsigned long addr;

 	if (type != 0 || mem->type != 0) {
