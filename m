Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276787AbRJHHNb>; Mon, 8 Oct 2001 03:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276785AbRJHHNV>; Mon, 8 Oct 2001 03:13:21 -0400
Received: from [203.94.130.164] ([203.94.130.164]:23306 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S276782AbRJHHNL>;
	Mon, 8 Oct 2001 03:13:11 -0400
Date: Mon, 8 Oct 2001 17:28:53 +1000 (EST)
From: brett <brett@bad-sports.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Toshiba driver compilation error
Message-ID: <Pine.LNX.4.33.0110081723010.17228-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

The patch to drivers/char/toshiba.c in 2.4.10-ac6 added in an #ifdef that
shouldn't be there.  It caused the following compilation error when
toshiba.c was built in.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.10-ac7/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i586   -c -o drivers/char/toshiba.o
drivers/char/toshiba.c

drivers/char/toshiba.c:87: parse error before string constant
drivers/char/toshiba.c:87: warning: type defaults to `int' in
declaration of `MODULE_PARM'
drivers/char/toshiba.c:87: warning: function declaration isn't a
prototype
drivers/char/toshiba.c:87: warning: data definition has no type or
storage classdrivers/char/toshiba.c:89: parse error before string
constant
drivers/char/toshiba.c:89: warning: type defaults to `int' in
declaration of `MODULE_LICENSE'
drivers/char/toshiba.c:89: warning: function declaration isn't a
prototype
drivers/char/toshiba.c:89: warning: data definition has no type or
storage classdrivers/char/toshiba.c:98: `THIS_MODULE' undeclared here
(not in a function)
drivers/char/toshiba.c:98: initializer element is not constant
drivers/char/toshiba.c:98: (near initialization for `tosh_fops.owner')
make: *** [drivers/char/toshiba.o] Error 1

Of course, the simple solution is

--- drivers/char/toshiba.c~	Mon Oct  8 16:55:23 2001
+++ drivers/char/toshiba.c	Sun Oct  7 23:07:23 2001
@@ -56,10 +56,8 @@
 #define TOSH_VERSION "1.11 26/9/2001"
 #define TOSH_DEBUG 0

-#ifdef MODULE
 #include <linux/module.h>
 #include <linux/version.h>
-#endif
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/types.h>


Alan, I think this can safely be applied, as opposed to the patch I gave
you on a napkin at LCA last year, which I think you were correct in
rejecting :)

thanks,

	/ Brett

