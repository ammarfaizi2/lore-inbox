Return-Path: <linux-kernel-owner+w=401wt.eu-S1751040AbXAFBG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbXAFBG7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbXAFBG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:06:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2524 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751040AbXAFBG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:06:58 -0500
Date: Sat, 6 Jan 2007 02:07:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make proc_dointvec_taint() static
Message-ID: <20070106010701.GG20714@stusta.de>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104220200.ae4e9a46.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 10:02:00PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc2-mm1:
>...
> +add-taint_user-and-ability-to-set-taint-flags-from-userspace.patch
>...
>  Misc fixes and updates
>...

This patch makes the needlessly global proc_dointvec_taint() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/sysctl.h |    2 --
 kernel/sysctl.c        |    7 +++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.20-rc3-mm1/include/linux/sysctl.h.old	2007-01-05 23:28:46.000000000 +0100
+++ linux-2.6.20-rc3-mm1/include/linux/sysctl.h	2007-01-05 23:28:54.000000000 +0100
@@ -929,8 +929,6 @@
 			 void __user *, size_t *, loff_t *);
 extern int proc_dointvec_bset(ctl_table *, int, struct file *,
 			      void __user *, size_t *, loff_t *);
-extern int proc_dointvec_taint(ctl_table *, int, struct file *,
-			       void __user *, size_t *, loff_t *);
 extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
 				void __user *, size_t *, loff_t *);
 extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
--- linux-2.6.20-rc3-mm1/kernel/sysctl.c.old	2007-01-05 23:29:05.000000000 +0100
+++ linux-2.6.20-rc3-mm1/kernel/sysctl.c	2007-01-05 23:30:31.000000000 +0100
@@ -181,6 +181,9 @@
 int sysctl_legacy_va_layout;
 #endif
 
+static int proc_dointvec_taint(ctl_table *table, int write, struct file *filp,
+			       void __user *buffer, size_t *lenp, loff_t *ppos);
+
 static void *get_uts(ctl_table *table, int write)
 {
 	char *which = table->data;
@@ -2022,8 +2025,8 @@
 /*
  *	Taint values can only be increased
  */
-int proc_dointvec_taint(ctl_table *table, int write, struct file *filp,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_taint(ctl_table *table, int write, struct file *filp,
+			       void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int op;
 

