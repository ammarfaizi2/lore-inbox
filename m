Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWD0Uft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWD0Uft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWD0Uft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:35:49 -0400
Received: from xenotime.net ([66.160.160.81]:52182 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751635AbWD0Ufj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:35:39 -0400
Date: Thu, 27 Apr 2006 13:38:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] add Doc/SubmitChecklist
Message-Id: <20060427133801.526bba5b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Provide a checklist of techniques to aid kernel patch
submitters in producing healthy patches and in lessening
a burden on maintainers.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/SubmitChecklist |   56 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+)

--- /dev/null
+++ linux-2617-rc3/Documentation/SubmitChecklist
@@ -0,0 +1,56 @@
+Linux Kernel patch sumbittal checklist
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Here are some basic things that developers should do if they
+want to see their kernel patch submittals accepted quicker.
+
+These are all above and beyond the documentation that is provided
+in Documentation/SubmittingPatches and elsewhere about submitting
+Linux kernel patches.
+
+
+
+- Builds cleanly with applicable or modified CONFIG options =y, =m, and =n.
+  No gcc warnings/errors, no linker warnings/errors.
+
+- Passes allnoconfig, allmodconfig
+
+- Builds on multiple CPU arch-es by using local cross-compile tools
+  or something like PLM at OSDL.
+
+- ppc64 is a good architecture for cross-compilation checking because it
+  tends to use `unsigned long' for 64-bit quantities.
+
+- Matches kernel coding style(!)
+
+- Any new or modified CONFIG options don't muck up the config menu.
+
+- All new Kconfig options have help text.
+
+- Has been carefully reviewed with respect to relevant Kconfig
+  combinations.  This is very hard to get right with testing --
+  brainpower pays off here.
+
+- Check cleanly with sparse.
+
+- Use 'make checkstack' and 'make namespacecheck' and fix any
+  problems that they find.  Note:  checkstack does not point out
+  problems explicitly, but any one function that uses more than
+  512 bytes on the stack is a candidate for change.
+
+- Include kernel-doc to document global kernel APIs.  (Not required
+  for static functions, but OK there also.)  Use 'make htmldocs'
+  or 'make mandocs' to check the kernel-doc and fix any issues.
+
+- Has been tested with CONFIG_PREEMPT, CONFIG_DEBUG_SLAB,
+  CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_MUTEXES, CONFIG_DEBUG_SPINLOCK,
+  CONFIG_DEBUG_SPINLOCK_SLEEP all simultaneously enabled.
+
+- Has been build- and runtime tested with and without CONFIG_SMP and
+  CONFIG_PREEMPT.
+
+- If the patch affects IO/Disk, etc: has been tested with and without
+  CONFIG_LBD.
+
+
+2006-APR-27


---
