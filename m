Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268387AbUHLAIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268387AbUHLAIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268242AbUHLAFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:05:08 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:29931 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268386AbUHKXgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:36:10 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112334.i7BNYtEI163738@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 17 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:34:55 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 16:58:49-05:00 pfg@sgi.com 
#   New includes
# 
# include/asm-ia64/sn/xtalk/hubdev.h
#   2004/08/11 16:56:07-05:00 pfg@sgi.com +57 -0
# 
# include/asm-ia64/sn/xtalk/hubdev.h
#   2004/08/11 16:56:07-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/include/asm-ia64/sn/xtalk/hubdev.h
# 
# include/asm-ia64/sn/pci/pcidev.h
#   2004/08/11 16:56:05-05:00 pfg@sgi.com +45 -0
# 
# include/asm-ia64/sn/pci/pcidev.h
#   2004/08/11 16:56:05-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/include/asm-ia64/sn/pci/pcidev.h
# 
# include/asm-ia64/sn/pci/pcibus.h
#   2004/08/11 16:56:03-05:00 pfg@sgi.com +71 -0
# 
# include/asm-ia64/sn/pci/pcibus.h
#   2004/08/11 16:56:02-05:00 pfg@sgi.com +0 -0
#   BitKeeper file /work.attica2/pfg/Linux/2.5-BK/to-base-2.6/include/asm-ia64/sn/pci/pcibus.h
# 
diff -Nru a/include/asm-ia64/sn/pci/pcibus.h b/include/asm-ia64/sn/pci/pcibus.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ia64/sn/pci/pcibus.h	2004-08-11 17:41:56 -05:00
@@ -0,0 +1,71 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1992 - 1997, 2000-2004 Silicon Graphics, Inc. All rights reserved.
+ */
+#ifndef _ASM_IA64_SN_PCI_PCIBUS_H
+#define _ASM_IA64_SN_PCI_PCIBUS_H
+
+/*
+ * PMU resources.
+ */
+struct ate_resource{
+	uint64_t *ate;
+	uint64_t num_ate;
+	uint64_t lowest_free_index;
+};
+
+struct pcibus_slot { 
+	int		d32_uctr;
+	int		pmu_uctr;
+	int		d64_uctr;
+	unsigned	d32_flags;
+	uint64_t	device;
+	uint64_t	d32_base;
+
+};
+
+struct pcibus_info {
+	struct pcibus_bussoft_s pbi_buscommon;	 /* common header */
+	uint32_t		pbi_magic;	 /* init to PCIBR_SOFT_MAGIC */
+	uint32_t		pbi_moduleid;
+	int			pbi_brick_busnum;
+	int			pbi_busnum;
+	uint32_t		pbi_rev_num;
+	uint32_t		pbi_tio_rev_num;
+	short			pbi_bridge_type;
+	short			pbi_bridge_mode;
+	uint64_t		*pbi_base;
+	uint64_t		pbi_legacy_io_addr;
+
+	struct ate_resource	pbi_int_ate_resource;
+	uint64_t		pbi_int_ate_size;
+
+	uint64_t		pbi_dma_flags;
+	uint64_t		pbi_dir_xbase;
+	char			pbi_self_xid;
+	char			pbi_hub_xid;
+	char			pbi_dir_xport;
+
+	struct pcibus_slot	pbi_slot[8];
+	void			*pbi_info_list;
+	struct xwidget_info	*pbi_xwidget_info;
+	spinlock_t		pbi_lock;
+};
+
+/*
+ * pcibus_info structure locking macros
+ */
+inline static unsigned long
+pcibr_lock(struct pcibus_info *pcibus_info)
+{
+	unsigned long flag;
+	spin_lock_irqsave(&pcibus_info->pbi_lock, flag);
+	return(flag);
+}
+#define pcibr_unlock(pcibus_info, flag)  spin_unlock_irqrestore(&pcibus_info->pbi_lock, flag)
+
+
+#endif /* _ASM_IA64_SN_PCI_PCIBUS_H */
diff -Nru a/include/asm-ia64/sn/pci/pcidev.h b/include/asm-ia64/sn/pci/pcidev.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ia64/sn/pci/pcidev.h	2004-08-11 17:41:56 -05:00
@@ -0,0 +1,45 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1992 - 1997, 2000-2004 Silicon Graphics, Inc. All rights reserved.
+ */
+#ifndef _ASM_IA64_SN_PCI_PCIDEV_H
+#define _ASM_IA64_SN_PCI_PCIDEV_H
+
+#define PCIIO_BUS_NONE	255      /* bus 255 reserved */
+#define PCIIO_SLOT_NONE 255
+#define PCIIO_FUNC_NONE 255
+#define PCIIO_VENDOR_ID_NONE	(-1)
+
+#define PCIIO_DMA_CMD           0x0010
+#define PCIIO_DMA_DATA          0x0020
+#define PCIIO_DMA_A64           0x0040
+
+#define PCIIO_WRITE_GATHER      0x0100
+#define PCIIO_NOWRITE_GATHER    0x0200
+#define PCIIO_PREFETCH          0x0400
+#define PCIIO_NOPREFETCH        0x0800
+
+/* Requesting an endianness setting that the
+ * underlieing hardware can not support
+ * WILL result in a failure to allocate
+ * dmamaps or complete a dmatrans.
+ */
+#define PCIIO_BYTE_STREAM       0x1000  /* set BYTE SWAP for "byte stream" */
+#define PCIIO_WORD_VALUES       0x2000  /* set BYTE SWAP for "word values" */
+
+struct pcidev_info {
+	uint8_t			pdi_internal_dev;/* Internal Device number(f_dev) */
+	uint64_t		pdi_pio_mapped_addr[7]; /* 6 BARs PLUS 1 ROM */
+	uint64_t		pdi_slot_host_handle;	/* Bus and devfn Host pci_dev */
+
+	struct pcibus_info	*pdi_pcibus_info;	/* Kernel pci_bus */
+	struct pcidev_info	*pdi_host_pcidev_info;	/* Kernel Host pci_dev */
+	struct pci_dev		*pdi_linux_pcidev;	/* Kernel pci_dev */
+
+	struct sn_irq_info	*pdi_sn_irq_info;
+};
+
+#endif				/* _ASM_IA64_SN_PCI_PCIDEV_H */
diff -Nru a/include/asm-ia64/sn/xtalk/hubdev.h b/include/asm-ia64/sn/xtalk/hubdev.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ia64/sn/xtalk/hubdev.h	2004-08-11 17:41:56 -05:00
@@ -0,0 +1,57 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1992 - 1997, 2000-2003 Silicon Graphics, Inc. All rights reserved.
+ */
+#ifndef _ASM_IA64_SN_SN2_SN_PRIVATE_H
+#define _ASM_IA64_SN_SN2_SN_PRIVATE_H
+
+#define HUB_WIDGET_ID_MAX 0xf
+#define DEV_PER_WIDGET (2*2*8)
+#define IIO_ITTE_WIDGET_BITS    4       /* size of widget field */
+#define IIO_ITTE_WIDGET_MASK    ((1<<IIO_ITTE_WIDGET_BITS)-1)
+#define IIO_ITTE_WIDGET_SHIFT   8
+
+/*
+ * Use the top big window as a surrogate for the first small window
+ */
+#define SWIN0_BIGWIN            HUB_NUM_BIG_WINDOW
+#define IIO_NUM_ITTES   7
+#define HUB_NUM_BIG_WINDOW      (IIO_NUM_ITTES - 1)
+
+struct sn_flush_device_list {
+	int sfdl_bus;
+	int sfdl_slot;
+	int sfdl_pin;
+	struct bar_list {
+		unsigned long start;
+		unsigned long end;
+	} sfdl_bar_list[6];
+	unsigned long sfdl_force_int_addr;
+	unsigned long sfdl_flush_value;
+	volatile unsigned long *sfdl_flush_addr;
+	uint64_t sfdl_persistent_busnum;
+	struct pcibus_info *sfdl_pcibus_info;
+	spinlock_t sfdl_flush_lock;
+};
+
+/*
+ * **widget_p - Used as an array[wid_num][device] of sn_flush_device_list.
+ */
+struct sn_flush_nasid_entry  {
+	struct sn_flush_device_list **widget_p; /* Used as a array of wid_num */
+	uint64_t iio_itte[8];
+};
+
+struct hubdev_info{
+	geoid_t				hdi_geoid;
+	short				hdi_nasid;
+	short				hdi_peer_nasid;   /* Dual Porting Peer */
+
+	struct sn_flush_nasid_entry	hdi_flush_nasid_list;
+	struct xwidget_info		hdi_xwidget_info[HUB_WIDGET_ID_MAX + 1];
+};
+
+#endif /* _ASM_IA64_SN_SN2_SN_PRIVATE_H */
