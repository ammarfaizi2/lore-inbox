Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVGZRbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVGZRbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGZRbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:31:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16775 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261915AbVGZRaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:30:39 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/23] Add emergency_restart()
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:29:55 -0600
In-Reply-To: <m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:27:34 -0600")
Message-ID: <m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the kernel is working well and we want to restart cleanly
kernel_restart is the function to use.   But in many instances
the kernel wants to reboot when thing are expected to be working
very badly such as from panic or a software watchdog handler.

This patch adds the function emergency_restart() so that
callers can be clear what semantics they expect when calling
restart.  emergency_restart() is expected to be callable
from interrupt context and possibly reliable in even more
trying circumstances.

This is an initial generic implementation for all architectures.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 include/asm-alpha/emergency-restart.h     |    6 ++++++
 include/asm-arm/emergency-restart.h       |    6 ++++++
 include/asm-arm26/emergency-restart.h     |    6 ++++++
 include/asm-cris/emergency-restart.h      |    6 ++++++
 include/asm-frv/emergency-restart.h       |    6 ++++++
 include/asm-generic/emergency-restart.h   |    9 +++++++++
 include/asm-h8300/emergency-restart.h     |    6 ++++++
 include/asm-i386/emergency-restart.h      |    6 ++++++
 include/asm-ia64/emergency-restart.h      |    6 ++++++
 include/asm-m32r/emergency-restart.h      |    6 ++++++
 include/asm-m68k/emergency-restart.h      |    6 ++++++
 include/asm-m68knommu/emergency-restart.h |    6 ++++++
 include/asm-mips/emergency-restart.h      |    6 ++++++
 include/asm-parisc/emergency-restart.h    |    6 ++++++
 include/asm-ppc/emergency-restart.h       |    6 ++++++
 include/asm-ppc64/emergency-restart.h     |    6 ++++++
 include/asm-s390/emergency-restart.h      |    6 ++++++
 include/asm-sh/emergency-restart.h        |    6 ++++++
 include/asm-sh64/emergency-restart.h      |    6 ++++++
 include/asm-sparc/emergency-restart.h     |    6 ++++++
 include/asm-sparc64/emergency-restart.h   |    6 ++++++
 include/asm-um/emergency-restart.h        |    6 ++++++
 include/asm-v850/emergency-restart.h      |    6 ++++++
 include/asm-x86_64/emergency-restart.h    |    6 ++++++
 include/asm-xtensa/emergency-restart.h    |    6 ++++++
 include/linux/reboot.h                    |    7 +++++++
 kernel/sys.c                              |    6 ++++++
 27 files changed, 166 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-alpha/emergency-restart.h
 create mode 100644 include/asm-arm/emergency-restart.h
 create mode 100644 include/asm-arm26/emergency-restart.h
 create mode 100644 include/asm-cris/emergency-restart.h
 create mode 100644 include/asm-frv/emergency-restart.h
 create mode 100644 include/asm-generic/emergency-restart.h
 create mode 100644 include/asm-h8300/emergency-restart.h
 create mode 100644 include/asm-i386/emergency-restart.h
 create mode 100644 include/asm-ia64/emergency-restart.h
 create mode 100644 include/asm-m32r/emergency-restart.h
 create mode 100644 include/asm-m68k/emergency-restart.h
 create mode 100644 include/asm-m68knommu/emergency-restart.h
 create mode 100644 include/asm-mips/emergency-restart.h
 create mode 100644 include/asm-parisc/emergency-restart.h
 create mode 100644 include/asm-ppc/emergency-restart.h
 create mode 100644 include/asm-ppc64/emergency-restart.h
 create mode 100644 include/asm-s390/emergency-restart.h
 create mode 100644 include/asm-sh/emergency-restart.h
 create mode 100644 include/asm-sh64/emergency-restart.h
 create mode 100644 include/asm-sparc/emergency-restart.h
 create mode 100644 include/asm-sparc64/emergency-restart.h
 create mode 100644 include/asm-um/emergency-restart.h
 create mode 100644 include/asm-v850/emergency-restart.h
 create mode 100644 include/asm-x86_64/emergency-restart.h
 create mode 100644 include/asm-xtensa/emergency-restart.h

3d8ea7bd8df5d92589d8e02f45b979073c855848
diff --git a/include/asm-alpha/emergency-restart.h b/include/asm-alpha/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-alpha/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-arm/emergency-restart.h b/include/asm-arm/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-arm/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-arm26/emergency-restart.h b/include/asm-arm26/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-arm26/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-cris/emergency-restart.h b/include/asm-cris/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-cris/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-frv/emergency-restart.h b/include/asm-frv/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-frv/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-generic/emergency-restart.h b/include/asm-generic/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-generic/emergency-restart.h
@@ -0,0 +1,9 @@
+#ifndef _ASM_GENERIC_EMERGENCY_RESTART_H
+#define _ASM_GENERIC_EMERGENCY_RESTART_H
+
+static inline void machine_emergency_restart(void)
+{
+	machine_restart(NULL);
+}
+
+#endif /* _ASM_GENERIC_EMERGENCY_RESTART_H */
diff --git a/include/asm-h8300/emergency-restart.h b/include/asm-h8300/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-h8300/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-i386/emergency-restart.h b/include/asm-i386/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-i386/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-ia64/emergency-restart.h b/include/asm-ia64/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-ia64/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-m32r/emergency-restart.h b/include/asm-m32r/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-m32r/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-m68k/emergency-restart.h b/include/asm-m68k/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-m68k/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-m68knommu/emergency-restart.h b/include/asm-m68knommu/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-m68knommu/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-mips/emergency-restart.h b/include/asm-mips/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-mips/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-parisc/emergency-restart.h b/include/asm-parisc/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-parisc/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-ppc/emergency-restart.h b/include/asm-ppc/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-ppc/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-ppc64/emergency-restart.h b/include/asm-ppc64/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-ppc64/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-s390/emergency-restart.h b/include/asm-s390/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-s390/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-sh/emergency-restart.h b/include/asm-sh/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-sh/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-sh64/emergency-restart.h b/include/asm-sh64/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-sh64/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-sparc/emergency-restart.h b/include/asm-sparc/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-sparc/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-sparc64/emergency-restart.h b/include/asm-sparc64/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-sparc64/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-um/emergency-restart.h b/include/asm-um/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-um/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-v850/emergency-restart.h b/include/asm-v850/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-v850/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-x86_64/emergency-restart.h b/include/asm-x86_64/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-x86_64/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/asm-xtensa/emergency-restart.h b/include/asm-xtensa/emergency-restart.h
new file mode 100644
--- /dev/null
+++ b/include/asm-xtensa/emergency-restart.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_EMERGENCY_RESTART_H
+#define _ASM_EMERGENCY_RESTART_H
+
+#include <asm-generic/emergency-restart.h>
+
+#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -64,6 +64,13 @@ extern void kernel_halt(void);
 extern void kernel_power_off(void);
 extern void kernel_kexec(void);
 
+/*
+ * Emergency restart, callable from an interrupt handler.
+ */
+
+extern void emergency_restart(void);
+#include <asm/emergency-restart.h>
+
 #endif
 
 #endif /* _LINUX_REBOOT_H */
diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -361,6 +361,12 @@ out_unlock:
 	return retval;
 }
 
+void emergency_restart(void)
+{
+	machine_emergency_restart();
+}
+EXPORT_SYMBOL_GPL(emergency_restart);
+
 void kernel_restart(char *cmd)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
