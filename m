Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVCKTpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVCKTpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVCKTld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:41:33 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:10429 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261563AbVCKTge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:36:34 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 4/9] UML - Export gcov symbol based on gcc version
Date: Fri, 11 Mar 2005 20:35:48 +0100
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
In-Reply-To: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503112035.49163.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 03:16, Jeff Dike wrote:
> The init function called by gcc when gcov is enabled is __gcov_init or
> __bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and
> seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we need
> to close that gap a bit.

I'll have to undo this patch... I said that you must export both symbols when 
GCC version is the right one.

And I can say this version is > 3.3.4, since my good Gentoo's 3.3.4 does not 
include this symbol.

We rediscussed this with Jeff, and I'll post a better patch: 
EXPORT_SYMBOL(__gcov_init), and weakly define it to an empty function. I'll 
do it tomorrow.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
> ===================================================================
> --- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c 2005-03-07
> 10:53:03.000000000 -0500 +++
> linux-2.6.11/arch/um/kernel/gmon_syms.c 2005-03-07 16:29:37.000000000 -0500
> @@ -5,8 +5,14 @@
>
>  #include "linux/module.h"
>
> +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> + (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> +extern void __gcov_init(void *);
> +EXPORT_SYMBOL(__gcov_init);
> +#else
>  extern void __bb_init_func(void *);
>  EXPORT_SYMBOL(__bb_init_func);
> +#endif
>
>  /*
>   * Overrides for Emacs so that we follow Linus's tabbing style.


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

