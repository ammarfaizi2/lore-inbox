Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUDNV0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUDNV0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:26:46 -0400
Received: from waste.org ([209.173.204.2]:44267 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261791AbUDNV0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:26:32 -0400
Date: Wed, 14 Apr 2004 16:25:39 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-ID: <20040414212539.GE1175@waste.org>
References: <407CEB91.1080503@pobox.com> <20040414005832.083de325.akpm@osdl.org> <20040414010240.0e9f4115.akpm@osdl.org> <407CF201.408@pobox.com> <20040414011653.22c690d9.akpm@osdl.org> <407CFFF9.5010500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407CFFF9.5010500@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 05:10:17AM -0400, Jeff Garzik wrote:
> Andrew Morton wrote:
> >Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>I would rather not kill the code in submit_bh() outright, just disable 
> >>it for non-filesystem developers.
> >
> >
> >submit_bh() is a slowpath ;) The one in mark_buffer_dirty() will be called
> >more often, possibly others.  Kill!
> 
> Jens seems to like the debugging checks, so here's an alterna-patch.
> 
> 	Jeff
> 
> 

> ===== arch/alpha/Kconfig 1.36 vs edited =====
> +++ edited/arch/alpha/Kconfig	Wed Apr 14 04:58:08 2004
> @@ -690,6 +690,13 @@
>  	  Say Y here only if you plan to use gdb to debug the kernel.
>  	  If you don't debug the kernel, you can say N.
>  
> +config DEBUG_BUFFERS
> +	bool "Enable additional filesystem buffer_head checks"
> +	depends on DEBUG_KERNEL
> +	help
> +	  If you say Y here, additional checks are performed that aid
> +	  filesystem development.
> +
>  endmenu

Sticking this in arch/*/Kconfig seems silly (as does much of the
duplication in said files). Can we stick this and other debug bits
under the kallsyms option in init/Kconfig instead? Or alternately move
debugging bits into their own file that gets included as appropriate.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
