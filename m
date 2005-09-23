Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVIWXYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVIWXYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIWXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:24:22 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:8249 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751345AbVIWXYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:24:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dBxIsY+LwR75+AZW6e+NyN/3FFh1PdNzyjnHmHGSmQ0YkzVJdhg6B5gqYknPExKZrOHXgBaayDlAcmvLf5DZeoVVGMWBW413nzMhhtYC4Lc2zImCsTn7HJ6yW1Yp9ZvrR+jZWbkunnVM8Kpod4Al2y59mXEeVhWOVw3ChbRS5PA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] inline a few tiny functions in init/initramfs.c
Date: Sat, 24 Sep 2005 01:26:26 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509240126.26575.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few functions in init/initramfs.c are so simple that I don't see why *any* 
point in them having to bear the cost of a function call.
Wouldn't something like the patch below make sense ?


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 init/initramfs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc2-git3-orig/init/initramfs.c	2005-09-22 00:28:39.000000000 +0200
+++ linux-2.6.14-rc2-git3/init/initramfs.c	2005-09-24 01:21:55.000000000 +0200
@@ -14,12 +14,12 @@ static void __init error(char *x)
 		message = x;
 }
 
-static void __init *malloc(size_t size)
+static inline void __init *malloc(size_t size)
 {
 	return kmalloc(size, GFP_KERNEL);
 }
 
-static void __init free(void *where)
+static inline void __init free(void *where)
 {
 	kfree(where);
 }
@@ -155,7 +155,7 @@ static void __init read_into(char *buf, 
 
 static __initdata char *header_buf, *symlink_buf, *name_buf;
 
-static int __init do_start(void)
+static inline int __init do_start(void)
 {
 	read_into(header_buf, 110, GotHeader);
 	return 0;


