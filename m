Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUBJQW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265948AbUBJQW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:22:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:27801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265843AbUBJQWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:22:51 -0500
Date: Tue, 10 Feb 2004 08:25:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Chua <jchua@fedex.com>
Cc: jeffchua@silk.corp.fedex.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
Message-Id: <20040210082514.04afde4a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com>
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
	<20040209225336.1f9bc8a8.akpm@osdl.org>
	<Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua <jchua@fedex.com> wrote:
>
> ...
> Here's output of "gcc -H sig.c" gcc 2.95.3  glibc 2.2.5  linux 2.6.3-rc2
> 
> 
> /usr/include/signal.h
>  /usr/include/features.h
>   /usr/include/sys/cdefs.h
>   /usr/include/gnu/stubs.h
>  /usr/include/bits/sigset.h
>  /usr/include/bits/types.h
>   /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stddef.h
>   /usr/include/bits/pthreadtypes.h
>    /usr/include/bits/sched.h
>  /usr/include/bits/signum.h
>  /usr/include/time.h
>  /usr/include/bits/siginfo.h
>   /usr/include/bits/wordsize.h
>  /usr/include/bits/sigaction.h
>  /usr/include/bits/sigcontext.h
>   /usr/include/asm/sigcontext.h
>    /usr/include/linux/compiler.h
>     /usr/include/linux/compiler-gcc2.h
>      /usr/include/linux/compiler-gcc.h
> In file included from /usr/include/linux/compiler.h:18,
>                  from /usr/include/asm/sigcontext.h:4,
>                  from /usr/include/bits/sigcontext.h:28,
>                  from /usr/include/signal.h:307,
>                  from sig.c:1:
> /usr/include/linux/compiler-gcc2.h:21: warning: `__attribute_used__' redefined

ah, thanks.

Like this?

--- 25/include/asm-i386/sigcontext.h~sigcontext-include-fix	2004-02-10 08:23:47.000000000 -0800
+++ 25-akpm/include/asm-i386/sigcontext.h	2004-02-10 08:24:18.000000000 -0800
@@ -1,7 +1,9 @@
 #ifndef _ASMi386_SIGCONTEXT_H
 #define _ASMi386_SIGCONTEXT_H
 
+#ifdef __KERNEL__
 #include <linux/compiler.h>
+#endif
 
 /*
  * As documented in the iBCS2 standard..

_

