Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWFSMZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWFSMZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWFSMZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932414AbWFSMZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:05 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/15] frv: sysctl __user annotations
Date: Mon, 19 Jun 2006 13:24:53 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122453.10060.92202.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Add __user annotations to FRV-specific sysctl stuff.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/pm.c     |   40 ++++++++++++++++++++--------------------
 arch/frv/kernel/sysctl.c |    4 ++--
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
index f0b8fff..43ce28a 100644
--- a/arch/frv/kernel/pm.c
+++ b/arch/frv/kernel/pm.c
@@ -137,7 +137,7 @@ #define CTL_PM_CMODE 2
 #define CTL_PM_P0 4
 #define CTL_PM_CM 5
 
-static int user_atoi(char *ubuf, size_t len)
+static int user_atoi(char __user *ubuf, size_t len)
 {
 	char buf[16];
 	unsigned long ret;
@@ -159,7 +159,7 @@ static int user_atoi(char *ubuf, size_t 
  * Send us to sleep.
  */
 static int sysctl_pm_do_suspend(ctl_table *ctl, int write, struct file *filp,
-				void *buffer, size_t *lenp, loff_t *fpos)
+				void __user *buffer, size_t *lenp, loff_t *fpos)
 {
 	int retval, mode;
 
@@ -215,7 +215,7 @@ #endif
 
 
 static int cmode_procctl(ctl_table *ctl, int write, struct file *filp,
-			 void *buffer, size_t *lenp, loff_t *fpos)
+			 void __user *buffer, size_t *lenp, loff_t *fpos)
 {
 	int new_cmode;
 
@@ -227,9 +227,9 @@ static int cmode_procctl(ctl_table *ctl,
 	return try_set_cmode(new_cmode)?:*lenp;
 }
 
-static int cmode_sysctl(ctl_table *table, int *name, int nlen,
-			void *oldval, size_t *oldlenp,
-			void *newval, size_t newlen, void **context)
+static int cmode_sysctl(ctl_table *table, int __user *name, int nlen,
+			void __user *oldval, size_t __user *oldlenp,
+			void __user *newval, size_t newlen, void **context)
 {
 	if (oldval && oldlenp) {
 		size_t oldlen;
@@ -240,7 +240,7 @@ static int cmode_sysctl(ctl_table *table
 		if (oldlen != sizeof(int))
 			return -EINVAL;
 
-		if (put_user(clock_cmode_current, (unsigned int *)oldval) ||
+		if (put_user(clock_cmode_current, (unsigned __user *)oldval) ||
 		    put_user(sizeof(int), oldlenp))
 			return -EFAULT;
 	}
@@ -250,7 +250,7 @@ static int cmode_sysctl(ctl_table *table
 		if (newlen != sizeof(int))
 			return -EINVAL;
 
-		if (get_user(new_cmode, (int *)newval))
+		if (get_user(new_cmode, (int __user *)newval))
 			return -EFAULT;
 
 		return try_set_cmode(new_cmode)?:1;
@@ -318,7 +318,7 @@ #endif
 }
 
 static int p0_procctl(ctl_table *ctl, int write, struct file *filp,
-		      void *buffer, size_t *lenp, loff_t *fpos)
+		      void __user *buffer, size_t *lenp, loff_t *fpos)
 {
 	int new_p0;
 
@@ -330,9 +330,9 @@ static int p0_procctl(ctl_table *ctl, in
 	return try_set_p0(new_p0)?:*lenp;
 }
 
-static int p0_sysctl(ctl_table *table, int *name, int nlen,
-		     void *oldval, size_t *oldlenp,
-		     void *newval, size_t newlen, void **context)
+static int p0_sysctl(ctl_table *table, int __user *name, int nlen,
+		     void __user *oldval, size_t __user *oldlenp,
+		     void __user *newval, size_t newlen, void **context)
 {
 	if (oldval && oldlenp) {
 		size_t oldlen;
@@ -343,7 +343,7 @@ static int p0_sysctl(ctl_table *table, i
 		if (oldlen != sizeof(int))
 			return -EINVAL;
 
-		if (put_user(clock_p0_current, (unsigned int *)oldval) ||
+		if (put_user(clock_p0_current, (unsigned __user *)oldval) ||
 		    put_user(sizeof(int), oldlenp))
 			return -EFAULT;
 	}
@@ -353,7 +353,7 @@ static int p0_sysctl(ctl_table *table, i
 		if (newlen != sizeof(int))
 			return -EINVAL;
 
-		if (get_user(new_p0, (int *)newval))
+		if (get_user(new_p0, (int __user *)newval))
 			return -EFAULT;
 
 		return try_set_p0(new_p0)?:1;
@@ -362,7 +362,7 @@ static int p0_sysctl(ctl_table *table, i
 }
 
 static int cm_procctl(ctl_table *ctl, int write, struct file *filp,
-		      void *buffer, size_t *lenp, loff_t *fpos)
+		      void __user *buffer, size_t *lenp, loff_t *fpos)
 {
 	int new_cm;
 
@@ -374,9 +374,9 @@ static int cm_procctl(ctl_table *ctl, in
 	return try_set_cm(new_cm)?:*lenp;
 }
 
-static int cm_sysctl(ctl_table *table, int *name, int nlen,
-		     void *oldval, size_t *oldlenp,
-		     void *newval, size_t newlen, void **context)
+static int cm_sysctl(ctl_table *table, int __user *name, int nlen,
+		     void __user *oldval, size_t __user *oldlenp,
+		     void __user *newval, size_t newlen, void **context)
 {
 	if (oldval && oldlenp) {
 		size_t oldlen;
@@ -387,7 +387,7 @@ static int cm_sysctl(ctl_table *table, i
 		if (oldlen != sizeof(int))
 			return -EINVAL;
 
-		if (put_user(clock_cm_current, (unsigned int *)oldval) ||
+		if (put_user(clock_cm_current, (unsigned __user *)oldval) ||
 		    put_user(sizeof(int), oldlenp))
 			return -EFAULT;
 	}
@@ -397,7 +397,7 @@ static int cm_sysctl(ctl_table *table, i
 		if (newlen != sizeof(int))
 			return -EINVAL;
 
-		if (get_user(new_cm, (int *)newval))
+		if (get_user(new_cm, (int __user *)newval))
 			return -EFAULT;
 
 		return try_set_cm(new_cm)?:1;
diff --git a/arch/frv/kernel/sysctl.c b/arch/frv/kernel/sysctl.c
index 408b0f3..b908863 100644
--- a/arch/frv/kernel/sysctl.c
+++ b/arch/frv/kernel/sysctl.c
@@ -49,7 +49,7 @@ static void frv_change_dcache_mode(unsig
  * handle requests to dynamically switch the write caching mode delivered by /proc
  */
 static int procctl_frv_cachemode(ctl_table *table, int write, struct file *filp,
-				 void *buffer, size_t *lenp, loff_t *ppos)
+				 void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned long hsr0;
 	char buff[8];
@@ -123,7 +123,7 @@ static int procctl_frv_cachemode(ctl_tab
  */
 #ifdef CONFIG_MMU
 static int procctl_frv_pin_cxnr(ctl_table *table, int write, struct file *filp,
-				void *buffer, size_t *lenp, loff_t *ppos)
+				void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	pid_t pid;
 	char buff[16], *p;

