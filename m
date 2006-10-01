Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752020AbWJAEyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbWJAEyD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 00:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWJAEyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 00:54:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752020AbWJAEyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 00:54:00 -0400
Date: Sat, 30 Sep 2006 21:53:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, mchehab@infradead.org
Subject: Re: __STRICT_ANSI__ checks in headers
Message-Id: <20060930215343.548f5cd9.akpm@osdl.org>
In-Reply-To: <200609281030.26640.ismail@pardus.org.tr>
References: <200609150901.33644.ismail@pardus.org.tr>
	<200609281003.28644.ismail@pardus.org.tr>
	<1159427179.3309.183.camel@pmac.infradead.org>
	<200609281030.26640.ismail@pardus.org.tr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 10:30:25 +0300
Ismail Donmez <ismail@pardus.org.tr> wrote:

> 28 Eyl 2006 Per 10:06 tarihinde, David Woodhouse şunları yazmıştı: 
> > On Thu, 2006-09-28 at 10:03 +0300, Ismail Donmez wrote:
> > > David, is this ok? It would be good to apply this for 2.6.19 so all of
> > > KDE would compile ( all of the parts I tested ) with kernel-headers.
> >
> > Looks good to me.
> 
> Andrew, now that David gave his blessing , can you push this for 2.6.19?
> 

Bisection shows that this patch causes these depmod warnings:



WARNING: "snd_card_disconnect" [sound/usb/usx2y/snd-usb-usx2y.ko] has no CRC!
WARNING: "snd_card_disconnect" [sound/usb/snd-usb-audio.ko] has no CRC!
WARNING: "snd_card_disconnect" [sound/drivers/mpu401/snd-mpu401.ko] has no CRC!
WARNING: "no_llseek" [net/sunrpc/sunrpc.ko] has no CRC!
WARNING: "seq_lseek" [net/sunrpc/sunrpc.ko] has no CRC!
WARNING: "seq_lseek" [net/sctp/sctp.ko] has no CRC!
WARNING: "seq_lseek" [net/netfilter/x_tables.ko] has no CRC!
WARNING: "seq_lseek" [net/netfilter/nfnetlink_queue.ko] has no CRC!
WARNING: "seq_lseek" [net/netfilter/nfnetlink_log.ko] has no CRC!
WARNING: "seq_lseek" [net/ipv4/netfilter/ipt_hashlimit.ko] has no CRC!
WARNING: "seq_lseek" [net/ipv4/netfilter/ipt_CLUSTERIP.ko] has no CRC!
WARNING: "seq_lseek" [net/ipv4/netfilter/ip_conntrack.ko] has no CRC!
WARNING: "generic_file_llseek" [fs/ufs/ufs.ko] has no CRC!
WARNING: "remote_llseek" [fs/smbfs/smbfs.ko] has no CRC!
WARNING: "generic_file_llseek" [fs/ntfs/ntfs.ko] has no CRC!
WARNING: "vfs_llseek" [fs/nfsd/nfsd.ko] has no CRC!
WARNING: "seq_lseek" [fs/nfsd/nfsd.ko] has no CRC!
WARNING: "remote_llseek" [fs/nfs/nfs.ko] has no CRC!
[etc]


I don't know why that would happen.

http://www.zip.com.au/~akpm/linux/patches/stuff/config-sony



From: Ismail Donmez <ismail@pardus.org.tr>

__STRICT_ANSI__ usage in types.h header results in compile errors for some
userspace packages[1] when used with gcc -ansi flag.  With the suggestion
of Kyle Moffett I replace strict ansi checks with __extension__ to tell gcc
not to error or warn on gcc extensions.  Compile tested on x86 with 2.6.18.

[1]  kopete and kdetv are such userspace applications.

Signed-off-by: Ismail Donmez <ismail@pardus.org.tr>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/asm-arm/types.h     |    6 +++---
 include/asm-arm26/types.h   |    6 +++---
 include/asm-cris/types.h    |    8 ++++----
 include/asm-frv/types.h     |    6 +++---
 include/asm-h8300/types.h   |    6 +++---
 include/asm-i386/types.h    |    6 +++---
 include/asm-m32r/types.h    |    6 +++---
 include/asm-m68k/types.h    |    6 +++---
 include/asm-mips/types.h    |   12 ++++++------
 include/asm-parisc/types.h  |    6 +++---
 include/asm-powerpc/types.h |    6 +++---
 include/asm-s390/types.h    |   10 +++++-----
 include/asm-sh/types.h      |    6 +++---
 include/asm-sh64/types.h    |    6 +++---
 include/asm-v850/types.h    |    6 +++---
 include/asm-xtensa/types.h  |    6 +++---
 include/linux/types.h       |   18 +++++++++---------
 17 files changed, 63 insertions(+), 63 deletions(-)

diff -puN include/asm-arm/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-arm/types.h
--- a/include/asm-arm/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-arm/types.h
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
diff -puN include/asm-arm26/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-arm26/types.h
--- a/include/asm-arm26/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-arm26/types.h
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
diff -puN include/asm-cris/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-cris/types.h
--- a/include/asm-cris/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-cris/types.h
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
 
diff -puN include/asm-frv/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-frv/types.h
--- a/include/asm-frv/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-frv/types.h
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
diff -puN include/asm-h8300/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-h8300/types.h
--- a/include/asm-h8300/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-h8300/types.h
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
diff -puN include/asm-i386/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-i386/types.h
--- a/include/asm-i386/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-i386/types.h
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
diff -puN include/asm-m32r/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-m32r/types.h
--- a/include/asm-m32r/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-m32r/types.h
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
 
diff -puN include/asm-m68k/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-m68k/types.h
--- a/include/asm-m68k/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-m68k/types.h
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
diff -puN include/asm-mips/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-mips/types.h
--- a/include/asm-mips/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-mips/types.h
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
diff -puN include/asm-parisc/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-parisc/types.h
--- a/include/asm-parisc/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-parisc/types.h
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
diff -puN include/asm-powerpc/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-powerpc/types.h
--- a/include/asm-powerpc/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-powerpc/types.h
@@ -40,9 +40,9 @@ typedef unsigned int __u32;
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
 
diff -puN include/asm-s390/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-s390/types.h
--- a/include/asm-s390/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-s390/types.h
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
diff -puN include/asm-sh/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-sh/types.h
--- a/include/asm-sh/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-sh/types.h
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
diff -puN include/asm-sh64/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-sh64/types.h
--- a/include/asm-sh64/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-sh64/types.h
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
diff -puN include/asm-v850/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-v850/types.h
--- a/include/asm-v850/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-v850/types.h
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
diff -puN include/asm-xtensa/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/asm-xtensa/types.h
--- a/include/asm-xtensa/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/asm-xtensa/types.h
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
diff -puN include/linux/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__ include/linux/types.h
--- a/include/linux/types.h~fix-compile-errors-for-64-bit-types-in-headers-with-__strict_ansi__
+++ a/include/linux/types.h
@@ -54,8 +54,8 @@ typedef __kernel_uid_t		uid_t;
 typedef __kernel_gid_t		gid_t;
 #endif /* __KERNEL__ */
 
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __kernel_loff_t		loff_t;
+#if defined(__GNUC__)
+__extension__ typedef __kernel_loff_t		loff_t;
 #endif
 
 /*
@@ -120,10 +120,10 @@ typedef		__u8		uint8_t;
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
@@ -172,9 +172,9 @@ typedef __u16 __bitwise __le16;
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
_

