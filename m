Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUI2UCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUI2UCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268911AbUI2UCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:02:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:23237 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268904AbUI2UCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:02:11 -0400
Date: Wed, 29 Sep 2004 22:01:58 +0200
From: Olaf Hering <olh@suse.de>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH]  allow CONFIG_NET=n on ppc64
Message-ID: <20040929200158.GA16366@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


The attached minimal config does not compile on ppc64.
I was able to boot the resulting binary with this patch.


Signed-off-by: Olaf Hering <olh@suse.de>


diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.9-rc2/arch/ppc64/kernel/misc.S linux-2.6.9-rc2.ppc64/arch/ppc64/kernel/misc.S
--- linux-2.6.9-rc2/arch/ppc64/kernel/misc.S	2004-09-13 07:33:23.000000000 +0200
+++ linux-2.6.9-rc2.ppc64/arch/ppc64/kernel/misc.S	2004-09-29 21:00:44.909074755 +0200
@@ -703,7 +703,11 @@ _GLOBAL(sys_call_table32)
 	.llong .compat_sys_statfs
 	.llong .compat_sys_fstatfs		/* 100 */
 	.llong .sys_ni_syscall		/* old ioperm syscall */
+#ifdef CONFIG_NET
 	.llong .compat_sys_socketcall
+#else
+	.llong .sys_ni_syscall		/* old ioperm syscall */
+#endif
 	.llong .sys32_syslog
 	.llong .compat_sys_setitimer
 	.llong .compat_sys_getitimer		/* 105 */
diff -purNX /suse/olh/kernel/kernel_exclude.txt linux-2.6.9-rc2/include/net/sock.h linux-2.6.9-rc2.ppc64/include/net/sock.h
--- linux-2.6.9-rc2/include/net/sock.h	2004-09-13 07:33:11.000000000 +0200
+++ linux-2.6.9-rc2.ppc64/include/net/sock.h	2004-09-29 21:06:03.544933591 +0200
@@ -1327,6 +1327,13 @@ static inline void sock_valbool_flag(str
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
+#ifdef CONFIG_NET
 int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+#else
+static inline int siocdevprivate_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	return -ENODEV;
+}
+#endif
 
 #endif	/* _SOCK_H */

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="minimal.config"

CONFIG_64BIT=y
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_EARLY_PRINTK=y
CONFIG_COMPAT=y
CONFIG_FRAME_POINTER=y
CONFIG_FORCE_MAX_ZONEORDER=13
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCALVERSION=""
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_SHMEM=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_PPC_PSERIES=y
CONFIG_PPC=y
CONFIG_PPC64=y
CONFIG_PPC_OF=y
CONFIG_IOMMU_VMERGE=y
CONFIG_SMP=y
CONFIG_IRQ_ALL_CPUS=y
CONFIG_NR_CPUS=128
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_BINFMT_ELF=y
CONFIG_PROC_DEVICETREE=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="panic=1"
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUGGER=y
CONFIG_XMON=y
CONFIG_XMON_DEFAULT=y
CONFIG_LIBCRC32C=y

--h31gzZEtNLTqOjlF--
