Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWFJUdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWFJUdK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 16:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWFJUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 16:33:10 -0400
Received: from xenotime.net ([66.160.160.81]:29333 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751697AbWFJUdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 16:33:09 -0400
Date: Sat, 10 Jun 2006 13:28:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org, akpm <akpm@osdl.org>
Subject: [PATCH] jffs2: fix section mismatches
Message-Id: <20060610132803.8909971c.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Priority: not critical; makes init code discardable.

Fix section mismatch warnings:
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to .init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' (at offset 0x546) and 'jffs2_compressors_exit'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/jffs2/compr.c       |    2 +-
 fs/jffs2/compr_rtime.c |    2 +-
 fs/jffs2/compr_rubin.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2617-rc6.orig/fs/jffs2/compr.c
+++ linux-2617-rc6/fs/jffs2/compr.c
@@ -412,7 +412,7 @@ void jffs2_free_comprbuf(unsigned char *
                 kfree(comprbuf);
 }
 
-int jffs2_compressors_init(void)
+int __init jffs2_compressors_init(void)
 {
 /* Registering compressors */
 #ifdef CONFIG_JFFS2_ZLIB
--- linux-2617-rc6.orig/fs/jffs2/compr_rtime.c
+++ linux-2617-rc6/fs/jffs2/compr_rtime.c
@@ -121,7 +121,7 @@ static struct jffs2_compressor jffs2_rti
 #endif
 };
 
-int jffs2_rtime_init(void)
+int __init jffs2_rtime_init(void)
 {
     return jffs2_register_compressor(&jffs2_rtime_comp);
 }
--- linux-2617-rc6.orig/fs/jffs2/compr_rubin.c
+++ linux-2617-rc6/fs/jffs2/compr_rubin.c
@@ -344,7 +344,7 @@ static struct jffs2_compressor jffs2_rub
 #endif
 };
 
-int jffs2_rubinmips_init(void)
+int __init jffs2_rubinmips_init(void)
 {
     return jffs2_register_compressor(&jffs2_rubinmips_comp);
 }
@@ -367,7 +367,7 @@ static struct jffs2_compressor jffs2_dyn
 #endif
 };
 
-int jffs2_dynrubin_init(void)
+int __init jffs2_dynrubin_init(void)
 {
     return jffs2_register_compressor(&jffs2_dynrubin_comp);
 }


---
