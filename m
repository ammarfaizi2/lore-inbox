Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267554AbTAQQE5>; Fri, 17 Jan 2003 11:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbTAQQE5>; Fri, 17 Jan 2003 11:04:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14904 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267554AbTAQQE4>; Fri, 17 Jan 2003 11:04:56 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, kai@tp1.ruhr-uni-bochum.de,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
References: <15911.64825.624251.707026@harpo.it.uu.se>
	<20030117135638.A376@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Jan 2003 09:13:14 -0700
In-Reply-To: <20030117135638.A376@flint.arm.linux.org.uk>
Message-ID: <m1adhzg3fp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Fri, Jan 17, 2003 at 01:55:21PM +0100, Mikael Pettersson wrote:
> > This oops occurs for every module, not just af_packet.ko, at
> > resolve_symbol()'s first call to __find_symbol().
> > 
> > What happens is that __find_symbol() oopses because the kernel's
> > symbol table is in la-la land. (Note the bogus kernel adress
> > 2220c021 it tried to dereference above.)
> > 
> > Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
> > problem and modules now load correctly for me.
> > 
> > I don't know if this is a problem also for non-i386 archs.
> 
> Well:
> 
>         __start___ksymtab = .;                                          \
>         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         \
>                 *(__ksymtab)                                            \
>         }                                                               \
>         __stop___ksymtab = .;                                           \
> 
> breaks on some ARM binutils (from a couple of years ago.)  The most
> reliable way we've found in with ARM binutils is to place the symbols
> inside the section - this appears to work 100% every single time and
> I've never had any reports of failure (whereas I did with the symbols
> outside as above.)

That has been roughly my experience on x86 as well with the exception
of bss sections.  For bss sections placing the symbols inside the section
itself has been deadly.

Eric
