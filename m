Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVH2CAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVH2CAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 22:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVH2CAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 22:00:35 -0400
Received: from smtpout.mac.com ([17.250.248.71]:21189 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751168AbVH2CAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 22:00:34 -0400
In-Reply-To: <20050828233716.GB3820@stusta.de>
References: <3B0AEB5C-4A65-413F-BD35-B9F0E0984653@mac.com> <20050828145503.7b1a5f71.akpm@osdl.org> <20050828233716.GB3820@stusta.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: multipart/mixed; boundary=Apple-Mail-1-944735047
Message-Id: <EA705652-7069-40EA-B9FA-5C9055B0C234@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Why is kmem_bufctl_t different across platforms?
Date: Sun, 28 Aug 2005 22:00:23 -0400
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-944735047
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

On Aug 28, 2005, at 19:37:16, Adrian Bunk wrote:
> On Sun, Aug 28, 2005 at 02:55:03PM -0700, Andrew Morton wrote:
>> Kyle Moffett <mrmacman_g4@mac.com> wrote:
>>> While exploring the asm-*/types.h files, I discovered that the
>>>  type "kmem_bufctl_t" is differently defined across each platform,
>>>  sometimes as a short, and sometimes as an int.  The only file
>>>  where it's used is mm/slab.c, and as far as I can tell, that file
>>>  doesn't care at all, aside from preferring it to be a small-sized
>>>  type.
>>
>> I don't think there's any good reason for this.  -mm's
>> slab-leak-detector.patch switches them all to unsigned long.
>
> What about moving it to include/linux/types.h ?

Or, since it's _only_ used in mm/slab.c, why not put it in there?
Here is a really simple patch that does just that:

--Apple-Mail-1-944735047
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="kmem_bufctl_t-consolidation.patch"
Content-Disposition: attachment;
	filename=kmem_bufctl_t-consolidation.patch

diff -r 79e63ca47e09 include/asm-alpha/types.h
--- a/include/asm-alpha/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-alpha/types.h	Sun Aug 28 21:59:49 2005
@@ -56,8 +56,6 @@
 typedef u64 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ALPHA_TYPES_H */
diff -r 79e63ca47e09 include/asm-arm/types.h
--- a/include/asm-arm/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-arm/types.h	Sun Aug 28 21:59:49 2005
@@ -52,8 +52,6 @@
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-arm26/types.h
--- a/include/asm-arm26/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-arm26/types.h	Sun Aug 28 21:59:49 2005
@@ -52,8 +52,6 @@
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-cris/types.h
--- a/include/asm-cris/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-cris/types.h	Sun Aug 28 21:59:49 2005
@@ -52,8 +52,6 @@
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-frv/types.h
--- a/include/asm-frv/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-frv/types.h	Sun Aug 28 21:59:49 2005
@@ -65,8 +65,6 @@
 
 typedef u32 dma_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-h8300/types.h
--- a/include/asm-h8300/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-h8300/types.h	Sun Aug 28 21:59:49 2005
@@ -58,8 +58,6 @@
 #define HAVE_SECTOR_T
 typedef u64 sector_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff -r 79e63ca47e09 include/asm-i386/types.h
--- a/include/asm-i386/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-i386/types.h	Sun Aug 28 21:59:49 2005
@@ -63,8 +63,6 @@
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-ia64/types.h
--- a/include/asm-ia64/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-ia64/types.h	Sun Aug 28 21:59:49 2005
@@ -67,8 +67,6 @@
 
 typedef u64 dma_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
 
diff -r 79e63ca47e09 include/asm-m32r/types.h
--- a/include/asm-m32r/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-m32r/types.h	Sun Aug 28 21:59:49 2005
@@ -55,8 +55,6 @@
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-m68k/types.h
--- a/include/asm-m68k/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-m68k/types.h	Sun Aug 28 21:59:49 2005
@@ -60,8 +60,6 @@
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-mips/types.h
--- a/include/asm-mips/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-mips/types.h	Sun Aug 28 21:59:49 2005
@@ -99,8 +99,6 @@
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-parisc/types.h
--- a/include/asm-parisc/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-parisc/types.h	Sun Aug 28 21:59:49 2005
@@ -56,8 +56,6 @@
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-ppc/types.h
--- a/include/asm-ppc/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-ppc/types.h	Sun Aug 28 21:59:49 2005
@@ -62,8 +62,6 @@
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-ppc64/types.h
--- a/include/asm-ppc64/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-ppc64/types.h	Sun Aug 28 21:59:49 2005
@@ -72,7 +72,6 @@
 	unsigned long env;
 } func_descr_t;
 
-typedef unsigned int kmem_bufctl_t;
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-s390/types.h
--- a/include/asm-s390/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-s390/types.h	Sun Aug 28 21:59:49 2005
@@ -79,8 +79,6 @@
 
 typedef u32 dma_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #ifndef __s390x__
 typedef union {
 	unsigned long long pair;
diff -r 79e63ca47e09 include/asm-sh/types.h
--- a/include/asm-sh/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-sh/types.h	Sun Aug 28 21:59:49 2005
@@ -58,8 +58,6 @@
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-sh64/types.h
--- a/include/asm-sh64/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-sh64/types.h	Sun Aug 28 21:59:49 2005
@@ -65,8 +65,6 @@
 #endif
 typedef u64 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #define BITS_PER_LONG 32
diff -r 79e63ca47e09 include/asm-sparc/types.h
--- a/include/asm-sparc/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-sparc/types.h	Sun Aug 28 21:59:49 2005
@@ -54,8 +54,6 @@
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-sparc64/types.h
--- a/include/asm-sparc64/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-sparc64/types.h	Sun Aug 28 21:59:49 2005
@@ -56,8 +56,6 @@
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-v850/types.h
--- a/include/asm-v850/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-v850/types.h	Sun Aug 28 21:59:49 2005
@@ -59,8 +59,6 @@
 
 typedef u32 dma_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-x86_64/types.h
--- a/include/asm-x86_64/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-x86_64/types.h	Sun Aug 28 21:59:49 2005
@@ -51,8 +51,6 @@
 typedef u64 sector_t;
 #define HAVE_SECTOR_T
 
-typedef unsigned short kmem_bufctl_t;
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -r 79e63ca47e09 include/asm-xtensa/types.h
--- a/include/asm-xtensa/types.h	Fri Aug 26 18:39:19 2005
+++ b/include/asm-xtensa/types.h	Sun Aug 28 21:59:49 2005
@@ -58,8 +58,6 @@
 
 typedef u32 dma_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
-
 #endif	/* __KERNEL__ */
 #endif
 
diff -r 79e63ca47e09 mm/slab.c
--- a/mm/slab.c	Fri Aug 26 18:39:19 2005
+++ b/mm/slab.c	Sun Aug 28 21:59:49 2005
@@ -189,6 +189,7 @@
  * is less than 512 (PAGE_SIZE<<3), but greater than 256.
  */
 
+typedef unsigned int kmem_bufctl_t;
 #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
 #define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)

--Apple-Mail-1-944735047
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.




--Apple-Mail-1-944735047--
