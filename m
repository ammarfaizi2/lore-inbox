Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRCSBpq>; Sun, 18 Mar 2001 20:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131331AbRCSBpg>; Sun, 18 Mar 2001 20:45:36 -0500
Received: from [211.58.56.23] ([211.58.56.23]:19931 "EHLO mo8.hananet.net")
	by vger.kernel.org with ESMTP id <S131323AbRCSBpX>;
	Sun, 18 Mar 2001 20:45:23 -0500
Date: Mon, 19 Mar 2001 10:43:39 +0900 (KST)
From: Byeong-ryeol Kim <jinbo21@hananet.net>
X-X-Sender: <jinbo21@progress.plw.net>
Reply-To: Byeong-ryeol Kim <jinbo21@hananet.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.2-ac18 and lvm_0.9
Message-ID: <Pine.LNX.4.33.0103191036460.18081-100000@progress.plw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I met following errors errors when compiling lvm_0.9(lvm-0.9 in latest
Rawhide) with gcc-2.95.3-test5 under kernel-2.4.2-ac18 and glibc-2.2.2.

....
make[1]: Entering directory `/usr/src/redhat/BUILD/LVM/0.9/tools'
make[2]: Entering directory `/usr/src/redhat/BUILD/LVM/0.9/tools/lib'
make[3]: Entering directory `/usr/src/redhat/BUILD/LVM/0.9/tools/lib'
gcc -c -pipe -D_GNU_SOURCE -O2 -march=i686 -mcpu=i686 -pipe -Wall \
-I../../tools/lib -I../../tools -o basename.o basename.c
In file included from /usr/include/linux/prefetch.h:13,
                 from /usr/include/linux/list.h:6,
                 from ../../tools/lib/lvm.h:98,
                 from ../../tools/lib/liblvm.h:90,
                 from basename.c:34:
/usr/include/asm/processor.h:47: parse error before `u16'
/usr/include/asm/processor.h:47: warning: no semicolon at end of struct \
or union
/usr/include/asm/processor.h:56: parse error before `}'
make[3]: *** [basename.o] Error 1
make[3]: Leaving directory `/usr/src/redhat/BUILD/LVM/0.9/tools/lib'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/usr/src/redhat/BUILD/LVM/0.9/tools/lib'
make[2]: Entering directory `/usr/src/redhat/BUILD/LVM/0.9/tools/man8'
make[3]: Entering directory `/usr/src/redhat/BUILD/LVM/0.9/tools/man8'
make[3]: Leaving directory `/usr/src/redhat/BUILD/LVM/0.9/tools/man8'
make[2]: Leaving directory `/usr/src/redhat/BUILD/LVM/0.9/tools/man8'
make[2]: Entering directory `/usr/src/redhat/BUILD/LVM/0.9/tools'
gcc -c -pipe -D_GNU_SOURCE -O2 -march=i686 -mcpu=i686 -pipe -Wall \
-I../tools/lib -I../tools -o e2fsadm.o e2fsadm.c
In file included from /usr/include/linux/prefetch.h:13,
                 from /usr/include/linux/list.h:6,
                 from ../tools/lib/lvm.h:98,
                 from ../tools/lib/liblvm.h:90,
                 from ../tools/lvm_user.h:44,
                 from e2fsadm.c:45:
/usr/include/asm/processor.h:47: parse error before `u16'
/usr/include/asm/processor.h:47: warning: no semicolon at end of \
struct or union
/usr/include/asm/processor.h:56: parse error before `}'
make[2]: *** [e2fsadm.o] Error 1
....

This is true to 2.4.2-20, too.
After applying folling patch to kernel source, the compile process of
lvm-0.9 went through flawlessly. I guess it is a typo introduced into
2.4.2-ac18 or so.


--- linux/include/asm/processor.h.orig	Tue Mar 13 03:55:41 2001
+++ linux/include/asm/processor.h	Tue Mar 13 03:52:16 2001
@@ -44,7 +44,7 @@
 	char	x86_model_id[64];
 	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
 				    call  */
-	u16	clockmul;	 /* Clock multiplier */
+	__u16	clockmul;	 /* Clock multiplier */
 	int	fdiv_bug;
 	int	f00f_bug;
 	int	coma_bug;

-- 
 "Where there is a will, there is a way."  jinbo21@hananet.net
  For the future of you and me!            hitel: jinbo21



