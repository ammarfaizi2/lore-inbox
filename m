Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSE2UhR>; Wed, 29 May 2002 16:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSE2UhQ>; Wed, 29 May 2002 16:37:16 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:51593 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S313898AbSE2UhP>; Wed, 29 May 2002 16:37:15 -0400
Date: Wed, 29 May 2002 15:37:15 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 : 'make dep' error
In-Reply-To: <Pine.LNX.4.33.0205291611040.8639-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0205291528160.9971-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Frank Davis wrote:

> make[1]: Entering directory `/usr/src/linux/scripts'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o split-include split-include.c
> In file included from /usr/include/linux/errno.h:4,
>                  from /usr/include/bits/errno.h:25,
>                  from /usr/include/errno.h:36,
>                  from split-include.c:26:
> /usr/include/asm/errno.h:4:31: asm-generic/errno.h: No such file or directory
> make[1]: *** [split-include] Error 1
> make[1]: Leaving directory `/usr/src/linux/scripts'
> make: *** [scripts/mkdep] Error 2

Uh-oh, your system doesn't build user space applications (that's not even 
kernel specific). I suppose you have a symlink from /usr/include/asm
to /usr/src/linux/include/asm? Ask google why that is not a good idea - 
well, actually, you have the answer right there ;-)

The kernel asm-i386/errno.h was changed to just include
asm-generic/errno.h in 2.5.19. Unfortunately, due to the symlink, your
userspace includes the kernel asm/errno.h, which now points to the (for 
userspace non existing) asm-generic/errno.h - bad luck.

So fix your setup to not use symlinks, or, at least, put an older kernel 
back into /usr/src/linux and compile the new kernels elsewhere.

--Kai


