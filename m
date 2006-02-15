Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWBOGey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWBOGey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWBOGey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:34:54 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:22109 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750866AbWBOGex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:34:53 -0500
X-IronPort-AV: i="4.02,116,1139212800"; 
   d="scan'208"; a="405298938:sNHT42587868"
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, mst@mellanox.co.il, hugh@veritas.com,
       wli@holomorphy.com, gleb@minantech.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       vandrove@vc.cvut.cz, pbadari@us.ibm.com, grundler@parisc-linux.org,
       matthew@wil.cx
Subject: [PATCH] Fix up MADV_DONTFORK/MADV_DOFORK definitions
X-Message-Flag: Warning: May contain useful information
References: <20060213154114.GO32041@mellanox.co.il>
	<Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
	<adar767133j.fsf@cisco.com>
	<Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
	<Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
	<20060213210906.GC13603@mellanox.co.il>
	<Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
	<Pine.LNX.4.64.0602131426470.3691@g5.osdl.org>
	<20060213225538.GE13603@mellanox.co.il>
	<Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com>
	<20060213233517.GG13603@mellanox.co.il>
	<43F2AEAE.5010700@yahoo.com.au> <adawtfxqhk1.fsf@cisco.com>
	<20060214221654.67288424.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Feb 2006 22:34:48 -0800
In-Reply-To: <20060214221654.67288424.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 14 Feb 2006 22:16:54 -0800")
Message-ID: <adaslqlqgdz.fsf_-_@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 15 Feb 2006 06:34:51.0805 (UTC) FILETIME=[ECEA8CD0:01C631F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> yes, please do.

OK, here's a patch that changes them to 9 and 10.  I would hold off
sending this to Linus until Michael has a chance to speak up, in case
there's a reason I don't know for choosing 0x30 and 0x31.

 - R.


The recently added MADV_DONTFORK and MADV_DOFORK values were defined
to be 0x30 and 0x31 respectively.  This leaves a strange gap from the
older values, and ends up putting the values in the range of values
that parisc reserves for page size specification.  Also, the macros
were always defined using hex, which looks somewhat strange when an
architecture defines all the other values in decimal.

Change MADV_DONTFORK and MADV_DOFORK to be 9 and 10 respectively.
These values are unused on all architectures and safely outside of the
parisc reserved range.  Define the values in decimal or hex to match
the surrounding style for each architecture.  While we're touching all
this, change the comments from "dont inherit" to "don't inherit."

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/asm-alpha/mman.h b/include/asm-alpha/mman.h
index a21515c..0831a7c 100644
--- a/include/asm-alpha/mman.h
+++ b/include/asm-alpha/mman.h
@@ -43,8 +43,8 @@
 #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
 #define MADV_DONTNEED	6		/* don't need these pages */
 #define MADV_REMOVE	7		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	9		/* don't inherit across fork */
+#define MADV_DOFORK	10		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-arm/mman.h b/include/asm-arm/mman.h
index 693ed85..9a87604 100644
--- a/include/asm-arm/mman.h
+++ b/include/asm-arm/mman.h
@@ -36,8 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-arm26/mman.h b/include/asm-arm26/mman.h
index 2096c50..83240c8 100644
--- a/include/asm-arm26/mman.h
+++ b/include/asm-arm26/mman.h
@@ -36,8 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-cris/mman.h b/include/asm-cris/mman.h
index deddfb2..536bb02 100644
--- a/include/asm-cris/mman.h
+++ b/include/asm-cris/mman.h
@@ -38,8 +38,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-frv/mman.h b/include/asm-frv/mman.h
index d3bca30..7f96e5f 100644
--- a/include/asm-frv/mman.h
+++ b/include/asm-frv/mman.h
@@ -36,8 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-h8300/mman.h b/include/asm-h8300/mman.h
index ac0346f..e03cbd8 100644
--- a/include/asm-h8300/mman.h
+++ b/include/asm-h8300/mman.h
@@ -36,8 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-i386/mman.h b/include/asm-i386/mman.h
index ab2339a..2c740e2 100644
--- a/include/asm-i386/mman.h
+++ b/include/asm-i386/mman.h
@@ -36,8 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-ia64/mman.h b/include/asm-ia64/mman.h
index 357ebb7..a4b8dc1 100644
--- a/include/asm-ia64/mman.h
+++ b/include/asm-ia64/mman.h
@@ -44,8 +44,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-m32r/mman.h b/include/asm-m32r/mman.h
index 6b02fe3..68c28c5 100644
--- a/include/asm-m32r/mman.h
+++ b/include/asm-m32r/mman.h
@@ -38,8 +38,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-m68k/mman.h b/include/asm-m68k/mman.h
index efd12bc..dd98f77 100644
--- a/include/asm-m68k/mman.h
+++ b/include/asm-m68k/mman.h
@@ -36,8 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-mips/mman.h b/include/asm-mips/mman.h
index 6d01e26..018eb2e 100644
--- a/include/asm-mips/mman.h
+++ b/include/asm-mips/mman.h
@@ -66,8 +66,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON       MAP_ANONYMOUS
diff --git a/include/asm-parisc/mman.h b/include/asm-parisc/mman.h
index a381cf5..e231d7a 100644
--- a/include/asm-parisc/mman.h
+++ b/include/asm-parisc/mman.h
@@ -39,6 +39,8 @@
 #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
 #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
 #define MADV_REMOVE     8		/* remove these pages & resources */
+#define MADV_DONTFORK	9		/* don't inherit across fork */
+#define MADV_DOFORK	10		/* do inherit across fork */
 
 /* The range 12-64 is reserved for page size specification. */
 #define MADV_4K_PAGES   12              /* Use 4K pages  */
@@ -49,8 +51,6 @@
 #define MADV_4M_PAGES   22              /* Use 4 Megabyte pages */
 #define MADV_16M_PAGES  24              /* Use 16 Megabyte pages */
 #define MADV_64M_PAGES  26              /* Use 64 Megabyte pages */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-powerpc/mman.h b/include/asm-powerpc/mman.h
index fcff25d..e81aa80 100644
--- a/include/asm-powerpc/mman.h
+++ b/include/asm-powerpc/mman.h
@@ -45,8 +45,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-s390/mman.h b/include/asm-s390/mman.h
index d41ca14..d9a5387 100644
--- a/include/asm-s390/mman.h
+++ b/include/asm-s390/mman.h
@@ -44,8 +44,8 @@
 #define MADV_WILLNEED  0x3              /* pre-fault pages */
 #define MADV_DONTNEED  0x4              /* discard these pages */
 #define MADV_REMOVE    0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK  0x9		/* don't inherit across fork */
+#define MADV_DOFORK    0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-sh/mman.h b/include/asm-sh/mman.h
index 0e08d05..0e3efb1 100644
--- a/include/asm-sh/mman.h
+++ b/include/asm-sh/mman.h
@@ -36,8 +36,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-sparc/mman.h b/include/asm-sparc/mman.h
index 4a298b2..d1618d8 100644
--- a/include/asm-sparc/mman.h
+++ b/include/asm-sparc/mman.h
@@ -55,8 +55,8 @@
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
 #define MADV_REMOVE	0x6		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-sparc64/mman.h b/include/asm-sparc64/mman.h
index d705ec9..cabec87 100644
--- a/include/asm-sparc64/mman.h
+++ b/include/asm-sparc64/mman.h
@@ -55,8 +55,8 @@
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
 #define MADV_REMOVE	0x6		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-v850/mman.h b/include/asm-v850/mman.h
index 7b851c3..d652235 100644
--- a/include/asm-v850/mman.h
+++ b/include/asm-v850/mman.h
@@ -33,8 +33,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-x86_64/mman.h b/include/asm-x86_64/mman.h
index b699a38..9333709 100644
--- a/include/asm-x86_64/mman.h
+++ b/include/asm-x86_64/mman.h
@@ -37,8 +37,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff --git a/include/asm-xtensa/mman.h b/include/asm-xtensa/mman.h
index e2d7afb..12f93a7 100644
--- a/include/asm-xtensa/mman.h
+++ b/include/asm-xtensa/mman.h
@@ -73,8 +73,8 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_REMOVE	0x5		/* remove these pages & resources */
-#define MADV_DONTFORK	0x30		/* dont inherit across fork */
-#define MADV_DOFORK	0x31		/* do inherit across fork */
+#define MADV_DONTFORK	0x9		/* don't inherit across fork */
+#define MADV_DOFORK	0xa		/* do inherit across fork */
 
 /* compatibility flags */
 #define MAP_ANON       MAP_ANONYMOUS
