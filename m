Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbTFVCq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 22:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbTFVCqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 22:46:25 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22995 "EHLO
	rwcrmhc11.attbi.com") by vger.kernel.org with ESMTP id S265470AbTFVCqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 22:46:16 -0400
Message-ID: <3EF51E1F.9000701@kegel.com>
Date: Sat, 21 Jun 2003 20:10:23 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kaz Kojima <kkojima@rr.iij4u.or.jp>
Subject: [PATCH] Hide struct ustat in include/linux/types.h from userspace?;
 needed to build glibc-2.3.2 on sh4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to apply the following patch, kindly sent to me by
Kaz Kojima, to the 2.4.19/2.4.20 kernel in
order to build glibc-2.3.2 for the sh4 processor.
All it does is hide the kernel's definition of struct ustat
from userspace.  This prevents a clash with the userspace
definition of struct ustat.
I verified this has not yet been applied as of 2.4.22-pre1.

I'm not familiar enough with the kernel/c-library interface to
know whether this patch is the proper fix, but it's the one
being used by the sh-linux folks.

The symptom without this patch is:

In file included from sys/ustat.h:30,
                  from ../sysdeps/unix/sysv/linux/ustat.c:21:
../sysdeps/generic/bits/ustat.h:26: error: redefinition of `struct ustat'
make[2]: *** [/build/sh4-unknown-linux-gnu/gcc-3.3-glibc-2.3.2/build-glibc/misc/ustat.o] Error 1
make[2]: Leaving directory `/build/sh4-unknown-linux-gnu/gcc-3.3-glibc-2.3.2/glibc-2.3.2/misc'

Yeah, I know the sh folks have their own kernel tree, but IMHO
one ought at least be able to build working toolchains with the
vanilla vger kernel headers.   I now have a script that builds
cross-toolchains for many architectures from scratch at
  http://kegel.com/crosstool
and I'm trying to nudge patches into the main trees of gcc, glibc, and linux
so their next vanilla releases can be used to build working
cross-compilers targeting every architecture glibc supports
without patches.
- Dan

diff -u linux-2.5.69-sf-orig/include/linux/types.h /usr/local/sh4-unknown-linux-gnu/include/linux/types.h
--- linux-2.5.69-sf-orig/include/linux/types.h	Wed Mar  5 12:29:34 2003
+++ sh4-unknown-linux-gnu/include/linux/types.h	Sat Apr 19 10:05:52 2003
@@ -141,6 +141,7 @@

  #endif /* __KERNEL_STRICT_NAMES */

+#ifdef	__KERNEL__
  /*
   * Below are truly Linux-specific types that should never collide with
   * any application/library that wants linux/types.h.
@@ -152,5 +153,6 @@
  	char			f_fname[6];
  	char			f_fpack[6];
  };
+#endif

  #endif /* _LINUX_TYPES_H */


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

