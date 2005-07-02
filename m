Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVGBRnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVGBRnB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 13:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGBRnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 13:43:01 -0400
Received: from mail.suse.de ([195.135.220.2]:28585 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261233AbVGBRk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 13:40:56 -0400
Date: Sat, 2 Jul 2005 19:40:55 +0200
From: Andi Kleen <ak@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
Message-ID: <20050702174055.GI21330@wotan.suse.de>
References: <42A2B610.1020408@drzeus.cx.suse.lists.linux.kernel> <42A3061C.7010604@drzeus.cx.suse.lists.linux.kernel> <42B1A08B.8080601@drzeus.cx.suse.lists.linux.kernel> <20050616170622.A1712@flint.arm.linux.org.uk.suse.lists.linux.kernel> <42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel> <1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel> <42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel> <42C432BB.407@drzeus.cx.suse.lists.linux.kernel> <p73u0jeg5lg.fsf@verdi.suse.de> <42C6CF40.4040308@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C6CF40.4040308@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I used i8259.c as an example and it includes its suspend routines in all
> cases. Also, the problem this patch solves is for suspend-to-ram, not
> suspend-to-disk (i.e. software suspend).

Hmm, it would be better if that all was CONFIG_ able. But ok.

> Index: linux-wbsd/arch/x86_64/kernel/Makefile
> ===================================================================
> --- linux-wbsd/arch/x86_64/kernel/Makefile	(revision 153)
> +++ linux-wbsd/arch/x86_64/kernel/Makefile	(working copy)
> @@ -7,7 +7,8 @@
>  obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
>  		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
>  		x8664_ksyms.o i387.o syscall.o vsyscall.o \
> -		setup64.o bootflag.o e820.o reboot.o quirks.o
> +		setup64.o bootflag.o e820.o reboot.o quirks.o \
> +		../../i386/kernel/i8237.o

I think that will break in builds with separate objdirs. You'll need
to do it like the other files (see the end of the Makefile)

-Andi
