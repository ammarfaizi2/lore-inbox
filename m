Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWG1JAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWG1JAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWG1JAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 05:00:07 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:55604 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161103AbWG1JAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 05:00:05 -0400
Date: Fri, 28 Jul 2006 11:00:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20060728090014.GC19478@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/defconfig           |   44 +++++++++++++++++++++++++++++++++---------
 drivers/s390/cio/ccwgroup.c   |   10 ++-------
 drivers/s390/cio/device_fsm.c |    3 +-
 3 files changed, 40 insertions(+), 17 deletions(-)

Cornelia Huck:
      [S390] duplicate ccw devices in ccwgroup.

Martin Schwidefsky:
      [S390] update default configuration

Peter Oberparleiter:
      [S390] permanent subchannel busy conditions may cause I/O stall

diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index f4dfc10..f1d4591 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -1,13 +1,16 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-rc1
-# Mon Apr  3 14:34:15 2006
+# Linux kernel version: 2.6.18-rc2
+# Thu Jul 27 13:51:07 2006
 #
 CONFIG_MMU=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_S390=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
@@ -25,6 +28,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
@@ -43,10 +47,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -94,7 +100,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_DEFAULT_MIGRATION_COST=1000000
 CONFIG_COMPAT=y
 CONFIG_SYSVIPC_COMPAT=y
-CONFIG_BINFMT_ELF32=y
 
 #
 # Code generation options
@@ -115,6 +120,7 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_RESOURCES_64BIT=y
 
 #
 # I/O subsystem configuration
@@ -142,6 +148,7 @@ CONFIG_VIRT_CPU_ACCOUNTING=y
 # CONFIG_APPLDATA_BASE is not set
 CONFIG_NO_IDLE_HZ=y
 CONFIG_NO_IDLE_HZ_INIT=y
+CONFIG_S390_HYPFS_FS=y
 CONFIG_KEXEC=y
 
 #
@@ -174,6 +181,8 @@ # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -186,7 +195,10 @@ # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
 # CONFIG_IPV6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -263,6 +275,7 @@ #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
+# CONFIG_NET_TCPPROBE is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
@@ -276,6 +289,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+CONFIG_SYS_HYPERVISOR=y
 
 #
 # Connector - unified userspace <-> kernelspace linker
@@ -334,6 +348,7 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 
@@ -359,9 +374,7 @@ CONFIG_MD_LINEAR=m
 CONFIG_MD_RAID0=m
 CONFIG_MD_RAID1=m
 # CONFIG_MD_RAID10 is not set
-CONFIG_MD_RAID5=m
-# CONFIG_MD_RAID5_RESHAPE is not set
-# CONFIG_MD_RAID6 is not set
+# CONFIG_MD_RAID456 is not set
 CONFIG_MD_MULTIPATH=m
 # CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=y
@@ -419,7 +432,8 @@ # CONFIG_MONREADER is not set
 #
 # Cryptographic devices
 #
-CONFIG_Z90CRYPT=m
+CONFIG_ZCRYPT=m
+# CONFIG_ZCRYPT_MONOLITHIC is not set
 
 #
 # Network device support
@@ -509,6 +523,7 @@ # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -614,26 +629,36 @@ #
 # Instrumentation Support
 #
 # CONFIG_PROFILING is not set
-# CONFIG_STATISTICS is not set
+CONFIG_STATISTICS=y
+CONFIG_KPROBES=y
 
 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
-CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_FRAME_POINTER is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
@@ -688,3 +713,4 @@ # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
+CONFIG_PLIST=y
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index f26a2ee..3cba6c9 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -152,7 +152,6 @@ ccwgroup_create(struct device *root,
 	struct ccwgroup_device *gdev;
 	int i;
 	int rc;
-	int del_drvdata;
 
 	if (argc > 256) /* disallow dumb users */
 		return -EINVAL;
@@ -163,7 +162,6 @@ ccwgroup_create(struct device *root,
 
 	atomic_set(&gdev->onoff, 0);
 
-	del_drvdata = 0;
 	for (i = 0; i < argc; i++) {
 		gdev->cdev[i] = get_ccwdev_by_busid(cdrv, argv[i]);
 
@@ -180,10 +178,8 @@ ccwgroup_create(struct device *root,
 			rc = -EINVAL;
 			goto free_dev;
 		}
-	}
-	for (i = 0; i < argc; i++)
 		gdev->cdev[i]->dev.driver_data = gdev;
-	del_drvdata = 1;
+	}
 
 	gdev->creator_id = creator_id;
 	gdev->count = argc;
@@ -226,9 +222,9 @@ error:
 free_dev:
 	for (i = 0; i < argc; i++)
 		if (gdev->cdev[i]) {
-			put_device(&gdev->cdev[i]->dev);
-			if (del_drvdata)
+			if (gdev->cdev[i]->dev.driver_data == gdev)
 				gdev->cdev[i]->dev.driver_data = NULL;
+			put_device(&gdev->cdev[i]->dev);
 		}
 	kfree(gdev);
 	return rc;
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index ac6e0c7..7a39e0b 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -152,7 +152,8 @@ ccw_device_cancel_halt_clear(struct ccw_
 		if (cdev->private->iretry) {
 			cdev->private->iretry--;
 			ret = cio_halt(sch);
-			return (ret == 0) ? -EBUSY : ret;
+			if (ret != -EBUSY)
+				return (ret == 0) ? -EBUSY : ret;
 		}
 		/* halt io unsuccessful. */
 		cdev->private->iretry = 255;	/* 255 clear retries. */
