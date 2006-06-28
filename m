Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423176AbWF1FXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423176AbWF1FXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWF1FTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:4046 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423169AbWF1FTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:07 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 12/31] mips64 support for klibc
Date: Tue, 27 Jun 2006 22:17:12 -0700
Message-Id: <klibc.200606272217.12@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parts of klibc specific to the mips64 architecture.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 364ccece6cff9e5b99b6b5b94d2f781ebf6bdfb8
tree b1d0debd466a7a43ae4b686e7025bd83ebfa14ed
parent de9abe3c88abea63b10e8935cff79211c5983c9e
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:46 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:46 -0700

 usr/include/arch/mips64/klibc/archconfig.h |   14 ++++++++++++
 usr/include/arch/mips64/klibc/archsignal.h |   14 ++++++++++++
 usr/include/arch/mips64/klibc/archstat.h   |   33 ++++++++++++++++++++++++++++
 usr/klibc/arch/mips64/MCONFIG              |   11 +++++++++
 usr/klibc/arch/mips64/Makefile.inc         |   10 ++++++++
 5 files changed, 82 insertions(+), 0 deletions(-)

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
