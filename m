Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSF3Wkg>; Sun, 30 Jun 2002 18:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSF3Wkf>; Sun, 30 Jun 2002 18:40:35 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:48146 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314284AbSF3Wkd>; Sun, 30 Jun 2002 18:40:33 -0400
Date: Mon, 1 Jul 2002 00:42:58 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Dave Jones <davej@suse.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove 16 unnecessary includes of sched.h
Message-ID: <Pine.LNX.4.33.0207010035030.11868-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - remove 16 unneccessary #includes of <linux/sched.h>.
 - reinsert some #includes of header files included by <linux/sched.h>
   to fix indirect dependencies.

Just a small start, many more to come. This time I did a more thorough 
analysis of dependencies by extensive use of ctags and grep. Still the 
first compile revealed more obscure dependencies.

The patch depends on the previously posted one to break task_struct out of 
sched.h to actually compile.

Tim


--- linux-2.5.24/fs/bfs/dir.c	Fri Jun 21 00:53:56 2002
+++ linux-2.5.24-schedrem/fs/bfs/dir.c	Sun Jun 30 19:22:13 2002
@@ -9,7 +9,6 @@
 #include <linux/fs.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-#include <linux/sched.h>
 #include "bfs.h"
 
 #undef DEBUG

--- linux-2.5.24/fs/ext2/ialloc.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-schedrem/fs/ext2/ialloc.c	Sun Jun 30 19:22:46 2002
@@ -15,7 +15,6 @@
 #include <linux/config.h>
 #include "ext2.h"
 #include <linux/quotaops.h>
-#include <linux/sched.h>
 #include <linux/buffer_head.h>
 
 

--- linux-2.5.24/fs/fs-writeback.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-schedrem/fs/fs-writeback.c	Sun Jun 30 19:16:06 2002
@@ -15,7 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/writeback.h>

--- linux-2.5.24/fs/jffs2/fs.c	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-schedrem/fs/jffs2/fs.c	Sun Jun 30 19:26:05 2002
@@ -37,7 +37,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/sem.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>

--- linux-2.5.24/fs/lockd/host.c	Fri Jun 21 00:53:53 2002
+++ linux-2.5.24-schedrem/fs/lockd/host.c	Sun Jun 30 19:33:01 2002
@@ -9,13 +9,15 @@
  */
 
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
+#include <linux/capability.h>
 #include <linux/slab.h>
 #include <linux/in.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
 #include <linux/lockd/sm_inter.h>
+#include <asm/current.h>
 
 
 #define NLMDBG_FACILITY		NLMDBG_HOSTCACHE

--- linux-2.5.24/fs/lockd/xdr.c	Fri Jun 21 00:53:44 2002
+++ linux-2.5.24-schedrem/fs/lockd/xdr.c	Sun Jun 30 19:33:39 2002
@@ -8,7 +8,6 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
-#include <linux/sched.h>
 #include <linux/utsname.h>
 #include <linux/nfs.h>
 
@@ -18,6 +17,8 @@
 #include <linux/sunrpc/stats.h>
 #include <linux/lockd/lockd.h>
 #include <linux/lockd/sm_inter.h>
+
+#include <asm/current.h>
 
 #define NLMDBG_FACILITY		NLMDBG_XDR
 

--- linux-2.5.24/fs/lockd/xdr4.c	Fri Jun 21 00:53:42 2002
+++ linux-2.5.24-schedrem/fs/lockd/xdr4.c	Sun Jun 30 19:33:43 2002
@@ -8,7 +8,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/sched.h>
 #include <linux/utsname.h>
 #include <linux/nfs.h>
 
@@ -18,6 +17,8 @@
 #include <linux/sunrpc/stats.h>
 #include <linux/lockd/lockd.h>
 #include <linux/lockd/sm_inter.h>
+
+#include <asm/current.h>
 
 #define NLMDBG_FACILITY		NLMDBG_XDR
 

--- linux-2.5.24/fs/nfsd/auth.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-schedrem/fs/nfsd/auth.c	Sun Jun 30 19:38:07 2002
@@ -5,10 +5,12 @@
  */
 
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/capability.h>
+#include <asm/param.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfsd/nfsd.h>
+#include <asm/current.h>
 
 #define	CAP_NFSD_MASK (CAP_FS_MASK|CAP_TO_MASK(CAP_SYS_RESOURCE))
 void

--- linux-2.5.24/fs/nfsd/nfsfh.c	Fri Jun 21 00:53:50 2002
+++ linux-2.5.24-schedrem/fs/nfsd/nfsfh.c	Sun Jun 30 19:37:24 2002
@@ -9,7 +9,6 @@
  * ... and again Southern-Winter 2001 to support export_operations
  */
 
-#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>

--- linux-2.5.24/fs/ntfs/time.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-schedrem/fs/ntfs/time.c	Sun Jun 30 19:25:33 2002
@@ -19,7 +19,9 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/sched.h>	/* For CURRENT_TIME. */
+#include <linux/time.h>
+#include <linux/types.h>
+#include <asm/current.h>
 #include <asm/div64.h>		/* For do_div(). */
 
 #include "ntfs.h"

--- linux-2.5.24/fs/sysv/ialloc.c	Fri Jun 21 00:53:46 2002
+++ linux-2.5.24-schedrem/fs/sysv/ialloc.c	Sun Jun 30 19:34:30 2002
@@ -21,10 +21,10 @@
 
 #include <linux/kernel.h>
 #include <linux/stddef.h>
-#include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/buffer_head.h>
+#include <asm/current.h>
 #include "sysv.h"
 
 /* We don't trust the value of

--- linux-2.5.24/fs/udf/ialloc.c	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-schedrem/fs/udf/ialloc.c	Sun Jun 30 19:22:35 2002
@@ -27,7 +27,6 @@
 #include <linux/fs.h>
 #include <linux/quotaops.h>
 #include <linux/udf_fs.h>
-#include <linux/sched.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"

--- linux-2.5.24/fs/ufs/ialloc.c	Fri Jun 21 00:53:49 2002
+++ linux-2.5.24-schedrem/fs/ufs/ialloc.c	Sun Jun 30 19:26:54 2002
@@ -27,7 +27,6 @@
 #include <linux/string.h>
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
-#include <linux/sched.h>
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 

--- linux-2.5.24/kernel/panic.c	Fri Jun 21 00:53:51 2002
+++ linux-2.5.24-schedrem/kernel/panic.c	Sun Jun 30 19:15:36 2002
@@ -9,13 +9,13 @@
  * to indicate a major problem.
  */
 #include <linux/config.h>
-#include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <asm/current.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 

--- linux-2.5.24/kernel/resource.c	Fri Jun 21 00:53:55 2002
+++ linux-2.5.24-schedrem/kernel/resource.c	Sun Jun 30 19:14:56 2002
@@ -7,7 +7,7 @@
  * Arbitrary resource management.
  */
 
-#include <linux/sched.h>
+#include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/init.h>

--- linux-2.5.24/lib/brlock.c	Fri Jun 21 00:53:45 2002
+++ linux-2.5.24-schedrem/lib/brlock.c	Sun Jun 30 19:38:45 2002
@@ -12,7 +12,6 @@
 
 #ifdef CONFIG_SMP
 
-#include <linux/sched.h>
 #include <linux/brlock.h>
 
 #ifdef __BRLOCK_USE_ATOMICS


