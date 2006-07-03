Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWGCPEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWGCPEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 11:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWGCPEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 11:04:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:29327 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932072AbWGCPEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 11:04:51 -0400
Message-ID: <44A931C1.7060604@zytor.com>
Date: Mon, 03 Jul 2006 08:03:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, ralf@linux-mips.org,
       erik_frederiksen@pmc-sierra.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consistently use MAX_ERRNO in __syscall_return
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>	<20060628140825.692f31be.rdunlap@xenotime.net>	<20060629181013.GA18777@linux-mips.org>	<20060701114409.ed320be0.rdunlap@xenotime.net>	<44A6F5E3.8000300@zytor.com>	<20060702112722.74b5adff.rdunlap@xenotime.net> <20060703003941.2f5fe722.akpm@osdl.org>
In-Reply-To: <20060703003941.2f5fe722.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 2 Jul 2006 11:27:22 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
>> --- linux-2617-g20.orig/include/asm-i386/unistd.h
>> +++ linux-2617-g20/include/asm-i386/unistd.h
>> @@ -327,14 +327,15 @@
>>  #ifdef __KERNEL__
>>  
>>  #define NR_syscalls 318
>> +#include <linux/err.h>
> 
> include/linux/err.h: Assembler messages:
> include/linux/err.h:20: Error: no such instruction: `static inline void *ERR_PTR(long error)'
> include/linux/err.h:21: Error: junk at end of line, first unrecognized character is `{'
> include/linux/err.h:22: Error: no such instruction: `return (void *)error'
> include/linux/err.h:23: Error: junk at end of line, first unrecognized character is `}'
> include/linux/err.h:25: Error: no such instruction: `static inline long PTR_ERR(const void *ptr)'
> include/linux/err.h:26: Error: junk at end of line, first unrecognized character is `{'
> include/linux/err.h:27: Error: no such instruction: `return (long)ptr'
> include/linux/err.h:28: Error: junk at end of line, first unrecognized character is `}'
> include/linux/err.h:30: Error: no such instruction: `static inline long IS_ERR(const void *ptr)'
> include/linux/err.h:31: Error: junk at end of line, first unrecognized character is `{'
> include/linux/err.h:32: Error: no such instruction: `return unlikely(((unsigned long)ptr)>=(unsigned long)-4095)'
> include/linux/err.h:33: Error: junk at end of line, first unrecognized character is `}'
> distcc[7619] ERROR: compile (null) on localhost failed
> make[1]: *** [arch/i386/kernel/vsyscall-sysenter.o] Error 1
> make: *** [arch/i386/kernel/vsyscall-sysenter.o] Error 2

unlikely() shouldn't be used in code exported to user space.  At least 
one architecture simply open-codes the __builtin_expect(); or we could
introduce __likely() and __unlikely() for the benefit of userspace.

	-hpa
