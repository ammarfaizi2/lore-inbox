Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWITP6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWITP6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWITP6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:58:42 -0400
Received: from xenotime.net ([66.160.160.81]:51634 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751686AbWITP6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:58:40 -0400
Date: Wed, 20 Sep 2006 08:59:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jes Sorensen <jes@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec driver
Message-Id: <20060920085939.47b753d9.rdunlap@xenotime.net>
In-Reply-To: <yq0psdrc81u.fsf@jaguar.mkp.net>
References: <yq0psdrc81u.fsf@jaguar.mkp.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Sep 2006 03:26:53 -0400 Jes Sorensen wrote:

Ahoy.

>  drivers/char/Kconfig  |    8 
>  drivers/char/Makefile |    1 
>  drivers/char/mspec.c  |  421 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 430 insertions(+)
> 
> Index: linux-2.6/drivers/char/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/char/Kconfig
> +++ linux-2.6/drivers/char/Kconfig
> @@ -439,6 +439,14 @@ config SGI_MBCS
>           If you have an SGI Altix with an attached SABrick
>           say Y or M here, otherwise say N.
>  
> +config MSPEC
> +	tristate "Memory special operations driver"
> +	depends on IA64
> +	help
> +	  If you have an ia64 and you want to enable memory special
> +	  operations support (formerly known as fetchop), say Y here,
> +	  otherwise say N.

If the answers are {Y, N}, then it should be bool instead of tristate.
If tristate, M can be an answer....

>  source "drivers/serial/Kconfig"
>  
>  config UNIX98_PTYS

> Index: linux-2.6/drivers/char/mspec.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/char/mspec.c
> @@ -0,0 +1,421 @@
> +#include <linux/config.h>

Don't need to include config.h (it's done by build system).
(well, actually autoconf.h is)

> +static struct vm_operations_struct mspec_vm_ops = {
> +	.open = mspec_open,
> +	.close = mspec_close,
> +	.nopfn = mspec_nopfn
> +};

These interfaces create a userspace interface, eh?
So those 3 functions could stand to have kernel-doc function
comments and have documentation in Documentation/ABI/ (see its
README file for more details).  Maybe check all of
Documentation/SubmitChecklist for other items...

> +/*
> + * mspec_init
> + *
> + * Called at boot time to initialize the mspec facility.
> + */
> +static int __init
> +mspec_init(void)

ugh, matey.  All on one line.

> +{
> +}
> +
> +static void __exit
> +mspec_exit(void)

Ditto.

> +{
> +}

---
~Randy
