Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVABLBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVABLBg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 06:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVABLBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 06:01:35 -0500
Received: from mail.linicks.net ([217.204.244.146]:46208 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261248AbVABLBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 06:01:30 -0500
From: Nick Warne <nick@linicks.net>
To: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: kswapd0 oops -> debug information
Date: Sun, 2 Jan 2005 11:01:21 +0000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200411271311.25997.nick@linicks.net> <200411271721.21847.nick@linicks.net> <20050102074112.GA31709@mail.13thfloor.at>
In-Reply-To: <20050102074112.GA31709@mail.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501021101.21117.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 January 2005 07:41, Herbert Poetzl wrote:

> > The book I have re the make /dir/file.s states that it will produce
> > assembler with _line_ numbers to corresponding C code.  That is where I
> > got lost, as it doesn't.
>
> hmm, sorry for the late reply, but better late
> than not at all ...
>
> if you do
>
>  make fs/file.s V=1
>
> you'll see what make actually does to compile
> the source code into assembler code ...
>
> make -f scripts/Makefile.build obj=scripts/basic
> make -f scripts/Makefile.build obj=scripts
> make -f scripts/Makefile.build obj=fs fs/file.s
>   gcc -Wp,-MD,fs/.file.s.d -nostdinc -iwithprefix include -D__KERNEL__
> -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -O2     -fomit-frame-pointer -g -pipe -msoft-float
> -mpreferred-stack-boundary=2  -march=i586 -Iinclude/asm-i386/mach-default  
>   -DKBUILD_BASENAME=file -DKBUILD_MODNAME=file -S -o fs/file.s fs/file.c
>
> and if that final gcc command does include a -g
> (which can be controlled by CONFIG_DEBUG_INFO, or
> simply added by hand), then the output will contain
> lines like this:
>
>         .loc 1 45 0
>         .loc 1 46 0
>
> which reference the file and line number in the
> source code. files are 'declared' with lines:
>
>         .file   "file.c"
>         .file 1 "fs/file.c"
>         .file 2 "include/linux/posix_types.h"
>
> so you can pretty easy find the code in the
> source. a different, but sometimes easier approach
> is to use 'addr2line' on the kernel binary (if it
> was compiled with CONFIG_DEBUG_INFO) to get the
> source line from a kernel address ...
>
>  addr2line -e vmlinux c0123456
>
> HTH,
> Herbert

Hi Herbert,

Thanks for reply.

I will file this for when needed again for future reference, as I have moved 
back to 2.6.4 kernel, as that tree never once produces a kswapd oops and just 
runs and runs and runs.

I just don't know why > 2.6.4 kernels produce oops on my system - I have been 
through change log looking at all the relevant stuff, but can't really see 
anything obvious.  I have built kernels 'clean' from bottom up, but all 
produce kswapd oops within a few days - except 2.6.4.

I wish this box wasn't my LAN gateway, otherwise I wouldn't mine when it does 
go AWOL and I could debug at my leisure.

Thanks for help,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
