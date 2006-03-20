Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWCTOkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWCTOkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWCTOkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:40:35 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:64203 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932305AbWCTOke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:40:34 -0500
Message-ID: <441EC051.2050505@student.ltu.se>
Date: Mon, 20 Mar 2006 15:46:41 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
In-Reply-To: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
(and sorry Andrew for the double-mailing, hit the wrong button)

akpm@osdl.org wrote:

>diff -puN include/linux/kernel.h~consolidate-true-and-false include/linux/kernel.h
>--- devel/include/linux/kernel.h~consolidate-true-and-false	2006-03-16 02:01:02.000000000 -0800
>+++ devel-akpm/include/linux/kernel.h	2006-03-16 02:01:02.000000000 -0800
>@@ -18,6 +18,13 @@
> 
> extern const char linux_banner[];
> 
>+/*
>+ * Give these a funny-looking definition to improve the chances of them
>+ * clashing with other definitions of TRUE and FALSE, causing a cpp error
>+ */
>+#define TRUE		((1))
>+#define FALSE		((0))
>+
> #define INT_MAX		((int)(~0U>>1))
> #define INT_MIN		(-INT_MAX - 1)
> #define UINT_MAX	(~0U) 
>
Just an alternative implementation, letting "true" be true and "false" 
be false.
Also making it similar to GCC's library.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---

diff -Narup a/include/linux/stdbool.h b/include/linux/stdbool.h
--- a/include/linux/stdbool.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/linux/stdbool.h	2006-03-20 04:15:47.000000000 +0100
@@ -0,0 +1,15 @@
+/**
+ * Boolean handling
+ */
+#ifndef _STDBOOL_H	/* Same name as in GCC's include/stdbool.h */
+#define _STDBOOL_H
+
+typedef _Bool	bool;
+
+#define true	((0==0))
+#define false	((!true))
+
+#define TRUE	true
+#define FALSE	false
+
+#endif
diff -Narup a/include/linux/types.h b/include/linux/types.h
--- a/include/linux/types.h	2006-03-19 23:47:06.000000000 +0100
+++ b/include/linux/types.h	2006-03-20 03:51:39.000000000 +0100
@@ -3,6 +3,7 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
+#include <linux/stdbool.h>
 
 #define BITS_TO_LONGS(bits) \
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)


