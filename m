Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315557AbSEJLuB>; Fri, 10 May 2002 07:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315559AbSEJLuA>; Fri, 10 May 2002 07:50:00 -0400
Received: from kim.it.uu.se ([130.238.12.178]:4480 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S315557AbSEJLt7>;
	Fri, 10 May 2002 07:49:59 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.46033.278561.40777@kim.it.uu.se>
Date: Fri, 10 May 2002 13:49:37 +0200
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.15 warnings
In-Reply-To: <26949.1021006885@kao2.melbourne.sgi.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
 > drivers/char/ftape/zftape/zftape-init.c: In function `zft_open':
 > drivers/char/ftape/zftape/zftape-init.c:116: warning: passing arg 2 of `test_and_set_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c:122: warning: passing arg 2 of `clear_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c:130: warning: passing arg 2 of `clear_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c: In function `zft_close':
 > drivers/char/ftape/zftape/zftape-init.c:149: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c:159: warning: passing arg 2 of `clear_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c: In function `zft_ioctl':
 > drivers/char/ftape/zftape/zftape-init.c:172: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c: In function `zft_mmap':
 > drivers/char/ftape/zftape/zftape-init.c:192: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c: In function `zft_read':
 > drivers/char/ftape/zftape/zftape-init.c:222: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
 > drivers/char/ftape/zftape/zftape-init.c: In function `zft_write':
 > drivers/char/ftape/zftape/zftape-init.c:245: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type

This patch silences the zftape warnings. (Dave: please include in the next -dj)

/Mikael

--- linux-2.5.15/drivers/char/ftape/zftape/zftape-init.c.~1~	Wed Feb 20 03:11:00 2002
+++ linux-2.5.15/drivers/char/ftape/zftape/zftape-init.c	Fri May 10 01:54:40 2002
@@ -67,7 +67,7 @@
 
 /*      Local vars.
  */
-static int busy_flag;
+static unsigned long busy_flag;
 
 static sigset_t orig_sigmask;
 
