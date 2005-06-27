Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVF0TLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVF0TLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVF0TIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:08:10 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:57076 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261620AbVF0TGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:06:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lT38RfrSYQG+oI6Rz2z1QUjP7RkJX/LRknbChrzYTebKVDXR5SbXJirAbZ4Ujz3raQCF4UR4aHqjaWO+FwfDjsiB0TnirT8Y+ELhb2bVOfqYo1m4VX/emv7yV+FF2HGWb2kj8jrWt6wO9DDByedORCCiGafXYcRQN3LCNOmAHcc=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>, Randy Dunlap <rddunlap@osdl.org>
Subject: [PATCH] kexec: fix sparse warnings
Date: Mon, 27 Jun 2005 23:12:29 +0400
User-Agent: KMail/1.7.2
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506272312.29445.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-sparse/kernel/kexec.c
===================================================================
--- linux-sparse.orig/kernel/kexec.c	2005-06-27 09:32:52.000000000 +0400
+++ linux-sparse/kernel/kexec.c	2005-06-27 23:08:00.000000000 +0400
@@ -241,7 +241,7 @@ static int kimage_normal_alloc(struct ki
 
 static int kimage_crash_alloc(struct kimage **rimage, unsigned long entry,
 				unsigned long nr_segments,
-				struct kexec_segment *segments)
+				struct kexec_segment __user *segments)
 {
 	int result;
 	struct kimage *image;
@@ -650,7 +650,7 @@ static kimage_entry_t *kimage_dst_used(s
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 static struct page *kimage_alloc_page(struct kimage *image,
@@ -696,7 +696,7 @@ static struct page *kimage_alloc_page(st
 		/* Allocate a page, if we run out of memory give up */
 		page = kimage_alloc_pages(gfp_mask, 0);
 		if (!page)
-			return 0;
+			return NULL;
 		/* If the page cannot be used file it away */
 		if (page_to_pfn(page) >
 				(KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
@@ -754,7 +754,7 @@ static int kimage_load_normal_segment(st
 	unsigned long maddr;
 	unsigned long ubytes, mbytes;
 	int result;
-	unsigned char *buf;
+	unsigned char __user *buf;
 
 	result = 0;
 	buf = segment->buf;
@@ -818,7 +818,7 @@ static int kimage_load_crash_segment(str
 	unsigned long maddr;
 	unsigned long ubytes, mbytes;
 	int result;
-	unsigned char *buf;
+	unsigned char __user *buf;
 
 	result = 0;
 	buf = segment->buf;
