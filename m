Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132146AbRDKHai>; Wed, 11 Apr 2001 03:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRDKHaT>; Wed, 11 Apr 2001 03:30:19 -0400
Received: from bcs-marka.marka.net.ua ([217.24.161.217]:48139 "EHLO
	relay1.bcs.zp.ua") by vger.kernel.org with ESMTP id <S132146AbRDKHaI>;
	Wed, 11 Apr 2001 03:30:08 -0400
Message-Id: <200104110729.KAA02201@pif.bcs.zp.ua>
Subject: iBCS with 2.2.19 kernel
To: k3ph@dxis.monroe.pa.us, linux-kernel@vger.kernel.org
Date: Wed, 11 Apr 2001 10:29:22 +0300 (EEST)
From: sav@bcs.zp.ua (Andrew V. Samoilov)
Organization: Business Computer Service (Zaporozhye)
X-Mailer: ELM [version 2.4ME+ PL47 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-03-27 08:39:32 PST Bob Schreibmaier k3ph@dxis.monroe.pa.us write
to comp.os.linux.misc

> I just compiled the 2.2.19 kernel with gcc 2.95.3.
> Compiles and runs just fine.  I recompiled the
> iBCS 2.1 module and it compiles just fine, too.
> However, when I try to insmod iBCS it complains
> about variable strlen_user undefined.
> 
> Everything works fine under 2.2.18.
> 
> Anybody else see this?  Anybody know how to fix this?
>
> TIA.

This night I also had same problem. But iBCS does not work for me from 2.2.18.

I write a patch, and it seems everithing works fine for me.

Can you test this patch ?

With best wishes,
Andrew.

diff -rup ibcs/iBCSemul/binfmt_lib.c ibcs-2219/iBCSemul/binfmt_lib.c
--- ibcs/iBCSemul/binfmt_lib.c	Sat Jul  4 01:22:11 1998
+++ ibcs-2219/iBCSemul/binfmt_lib.c	Wed Apr 11 02:08:12 2001
@@ -12,6 +12,9 @@
 
 #include <asm/pgtable.h>

+#if LINUX_VERSION_CODE > 0x020212	/* > 2.2.18 */
+#define	strlen_user(p)	strnlen_user((p), LONG_MAX)
+#endif
 
 unsigned long *
 create_ibcs_tables(char *p, struct linux_binprm *bprm, int ibcs)
diff -rup ibcs/include/ibcs/ibcs.h ibcs-2219/include/ibcs/ibcs.h
--- ibcs/include/ibcs/ibcs.h	Thu Nov  5 23:50:32 1998
+++ ibcs-2219/include/ibcs/ibcs.h	Wed Apr 11 02:07:40 2001
@@ -43,9 +43,11 @@ do_revalidate(struct dentry *dentry)
 	return 0;
 }
 
-
 typedef int (*sysfun_p)();
 
+#if LINUX_VERSION_CODE > 0x020212	/* > 2.2.18 */
+#define	strlen_user(p)	strnlen_user ((p), LONG_MAX)
+#endif
 
 extern sysfun_p sys_call_table[];
 
