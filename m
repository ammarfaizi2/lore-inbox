Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVIKW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVIKW7a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVIKW7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:59:30 -0400
Received: from xenotime.net ([66.160.160.81]:5553 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751011AbVIKW73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:59:29 -0400
Date: Sun, 11 Sep 2005 15:59:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] use add_taint() for setting tainted bit flags
Message-Id: <20050911155927.721ed2b9.rdunlap@xenotime.net>
In-Reply-To: <20050911183353.GA4353@mipter.zuzino.mipt.ru>
References: <20050911104431.1d755c4e.rdunlap@xenotime.net>
	<20050911183353.GA4353@mipter.zuzino.mipt.ru>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005 22:33:53 +0400 Alexey Dobriyan wrote:

> On Sun, Sep 11, 2005 at 10:44:31AM -0700, Randy.Dunlap wrote:
> > Use the add_taint() interface for setting tainted bit flags
> > instead of doing it manually.
> 
> > --- linux-2613-git10/kernel/module.c~use_add_taint
> > +++ linux-2613-git10/kernel/module.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/module.h>
> >  #include <linux/moduleloader.h>
> >  #include <linux/init.h>
> > +#include <linux/kernel.h>
>    ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Will something like this be accepted? Not even boot-tested yet.

Makes sense to me.

> [PATCH] Separate tainted code.
> 
> include/linux/kernel.h is overcrowded. kernel/panic.c has nothing to do
> with tainting.
> 
>  arch/i386/kernel/smpboot.c |    1 +
>  arch/x86_64/kernel/mce.c   |    1 +
>  include/linux/kernel.h     |   10 ----------
>  include/linux/tainted.h    |   15 +++++++++++++++
>  kernel/Makefile            |    2 +-
>  kernel/module.c            |    1 +
>  kernel/panic.c             |   37 -------------------------------------
>  kernel/sysctl.c            |    1 +
>  kernel/tainted.c           |   41 +++++++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c            |    1 +
>  10 files changed, 62 insertions(+), 48 deletions(-)
> 

> +/**
> + * print_tainted - return a string to represent the kernel taint state.
> + *
> + * 'P' - Proprietary module has been loaded.
> + * 'F' - Module has been forcibly loaded.
> + * 'S' - SMP with CPUs not designed for SMP.
> + * 'R' - User forced a module unload.
> + * 'M' - Machine had a machine check experience.
> + * 'B' - System has hit bad_page.
> + *
> + * The string is overwritten by the next call to print_taint().
                                                    ~~~~~~~~~~~
Please change that to 'print_tainted' too.

> + */
> +
> +const char * print_tainted(void)
> +{

---
~Randy
