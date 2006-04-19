Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWDSRy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWDSRy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWDSRy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:54:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:670 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751062AbWDSRym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:54:42 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:50:18 -0700
Message-Id: <20060419175018.29149.391.sendpatchset@ermintrude.int.wirex.com>
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 9/11] security: AppArmor - Audit changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AppArmor support to the audit subsystem.

It creates id 1500 (already included in the the upstream auditd package) for 
AppArmor messages.

It also exports the audit_log_vformat function (analagous to having both
printk and vprintk exported).

Signed-off-by: Tony Jones <tonyj@suse.de>

---
 include/linux/audit.h |    5 +++++
 kernel/audit.c        |    3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc1.orig/include/linux/audit.h
+++ linux-2.6.17-rc1/include/linux/audit.h
@@ -95,6 +95,8 @@
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
 #define AUDIT_ANOM_PROMISCUOUS      1700 /* Device changed promiscuous mode */
 
+#define AUDIT_AA		1500	/* AppArmor audit */
+
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
 /* Rule flags */
@@ -349,6 +351,9 @@
 				      __attribute__((format(printf,4,5)));
 
 extern struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type);
+extern void		    audit_log_vformat(struct audit_buffer *ab,
+					      const char *fmt, va_list args)
+			    __attribute__((format(printf,2,0)));
 extern void		    audit_log_format(struct audit_buffer *ab,
 					     const char *fmt, ...)
 			    __attribute__((format(printf,2,3)));
--- linux-2.6.17-rc1.orig/kernel/audit.c
+++ linux-2.6.17-rc1/kernel/audit.c
@@ -797,7 +797,7 @@
  * will be called a second time.  Currently, we assume that a printk
  * can't format message larger than 1024 bytes, so we don't either.
  */
-static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
+void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
 			      va_list args)
 {
 	int len, avail;
@@ -999,4 +999,5 @@
 EXPORT_SYMBOL(audit_log_start);
 EXPORT_SYMBOL(audit_log_end);
 EXPORT_SYMBOL(audit_log_format);
+EXPORT_SYMBOL(audit_log_vformat);
 EXPORT_SYMBOL(audit_log);
