Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVGLVoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVGLVoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVGLVoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:44:06 -0400
Received: from zs04.physik.fu-berlin.de ([160.45.35.155]:21651 "EHLO
	zs04.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id S262373AbVGLVjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:39:25 -0400
Date: Tue, 12 Jul 2005 23:39:20 +0200
To: rusty@rustcorp.com.au
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Runtime fix for intermodule.c
Message-ID: <20050712213920.GA9714@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Scanned: No viruses found.
X-Spam-Report: No (score -5.9)
        -3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-Scan-Signature: 01656a33c131dbe46878302be211cf9e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rusty,

As it seeems that you are the maintainer of the module
related code in the Linux kernel, I send these
two small patches to you:

This little patch adds the missing function declaration
of the deprecatated function call inter_module_get
to the header file include/linux/module.h and the
necessary EXPORT_SYMBOL to kernel/intermodule.c. Without
the declaration and the EXPORT_SYMBOL any module that requires
the inter_module_get call will fail upon loading
since the symbol inter_module_get cannot be resolved,
applying this patch will make those modules work again.

Kernel version is 2.6.12.1

Affected modules are for example the ltmodem drivers
version 8.31a8 for lucent chipsets, they won't
work without the fix.

Regards,

Adrian Glaubitz
(glaubitz@physik.fu-berlin.de)


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="intermodule.c.diff"

--- kernel/intermodule.c.orig	2005-07-12 23:19:29.000000000 +0200
+++ kernel/intermodule.c	2005-07-12 23:19:58.000000000 +0200
@@ -180,3 +180,4 @@ EXPORT_SYMBOL(inter_module_register);
 EXPORT_SYMBOL(inter_module_unregister);
 EXPORT_SYMBOL(inter_module_get_request);
 EXPORT_SYMBOL(inter_module_put);
+EXPORT_SYMBOL(inter_module_get);

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="module.h.diff"

--- include/linux/module.h.orig	2005-07-12 22:58:20.000000000 +0200
+++ include/linux/module.h	2005-07-12 22:31:45.000000000 +0200
@@ -566,5 +566,6 @@ extern void __deprecated inter_module_un
 extern const void * __deprecated inter_module_get_request(const char *,
 		const char *);
 extern void __deprecated inter_module_put(const char *);
+extern const void * __deprecated inter_module_get(const char *);
 
 #endif /* _LINUX_MODULE_H */

--MGYHOYXEY6WxJCY8--
