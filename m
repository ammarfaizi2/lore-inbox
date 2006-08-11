Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWHKHjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWHKHjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWHKHjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:39:49 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:41144 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750711AbWHKHjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:39:48 -0400
Date: Fri, 11 Aug 2006 09:39:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] make all archs use early_param
Message-ID: <20060811073941.GA9590@osiris.boeblingen.de.ibm.com>
References: <1155280728.27719.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155280728.27719.34.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 05:18:47PM +1000, Rusty Russell wrote:
> Gold star to PowerPC and s390 for calling parse_early_param(), *and*
> using it instead of open-coded early cmdline hacking.

Thanks! :)

> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.6.18-rc3-mm2/arch/s390/kernel/setup.c working-2.6.18-rc3-mm2-early_param-for-all/arch/s390/kernel/setup.c
> --- linux-2.6.18-rc3-mm2/arch/s390/kernel/setup.c	2006-08-03 12:50:21.000000000 +1000
> +++ working-2.6.18-rc3-mm2-early_param-for-all/arch/s390/kernel/setup.c	2006-08-11 17:14:03.000000000 +1000
> @@ -600,6 +600,7 @@ setup_arch(char **cmdline_p)
>  
>  	/* Save unparsed command line copy for /proc/cmdline */
>  	strlcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
> +	parse_early_param();
>  
>  	*cmdline_p = COMMAND_LINE;
>  	*(*cmdline_p + COMMAND_LINE_SIZE - 1) = '\0';

This part of the patch should be removed.
That would be s390's second call to parse_early_param(). It needs to be done
a bit later _after_ the 'memory_end = memory_size' line, where it is already.
Otherwise passing 'mem=' to the kernel will have no effect anymory.
