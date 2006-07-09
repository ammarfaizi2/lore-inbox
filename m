Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWGIO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWGIO2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWGIO2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:28:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63757 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932453AbWGIO2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:28:47 -0400
Date: Sun, 9 Jul 2006 16:28:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix MODULES=n compile
Message-ID: <20060709142845.GH13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:11:06AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm6:
>...
> +null-terminate-over-long-proc-kallsyms-symbols.patch
>...
>  Misc updates.
>...

This patch fixes the following compile error with CONFIG_MODULES=n:

<--  snip  -->

...
  CC      kernel/kallsyms.o
kernel/kallsyms.c: In function ‘get_ksymbol_mod’:
kernel/kallsyms.c:279: error: too many arguments to function ‘module_get_kallsym’
make[1]: *** [kernel/kallsyms.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm1-full/include/linux/module.h.old	2006-07-09 11:30:38.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/include/linux/module.h	2006-07-09 11:31:36.000000000 +0200
@@ -533,8 +533,8 @@
 
 static inline struct module *module_get_kallsym(unsigned int symnum,
 						unsigned long *value,
-						char *type,
-						char namebuf[128])
+						char *type, char *name,
+						size_t namelen)
 {
 	return NULL;
 }

