Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUCOVBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbUCOVBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:01:32 -0500
Received: from gprs40-162.eurotel.cz ([160.218.40.162]:32171 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262754AbUCOU6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:58:14 -0500
Date: Mon, 15 Mar 2004 21:57:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remove pmdisk from kernel
Message-ID: <20040315205752.GG258@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz> <20040315125357.3330c8c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315125357.3330c8c4.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > This removes pmdisk from kernel.
> 
> It would be unfortunate if Pat had more development planned or even
> underway.  Have we checked?

Last time I attempted pmdisk removal, he did not react. Lets try one
more time.

> > PS: Alternatively, I'm wiling to kill swsusp, rename pmdisk to "swap
> > suspend", and submit patches to fix it. Its going to be slightly more
> > complicated, through... 
> 
> People have suggested that I incorporate swsusp2.  Where does this fit into
> things?

I believe that you don't want swsusp2 in 2.6. It has hooks all over
the place:

								Pavel

 Documentation/kernel-parameters.txt      |    9 
 Documentation/power/swsusp2.txt          |  495 +++++++++++++++++++++++++++++++
 arch/arm/kernel/ecard.c                  |    6 
 arch/i386/kernel/apm.c                   |    8 
 arch/i386/kernel/process.c               |   25 +
 arch/i386/kernel/signal.c                |    5 
 arch/i386/kernel/smp.c                   |    2 
 arch/i386/mm/pageattr.c                  |    2 
 arch/i386/power/Makefile                 |    1 
 arch/i386/power/cpu.c                    |    8 
 arch/i386/power/swsusp2-asm.S            |  259 ++++++++++++++++
 arch/i386/power/swsusp2.c                |  130 ++++++++
 arch/ppc/Kconfig                         |    2 
 arch/ppc/Makefile                        |    1 
 arch/ppc/kernel/signal.c                 |    6 
 arch/ppc/kernel/vmlinux.lds.S            |    6 
 arch/ppc/power/Makefile                  |    2 
 arch/ppc/power/cpu.c                     |   72 ++++
 arch/ppc/power/cpu_reg.S                 |  325 ++++++++++++++++++++
 arch/ppc/power/swsusp2-asm.S             |   51 +++
 arch/ppc/power/swsusp2-copyback.S        |   73 ++++
 arch/ppc/power/swsusp2.c                 |  170 ++++++++++
 drivers/acpi/sleep/proc.c                |    7 
 drivers/block/loop.c                     |    3 
 drivers/char/hvc_console.c               |    6 
 drivers/char/keyboard.c                  |   84 +++++
 drivers/char/n_tty.c                     |    4 
 drivers/char/tty_io.c                    |   14 
 drivers/char/vt.c                        |   20 -
 drivers/ide/ide-disk.c                   |    3 
 drivers/ieee1394/nodemgr.c               |   12 
 drivers/input/serio/serio.c              |   11 
 drivers/md/md.c                          |    3 
 drivers/media/video/msp3400.c            |   14 
 drivers/media/video/tvaudio.c            |    8 
 drivers/message/i2o/i2o_block.c          |   11 
 drivers/message/i2o/i2o_core.c           |   23 +
 drivers/mtd/mtdblock.c                   |    4 
 drivers/net/8139too.c                    |    2 
 drivers/net/irda/sir_kthread.c           |   10 
 drivers/net/wireless/airo.c              |    2 
 drivers/parport/ieee1284.c               |    4 
 drivers/pcmcia/cs.c                      |   11 
 drivers/scsi/scsi_error.c                |   16 -
 drivers/serial/8250.c                    |  100 ++++++
 drivers/usb/core/hub.c                   |   10 
 drivers/usb/storage/usb.c                |   14 
 fs/buffer.c                              |   89 ++++-
 fs/dcache.c                              |    5 
 fs/devfs/base.c                          |   14 
 fs/exec.c                                |   18 +
 fs/fcntl.c                               |   19 +
 fs/jbd/journal.c                         |   20 -
 fs/jffs/intrep.c                         |   15 
 fs/jffs2/background.c                    |   18 -
 fs/jfs/jfs_logmgr.c                      |   24 -
 fs/jfs/jfs_txnmgr.c                      |   61 ++-
 fs/lockd/clntlock.c                      |    8 
 fs/lockd/clntproc.c                      |    6 
 fs/lockd/svc.c                           |   12 
 fs/locks.c                               |    8 
 fs/namei.c                               |   54 +++
 fs/namespace.c                           |   16 -
 fs/nfsd/nfssvc.c                         |    8 
 fs/open.c                                |   84 +++++
 fs/pipe.c                                |    4 
 fs/proc/generic.c                        |    8 
 fs/proc/kmsg.c                           |    9 
 fs/read_write.c                          |   66 +++-
 fs/stat.c                                |   41 ++
 fs/super.c                               |    5 
 fs/sysfs/file.c                          |    4 
 fs/xfs/linux/xfs_buf.c                   |   11 
 fs/xfs/linux/xfs_super.c                 |   11 
 include/asm-i386/cpufeature.h            |    1 
 include/asm-i386/mtrr.h                  |    4 
 include/asm-i386/tlbflush.h              |    5 
 include/asm-ppc/suspend.h                |   14 
 include/linux/pagemap.h                  |    5 
 include/linux/sched.h                    |    8 
 include/linux/selection.h                |    4 
 include/linux/suspend-version-specific.h |   74 ++++
 include/linux/suspend.h                  |   75 ----
 include/linux/suspend1.h                 |   76 ++++
 kernel/exit.c                            |    7 
 kernel/fork.c                            |    7 
 kernel/module.c                          |   27 +
 kernel/panic.c                           |    5 
 kernel/power/Kconfig                     |  102 ++++++
 kernel/power/Makefile                    |   12 
 kernel/power/console.c                   |   51 ---
 kernel/power/disk.c                      |    3 
 kernel/power/main.c                      |    3 
 kernel/power/pmdisk.c                    |    2 
 kernel/power/process.c                   |  128 --------
 kernel/power/swsusp.c                    |    2 
 kernel/sched.c                           |   10 
 kernel/softirq.c                         |    3 
 kernel/sys.c                             |    6 
 kernel/workqueue.c                       |    3 
 mm/page_alloc.c                          |   30 +
 mm/pdflush.c                             |    8 
 mm/swapfile.c                            |    5 
 mm/vmscan.c                              |  443 ++++++++++++++++-----------
 net/bluetooth/bnep/core.c                |   11 
 net/bluetooth/rfcomm/core.c              |   11 
 net/socket.c                             |   21 +
 net/sunrpc/sched.c                       |   12 
 net/sunrpc/svcsock.c                     |    8 
 109 files changed, 3254 insertions(+), 624 deletions(-)

This is one small example what swsusp2 needs:

diff -ruN linux-2.6.2/fs/buffer.c software-suspend-linux-2.6.2/fs/buffer.c
--- linux-2.6.2/fs/buffer.c	2004-02-06 17:27:46.000000000 +1300
+++ software-suspend-linux-2.6.2/fs/buffer.c	2004-02-06 17:41:09.000000000 +1300
@@ -37,6 +37,7 @@
 #include <linux/bio.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/init.h>
 #include <asm/bitops.h>
 
 static void invalidate_bh_lrus(void);
@@ -229,16 +230,24 @@
  */
 int fsync_super(struct super_block *sb)
 {
-	sync_inodes_sb(sb, 0);
-	DQUOT_SYNC(sb);
-	lock_super(sb);
-	if (sb->s_dirt && sb->s_op->write_super)
-		sb->s_op->write_super(sb);
-	unlock_super(sb);
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
-	sync_inodes_sb(sb, 1);
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	if (likely(!(swsusp_state & FREEZE_UNREFRIGERATED)))
+#endif
+	{
+		sync_inodes_sb(sb, 0);
+		DQUOT_SYNC(sb);
+		lock_super(sb);
+		if (sb->s_dirt && sb->s_op->write_super)
+			sb->s_op->write_super(sb);
+		unlock_super(sb);
+		if (sb->s_op->sync_fs)
+			sb->s_op->sync_fs(sb, 1);
+		sync_blockdev(sb->s_bdev);
+		sync_inodes_sb(sb, 1);
+	}
 
 	return sync_blockdev(sb->s_bdev);
 }
@@ -251,12 +260,20 @@
 int fsync_bdev(struct block_device *bdev)
 {
 	struct super_block *sb = get_super(bdev);
+	int result = 0;
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+	
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 	if (sb) {
 		int res = fsync_super(sb);
 		drop_super(sb);
 		return res;
 	}
-	return sync_blockdev(bdev);
+	result = sync_blockdev(bdev);
+	current->flags &= ~PF_SYNCTHREAD;
+ 	SWSUSP_ACTIVITY_END;
+	return result;
 }
 
 /*
@@ -265,20 +282,34 @@
  */
 static void do_sync(unsigned long wait)
 {
-	wakeup_bdflush(0);
-	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
-	DQUOT_SYNC(NULL);
-	sync_supers();		/* Write the superblocks */
-	sync_filesystems(0);	/* Start syncing the filesystems */
-	sync_filesystems(wait);	/* Waitingly sync the filesystems */
-	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
-	if (!wait)
-		printk("Emergency Sync complete\n");
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	/* A safety net. During suspend, we might overwrite
+	 * memory containing filesystem info. We don't then
+	 * want to sync it to disk. */
+	if (likely(!(swsusp_state & FREEZE_UNREFRIGERATED)))
+#endif
+	{
+		wakeup_bdflush(0);
+		sync_inodes(0);		/* All mappings, inodes and their blockdevs */
+		DQUOT_SYNC(NULL);
+		sync_supers();		/* Write the superblocks */
+		sync_filesystems(0);	/* Start syncing the filesystems */
+		sync_filesystems(wait);	/* Waitingly sync the filesystems */
+		sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
+		if (!wait)
+			printk("Emergency Sync complete\n");
+	}
 }
 
 asmlinkage long sys_sync(void)
 {
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 	do_sync(1);
+	current->flags &= ~PF_SYNCTHREAD;
+ 	SWSUSP_ACTIVITY_END;
 	return 0;
 }
 
@@ -319,6 +350,10 @@
 	struct file * file;
 	struct address_space *mapping;
 	int ret, err;
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 
 	ret = -EBADF;
 	file = fget(fd);
@@ -349,6 +384,8 @@
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -357,6 +394,10 @@
 	struct file * file;
 	struct address_space *mapping;
 	int ret, err;
+ 	DECLARE_SWSUSP_LOCAL_VAR;
+
+	SWSUSP_ACTIVITY_START(PF_SYNCTHREAD);
+	current->flags |= PF_SYNCTHREAD;
 
 	ret = -EBADF;
 	file = fget(fd);
@@ -384,6 +425,8 @@
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
+	SWSUSP_ACTIVITY_END;
 	return ret;
 }
 
@@ -1071,6 +1114,10 @@
 	 * async buffer heads in use.
 	 */
 	free_more_memory();
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+	if (suspend_task == current->pid)
+		cleanup_finished_swsusp_io();
+#endif
 	goto try_again;
 }
 
@@ -2800,7 +2847,7 @@
  *
  * try_to_free_buffers() is non-blocking.
  */
-static inline int buffer_busy(struct buffer_head *bh)
+inline int buffer_busy(struct buffer_head *bh)
 {
 	return atomic_read(&bh->b_count) |
 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
