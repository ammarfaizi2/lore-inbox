Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVFISDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVFISDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVFISDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 14:03:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:18161 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262432AbVFISDs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 14:03:48 -0400
Message-ID: <42A8847E.4020302@us.ibm.com>
Date: Thu, 09 Jun 2005 11:03:42 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>,
       "Bligh, Martin J." <Martin.Bligh@us.ibm.com>
Subject: Fix warning in kernel/module.c
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030802020802090900000401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030802020802090900000401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I get this warning compiling 2.6.12-rc6-mm1:

kernel/module.c:404: warning: `modinfo_attrs' defined but not used

The attached patch fixes the warning, which I guess was sort of caused by
me.  I was having compilation problems on -rc5-mm2 and I sent a patch to
move some definitions outside an ifdef.  Now the code only uses those
definitions INSIDE appropriately ifdef'd sections, so we get a warning
about not using them.  Bah.  This should (hopefully) end this.

-Matt

--------------030802020802090900000401
Content-Type: text/x-patch;
 name="modinfo_attrs-fix2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modinfo_attrs-fix2.patch"

--- linux-2.6.12-rc6-mm1/kernel/module.c	2005-06-08 15:22:43.995409432 -0700
+++ linux-2.6.12-rc6-mm1/kernel/module.c.fixed	2005-06-08 15:21:55.286814264 -0700
@@ -370,6 +370,7 @@ static inline void percpu_modcopy(void *
 }
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_MODULE_UNLOAD
 #define MODINFO_ATTR(field)	\
 static void setup_modinfo_##field(struct module *mod, const char *s)  \
 {                                                                     \
@@ -407,7 +408,6 @@ static struct module_attribute *modinfo_
 	NULL,
 };
 
-#ifdef CONFIG_MODULE_UNLOAD
 /* Init the unload section of the module. */
 static void module_unload_init(struct module *mod)
 {

--------------030802020802090900000401--
