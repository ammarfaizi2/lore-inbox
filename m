Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965498AbWJ3Kpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965498AbWJ3Kpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965501AbWJ3Kpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:45:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60826 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965467AbWJ3Kpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:45:44 -0500
To: linux-arch@vger.kernel.org
Subject: [PATCH 2/7] severing fs.h, radix-tree.h -> sched.h
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1GeUeF-0002o7-6s@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:45:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/i386/kernel/acpi/cstate.c |    1 +
 drivers/acpi/dock.c            |    1 +
 drivers/char/hw_random/core.c  |    1 +
 drivers/char/tpm/tpm.h         |    1 +
 drivers/hwmon/hdaps.c          |    1 +
 drivers/spi/spi_butterfly.c    |    1 +
 fs/9p/conv.c                   |    1 +
 fs/9p/fcall.c                  |    1 +
 fs/9p/fid.c                    |    1 +
 fs/9p/v9fs.c                   |    1 +
 fs/9p/vfs_dir.c                |    1 +
 fs/9p/vfs_file.c               |    1 +
 fs/inotify.c                   |    1 +
 fs/jffs2/acl.c                 |    1 +
 fs/jffs2/wbuf.c                |    1 +
 fs/jfs/ioctl.c                 |    1 +
 fs/proc/root.c                 |    1 +
 fs/super.c                     |   18 ++++++++++++++++++
 fs/sync.c                      |    1 +
 fs/utimes.c                    |    1 +
 include/linux/fs.h             |   37 +++++++------------------------------
 include/linux/radix-tree.h     |    1 -
 22 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/arch/i386/kernel/acpi/cstate.c b/arch/i386/kernel/acpi/cstate.c
index 20563e5..4664b55 100644
--- a/arch/i386/kernel/acpi/cstate.c
+++ b/arch/i386/kernel/acpi/cstate.c
@@ -11,6 +11,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/sched.h>
 
 #include <acpi/processor.h>
 #include <asm/acpi.h>
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 578b99b..bf5b79e 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -27,6 +27,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/notifier.h>
+#include <linux/jiffies.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 154a81d..b8c9417 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -36,6 +36,7 @@ #include <linux/hw_random.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/delay.h>
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 050ced2..bb9a43c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -22,6 +22,7 @@ #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/miscdevice.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
diff --git a/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
index 26be4ea..e8ef62b 100644
--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -33,6 +33,7 @@ #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timer.h>
 #include <linux/dmi.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 
 #define HDAPS_LOW_PORT		0x1600	/* first port used by hdaps */
diff --git a/drivers/spi/spi_butterfly.c b/drivers/spi/spi_butterfly.c
index 39d9b20..c2f601f 100644
--- a/drivers/spi/spi_butterfly.c
+++ b/drivers/spi/spi_butterfly.c
@@ -23,6 +23,7 @@ #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/parport.h>
 
+#include <linux/sched.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/spi/flash.h>
diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index 56d88c1..a3ed571 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/idr.h>
 #include <asm/uaccess.h>
 #include "debug.h"
diff --git a/fs/9p/fcall.c b/fs/9p/fcall.c
index 8556097..dc336a6 100644
--- a/fs/9p/fcall.c
+++ b/fs/9p/fcall.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/idr.h>
 
 #include "debug.h"
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 70492cc..2750720 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/idr.h>
 
 #include "debug.h"
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 0f62804..0b96fae 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/parser.h>
 #include <linux/idr.h>
 
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e32d597..905c882 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -30,6 +30,7 @@ #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/sched.h>
 #include <linux/inet.h>
 #include <linux/idr.h>
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index c3c47ed..79e6f9c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
diff --git a/fs/inotify.c b/fs/inotify.c
index 723836a..f5099d8 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -27,6 +27,7 @@ #include <linux/spinlock.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/writeback.h>
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 0ae3cd1..73f0d60 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/crc32.h>
 #include <linux/jffs2.h>
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index b9b7007..7070730 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -19,6 +19,7 @@ #include <linux/mtd/mtd.h>
 #include <linux/crc32.h>
 #include <linux/mtd/nand.h>
 #include <linux/jiffies.h>
+#include <linux/sched.h>
 
 #include "nodelist.h"
 
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index 37db524..ed814b1 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -9,6 +9,7 @@ #include <linux/fs.h>
 #include <linux/ctype.h>
 #include <linux/capability.h>
 #include <linux/time.h>
+#include <linux/sched.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index ffe66c3..64d242b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -13,6 +13,7 @@ #include <linux/time.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
diff --git a/fs/super.c b/fs/super.c
index 47e554c..84c320f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -221,6 +221,24 @@ static int grab_super(struct super_block
 }
 
 /*
+ * Superblock locking.  We really ought to get rid of these two.
+ */
+void lock_super(struct super_block * sb)
+{
+	get_fs_excl();
+	mutex_lock(&sb->s_lock);
+}
+
+void unlock_super(struct super_block * sb)
+{
+	put_fs_excl();
+	mutex_unlock(&sb->s_lock);
+}
+
+EXPORT_SYMBOL(lock_super);
+EXPORT_SYMBOL(unlock_super);
+
+/*
  * Write out and wait upon all dirty data associated with this
  * superblock.  Filesystem data as well as the underlying block
  * device.  Takes the superblock lock.  Requires a second blkdev
diff --git a/fs/sync.c b/fs/sync.c
index 1de747b..865f32b 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -6,6 +6,7 @@ #include <linux/kernel.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/writeback.h>
 #include <linux/syscalls.h>
 #include <linux/linkage.h>
diff --git a/fs/utimes.c b/fs/utimes.c
index 1bcd852..99cf2cb 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -2,6 +2,7 @@ #include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/linkage.h>
 #include <linux/namei.h>
+#include <linux/sched.h>
 #include <linux/utime.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fe6e3f..cac7b1e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -276,7 +276,7 @@ #include <linux/list.h>
 #include <linux/radix-tree.h>
 #include <linux/prio_tree.h>
 #include <linux/init.h>
-#include <linux/sched.h>
+#include <linux/pid.h>
 #include <linux/mutex.h>
 
 #include <asm/atomic.h>
@@ -977,36 +977,13 @@ enum {
 #define vfs_check_frozen(sb, level) \
 	wait_event((sb)->s_wait_unfrozen, ((sb)->s_frozen < (level)))
 
-static inline void get_fs_excl(void)
-{
-	atomic_inc(&current->fs_excl);
-}
-
-static inline void put_fs_excl(void)
-{
-	atomic_dec(&current->fs_excl);
-}
-
-static inline int has_fs_excl(void)
-{
-	return atomic_read(&current->fs_excl);
-}
+#define get_fs_excl() atomic_inc(&current->fs_excl)
+#define put_fs_excl() atomic_dec(&current->fs_excl)
+#define has_fs_excl() atomic_read(&current->fs_excl)
 
-
-/*
- * Superblock locking.
- */
-static inline void lock_super(struct super_block * sb)
-{
-	get_fs_excl();
-	mutex_lock(&sb->s_lock);
-}
-
-static inline void unlock_super(struct super_block * sb)
-{
-	put_fs_excl();
-	mutex_unlock(&sb->s_lock);
-}
+/* not quite ready to be deprecated, but... */
+extern void lock_super(struct super_block *);
+extern void unlock_super(struct super_block *);
 
 /*
  * VFS helper functions..
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 9158a68..cbfa115 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -19,7 +19,6 @@
 #ifndef _LINUX_RADIX_TREE_H
 #define _LINUX_RADIX_TREE_H
 
-#include <linux/sched.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
 
-- 
1.4.2.GIT


