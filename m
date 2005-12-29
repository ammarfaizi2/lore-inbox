Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVL2UbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVL2UbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVL2UbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:31:25 -0500
Received: from quark.didntduck.org ([69.55.226.66]:1184 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750965AbVL2UbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:31:24 -0500
Message-ID: <43B447B9.7070902@didntduck.org>
Date: Thu, 29 Dec 2005 15:31:53 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Generic ioctl.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most arches copied the i386 ioctl.h.  Combine them into a generic header.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit fec8726c9f690898a16e094ddf19f5e119ed44b8
tree 81c772242e0622d3f892b484908f03a21148da93
parent 25b9d12fb87201e1fb11501a383e9cf62f37d21c
author Brian Gerst <bgerst@didntduck.org> Thu, 29 Dec 2005 13:12:45 -0500
committer Brian Gerst <bgerst@didntduck.org> Thu, 29 Dec 2005 13:12:45 -0500

 include/asm-arm/ioctl.h       |   75 -----------------------------------
 include/asm-arm26/ioctl.h     |   75 -----------------------------------
 include/asm-cris/ioctl.h      |   84 ---------------------------------------
 include/asm-frv/ioctl.h       |   81 -------------------------------------
 include/asm-generic/ioctl.h   |   80 +++++++++++++++++++++++++++++++++++++
 include/asm-h8300/ioctl.h     |   81 -------------------------------------
 include/asm-i386/ioctl.h      |   86 ----------------------------------------
 include/asm-ia64/ioctl.h      |   78 ------------------------------------
 include/asm-m32r/ioctl.h      |   79 ------------------------------------
 include/asm-m68k/ioctl.h      |   81 -------------------------------------
 include/asm-m68knommu/ioctl.h |    2 -
 include/asm-s390/ioctl.h      |   89 -----------------------------------------
 include/asm-sh/ioctl.h        |   76 -----------------------------------
 include/asm-sh64/ioctl.h      |   84 ---------------------------------------
 include/asm-v850/ioctl.h      |   81 -------------------------------------
 include/asm-x86_64/ioctl.h    |   76 -----------------------------------
 include/asm-xtensa/ioctl.h    |   84 ---------------------------------------
 17 files changed, 96 insertions(+), 1196 deletions(-)

diff --git a/include/asm-arm/ioctl.h b/include/asm-arm/ioctl.h
index 2cbb7d0..b279fe0 100644
--- a/include/asm-arm/ioctl.h
+++ b/include/asm-arm/ioctl.h
@@ -1,74 +1 @@
-/*
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _ASMARM_IOCTL_H
-#define _ASMARM_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASMARM_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-arm26/ioctl.h b/include/asm-arm26/ioctl.h
index 2cbb7d0..b279fe0 100644
--- a/include/asm-arm26/ioctl.h
+++ b/include/asm-arm26/ioctl.h
@@ -1,74 +1 @@
-/*
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _ASMARM_IOCTL_H
-#define _ASMARM_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASMARM_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-cris/ioctl.h b/include/asm-cris/ioctl.h
index be2d8f6..b279fe0 100644
--- a/include/asm-cris/ioctl.h
+++ b/include/asm-cris/ioctl.h
@@ -1,83 +1 @@
-/*
- * linux/ioctl.h for Linux by H.H. Bergman.
- *
- * This is the same as the i386 version.
- */
-
-#ifndef _ASMCRIS_IOCTL_H
-#define _ASMCRIS_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* provoke compile error for invalid uses of size argument */
-extern int __invalid_size_argument_for_IOC;
-#define _IOC_TYPECHECK(t) \
-	((sizeof(t) == sizeof(t[1]) && \
-	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
-	  sizeof(t) : __invalid_size_argument_for_IOC)
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASMCRIS_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-frv/ioctl.h b/include/asm-frv/ioctl.h
index 8aee769..b279fe0 100644
--- a/include/asm-frv/ioctl.h
+++ b/include/asm-frv/ioctl.h
@@ -1,80 +1 @@
-/*
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _ASM_IOCTL_H
-#define _ASM_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * I don't really have any idea about what this should look like, so
- * for the time being, this is heavily based on the PC definitions.
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASM_IOCTL_H */
-
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-generic/ioctl.h b/include/asm-generic/ioctl.h
new file mode 100644
index 0000000..cd02729
--- /dev/null
+++ b/include/asm-generic/ioctl.h
@@ -0,0 +1,80 @@
+#ifndef _ASM_GENERIC_IOCTL_H
+#define _ASM_GENERIC_IOCTL_H
+
+/* ioctl command encoding: 32 bits total, command in lower 16 bits,
+ * size of the parameter structure in the lower 14 bits of the
+ * upper 16 bits.
+ * Encoding the size of the parameter structure in the ioctl request
+ * is useful for catching programs compiled with old versions
+ * and to avoid overwriting user space outside the user buffer area.
+ * The highest 2 bits are reserved for indicating the ``access mode''.
+ * NOTE: This limits the max parameter size to 16kB -1 !
+ */
+
+/*
+ * The following is for compatibility across the various Linux
+ * platforms.  The generic ioctl numbering scheme doesn't really enforce
+ * a type field.  De facto, however, the top 8 bits of the lower 16
+ * bits are indeed used as a type field, so we might just as well make
+ * this explicit here.  Please be sure to use the decoding macros
+ * below from now on.
+ */
+#define _IOC_NRBITS	8
+#define _IOC_TYPEBITS	8
+#define _IOC_SIZEBITS	14
+#define _IOC_DIRBITS	2
+
+#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
+#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
+#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
+#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
+
+#define _IOC_NRSHIFT	0
+#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
+#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
+#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
+
+/*
+ * Direction bits.
+ */
+#define _IOC_NONE	0U
+#define _IOC_WRITE	1U
+#define _IOC_READ	2U
+
+#define _IOC(dir,type,nr,size) \
+	(((dir)  << _IOC_DIRSHIFT) | \
+	 ((type) << _IOC_TYPESHIFT) | \
+	 ((nr)   << _IOC_NRSHIFT) | \
+	 ((size) << _IOC_SIZESHIFT))
+
+/* provoke compile error for invalid uses of size argument */
+extern unsigned int __invalid_size_argument_for_IOC;
+#define _IOC_TYPECHECK(t) \
+	((sizeof(t) == sizeof(t[1]) && \
+	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
+	  sizeof(t) : __invalid_size_argument_for_IOC)
+
+/* used to create numbers */
+#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
+#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+
+/* used to decode ioctl numbers.. */
+#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
+#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
+#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
+#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
+
+/* ...and for the drivers/sound files... */
+
+#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
+#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
+#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
+#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
+#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
+
+#endif /* _ASM_GENERIC_IOCTL_H */
diff --git a/include/asm-h8300/ioctl.h b/include/asm-h8300/ioctl.h
index 031c623..b279fe0 100644
--- a/include/asm-h8300/ioctl.h
+++ b/include/asm-h8300/ioctl.h
@@ -1,80 +1 @@
-/* $Id: ioctl.h,v 1.1 2002/11/19 02:09:26 gerg Exp $
- *
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _H8300_IOCTL_H
-#define _H8300_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * I don't really have any idea about what this should look like, so
- * for the time being, this is heavily based on the PC definitions.
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _H8300_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-i386/ioctl.h b/include/asm-i386/ioctl.h
index 543f784..b279fe0 100644
--- a/include/asm-i386/ioctl.h
+++ b/include/asm-i386/ioctl.h
@@ -1,85 +1 @@
-/* $Id: ioctl.h,v 1.5 1993/07/19 21:53:50 root Exp root $
- *
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _ASMI386_IOCTL_H
-#define _ASMI386_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* provoke compile error for invalid uses of size argument */
-extern unsigned int __invalid_size_argument_for_IOC;
-#define _IOC_TYPECHECK(t) \
-	((sizeof(t) == sizeof(t[1]) && \
-	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
-	  sizeof(t) : __invalid_size_argument_for_IOC)
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASMI386_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-ia64/ioctl.h b/include/asm-ia64/ioctl.h
index be9cc24..b279fe0 100644
--- a/include/asm-ia64/ioctl.h
+++ b/include/asm-ia64/ioctl.h
@@ -1,77 +1 @@
-#ifndef _ASM_IA64_IOCTL_H
-#define _ASM_IA64_IOCTL_H
-
-/*
- * Based on <asm-i386/ioctl.h>.
- *
- * Modified 1998, 1999
- *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
- */
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The ia64 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASM_IA64_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-m32r/ioctl.h b/include/asm-m32r/ioctl.h
index 87d8f7d..b279fe0 100644
--- a/include/asm-m32r/ioctl.h
+++ b/include/asm-m32r/ioctl.h
@@ -1,78 +1 @@
-#ifndef _ASM_M32R_IOCTL_H
-#define _ASM_M32R_IOCTL_H
-
-/* $Id$ */
-
-/* orig : i386 2.4.18 */
-
-/*
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASM_M32R_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-m68k/ioctl.h b/include/asm-m68k/ioctl.h
index fd68914..b279fe0 100644
--- a/include/asm-m68k/ioctl.h
+++ b/include/asm-m68k/ioctl.h
@@ -1,80 +1 @@
-/* $Id: ioctl.h,v 1.3 1997/04/16 15:10:07 jes Exp $
- *
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _M68K_IOCTL_H
-#define _M68K_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * I don't really have any idea about what this should look like, so
- * for the time being, this is heavily based on the PC definitions.
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _M68K_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-m68knommu/ioctl.h b/include/asm-m68knommu/ioctl.h
index cff72f3..b279fe0 100644
--- a/include/asm-m68knommu/ioctl.h
+++ b/include/asm-m68knommu/ioctl.h
@@ -1 +1 @@
-#include <asm-m68k/ioctl.h>
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-s390/ioctl.h b/include/asm-s390/ioctl.h
index df73943..b279fe0 100644
--- a/include/asm-s390/ioctl.h
+++ b/include/asm-s390/ioctl.h
@@ -1,88 +1 @@
-/*
- *  include/asm-s390/ioctl.h
- *
- *  S390 version
- *
- *  Derived from "include/asm-i386/ioctl.h"
- */
-
-#ifndef _S390_IOCTL_H
-#define _S390_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* provoke compile error for invalid uses of size argument */
-extern unsigned long __invalid_size_argument_for_IOC;
-#define _IOC_TYPECHECK(t) \
-	((sizeof(t) == sizeof(t[1]) && \
-	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
-	  sizeof(t) : __invalid_size_argument_for_IOC)
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _S390_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-sh/ioctl.h b/include/asm-sh/ioctl.h
index 524700e..b279fe0 100644
--- a/include/asm-sh/ioctl.h
+++ b/include/asm-sh/ioctl.h
@@ -1,75 +1 @@
-/* $Id: ioctl.h,v 1.1.1.1 2001/10/15 20:45:09 mrbrown Exp $
- *
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef __ASM_SH_IOCTL_H
-#define __ASM_SH_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* __ASM_SH_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-sh64/ioctl.h b/include/asm-sh64/ioctl.h
index c089a6f..b279fe0 100644
--- a/include/asm-sh64/ioctl.h
+++ b/include/asm-sh64/ioctl.h
@@ -1,83 +1 @@
-#ifndef __ASM_SH64_IOCTL_H
-#define __ASM_SH64_IOCTL_H
-
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * include/asm-sh64/ioctl.h
- *
- * Copyright (C) 2000, 2001  Paolo Alberelli
- *
- * linux/ioctl.h for Linux by H.H. Bergman.
- *
- */
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* __ASM_SH64_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-v850/ioctl.h b/include/asm-v850/ioctl.h
index 1765df6..b279fe0 100644
--- a/include/asm-v850/ioctl.h
+++ b/include/asm-v850/ioctl.h
@@ -1,80 +1 @@
-/* $Id: ioctl.h,v 1.1 2002/09/28 14:58:41 gerg Exp $
- *
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _V850_IOCTL_H
-#define _V850_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * I don't really have any idea about what this should look like, so
- * for the time being, this is heavily based on the PC definitions.
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* __V850_IOCTL_H__ */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-x86_64/ioctl.h b/include/asm-x86_64/ioctl.h
index 609b663..b279fe0 100644
--- a/include/asm-x86_64/ioctl.h
+++ b/include/asm-x86_64/ioctl.h
@@ -1,75 +1 @@
-/* $Id: ioctl.h,v 1.2 2001/07/04 09:08:13 ak Exp $
- *
- * linux/ioctl.h for Linux by H.H. Bergman.
- */
-
-#ifndef _ASMX8664_IOCTL_H
-#define _ASMX8664_IOCTL_H
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _ASMX8664_IOCTL_H */
+#include <asm-generic/ioctl.h>
diff --git a/include/asm-xtensa/ioctl.h b/include/asm-xtensa/ioctl.h
index 856c605..b279fe0 100644
--- a/include/asm-xtensa/ioctl.h
+++ b/include/asm-xtensa/ioctl.h
@@ -1,83 +1 @@
-/*
- * include/asm-xtensa/ioctl.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2003 - 2005 Tensilica Inc.
- *
- * Derived from "include/asm-i386/ioctl.h"
- */
-
-#ifndef _XTENSA_IOCTL_H
-#define _XTENSA_IOCTL_H
-
-
-/* ioctl command encoding: 32 bits total, command in lower 16 bits,
- * size of the parameter structure in the lower 14 bits of the
- * upper 16 bits.
- * Encoding the size of the parameter structure in the ioctl request
- * is useful for catching programs compiled with old versions
- * and to avoid overwriting user space outside the user buffer area.
- * The highest 2 bits are reserved for indicating the ``access mode''.
- * NOTE: This limits the max parameter size to 16kB -1 !
- */
-
-/*
- * The following is for compatibility across the various Linux
- * platforms.  The i386 ioctl numbering scheme doesn't really enforce
- * a type field.  De facto, however, the top 8 bits of the lower 16
- * bits are indeed used as a type field, so we might just as well make
- * this explicit here.  Please be sure to use the decoding macros
- * below from now on.
- */
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	14
-#define _IOC_DIRBITS	2
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits.
- */
-#define _IOC_NONE	0U
-#define _IOC_WRITE	1U
-#define _IOC_READ	2U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode ioctl numbers.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif
+#include <asm-generic/ioctl.h>

