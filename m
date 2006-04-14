Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbWDNVYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWDNVYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWDNVYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:24:04 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:25862 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S965175AbWDNVYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:24:02 -0400
Date: Fri, 14 Apr 2006 23:23:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/05] percpu i386 linker script update
Message-ID: <20060414212355.GB12482@mars.ravnborg.org>
References: <1145049573.1336.137.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145049573.1336.137.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 05:19:33PM -0400, Steven Rostedt wrote:
> Add .data.percpu_offset section into arch/i386
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S
> ===================================================================
> --- linux-2.6.17-rc1.orig/arch/i386/kernel/vmlinux.lds.S	2006-04-14 15:43:49.000000000 -0400
> +++ linux-2.6.17-rc1/arch/i386/kernel/vmlinux.lds.S	2006-04-14 15:58:08.000000000 -0400
> @@ -62,6 +62,9 @@ SECTIONS
>    /* rarely changed data like cpu maps */
>    . = ALIGN(32);
>    .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) { *(.data.read_mostly) }
> +  __per_cpu_offset_start = .;
> +  .data.percpu_offset  : AT(ADDR(.data.percpu_offset) - LOAD_OFFSET) { *(.data.percpu_offset) }
> +  __per_cpu_offset_end = .;
>    _edata = .;			/* End of data section */
>  
>    . = ALIGN(THREAD_SIZE);	/* init_task */

Can we please have this definition in:
include/asm-generic/vmlinux.lds.h

At least it looks to make sense for other arch's than just i386.

Something like
#define PERCPU_OFFSET \
...

	Sam
