Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSI2XwK>; Sun, 29 Sep 2002 19:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261846AbSI2XvD>; Sun, 29 Sep 2002 19:51:03 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13513 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261845AbSI2Xuz>; Sun, 29 Sep 2002 19:50:55 -0400
Date: Sun, 29 Sep 2002 19:56:12 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "David S. Miller" <davem@redhat.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
Message-ID: <20020929195612.A3218@devserv.devel.redhat.com>
References: <20020926.142910.124086325.davem@redhat.com> <20020928122817.GV27082@louise.pinerecords.com> <20020928161316.GA4323@louise.pinerecords.com> <20020928.232350.33317317.davem@redhat.com> <20020929102238.GD4323@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929102238.GD4323@louise.pinerecords.com>; from szepe@pinerecords.com on Sun, Sep 29, 2002 at 12:22:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 29 Sep 2002 12:22:39 +0200
> From: Tomas Szepe <szepe@pinerecords.com>

> +++ linux-2.4.20-pre8/arch/sparc/kernel/sparc_ksyms.c	2002-09-29 11:45:33.000000000 +0200
> +#ifdef CONFIG_HIGHMEM
> +#include <asm/highmem.h>
> +#endif

OK, this is actually correct, I think. Looks funny. :)

> +++ linux-2.4.20-pre8/arch/sparc/mm/Makefile	2002-09-29 11:45:33.000000000 +0200
> @@ -11,7 +11,7 @@
>  	$(CC) $(AFLAGS) -ansi -c -o $*.o $<
>  
>  O_TARGET := mm.o
> -obj-y    := fault.o init.o loadmmu.o generic.o extable.o btfixup.o
> +obj-y    := fault.o init.o loadmmu.o generic.o extable.o highmem.o btfixup.o

Why is this not obj-$(CONFIG_HIGHMEM) ?

> +/* in mm/memory.c */
> +extern struct page *highmem_start_page;
> +

I would not do this. I would try to include <linux/highmem.h>
into arch/sparc/mm/highmem.c (instead of <asm/highmem.h> as you did).

Also, now that you moved a bunch of implementation out of inlines,
try to trim the #include list at the top of <asm-sparc/highmem.h>.
For instance, asm/vaddrs.h is a suspect.

The rest of the patch is sane, as far as I can tell. I do not
have a ready to run 2.4 sparc box, sorry. Please ask sparclinux@vger
people to test, especially Uzi.

-- Pete
