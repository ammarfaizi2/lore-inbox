Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWHUOrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWHUOrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbWHUOrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:47:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44723 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030513AbWHUOrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:47:03 -0400
Date: Mon, 21 Aug 2006 09:46:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2: m68k nsproxy compile breakage
Message-ID: <20060821144649.GA5573@sergelap.austin.ibm.com>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821020843.GG11651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821020843.GG11651@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adrian Bunk (bunk@stusta.de):
> namespaces-utsname-implement-utsname-namespaces.patch causes the 
> following compile error on m68k:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> arch/m68k/kernel/built-in.o: In function `sys_call_table':
> (.data+0x91c): undefined reference to `init_nsproxy'
> 
> <--  snip  -->
> 
> Is there a reason why struct init_nsproxy can't reside in 
> kernel/nsproxy.c?

Apparently not.  The following patch compiles and boots fine on s390.

(Ok, booted before I tweaked it, now I'm having some hardware error
both with and without the patch...)

thanks,
-serge

From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH] nsproxy: move init_nsproxy into kernel/nsproxy.c

Move the init_nsproxy definition out of arch/ into kernel/nsproxy.c.
This avoids all arches having to be updated.  Compiles and boots on
s390.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 arch/alpha/kernel/init_task.c     |    2 --
 arch/arm/kernel/init_task.c       |    2 --
 arch/arm26/kernel/init_task.c     |    2 --
 arch/frv/kernel/init_task.c       |    2 --
 arch/h8300/kernel/init_task.c     |    2 --
 arch/i386/kernel/init_task.c      |    2 --
 arch/ia64/kernel/init_task.c      |    2 --
 arch/m32r/kernel/init_task.c      |    2 --
 arch/m68knommu/kernel/init_task.c |    2 --
 arch/mips/kernel/init_task.c      |    2 --
 arch/parisc/kernel/init_task.c    |    2 --
 arch/powerpc/kernel/init_task.c   |    2 --
 arch/s390/kernel/init_task.c      |    2 --
 arch/sh/kernel/init_task.c        |    2 --
 arch/sh64/kernel/init_task.c      |    2 --
 arch/sparc/kernel/init_task.c     |    2 --
 arch/sparc64/kernel/init_task.c   |    2 --
 arch/um/kernel/init_task.c        |    2 --
 arch/v850/kernel/init_task.c      |    2 --
 arch/x86_64/kernel/init_task.c    |    2 --
 kernel/nsproxy.c                  |    3 +++
 21 files changed, 3 insertions(+), 40 deletions(-)

452bc4e24639258f44ca75ab619b35d7e43fa42d
diff --git a/arch/alpha/kernel/init_task.c b/arch/alpha/kernel/init_task.c
index 83d0902..835d09a 100644
--- a/arch/alpha/kernel/init_task.c
+++ b/arch/alpha/kernel/init_task.c
@@ -5,7 +5,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 #include <asm/uaccess.h>
 
 
@@ -14,7 +13,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 struct task_struct init_task = INIT_TASK(init_task);
 
 EXPORT_SYMBOL(init_mm);
diff --git a/arch/arm/kernel/init_task.c b/arch/arm/kernel/init_task.c
index 80f5eeb..a00cca0 100644
--- a/arch/arm/kernel/init_task.c
+++ b/arch/arm/kernel/init_task.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -18,7 +17,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/arm26/kernel/init_task.c b/arch/arm26/kernel/init_task.c
index 678c7b5..4191565 100644
--- a/arch/arm26/kernel/init_task.c
+++ b/arch/arm26/kernel/init_task.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -21,7 +20,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/frv/kernel/init_task.c b/arch/frv/kernel/init_task.c
index 5ec2742..2299393 100644
--- a/arch/frv/kernel/init_task.c
+++ b/arch/frv/kernel/init_task.c
@@ -5,7 +5,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -16,7 +15,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/h8300/kernel/init_task.c b/arch/h8300/kernel/init_task.c
index ef5755a..19272c2 100644
--- a/arch/h8300/kernel/init_task.c
+++ b/arch/h8300/kernel/init_task.c
@@ -8,7 +8,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -18,7 +17,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/i386/kernel/init_task.c b/arch/i386/kernel/init_task.c
index bd97f69..cff95d1 100644
--- a/arch/i386/kernel/init_task.c
+++ b/arch/i386/kernel/init_task.c
@@ -5,7 +5,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -16,7 +15,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/ia64/kernel/init_task.c b/arch/ia64/kernel/init_task.c
index 2d62471..b69c397 100644
--- a/arch/ia64/kernel/init_task.c
+++ b/arch/ia64/kernel/init_task.c
@@ -12,7 +12,6 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -22,7 +21,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/m32r/kernel/init_task.c b/arch/m32r/kernel/init_task.c
index 0057475..9e508fd 100644
--- a/arch/m32r/kernel/init_task.c
+++ b/arch/m32r/kernel/init_task.c
@@ -7,7 +7,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -17,7 +16,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/m68knommu/kernel/init_task.c b/arch/m68knommu/kernel/init_task.c
index b99fc6d..3897043 100644
--- a/arch/m68knommu/kernel/init_task.c
+++ b/arch/m68knommu/kernel/init_task.c
@@ -8,7 +8,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -18,7 +17,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/mips/kernel/init_task.c b/arch/mips/kernel/init_task.c
index dfe47e6..aeda7f5 100644
--- a/arch/mips/kernel/init_task.c
+++ b/arch/mips/kernel/init_task.c
@@ -4,7 +4,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/thread_info.h>
 #include <asm/uaccess.h>
@@ -15,7 +14,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/parisc/kernel/init_task.c b/arch/parisc/kernel/init_task.c
index c0c43e2..8384bf9 100644
--- a/arch/parisc/kernel/init_task.c
+++ b/arch/parisc/kernel/init_task.c
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -39,7 +38,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/powerpc/kernel/init_task.c b/arch/powerpc/kernel/init_task.c
index e24ace6..941043a 100644
--- a/arch/powerpc/kernel/init_task.c
+++ b/arch/powerpc/kernel/init_task.c
@@ -5,7 +5,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 #include <asm/uaccess.h>
 
 static struct fs_struct init_fs = INIT_FS;
@@ -13,7 +12,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/s390/kernel/init_task.c b/arch/s390/kernel/init_task.c
index 0918921..d73a740 100644
--- a/arch/s390/kernel/init_task.c
+++ b/arch/s390/kernel/init_task.c
@@ -11,7 +11,6 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -21,7 +20,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/sh/kernel/init_task.c b/arch/sh/kernel/init_task.c
index 81caf0f..44053ea 100644
--- a/arch/sh/kernel/init_task.c
+++ b/arch/sh/kernel/init_task.c
@@ -3,7 +3,6 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -13,7 +12,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/sh64/kernel/init_task.c b/arch/sh64/kernel/init_task.c
index 0c95f40..de2d07d 100644
--- a/arch/sh64/kernel/init_task.c
+++ b/arch/sh64/kernel/init_task.c
@@ -14,7 +14,6 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -24,7 +23,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 struct pt_regs fake_swapper_regs;
 
diff --git a/arch/sparc/kernel/init_task.c b/arch/sparc/kernel/init_task.c
index a73926d..fc31de6 100644
--- a/arch/sparc/kernel/init_task.c
+++ b/arch/sparc/kernel/init_task.c
@@ -3,7 +3,6 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -13,7 +12,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 struct task_struct init_task = INIT_TASK(init_task);
 
 EXPORT_SYMBOL(init_mm);
diff --git a/arch/sparc64/kernel/init_task.c b/arch/sparc64/kernel/init_task.c
index f1e9a4b..329b38f 100644
--- a/arch/sparc64/kernel/init_task.c
+++ b/arch/sparc64/kernel/init_task.c
@@ -3,7 +3,6 @@
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -14,7 +13,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/um/kernel/init_task.c b/arch/um/kernel/init_task.c
index be49948..8cde431 100644
--- a/arch/um/kernel/init_task.c
+++ b/arch/um/kernel/init_task.c
@@ -8,7 +8,6 @@
 #include "linux/sched.h"
 #include "linux/init_task.h"
 #include "linux/mqueue.h"
-#include "linux/nsproxy.h"
 #include "asm/uaccess.h"
 #include "asm/pgtable.h"
 #include "user_util.h"
@@ -17,7 +16,6 @@
 
 static struct fs_struct init_fs = INIT_FS;
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 static struct files_struct init_files = INIT_FILES;
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
diff --git a/arch/v850/kernel/init_task.c b/arch/v850/kernel/init_task.c
index 9d2de75..ed2f93c 100644
--- a/arch/v850/kernel/init_task.c
+++ b/arch/v850/kernel/init_task.c
@@ -16,7 +16,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -26,7 +25,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS (init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM (init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/arch/x86_64/kernel/init_task.c b/arch/x86_64/kernel/init_task.c
index 1c87ea0..ce31d90 100644
--- a/arch/x86_64/kernel/init_task.c
+++ b/arch/x86_64/kernel/init_task.c
@@ -5,7 +5,6 @@
 #include <linux/init_task.h>
 #include <linux/fs.h>
 #include <linux/mqueue.h>
-#include <linux/nsproxy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -16,7 +15,6 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
-struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 3ae08e2..f6b3f71 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -18,6 +18,9 @@
 #include <linux/nsproxy.h>
 #include <linux/namespace.h>
 #include <linux/utsname.h>
+#include <linux/init_task.h>
+
+struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 static inline void get_nsproxy(struct nsproxy *ns)
 {
-- 
1.1.6
