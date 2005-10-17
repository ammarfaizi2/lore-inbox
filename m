Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVJQQeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVJQQeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVJQQeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:34:01 -0400
Received: from [139.30.44.2] ([139.30.44.2]:60958 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750743AbVJQQd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:33:59 -0400
Date: Mon, 17 Oct 2005 18:33:58 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: nyk <nyk@giantx.co.uk>, Andi Kleen <ak@suse.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] Re: 2.6.14-rc4-mm1 ntfs/namei.c missing compat.h?
In-Reply-To: <20051017144900.GA2942@giantx.co.uk>
Message-ID: <Pine.LNX.4.61.0510171828440.5555@gans.physik3.uni-rostock.de>
References: <20051017144900.GA2942@giantx.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, nyk wrote:

> Looks like fs/ntfs/namei.c is missing linux/compat.h
> 
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC [M]  fs/ntfs/namei.o
> In file included from include/linux/dcache.h:6,
>                  from fs/ntfs/namei.c:23:
> include/asm/atomic.h:383: error: syntax error before '*' token
> include/asm/atomic.h:384: warning: function declaration isn't a prototype
> include/asm/atomic.h: In function 'atomic_scrub':
> include/asm/atomic.h:385: error: 'u32' undeclared (first use in this function)
> include/asm/atomic.h:385: error: (Each undeclared identifier is reported only once
[...]
> 
> Compiles fine with #include <linux/compat.h> added to the top of
> fs/ntfs/namei.c
> 
> If that's the right place for it, of course.

[Looks like you are on x86_64, as i386 compiles fine]

Actually, <asm-x86_64/atomic.h> seems to need <asm/types.h> for the 
declaration of u32.
The patch below makes NTFS compile on x86_64 for me. Andi?

Tim


--- linux-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h	2005-10-17 17:48:12.000000000 +0200
+++ linux-2.6.14-rc4-mm1-build/include/asm-x86_64/atomic.h	2005-10-17 18:20:19.000000000 +0200
@@ -2,6 +2,7 @@
 #define __ARCH_X86_64_ATOMIC__
 
 #include <linux/config.h>
+#include <asm/types.h>
 
 /* atomic_t should be 32 bit signed type */
 
