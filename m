Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVCNBTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVCNBTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 20:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCNBTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 20:19:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38373 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261619AbVCNBTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 20:19:15 -0500
Date: Sun, 13 Mar 2005 11:06:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Enable gcc warnings for vsprintf/vsnprintf with "format" attribute
Message-ID: <20050313140606.GA5946@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied to v2.4 - v2.6 wants the same change.

Against v2.6-BK.

From: Solar Designer <solar@openwall.com>

Enables gcc warnings for the case when arguments to vsprintf/vsnprintf
function don't match the format string.  This helps catch programming
errors.

--- a/include/linux/kernel.h.orig	2005-03-13 14:42:52.069920616 -0300
+++ b/include/linux/kernel.h	2005-03-13 14:45:15.192162728 -0300
@@ -91,10 +91,12 @@
 extern long long simple_strtoll(const char *,char **,unsigned int);
 extern int sprintf(char * buf, const char * fmt, ...)
 	__attribute__ ((format (printf, 2, 3)));
-extern int vsprintf(char *buf, const char *, va_list);
+extern int vsprintf(char *buf, const char *, va_list)
+	__attribute__ ((format (printf, 2, 0)));
 extern int snprintf(char * buf, size_t size, const char * fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
-extern int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
+extern int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
+	__attribute__ ((format (printf, 3, 0)));
 extern int scnprintf(char * buf, size_t size, const char * fmt, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);



