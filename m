Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWI1HDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWI1HDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWI1HDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:03:15 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:33478 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751649AbWI1HDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:03:10 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: __STRICT_ANSI__ checks in headers
Date: Thu, 28 Sep 2006 10:03:27 +0300
User-Agent: KMail/1.9.4
Cc: David Woodhouse <dwmw2@infradead.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       mchehab@infradead.org
References: <200609150901.33644.ismail@pardus.org.tr> <1158829373.24527.596.camel@pmac.infradead.org> <200609211553.55853.ismail@pardus.org.tr>
In-Reply-To: <200609211553.55853.ismail@pardus.org.tr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AP3GFXZa/V7u4xh"
Message-Id: <200609281003.28644.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_AP3GFXZa/V7u4xh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

21 Eyl 2006 Per 15:53 tarihinde, Ismail Donmez =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:=20
> 21 Eyl 2006 Per 12:02 tarihinde, David Woodhouse =C5=9Funlar=C4=B1 yazm=
=C4=B1=C5=9Ft=C4=B1:
> > On Thu, 2006-09-21 at 12:00 +0300, Ismail Donmez wrote:
> > > This looks way cleaner, I can cook up a patch for this if everyone
> > > agrees.  What do you guys think?
> >
> > Makes sense.
>
> Ok here is patch replacing __STRICT_ANSI__ with __extension__ as suggested
> by Kyle Moffett:
>
> __STRICT_ANSI__ usage in types.h header results in compile errors for some
> userspace packages[1] when used with gcc -ansi flag. With the suggestion =
of
> Kyle Moffett I replace strict ansi checks with __extension__ to tell gcc
> not to error or warn on gcc extensions. Compile tested on x86 with 2.6.18.
>
> [1]  kopete and kdetv are such userspace applications.
>
> Signed-off-by: Ismail Donmez <ismail@pardus.org.tr>

David, is this ok? It would be good to apply this for 2.6.19 so all of KDE=
=20
would compile ( all of the parts I tested ) with kernel-headers.

Regards,
ismail

=2D-=20
They that can give up essential liberty to obtain a little temporary safety=
=20
deserve neither liberty nor safety.
=2D- Benjamin Franklin

--Boundary-00=_AP3GFXZa/V7u4xh
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="strict-ansi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="strict-ansi.patch"

diff --git a/include/asm-arm/types.h b/include/asm-arm/types.h
index 22992ee..3141451 100644
--- a/include/asm-arm/types.h
+++ b/include/asm-arm/types.h
@@ -19,9 +19,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-arm26/types.h b/include/asm-arm26/types.h
index 81bd357..11d8a01 100644
--- a/include/asm-arm26/types.h
+++ b/include/asm-arm26/types.h
@@ -19,9 +19,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-cris/types.h b/include/asm-cris/types.h
index 84557c9..0bc01a9 100644
--- a/include/asm-cris/types.h
+++ b/include/asm-cris/types.h
@@ -19,9 +19,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
@@ -48,7 +48,7 @@ typedef signed long long s64;
 typedef unsigned long long u64;
 
 /* Dma addresses are 32-bits wide, just like our other addresses.  */
- 
+
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
diff --git a/include/asm-frv/types.h b/include/asm-frv/types.h
index 1b6d192..767e5ed 100644
--- a/include/asm-frv/types.h
+++ b/include/asm-frv/types.h
@@ -30,9 +30,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-h8300/types.h b/include/asm-h8300/types.h
index da2402b..231d0b1 100644
--- a/include/asm-h8300/types.h
+++ b/include/asm-h8300/types.h
@@ -27,9 +27,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 /*
diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
index 4b4b295..ef1607d 100644
--- a/include/asm-i386/types.h
+++ b/include/asm-i386/types.h
@@ -19,9 +19,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-m32r/types.h b/include/asm-m32r/types.h
index fcf24c6..8a14833 100644
--- a/include/asm-m32r/types.h
+++ b/include/asm-m32r/types.h
@@ -23,9 +23,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/asm-m68k/types.h b/include/asm-m68k/types.h
index b5a1feb..c35c09d 100644
--- a/include/asm-m68k/types.h
+++ b/include/asm-m68k/types.h
@@ -27,9 +27,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-mips/types.h b/include/asm-mips/types.h
index 2b52e18..d3fb568 100644
--- a/include/asm-mips/types.h
+++ b/include/asm-mips/types.h
@@ -34,9 +34,9 @@ typedef unsigned long __u64;
 
 #else
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif
@@ -69,9 +69,9 @@ typedef unsigned long u64;
 
 #else
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long s64;
-typedef unsigned long long u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long s64;
+__extension__ typedef unsigned long long u64;
 #endif
 
 #endif
diff --git a/include/asm-parisc/types.h b/include/asm-parisc/types.h
index 34fdce3..5722ffa 100644
--- a/include/asm-parisc/types.h
+++ b/include/asm-parisc/types.h
@@ -19,9 +19,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
index d6fb56b..ffe0233 100644
--- a/include/asm-powerpc/types.h
+++ b/include/asm-powerpc/types.h
@@ -40,9 +40,9 @@ #ifdef __powerpc64__
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
 #else
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 #endif /* __powerpc64__ */
 
diff --git a/include/asm-s390/types.h b/include/asm-s390/types.h
index ae2951c..50b7cd0 100644
--- a/include/asm-s390/types.h
+++ b/include/asm-s390/types.h
@@ -28,9 +28,9 @@ typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
 #ifndef __s390x__
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 #else /* __s390x__ */
 typedef __signed__ long __s64;
@@ -38,9 +38,9 @@ typedef unsigned long __u64;
 #endif
 
 /* A address type so that arithmetic can be done on it & it can be upgraded to
-   64 bit when necessary 
+   64 bit when necessary
 */
-typedef unsigned long addr_t; 
+typedef unsigned long addr_t;
 typedef __signed__ long saddr_t;
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-sh/types.h b/include/asm-sh/types.h
index 3c09dd4..574b31d 100644
--- a/include/asm-sh/types.h
+++ b/include/asm-sh/types.h
@@ -19,9 +19,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-sh64/types.h b/include/asm-sh64/types.h
index 8d41db2..2c7ad73 100644
--- a/include/asm-sh64/types.h
+++ b/include/asm-sh64/types.h
@@ -30,9 +30,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/asm-v850/types.h b/include/asm-v850/types.h
index dcef571..284bda8 100644
--- a/include/asm-v850/types.h
+++ b/include/asm-v850/types.h
@@ -27,9 +27,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 #endif /* !__ASSEMBLY__ */
diff --git a/include/asm-xtensa/types.h b/include/asm-xtensa/types.h
index 9d99a8e..958f362 100644
--- a/include/asm-xtensa/types.h
+++ b/include/asm-xtensa/types.h
@@ -29,9 +29,9 @@ typedef unsigned short __u16;
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#if defined(__GNUC__)
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
 #endif
 
 /*
diff --git a/include/linux/types.h b/include/linux/types.h
index 3f23566..4a6be4c 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -52,8 +52,8 @@ typedef __kernel_uid_t		uid_t;
 typedef __kernel_gid_t		gid_t;
 #endif /* __KERNEL__ */
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __kernel_loff_t		loff_t;
+#if defined(__GNUC__)
+__extension__ typedef __kernel_loff_t		loff_t;
 #endif
 
 /*
@@ -118,10 +118,10 @@ typedef		__u8		uint8_t;
 typedef		__u16		uint16_t;
 typedef		__u32		uint32_t;
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef		__u64		uint64_t;
-typedef		__u64		u_int64_t;
-typedef		__s64		int64_t;
+#if defined(__GNUC__)
+__extension__ typedef		__u64		uint64_t;
+__extension__ typedef		__u64		u_int64_t;
+__extension__ typedef		__s64		int64_t;
 #endif
 
 /* this is a special 64bit data type that is 8-byte aligned */
@@ -170,9 +170,9 @@ typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
 typedef __u32 __bitwise __le32;
 typedef __u32 __bitwise __be32;
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __u64 __bitwise __le64;
-typedef __u64 __bitwise __be64;
+#if defined(__GNUC__)
+__extension__ typedef __u64 __bitwise __le64;
+__extension__ typedef __u64 __bitwise __be64;
 #endif
 
 #ifdef __KERNEL__

--Boundary-00=_AP3GFXZa/V7u4xh--
