Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUKBJwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUKBJwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUKBJwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:52:43 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:47366 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266192AbUKBJet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:34:49 -0500
Date: Tue, 2 Nov 2004 09:34:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 7/14] FRV: GDB stub dependent additional BUG()'s
Message-ID: <20041102093440.GA5841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
	davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JULar023202@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411011930.iA1JULar023202@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 07:30:21PM +0000, dhowells@redhat.com wrote:
> The attached patch adds a couple of extra BUG() calls if a GDB stub is
> configured in the kernel. These allow the GDB stub to catch bad_page() and
> panic().
> 
> Signed-Off-By: dhowells@redhat.com
> ---
> diffstat frv-gdbstub-2610rc1bk10.diff
>  kernel/panic.c  |    3 +++
>  mm/page_alloc.c |    3 +++
>  2 files changed, 6 insertions(+)
> 
> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/panic.c linux-2.6.10-rc1-bk10-frv/kernel/panic.c
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/panic.c	2004-10-27 17:32:38.000000000 +0100
> +++ linux-2.6.10-rc1-bk10-frv/kernel/panic.c	2004-11-01 11:47:05.162632657 +0000
> @@ -59,6 +59,9 @@
>  	vsnprintf(buf, sizeof(buf), fmt, args);
>  	va_end(args);
>  	printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
> +#ifdef CONFIG_GDBSTUB
> +	BUG();
> +#endif
>  	bust_spinlocks(0);
>  
>  #ifdef CONFIG_SMP

please avoid the ifdef mess and add some invoke_debugger or whatever macro
burried in some header.

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/mm/page_alloc.c linux-2.6.10-rc1-bk10-frv/mm/page_alloc.c
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/mm/page_alloc.c	2004-11-01 11:45:35.000000000 +0000
> +++ linux-2.6.10-rc1-bk10-frv/mm/page_alloc.c	2004-11-01 11:47:05.230626996 +0000
> @@ -83,6 +83,9 @@
>  		page->mapping, page_mapcount(page), page_count(page));
>  	printk(KERN_EMERG "Backtrace:\n");
>  	dump_stack();
> +#ifdef CONFIG_GDBSTUB
> +	BUG();
> +#endif

besides the ifdef mess this changes behaviour as it didn't BUG without,
please skip this hunk completely.

