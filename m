Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTKHCjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 21:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTKHCjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 21:39:52 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:5650 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261484AbTKHCjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 21:39:47 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: alpha@steudten.com (Thomas Steudten), Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG Missing define] 2.6.0-test 9-bk11: ALPHA:  missing asm/mca.h
Organization: Core
In-Reply-To: <3FABD32A.9090601@steudten.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1AIIzZ-0002oE-00@gondolin.me.apana.org.au>
Date: Sat, 08 Nov 2003 13:38:25 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Steudten <alpha@steudten.com> wrote:
> 
> Andrew Morton wrote:
> 
>> Thomas Steudten <alpha@steudten.com> wrote:
>> 
>>>This problem ist still there in -test9..
>>>
>>>In file included from drivers/net/3c509.c:77:
>>>include/linux/mca.h:15:21: asm/mca.h: No such file or directory
>
> Problem still there in -bk11. Who can fix this in the kernel
> source code?

I don't know.  But here is a different approach which hides the
ifdef stuff in mca*.h.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
Index: kernel-source-2.5/include/linux/mca-legacy.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/include/linux/mca-legacy.h,v
retrieving revision 1.1.1.3
retrieving revision 1.3
diff -u -r1.1.1.3 -r1.3
--- kernel-source-2.5/include/linux/mca-legacy.h	8 Oct 2003 19:24:51 -0000	1.1.1.3
+++ kernel-source-2.5/include/linux/mca-legacy.h	26 Oct 2003 04:50:38 -0000	1.3
@@ -7,6 +7,7 @@
 #ifndef _LINUX_MCA_LEGACY_H
 #define _LINUX_MCA_LEGACY_H
 
+#include <linux/config.h>
 #include <linux/mca.h>
 
 #warning "MCA legacy - please move your driver to the new sysfs api"
@@ -24,7 +25,7 @@
  */
 #define MCA_NOTFOUND	(-1)
 
-
+#ifdef CONFIG_MCA
 
 /* Returns the slot of the first enabled adapter matching id.  User can
  * specify a starting slot beyond zero, to deal with detecting multiple
@@ -70,3 +71,4 @@
 extern void mca_write_pos(int slot, int reg, unsigned char byte);
 
 #endif
+#endif
Index: kernel-source-2.5/include/linux/mca.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/include/linux/mca.h,v
retrieving revision 1.4
retrieving revision 1.6
diff -u -r1.4 -r1.6
--- kernel-source-2.5/include/linux/mca.h	11 Oct 2003 06:29:27 -0000	1.4
+++ kernel-source-2.5/include/linux/mca.h	26 Oct 2003 04:50:38 -0000	1.6
@@ -6,6 +6,10 @@
 #ifndef _LINUX_MCA_H
 #define _LINUX_MCA_H
 
+#include <linux/config.h>
+
+#ifdef CONFIG_MCA
+
 /* FIXME: This shouldn't happen, but we need everything that previously
  * included mca.h to compile.  Take it out later when the MCA #includes
  * are sorted out */
@@ -149,4 +153,5 @@
 }
 #endif
 
+#endif /* CONFIG_MCA */
 #endif /* _LINUX_MCA_H */
