Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWG2FBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWG2FBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 01:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWG2FBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 01:01:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932614AbWG2FBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 01:01:47 -0400
Date: Fri, 28 Jul 2006 22:00:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [PATCH] 2.6.18-rc2-mm1: unresolved symbol brnf_deferred_hooks
 in xt_physdev module
Message-Id: <20060728220043.43201c6b.akpm@osdl.org>
In-Reply-To: <200607281338.22053.bero@arklinux.org>
References: <200607281338.22053.bero@arklinux.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 13:38:21 +0200
Bernhard Rosenkraenzer <bero@arklinux.org> wrote:

> The (trivial) patch below fixes the unresolved symbol brnf_deferred_hooks in 
> the xt_physdev module in 2.6.18-rc2-mm1.
> 
> Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>
> 
> ---
> --- linux-2.6.17/net/netfilter/xt_physdev.c.ark	2006-07-28 13:34:31.000000000 
> +0200
> +++ linux-2.6.17/net/netfilter/xt_physdev.c	2006-07-28 13:34:48.000000000 
> +0200
> @@ -16,6 +16,8 @@
>  #define MATCH   1
>  #define NOMATCH 0
>  
> +extern int brnf_deferred_hooks;
> +
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Bart De Schuymer <bdschuym@pandora.be>");
>  MODULE_DESCRIPTION("iptables bridge physical device match module");

OK, but please never put extern declarations in .c files.  They need to go
in a header where the compiler can check that the variable's type is
consistent at all usage sites.

We already have such a declaration, so I guess this is the fix:

--- a/net/netfilter/xt_physdev.c~xt_physdev-build-fix
+++ a/net/netfilter/xt_physdev.c
@@ -10,6 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/skbuff.h>
+#include <linux/netfilter/netfilter_bridge.h>
 #include <linux/netfilter/xt_physdev.h>
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_bridge.h>
_


Your email client is wordwrapping patches, btw.  There's a lot of it going
round at present.
