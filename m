Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUIRR2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUIRR2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 13:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269584AbUIRR2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 13:28:35 -0400
Received: from undl.funcitec.rct-sc.br ([200.135.30.197]:63361 "HELO
	mail.undl.org.br") by vger.kernel.org with SMTP id S268964AbUIRR2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 13:28:32 -0400
Message-ID: <414C6FFC.6060604@undl.org.br>
Date: Sat, 18 Sep 2004 14:27:24 -0300
From: Carlos Eduardo Medaglia Dyonisio <medaglia@undl.org.br>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: medaglia@undl.org.br
Subject: [PATCH][2.6.9-rc2] Fix types.h
Content-Type: multipart/mixed;
 boundary="------------010307090504010108060903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307090504010108060903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

This patch fixes troubles when compiling some applications that include 
<linux/byteorder/little_endian.h>, like xmms. When I was compiling xmms 
I've got:
In file included from /usr/include/asm/byteorder.h:57,
                  from /usr/include/linux/cdrom.h:14,
                  from cdaudio.h:60,
                  from cdaudio.c:21:
/usr/include/linux/byteorder/little_endian.h:43: error: parse error 
before "__cpu_to_le64p"
/usr/include/linux/byteorder/little_endian.h: In function `__cpu_to_le64p':
/usr/include/linux/byteorder/little_endian.h:45: error: `__le64' 
undeclared (first use in this function)
...etc...

I've put the __le(16|32|64) and __be(16|32|64) typedefs out of #ifndef 
__KERNEL_STRICT_NAMES and now everything is working. Xmms is compiling 
fine, and linux kernel too. :)

Maybe I made something wrong, because this is my first patch to linux 
kernel... But everything is working fine for me.

Regards,
Cadu

--------------010307090504010108060903
Content-Type: text/plain;
 name="patch-types.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-types.h.diff"

--- linux-2.6.9-rc2/include/linux/types.h	2004-09-13 02:33:23.000000000 -0300
+++ linux/include/linux/types.h	2004-09-18 14:16:27.000000000 -0300
@@ -140,6 +140,13 @@
 #define pgoff_t unsigned long
 #endif
 
+#endif /* __KERNEL_STRICT_NAMES */
+
+/*
+ * Below are truly Linux-specific types that should never collide with
+ * any application/library that wants linux/types.h.
+ */
+
 #ifdef __CHECKER__
 #define __bitwise __attribute__((bitwise))
 #else
@@ -153,13 +160,6 @@
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 
-#endif /* __KERNEL_STRICT_NAMES */
-
-/*
- * Below are truly Linux-specific types that should never collide with
- * any application/library that wants linux/types.h.
- */
-
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 	__kernel_ino_t		f_tinode;

--------------010307090504010108060903--
