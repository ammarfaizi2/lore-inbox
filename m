Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVLFU1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVLFU1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVLFU1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:27:45 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:19085 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030218AbVLFU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:27:44 -0500
Message-ID: <4395F405.9010107@droids-corp.org>
Date: Tue, 06 Dec 2005 21:26:45 +0100
From: Olivier MATZ <zer0@droids-corp.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] asm-i386 : config.h should not be included out of kernel
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------000509000103030605040707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509000103030605040707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

It seems that in include/asm-i386/param.h the "#include
<linux/config.h>" should be inside the #ifdef __KERNEL__, as it is done
in asm-ia64.

Some applications cannot compile/work correctly whithout this patch. For
example busybox defines for itself CONFIG_TR (related to the tr
program), which is unfortunately undefined when including sys/param.h,
which includes linux/config.h (CONFIG_TR is the config for token ring).

Can you consider the following patch ?

Thanks,
Olivier

--------------000509000103030605040707
Content-Type: text/plain;
 name="asm-i386_dont_include_config.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asm-i386_dont_include_config.diff"

--- linux-2.6.14.3.orig/include/asm-i386/param.h	2005-12-06 14:13:15.000000000 +0100
+++ linux-2.6.14.3/include/asm-i386/param.h	2005-12-06 13:51:12.000000000 +0100
@@ -1,9 +1,9 @@
-#include <linux/config.h>
-
 #ifndef _ASMi386_PARAM_H
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
+#include <linux/config.h>  /* mustn't include <linux/config.h> outside of #ifdef __KERNEL__ */
+
 # define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */

--------------000509000103030605040707--
