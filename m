Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVCCVyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVCCVyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVCCVvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:51:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1546 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262618AbVCCVmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:42:40 -0500
Date: Thu, 3 Mar 2005 22:42:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/kexec.c: make kexec_crash_image static
Message-ID: <20050303214233.GM4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/kexec.h |    1 -
 kernel/kexec.c        |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.11-rc5-mm1-full/include/linux/kexec.h.old	2005-03-03 16:34:17.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/include/linux/kexec.h	2005-03-03 16:34:29.000000000 +0100
@@ -101,7 +101,6 @@
 extern struct page *kimage_alloc_control_pages(struct kimage *image, unsigned int order);
 extern void crash_kexec(void);
 extern struct kimage *kexec_image;
-extern struct kimage *kexec_crash_image;
 
 #define KEXEC_ON_CRASH  0x00000001
 #define KEXEC_ARCH_MASK 0xffff0000
--- linux-2.6.11-rc5-mm1-full/kernel/kexec.c.old	2005-03-03 16:34:36.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/kexec.c	2005-03-03 16:36:10.000000000 +0100
@@ -868,7 +868,7 @@
  * that to happen you need to do that yourself.
  */
 struct kimage *kexec_image = NULL;
-struct kimage *kexec_crash_image = NULL;
+static struct kimage *kexec_crash_image = NULL;
 /*
  * A home grown binary mutex.
  * Nothing can wait so this mutex is safe to use

