Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWFZBCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWFZBCG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWFZA7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:59:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20879 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965001AbWFZA67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:59 -0400
Date: Sun, 25 Jun 2006 17:58:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 29/43] mips64 support for klibc
Message-Id: <klibc.200606251757.29@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the mips64 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit ebd2860ad3dc19cb11fd5b9cc235cab54e9165f4
tree 9102166758a04802e42c8eaaddf103002a14eb68
parent 8dc79563c06020d8844b9e9b821741828039b59e
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:33 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:33 -0700

 usr/include/arch/mips64/klibc/archconfig.h |   14 ++++++++++++
 usr/include/arch/mips64/klibc/archsignal.h |   14 ++++++++++++
 usr/include/arch/mips64/klibc/archstat.h   |   33 ++++++++++++++++++++++++++++
 usr/include/arch/mips64/klibc/archsys.h    |   12 ++++++++++
 usr/klibc/arch/mips64/MCONFIG              |   11 +++++++++
 usr/klibc/arch/mips64/Makefile.inc         |   10 ++++++++
 6 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/usr/include/arch/mips64/klibc/archconfig.h b/usr/include/arch/mips64/klibc/archconfig.h
new file mode 100644
index 0000000..b440af1
--- /dev/null
+++ b/usr/include/arch/mips64/klibc/archconfig.h
@@ -0,0 +1,14 @@
+/*
+ * include/arch/mips64/klibc/archconfig.h
+ *
+ * See include/klibc/sysconfig.h for the options that can be set in
+ * this file.
+ *
+ */
+
+#ifndef _KLIBC_ARCHCONFIG_H
+#define _KLIBC_ARCHCONFIG_H
+
+/* All defaults */
+
+#endif				/* _KLIBC_ARCHCONFIG_H */
diff --git a/usr/include/arch/mips64/klibc/archsignal.h b/usr/include/arch/mips64/klibc/archsignal.h
new file mode 100644
index 0000000..f350af9
--- /dev/null
+++ b/usr/include/arch/mips64/klibc/archsignal.h
@@ -0,0 +1,14 @@
+/*
+ * arch/mips64/include/klibc/archsignal.h
+ *
+ * Architecture-specific signal definitions
+ *
+ */
+
+#ifndef _KLIBC_ARCHSIGNAL_H
+#define _KLIBC_ARCHSIGNAL_H
+
+#include <asm/signal.h>
+/* No special stuff for this architecture */
+
+#endif
diff --git a/usr/include/arch/mips64/klibc/archstat.h b/usr/include/arch/mips64/klibc/archstat.h
new file mode 100644
index 0000000..577f9ad
--- /dev/null
+++ b/usr/include/arch/mips64/klibc/archstat.h
@@ -0,0 +1,33 @@
+#ifndef _KLIBC_ARCHSTAT_H
+#define _KLIBC_ARCHSTAT_H
+
+#define _STATBUF_ST_NSEC
+
+struct stat {
+	unsigned int		st_dev;
+	unsigned int		st_pad0[3]; /* Reserved for st_dev expansion */
+
+	unsigned long		st_ino;
+
+	mode_t			st_mode;
+	nlink_t			st_nlink;
+
+	uid_t			st_uid;
+	gid_t			st_gid;
+
+	unsigned int		st_rdev;
+	unsigned int		st_pad1[3]; /* Reserved for st_rdev expansion */
+
+	off_t			st_size;
+
+	struct timespec		st_atim;
+	struct timespec		st_mtim;
+	struct timespec		st_ctim;
+
+	unsigned int		st_blksize;
+	unsigned int		st_pad2;
+
+	unsigned long		st_blocks;
+};
+
+#endif
diff --git a/usr/include/arch/mips64/klibc/archsys.h b/usr/include/arch/mips64/klibc/archsys.h
new file mode 100644
index 0000000..76492d4
--- /dev/null
+++ b/usr/include/arch/mips64/klibc/archsys.h
@@ -0,0 +1,12 @@
+/*
+ * arch/mips64/include/klibc/archsys.h
+ *
+ * Architecture-specific syscall definitions
+ */
+
+#ifndef _KLIBC_ARCHSYS_H
+#define _KLIBC_ARCHSYS_H
+
+/* No special syscall definitions for this architecture */
+
+#endif				/* _KLIBC_ARCHSYS_H */
diff --git a/usr/klibc/arch/mips64/MCONFIG b/usr/klibc/arch/mips64/MCONFIG
new file mode 100644
index 0000000..3b55625
--- /dev/null
+++ b/usr/klibc/arch/mips64/MCONFIG
@@ -0,0 +1,11 @@
+# -*- makefile -*-
+#
+# arch/mips64/MCONFIG
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+KLIBCOPTFLAGS = -Os
+KLIBCBITSIZE  = 64
diff --git a/usr/klibc/arch/mips64/Makefile.inc b/usr/klibc/arch/mips64/Makefile.inc
new file mode 100644
index 0000000..4a9529a
--- /dev/null
+++ b/usr/klibc/arch/mips64/Makefile.inc
@@ -0,0 +1,10 @@
+# -*- makefile -*-
+#
+# arch/mips64/Makefile.inc
+#
+# Special rules for this architecture.  Note that this is actually
+# included from the main Makefile, and that pathnames should be
+# accordingly.
+#
+
+archclean:
