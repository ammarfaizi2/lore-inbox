Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265219AbSJPQtt>; Wed, 16 Oct 2002 12:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265204AbSJPQsa>; Wed, 16 Oct 2002 12:48:30 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:9699 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265203AbSJPQpt> convert rfc822-to-8bit; Wed, 16 Oct 2002 12:45:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.43 s390 (2/6): config & help.
Date: Wed, 16 Oct 2002 18:47:23 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210161847.23010.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add help text for CONFIG_NR_CPUS and CONFIG_PREEMPT. Remove help text for
CONFIG_ISA, CONFIG_MCA and CONFIG_EISA. Regenerated defconfigs.

diff -urN linux-2.5.43/arch/s390/Config.help linux-2.5.43-s390/arch/s390/Config.help
--- linux-2.5.43/arch/s390/Config.help	Wed Oct 16 05:28:30 2002
+++ linux-2.5.43-s390/arch/s390/Config.help	Wed Oct 16 17:53:57 2002
@@ -25,37 +25,29 @@
 
   If you don't know what to do here, say N.
 
+CONFIG_NR_CPUS
+  This allows you to specify the maximum number of CPUs which this
+  kernel will support.  The maximum supported value is 32 and the
+  minimum value which makes sense is 2.
+
+  This is purely to save memory - each supported CPU adds
+  approximately eight kilobytes to the kernel image.
+
+CONFIG_PREEMPT
+  This option reduces the latency of the kernel when reacting to
+  real-time or interactive events by allowing a low priority process to
+  be preempted even if it is in kernel mode executing a system call.
+  This allows applications to run more reliably even when the system is
+  under load.
+
+  Say Y here if you are building a kernel for a desktop, embedded
+  or real-time system.  Say N if you are unsure.
+
 CONFIG_MATHEMU
   This option is required for IEEE compliant floating point arithmetic
   on the Alpha. The only time you would ever not say Y is to say M in
   order to debug the code. Say Y unless you know what you are doing.
 
-CONFIG_ISA
-  Find out whether you have ISA slots on your motherboard.  ISA is the
-  name of a bus system, i.e. the way the CPU talks to the other stuff
-  inside your box.  Other bus systems are PCI, EISA, MicroChannel
-  (MCA) or VESA.  ISA is an older system, now being displaced by PCI;
-  newer boards don't support it.  If you have ISA, say Y, otherwise N.
-
-CONFIG_MCA
-  MicroChannel Architecture is found in some IBM PS/2 machines and
-  laptops.  It is a bus system similar to PCI or ISA. See
-  <file:Documentation/mca.txt> (and especially the web page given
-  there) before attempting to build an MCA bus kernel.
-
-CONFIG_EISA
-  The Extended Industry Standard Architecture (EISA) bus was
-  developed as an open alternative to the IBM MicroChannel bus.
-
-  The EISA bus provided some of the features of the IBM MicroChannel
-  bus while maintaining backward compatibility with cards made for
-  the older ISA bus.  The EISA bus saw limited use between 1988 and
-  1995 when it was made obsolete by the PCI bus.
-
-  Say Y here if you are building a kernel for an EISA-based machine.
-
-  Otherwise, say N.
-
 CONFIG_KCORE_ELF
   If you enabled support for /proc file system then the file
   /proc/kcore will contain the kernel core image. This can be used
diff -urN linux-2.5.43/arch/s390/defconfig linux-2.5.43-s390/arch/s390/defconfig
--- linux-2.5.43/arch/s390/defconfig	Wed Oct 16 05:28:34 2002
+++ linux-2.5.43-s390/arch/s390/defconfig	Wed Oct 16 17:53:57 2002
@@ -39,7 +39,7 @@
 #
 CONFIG_SMP=y
 CONFIG_MATHEMU=y
-CONFIG_NR_CPUS=64
+CONFIG_NR_CPUS=32
 
 #
 # I/O subsystem configuration
@@ -147,7 +147,7 @@
 CONFIG_DASD=y
 CONFIG_DASD_ECKD=y
 CONFIG_DASD_FBA=y
-# CONFIG_DASD_DIAG is not set
+CONFIG_DASD_DIAG=y
 
 #
 # Multi-device support (RAID and LVM)
@@ -301,7 +301,7 @@
 # CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
-CONFIG_DEVFS_FS=y
+# CONFIG_DEVFS_FS is not set
 # CONFIG_DEVFS_MOUNT is not set
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS is not set
@@ -325,13 +325,16 @@
 # CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
 # CONFIG_ROOT_NFS is not set
 CONFIG_NFSD=y
 # CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_V4 is not set
 # CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 CONFIG_EXPORTFS=y
+# CONFIG_CIFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_NCPFS_PACKET_SIGNING is not set
@@ -342,6 +345,7 @@
 # CONFIG_NCPFS_SMALLDOS is not set
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
+# CONFIG_AFS_FS is not set
 # CONFIG_ZISOFS_FS is not set
 
 #
diff -urN linux-2.5.43/arch/s390x/Config.help linux-2.5.43-s390/arch/s390x/Config.help
--- linux-2.5.43/arch/s390x/Config.help	Wed Oct 16 05:27:16 2002
+++ linux-2.5.43-s390/arch/s390x/Config.help	Wed Oct 16 17:53:57 2002
@@ -25,31 +25,23 @@
 
   If you don't know what to do here, say N.
 
-CONFIG_ISA
-  Find out whether you have ISA slots on your motherboard.  ISA is the
-  name of a bus system, i.e. the way the CPU talks to the other stuff
-  inside your box.  Other bus systems are PCI, EISA, MicroChannel
-  (MCA) or VESA.  ISA is an older system, now being displaced by PCI;
-  newer boards don't support it.  If you have ISA, say Y, otherwise N.
-
-CONFIG_MCA
-  MicroChannel Architecture is found in some IBM PS/2 machines and
-  laptops.  It is a bus system similar to PCI or ISA. See
-  <file:Documentation/mca.txt> (and especially the web page given
-  there) before attempting to build an MCA bus kernel.
-
-CONFIG_EISA
-  The Extended Industry Standard Architecture (EISA) bus was
-  developed as an open alternative to the IBM MicroChannel bus.
-
-  The EISA bus provided some of the features of the IBM MicroChannel
-  bus while maintaining backward compatibility with cards made for
-  the older ISA bus.  The EISA bus saw limited use between 1988 and
-  1995 when it was made obsolete by the PCI bus.
+CONFIG_NR_CPUS
+  This allows you to specify the maximum number of CPUs which this
+  kernel will support.  The maximum supported value is 32 and the
+  minimum value which makes sense is 2.
+
+  This is purely to save memory - each supported CPU adds
+  approximately eight kilobytes to the kernel image.
+
+CONFIG_PREEMPT
+  This option reduces the latency of the kernel when reacting to
+  real-time or interactive events by allowing a low priority process to
+  be preempted even if it is in kernel mode executing a system call.
+  This allows applications to run more reliably even when the system is
+  under load.
 
-  Say Y here if you are building a kernel for an EISA-based machine.
-
-  Otherwise, say N.
+  Say Y here if you are building a kernel for a desktop, embedded
+  or real-time system.  Say N if you are unsure.
 
 CONFIG_KCORE_ELF
   If you enabled support for /proc file system then the file
diff -urN linux-2.5.43/arch/s390x/defconfig linux-2.5.43-s390/arch/s390x/defconfig
--- linux-2.5.43/arch/s390x/defconfig	Wed Oct 16 05:26:43 2002
+++ linux-2.5.43-s390/arch/s390x/defconfig	Wed Oct 16 17:53:57 2002
@@ -38,15 +38,15 @@
 # Processor type and features
 #
 CONFIG_SMP=y
+CONFIG_NR_CPUS=64
 CONFIG_S390_SUPPORT=y
 CONFIG_BINFMT_ELF32=y
-CONFIG_NR_CPUS=64
 
 #
 # I/O subsystem configuration
 #
 CONFIG_MACHCHK_WARNING=y
-CONFIG_QDIO=y
+CONFIG_QDIO=m
 # CONFIG_QDIO_PERF_STATS is not set
 
 #
@@ -301,7 +301,7 @@
 # CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
-CONFIG_DEVFS_FS=y
+# CONFIG_DEVFS_FS is not set
 # CONFIG_DEVFS_MOUNT is not set
 # CONFIG_DEVFS_DEBUG is not set
 # CONFIG_DEVPTS_FS is not set
@@ -325,13 +325,16 @@
 # CONFIG_INTERMEZZO_FS is not set
 CONFIG_NFS_FS=y
 # CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
 # CONFIG_ROOT_NFS is not set
 CONFIG_NFSD=y
 # CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_V4 is not set
 # CONFIG_NFSD_TCP is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 CONFIG_EXPORTFS=y
+# CONFIG_CIFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_NCPFS_PACKET_SIGNING is not set
@@ -342,6 +345,7 @@
 # CONFIG_NCPFS_SMALLDOS is not set
 # CONFIG_NCPFS_NLS is not set
 # CONFIG_NCPFS_EXTRAS is not set
+# CONFIG_AFS_FS is not set
 # CONFIG_ZISOFS_FS is not set
 
 #

