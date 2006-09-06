Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWIFOpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWIFOpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWIFOpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:45:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57323 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751172AbWIFOpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:45:10 -0400
Message-Id: <20060906151644.832424377@winden.suse.de>
References: <20060906151438.228071937@winden.suse.de>
User-Agent: quilt/0.44-16.4
Date: Wed, 06 Sep 2006 17:14:40 +0200
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [patch 2/3] Add match_string() for mount option parsing 
Content-Disposition: inline; filename=parser-match_string.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The match_string() function allows to parse string constants in
mount options.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.18-rc6/include/linux/parser.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/parser.h
+++ linux-2.6.18-rc6/include/linux/parser.h
@@ -26,6 +26,7 @@ typedef struct {
 } substring_t;
 
 int match_token(char *, match_table_t table, substring_t args[]);
+int match_string(substring_t *s, const char *str);
 int match_int(substring_t *, int *result);
 int match_octal(substring_t *, int *result);
 int match_hex(substring_t *, int *result);
Index: linux-2.6.18-rc6/lib/parser.c
===================================================================
--- linux-2.6.18-rc6.orig/lib/parser.c
+++ linux-2.6.18-rc6/lib/parser.c
@@ -111,6 +111,19 @@ int match_token(char *s, match_table_t t
 }
 
 /**
+ * match_string: check for a particular parameter
+ * @s: substring to be scanned
+ * @str: string to scan for
+ *
+ * Description: Return if a &substring_t is equal to string @str.
+ */
+int match_string(substring_t *s, const char *str)
+{
+	return strlen(str) == s->to - s->from &&
+	       !memcmp(str, s->from, s->to - s->from);
+}
+
+/**
  * match_number: scan a number in the given base from a substring_t
  * @s: substring to be scanned
  * @result: resulting integer on success
@@ -213,6 +226,7 @@ char *match_strdup(substring_t *s)
 }
 
 EXPORT_SYMBOL(match_token);
+EXPORT_SYMBOL(match_string);
 EXPORT_SYMBOL(match_int);
 EXPORT_SYMBOL(match_octal);
 EXPORT_SYMBOL(match_hex);

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX Products GmbH / Novell Inc.

