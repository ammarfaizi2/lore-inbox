Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264065AbUDQXVK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 19:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbUDQXVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 19:21:10 -0400
Received: from ozlabs.org ([203.10.76.45]:9422 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264065AbUDQXVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 19:21:07 -0400
Subject: Re: Fw: [PATCH] Re: module_param() doesn't seem to work in
	2.6.6-rc1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Roskin <proski@gnu.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040417011836.318c679b.akpm@osdl.org>
References: <20040417011836.318c679b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1082244060.14091.2.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 09:21:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 18:18, Andrew Morton wrote:
> OK?

Yes, but I prefer this version, which actually checks whether the
section exists, rather than checking the size (same effect, but this is
clearer).

Name: Warn if module_param and MODULE_PARM mixed
Status: Trivial
From: Pavel Roskin <proski@gnu.org>

If you use both module_param (new) and MODULE_PARM (obsolete) in a
module, only the second gets recognised.  Warn.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .14500-linux-2.6.6-rc1-bk1/kernel/module.c .14500-linux-2.6.6-rc1-bk1.updated/kernel/module.c
--- .14500-linux-2.6.6-rc1-bk1/kernel/module.c	2004-04-15 16:06:55.000000000 +1000
+++ .14500-linux-2.6.6-rc1-bk1.updated/kernel/module.c	2004-04-18 09:17:26.000000000 +1000
@@ -1541,6 +1541,10 @@ static struct module *load_module(void _
 				      / sizeof(struct obsolete_modparm),
 				      sechdrs, symindex,
 				      (char *)sechdrs[strindex].sh_addr);
+		if (setupindex)
+			printk(KERN_WARNING "%s: Ignoring new-style "
+			       "parameters in presence of obsolete ones\n",
+			       mod->name);
 	} else {
 		/* Size of section 0 is 0, so this works well if no params */
 		err = parse_args(mod->name, mod->args,

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

