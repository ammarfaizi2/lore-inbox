Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314399AbSDRSTO>; Thu, 18 Apr 2002 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314402AbSDRSTN>; Thu, 18 Apr 2002 14:19:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2896 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314399AbSDRSTM>; Thu, 18 Apr 2002 14:19:12 -0400
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86 boot enhancements, Clean up the 32bit entry points 6/11
In-Reply-To: <20020418165939.22502.qmail@web11801.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Apr 2002 12:11:55 -0600
Message-ID: <m1hem86fmc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain <etienne_lorrain@yahoo.fr> writes:

>  Seems that previous message did not go through, rewrite.
> 
>  I am sorry I did not check enough your patch.
>  You are speaking of: arch/i386/boot/compressed/head.S

That is what you quoted, so I assumed that is what you were
talking about.

>  I am speaking of:    arch/i386/kernel/head.S
> 
>  Gujin skip completely arch/i386/boot/compressed/* and really
>  boots the file '$$tmppiggy.gz' line 44 of file:
> arch/i386/boot/compressed/Makefile
> 
>  So you can do whatever you want with the "first" 32 bits entry point,
>  I am just concerned by the "second" kernel 32 bits entry point, in
>  arch/i386/kernel/head.S
> 
>  I still have a problem to detect the size of your decompressor, and that
>  is my use of the "lss" instruction.
>  This "lss SYMBOL_NAME(stack_start),%esp" gives an access to the symbol
>  'stack_start', so it is quite easy to find back the GZIP signature
>  of the initial '$$tmppiggy.gz' in what I call my "compatibility" mode,
>  i.e. booting the legacy vmlinuz files - and skipping all of the real mode
>  code and the decompressor code.

Well it should be easier I put an explicit pointer to it.

>  This "lss" line has not always been at the same offset, but is around
>  since maybe even the 0.01 kernel, it is quite easy to find it from its
>  hexadecimal form. (function vmlinuz_header_treat() in vmlinuz.c of
>  Gujin).
> 
>  The loaded high/loaded low stuff is just to know if I have to remove
>  0x100000 or 0x1000 from this symbol to have the number of bytes
>  to skip on the file.
>  By the way, the bit in the kernel header is set by the bootloader to say
>  where it has loaded the kernel, not by the compiler/linker chain.

Nope.  LOADED_HIGH in loadflags is set at compile time.  It determines
where the bootloader must load the compressed part of the kernel.

>  So is it possible to write somewhere how much code to skip or the offset
>  of the kernel GZIP signature?

Already done.

>  Something like:
>   jmp next
>   lss SYMBOL_NAME(stack_start),%esp
> next:
>  Would make me really happy, but is dirty.
>  Changing the 'tmppiggy.lnk' in the Makefile can be done, but the value
>  (to know the length of the decompressor code) has to be _before_ the code
>  itself in the raw file.

Yep.

>  Else whatever signature at whatever fixed address with the code+rodata
>  size following would make me happy.

Check out the code.

Eric
