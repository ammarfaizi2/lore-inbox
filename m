Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424771AbWKQFlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424771AbWKQFlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424769AbWKQFlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:41:45 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:65150 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1162375AbWKQFlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:41:40 -0500
Date: Thu, 16 Nov 2006 21:36:48 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] ftape: fix printk format warnings
Message-Id: <20061116213648.16b35f50.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warnings:
drivers/char/ftape/zftape/zftape-buffers.c:87: warning: format '%d' expects type 
'int', but argument 3 has type 'size_t'
drivers/char/ftape/zftape/zftape-buffers.c:104: warning: format '%d' expects type
 'int', but argument 3 has type 'size_t'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/ftape/zftape/zftape-buffers.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2619-rc5mm2.orig/drivers/char/ftape/zftape/zftape-buffers.c
+++ linux-2619-rc5mm2/drivers/char/ftape/zftape/zftape-buffers.c
@@ -85,7 +85,7 @@ int zft_vmalloc_once(void *new, size_t s
 		peak_memory = used_memory;
 	}
 	TRACE_ABORT(0, ft_t_noise,
-		    "allocated buffer @ %p, %d bytes", *(void **)new, size);
+		    "allocated buffer @ %p, %zd bytes", *(void **)new, size);
 }
 int zft_vmalloc_always(void *new, size_t size)
 {
@@ -101,7 +101,7 @@ void zft_vfree(void *old, size_t size)
 	if (*(void **)old) {
 		vfree(*(void **)old);
 		used_memory -= size;
-		TRACE(ft_t_noise, "released buffer @ %p, %d bytes",
+		TRACE(ft_t_noise, "released buffer @ %p, %zd bytes",
 		      *(void **)old, size);
 		*(void **)old = NULL;
 	}


---
