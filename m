Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbUKXNkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUKXNkD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbUKXNhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:37:37 -0500
Received: from [213.146.154.40] ([213.146.154.40]:32989 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262678AbUKXNMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:12:18 -0500
Date: Wed, 24 Nov 2004 13:12:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 10/51: Exports for suspend built as modules.
Message-ID: <20041124131218.GA12868@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294252.5805.228.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101294252.5805.228.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  /*
>   * Platforms implementing 32 bit compatibility ioctl handlers in
> - * modules need this exported
> + * modules need this exported. So does Suspend2 (when made as
> + * modules), so the export_symbol is now unconditional.
>   */
> -#ifdef CONFIG_COMPAT
>  EXPORT_SYMBOL(sys_ioctl);
> -#endif

This is definitly the wrong interface for whatever you want to do.

> diff -ruN 400-exports-old/fs/namei.c 400-exports-new/fs/namei.c
> --- 400-exports-old/fs/namei.c	2004-11-03 21:53:11.000000000 +1100
> +++ 400-exports-new/fs/namei.c	2004-11-04 16:27:40.000000000 +1100
> @@ -1649,6 +1649,8 @@
>  	return error;
>  }
>  
> +EXPORT_SYMBOL(sys_mkdir);

Dito

>   * We try to drop the dentry early: we should have
>   * a usage count of 2 if we're the only user of this
> diff -ruN 400-exports-old/fs/namespace.c 400-exports-new/fs/namespace.c
> --- 400-exports-old/fs/namespace.c	2004-11-03 21:54:15.000000000 +1100
> +++ 400-exports-new/fs/namespace.c	2004-11-04 16:27:40.000000000 +1100
> @@ -490,6 +490,8 @@
>  	return retval;
>  }
>  
> +EXPORT_SYMBOL(sys_umount);

Dito

> +EXPORT_SYMBOL(sys_mount);

Dito.

> +EXPORT_SYMBOL(proc_match);

Also nothing anything outside of procfs internals should do.

> +EXPORT_SYMBOL(sys_write);

wrong aswell.

> +EXPORT_SYMBOL(sys_reboot);

Dito

>  unsigned long avenrun[3];
> +EXPORT_SYMBOL(avenrun);

Nothing you should poke into.

> +/* Exported for Software Suspend 2 */
> +EXPORT_SYMBOL(nr_free_highpages);
> +EXPORT_SYMBOL(pgdat_list);

Dito.

> +EXPORT_SYMBOL(swap_free);
> +EXPORT_SYMBOL(swap_info);
> +EXPORT_SYMBOL(sys_swapoff);
> +EXPORT_SYMBOL(sys_swapon);
> +EXPORT_SYMBOL(si_swapinfo);
> +EXPORT_SYMBOL(map_swap_page);
> +EXPORT_SYMBOL(get_swap_page);
> +EXPORT_SYMBOL(get_swap_info_struct);

Dito.  Lowlevel swapdevice access isn't something modules should poke
into.

Nigel, why do I have this strange feeling that exactly the same patch
was rejected already but you resubmitted it again?

If you want anything merged drop the modular swsusp bits, I doubt it'll
ever be merged.
