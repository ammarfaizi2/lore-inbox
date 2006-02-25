Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWBYNSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWBYNSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWBYNSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:18:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44549 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030186AbWBYNSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:18:15 -0500
Date: Sat, 25 Feb 2006 14:18:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/params.c: make param_array() static
Message-ID: <20060225131814.GM3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
> +remove-module_parm.patch
>...
>  Current 2.6.16 queue.  Some of these are a bit questionable at this stage.
>...


param_array() in kernel/params.c can now become static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/moduleparam.h |    7 -------
 kernel/params.c             |   12 ++++++------
 2 files changed, 6 insertions(+), 13 deletions(-)

--- linux-2.6.16-rc4-mm2-full/include/linux/moduleparam.h.old	2006-02-25 04:39:11.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/include/linux/moduleparam.h	2006-02-25 04:40:01.000000000 +0100
@@ -162,13 +162,6 @@
 extern int param_set_copystring(const char *val, struct kernel_param *kp);
 extern int param_get_string(char *buffer, struct kernel_param *kp);
 
-int param_array(const char *name,
-		const char *val,
-		unsigned int min, unsigned int max,
-		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp),
-		int *num);
-
 /* for exporting parameters in /sys/parameters */
 
 struct module;
--- linux-2.6.16-rc4-mm2-full/kernel/params.c.old	2006-02-25 04:40:07.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/kernel/params.c	2006-02-25 04:42:55.000000000 +0100
@@ -265,12 +265,12 @@
 }
 
 /* We cheat here and temporarily mangle the string. */
-int param_array(const char *name,
-		const char *val,
-		unsigned int min, unsigned int max,
-		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp),
-		int *num)
+static int param_array(const char *name,
+		       const char *val,
+		       unsigned int min, unsigned int max,
+		       void *elem, int elemsize,
+		       int (*set)(const char *, struct kernel_param *kp),
+		       int *num)
 {
 	int ret;
 	struct kernel_param kp;

