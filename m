Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWGLT0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWGLT0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWGLT0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:26:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:58005 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750863AbWGLT0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:26:48 -0400
Subject: [PATCH] 2.6.18-rc1-mm1: fix stub version of module_get_kallsym()
To: agruen@suse.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 12:26:41 -0700
Message-Id: <20060712192641.108BD64D@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Get this error when modules are compiled off:

kernel/kallsyms.c: In function `get_ksymbol_mod':
kernel/kallsyms.c:279: error: too many arguments to function `module_get_kallsym'

Seems to be from:
	
	null-terminate-over-long-proc-kallsyms-symbols.patch

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/include/linux/module.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/kallsyms.c~fix-get_ksymbol_mod-calls-module_get_kallsym kernel/kallsyms.c
diff -puN kernel/module.c~fix-get_ksymbol_mod-calls-module_get_kallsym kernel/module.c
diff -puN include/linux/module.h~fix-get_ksymbol_mod-calls-module_get_kallsym include/linux/module.h
--- lxc/include/linux/module.h~fix-get_ksymbol_mod-calls-module_get_kallsym	2006-07-12 12:22:05.000000000 -0700
+++ lxc-dave/include/linux/module.h	2006-07-12 12:22:22.000000000 -0700
@@ -534,7 +534,8 @@ static inline const char *module_address
 static inline struct module *module_get_kallsym(unsigned int symnum,
 						unsigned long *value,
 						char *type,
-						char namebuf[128])
+						char namebuf[128],
+						size_t namelen)
 {
 	return NULL;
 }
_
