Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUE0MtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUE0MtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUE0MtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:49:11 -0400
Received: from pxy3allmi.all.mi.charter.com ([24.247.15.42]:19857 "EHLO
	proxy3-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S262114AbUE0MtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:49:07 -0400
Message-ID: <40B5E3A6.8010806@quark.didntduck.org>
Date: Thu, 27 May 2004 08:48:38 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Mark cache_names __initdata
Content-Type: multipart/mixed;
 boundary="------------040504080705030708060706"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040504080705030708060706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

We don't need to keep the pointer array around after the caches are 
initialized.  This doesn't affect the actual strings.

--
				Brian Gerst

--------------040504080705030708060706
Content-Type: text/plain;
 name="cache_names_init-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cache_names_init-1"

diff -urN linux-2.6.7-rc1-bk/mm/slab.c linux/mm/slab.c
--- linux-2.6.7-rc1-bk/mm/slab.c	2004-05-23 18:41:51.000000000 -0400
+++ linux/mm/slab.c	2004-05-27 08:44:43.751423008 -0400
@@ -477,10 +477,12 @@
 EXPORT_SYMBOL(malloc_sizes);
 
 /* Must match cache_sizes above. Out of line to keep cache footprint low. */
-static struct cache_names {
+struct cache_names {
 	char *name;
 	char *name_dma;
-} cache_names[] = {
+};
+
+static struct cache_names __initdata cache_names[] = {
 #define CACHE(x) { .name = "size-" #x, .name_dma = "size-" #x "(DMA)" },
 #include <linux/kmalloc_sizes.h>
 	{ 0, }

--------------040504080705030708060706--
