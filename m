Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWHVPib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWHVPib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWHVPib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:38:31 -0400
Received: from [198.99.130.12] ([198.99.130.12]:11940 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932322AbWHVPia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:38:30 -0400
Date: Tue, 22 Aug 2006 11:37:23 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060822153723.GA4949@ccure.user-mode-linux.org>
References: <20060819073031.GA25711@atjola.homenet> <200608221207.00344.arnd@arndb.de> <20060822133945.GA3813@ccure.user-mode-linux.org> <200608221713.40165.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608221713.40165.arnd@arndb.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 05:13:39PM +0200, Arnd Bergmann wrote:
> No, that's not what I was referring to. I was thinking of the calls:
> 
> arch/um/os-Linux/process.c:inline _syscall0(pid_t, getpid)
> arch/um/os-Linux/sys-i386/tls.c:static _syscall1(int, get_thread_area, user_desc_t *, u_info);
> arch/um/os-Linux/tls.c:static _syscall1(int, get_thread_area, user_desc_t *, u_info);
> arch/um/os-Linux/tls.c:static _syscall1(int, set_thread_area, user_desc_t *, u_info);
> arch/um/sys-i386/unmap.c:static inline _syscall2(int,munmap,void *,start,size_t,len)
> arch/um/sys-i386/unmap.c:static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
> arch/um/sys-x86_64/unmap.c:static inline _syscall2(int,munmap,void *,start,size_t,len)
> arch/um/sys-x86_64/unmap.c:static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
> 
> Are these for calling the host OS or calling the UML kernel?
> If they are for the host, they can be implemented using syscall(),
> otherwise by calling the sys_* functions directly.

OK, these are all calling the host, and using syscall() instead sounds
reasonable.

				Jeff
