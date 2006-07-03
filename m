Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWGCHkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWGCHkA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWGCHkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:40:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750708AbWGCHj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:39:59 -0400
Date: Mon, 3 Jul 2006 00:39:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: hpa@zytor.com, ralf@linux-mips.org, erik_frederiksen@pmc-sierra.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consistently use MAX_ERRNO in __syscall_return
Message-Id: <20060703003941.2f5fe722.akpm@osdl.org>
In-Reply-To: <20060702112722.74b5adff.rdunlap@xenotime.net>
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>
	<20060628140825.692f31be.rdunlap@xenotime.net>
	<20060629181013.GA18777@linux-mips.org>
	<20060701114409.ed320be0.rdunlap@xenotime.net>
	<44A6F5E3.8000300@zytor.com>
	<20060702112722.74b5adff.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2006 11:27:22 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> --- linux-2617-g20.orig/include/asm-i386/unistd.h
> +++ linux-2617-g20/include/asm-i386/unistd.h
> @@ -327,14 +327,15 @@
>  #ifdef __KERNEL__
>  
>  #define NR_syscalls 318
> +#include <linux/err.h>

include/linux/err.h: Assembler messages:
include/linux/err.h:20: Error: no such instruction: `static inline void *ERR_PTR(long error)'
include/linux/err.h:21: Error: junk at end of line, first unrecognized character is `{'
include/linux/err.h:22: Error: no such instruction: `return (void *)error'
include/linux/err.h:23: Error: junk at end of line, first unrecognized character is `}'
include/linux/err.h:25: Error: no such instruction: `static inline long PTR_ERR(const void *ptr)'
include/linux/err.h:26: Error: junk at end of line, first unrecognized character is `{'
include/linux/err.h:27: Error: no such instruction: `return (long)ptr'
include/linux/err.h:28: Error: junk at end of line, first unrecognized character is `}'
include/linux/err.h:30: Error: no such instruction: `static inline long IS_ERR(const void *ptr)'
include/linux/err.h:31: Error: junk at end of line, first unrecognized character is `{'
include/linux/err.h:32: Error: no such instruction: `return unlikely(((unsigned long)ptr)>=(unsigned long)-4095)'
include/linux/err.h:33: Error: junk at end of line, first unrecognized character is `}'
distcc[7619] ERROR: compile (null) on localhost failed
make[1]: *** [arch/i386/kernel/vsyscall-sysenter.o] Error 1
make: *** [arch/i386/kernel/vsyscall-sysenter.o] Error 2

