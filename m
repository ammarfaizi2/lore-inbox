Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbUCKAlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbUCKAlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:41:22 -0500
Received: from ozlabs.org ([203.10.76.45]:42118 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262816AbUCKAlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:41:20 -0500
Subject: Re: [PATCH] 2.6.4-rc2: scripts/modpost.c
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Mack <daniel@zonque.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040304113749.GD5569@zonque.dyndns.org>
References: <20040304113749.GD5569@zonque.dyndns.org>
Content-Type: text/plain
Message-Id: <1078965617.23891.103.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 11:40:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 22:37, Daniel Mack wrote:

> --- linux-2.6.4-rc2.orig/scripts/modpost.c      2004-03-04 11:40:21.000000000 +0100
> +++ linux-2.6.4-rc2/scripts/modpost.c   2004-03-04 11:23:08.000000000 +0100
> @@ -63,16 +63,16 @@
>  new_module(char *modname)
>  {
>         struct module *mod;
> -       char *p;
> +       int len;
>  
>         mod = NOFAIL(malloc(sizeof(*mod)));
>         memset(mod, 0, sizeof(*mod));
>         mod->name = NOFAIL(strdup(modname));
>  
>         /* strip trailing .o */
> -       p = strstr(mod->name, ".o");
> -       if (p)
> -               *p = 0;
> +       len = strlen(mod->name);
> +       if (len > 2 && mod->name[len-2] == '.' && mod->name[len-1] == 'o')
> +               mod->name[len-2] = 0;
>  
>         /* add to list */
>         mod->next = modules;

Please use strrchr(mod->name, '.').  More readable, simpler, and ever
arguably more correct.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

