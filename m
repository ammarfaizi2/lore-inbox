Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266916AbSK2BXI>; Thu, 28 Nov 2002 20:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbSK2BXH>; Thu, 28 Nov 2002 20:23:07 -0500
Received: from dp.samba.org ([66.70.73.150]:26041 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266916AbSK2BWs>;
	Thu, 28 Nov 2002 20:22:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Thomas Molina <tmolina@copper.net>
Cc: linux-kernel@vger.kernel.org, Anders Gustafsson <andersg@0x63.nu>,
       Steve Lord <lord@sgi.com>
Subject: Re: [RELEASE] module-init-tools 0.8 
In-reply-to: Your message of "Wed, 27 Nov 2002 23:55:08 MDT."
             <Pine.LNX.4.44.0211272325370.924-100000@lap.molina> 
Date: Fri, 29 Nov 2002 11:59:49 +1100
Message-Id: <20021129013010.38C262C2BA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211272325370.924-100000@lap.molina> you write:
> With the patch you included, I get the following:
> 
> In file included from include/linux/raid/md.h:27,
>                  from init/do_mounts.c:25:
> include/linux/module.h:159: parse error before "Elf32_Sym"

Argh.... Put back the #include <linux/elf.h> at the top of the file.
It's required for CONFIG_KALLSYMS=y.

The main reason for separating out moduleloader.h was so modules.h
didn't include elf.h, because xfs defines AT_GID and AT_UID itself.
The kallsyms patch put that back.

We could make module.symtab a void*, but that's just wrong.  I think
we actually have to solve this clash, rather than hack around it,
since this is going to be a recurring problem.

Steve?  Changing the prefix on xfs or elf seems equally painful (xfs
because it'll be a big patch, elf because it's standardized and been
like that forever).

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
