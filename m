Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWEEK0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWEEK0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 06:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWEEK0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 06:26:35 -0400
Received: from sd291.sivit.org ([194.146.225.122]:18 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751538AbWEEK0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 06:26:35 -0400
Subject: [PATCH, 2.6.17-rc3-currentgit] jffs2: fix __init usage
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       jffs-dev@axis.com
Content-Type: text/plain
Date: Fri, 05 May 2006 12:26:31 +0200
Message-Id: <1146824791.8237.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling jffs2 as a module gives: 
	WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to
	.init.text:jffs2_zlib_init from .text between 
	'jffs2_compressors_init' (at offset 0xa0) and 'jffs2_compressors_exit'

The attached patch fixes that by adding the correct __init tags to
jffs2_compressors_init() and each compressor initialisation functions.

Signed-off-by: Stelian Pop <stelian@popies.net>

---

 compr.c       |    2 +-
 compr_rtime.c |    2 +-
 compr_rubin.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -r 8d66b80a7a7c fs/jffs2/compr.c
--- a/fs/jffs2/compr.c	Fri May  5 10:50:10 2006 +0200
+++ b/fs/jffs2/compr.c	Fri May  5 11:17:03 2006 +0200
@@ -412,7 +412,7 @@ void jffs2_free_comprbuf(unsigned char *
                 kfree(comprbuf);
 }
 
-int jffs2_compressors_init(void)
+int __init jffs2_compressors_init(void)
 {
 /* Registering compressors */
 #ifdef CONFIG_JFFS2_ZLIB
diff -r 8d66b80a7a7c fs/jffs2/compr_rtime.c
--- a/fs/jffs2/compr_rtime.c	Fri May  5 10:50:10 2006 +0200
+++ b/fs/jffs2/compr_rtime.c	Fri May  5 11:17:03 2006 +0200
@@ -121,7 +121,7 @@ static struct jffs2_compressor jffs2_rti
 #endif
 };
 
-int jffs2_rtime_init(void)
+int __init jffs2_rtime_init(void)
 {
     return jffs2_register_compressor(&jffs2_rtime_comp);
 }
diff -r 8d66b80a7a7c fs/jffs2/compr_rubin.c
--- a/fs/jffs2/compr_rubin.c	Fri May  5 10:50:10 2006 +0200
+++ b/fs/jffs2/compr_rubin.c	Fri May  5 11:17:03 2006 +0200
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


-- 
Stelian Pop <stelian@popies.net>

