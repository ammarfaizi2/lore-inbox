Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTB0UKX>; Thu, 27 Feb 2003 15:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTB0UKX>; Thu, 27 Feb 2003 15:10:23 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:53257 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S266718AbTB0UKV>; Thu, 27 Feb 2003 15:10:21 -0500
To: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.63 : Fix Jensen compilation
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 27 Feb 2003 21:16:13 +0100
Message-ID: <wrpbs0xh436.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Richard,

The following patch fixes a compilation problem on the Jensen (due to
the -Werror introduction).

BTW, the Jensen doesn't boot anymore :

Linux version 2.5.63 (maz@panther) (gcc version 3.2 (Debian)) #1 Thu Feb 27 21:3
Booting on Jensen using machine vector Jensen from SRM
Command line: ro root=/dev/sda1 console=ttyS0
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end     8192
freeing pages 256:384
freeing pages 738:8192
reserving pages 738:739
Max ASN from HWRPB is bad (0xf)
On node 0 totalpages: 8192
  DMA zone: 2048 pages, LIFO batch:1
  Normal zone: 6144 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: ro root=/dev/sda1 console=ttyS0
opDEC fixup enabled.
PID hash table entries: 512 (order 9: 8192 bytes)
Using epoch = 2000
Console: colour VGA+ 80x25
Calibrating delay loop... 292.12 BogoMIPS
Memory: 59880k/65536k available (2012k kernel code, 3512k reserved, 163k data, )
Dentry cache hash table entries: 8192 (order: 4, 131072 bytes)
Inode-cache hash table entries: 4096 (order: 3, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
-> /dev
-> /dev/console
-> /root
POSIX conformance testing by UNIFIX
Machine check

?06 DBL MCHK
  PC= 00000000.00014421 PSL= 00000000.00000007

>>> 

It used to run 2.5.61 just fine (with minor tricks...). Do you have
any idea ?

Thanks,

        M.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=jensen.patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1090  -> 1.1091 
#	arch/alpha/kernel/pci-noop.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/27	maz@hina.wild-wind.fr.eu.org	1.1091
# Help Jensen compile with -Werror.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
--- a/arch/alpha/kernel/pci-noop.c	Thu Feb 27 21:09:40 2003
+++ b/arch/alpha/kernel/pci-noop.c	Thu Feb 27 21:09:40 2003
@@ -48,7 +48,6 @@
 sys_pciconfig_iobase(long which, unsigned long bus, unsigned long dfn)
 {
 	struct pci_controller *hose;
-	struct pci_dev *dev;
 
 	/* from hose or from bus.devfn */
 	if (which & IOBASE_FROM_HOSE) {
@@ -106,6 +105,7 @@
 void *
 pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
 {
+	return NULL;
 }
 void
 pci_free_consistent(struct pci_dev *pdev, size_t size, void *cpu_addr,
@@ -116,6 +116,7 @@
 pci_map_single(struct pci_dev *pdev, void *cpu_addr, size_t size,
 	       int direction)
 {
+	return (dma_addr_t) 0;
 }
 void
 pci_unmap_single(struct pci_dev *pdev, dma_addr_t dma_addr, size_t size,

--=-=-=


-- 
Places change, faces change. Life is so very strange.

--=-=-=--
