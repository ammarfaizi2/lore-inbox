Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUEVOvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUEVOvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUEVOvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:51:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52948 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261451AbUEVOtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:49:18 -0400
Date: Sat, 22 May 2004 16:49:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small advansys cleanup
Message-ID: <20040522144910.GR18564@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following small cleanups for the advansys 
driver:
- remove obsolete maintainer information
- remove kernel 2.2 code

diffstat output:
 MAINTAINERS             |    7 
 drivers/scsi/advansys.c |  341 +++++++---------------------------------
 drivers/scsi/advansys.h |   26 ---
 3 files changed, 60 insertions(+), 314 deletions(-)

I've tested the compilation in 2.6.6-mm5.

Please apply
Adrian


--- linux-2.6.6-mm5-full/MAINTAINERS.old	2004-05-22 14:48:10.000000000 +0200
+++ linux-2.6.6-mm5-full/MAINTAINERS	2004-05-22 14:48:20.000000000 +0200
@@ -199,13 +199,6 @@
 W:	http://www.tu-darmstadt.de/~tek01/projects/linux.html
 S:	Maintained
 
-ADVANSYS SCSI DRIVER
-P:	Bob Frey
-M:	linux@advansys.com
-W:	http://www.advansys.com/linux.html
-L:	linux-scsi@vger.kernel.org
-S:	Maintained
-
 AEDSP16 DRIVER
 P:	Riccardo Facchetti
 M:	fizban@tin.it
--- linux-2.6.6-mm5-full/drivers/scsi/advansys.h.old	2004-05-22 14:42:56.000000000 +0200
+++ linux-2.6.6-mm5-full/drivers/scsi/advansys.h	2004-05-22 14:47:56.000000000 +0200
@@ -13,37 +13,11 @@
  * As of March 8, 2000 Advanced System Products, Inc. (AdvanSys)
  * changed its name to ConnectCom Solutions, Inc.
  *
- * There is an AdvanSys Linux WWW page at:
- *  http://www.connectcom.net/downloads/software/os/linux.html
- *  http://www.advansys.com/linux.html
- *
- * The latest released version of the AdvanSys driver is available at:
- *  ftp://ftp.advansys.com/pub/linux/linux.tgz
- *  ftp://ftp.connectcom.net/pub/linux/linux.tgz
- *
- * Please send questions, comments, bug reports to:
- *  linux@connectcom.net or bfrey@turbolinux.com.cn
  */
 
 #ifndef _ADVANSYS_H
 #define _ADVANSYS_H
 
-#include <linux/config.h>
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif /* LINUX_VERSION_CODE */
-
-/* Convert Linux Version, Patch-level, Sub-level to LINUX_VERSION_CODE. */
-#define ASC_LINUX_VERSION(V, P, S)    (((V) * 65536) + ((P) * 256) + (S))
-/* Driver supported only in version 2.2 and version >= 2.4. */
-#if LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,2,0) || \
-    (LINUX_VERSION_CODE > ASC_LINUX_VERSION(2,3,0) && \
-     LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,4,0))
-#error "AdvanSys driver supported only in 2.2 and 2.4 or greater kernels."
-#endif
-#define ASC_LINUX_KERNEL22 (LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,4,0))
-#define ASC_LINUX_KERNEL24 (LINUX_VERSION_CODE >= ASC_LINUX_VERSION(2,4,0))
-
 /*
  * Scsi_Host_Template function prototypes.
  */
--- linux-2.6.6-mm5-full/drivers/scsi/advansys.c.old	2004-05-22 14:31:42.000000000 +0200
+++ linux-2.6.6-mm5-full/drivers/scsi/advansys.c	2004-05-22 14:47:45.000000000 +0200
@@ -15,16 +15,6 @@
  * As of March 8, 2000 Advanced System Products, Inc. (AdvanSys)
  * changed its name to ConnectCom Solutions, Inc.
  *
- * There is an AdvanSys Linux WWW page at:
- *  http://www.connectcom.net/downloads/software/os/linux.html
- *  http://www.advansys.com/linux.html
- *
- * The latest released version of the AdvanSys driver is available at:
- *  ftp://ftp.advansys.com/pub/linux/linux.tgz
- *  ftp://ftp.connectcom.net/pub/linux/linux.tgz
- *
- * Please send questions, comments, bug reports to:
- *  support@connectcom.net
  */
 
 /*
@@ -41,7 +31,6 @@
   H. Release History
   I. Known Problems/Fix List
   J. Credits (Chronological Order)
-  K. ConnectCom (AdvanSys) Contact Information
 
   A. Linux Kernels Supported by this Driver
 
@@ -742,42 +731,10 @@
      Andy Kellner <AKellner@connectcom.net> continues the Advansys SCSI
      driver development for ConnectCom (Version > 3.3F).
 
-  K. ConnectCom (AdvanSys) Contact Information
-
-     Mail:                   ConnectCom Solutions, Inc.
-                             1150 Ringwood Court
-                             San Jose, CA 95131
-     Operator/Sales:         1-408-383-9400
-     FAX:                    1-408-383-9612
-     Tech Support:           1-408-467-2930
-     Tech Support E-Mail:    linux@connectcom.net
-     FTP Site:               ftp.connectcom.net (login: anonymous)
-     Web Site:               http://www.connectcom.net
-
 */
 
 
 /*
- * --- Linux Version
- */
-
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif /* LINUX_VERSION_CODE */
-
-/* Convert Linux Version, Patch-level, Sub-level to LINUX_VERSION_CODE. */
-#define ASC_LINUX_VERSION(V, P, S)    (((V) * 65536) + ((P) * 256) + (S))
-#define ASC_LINUX_KERNEL22 (LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,4,0))
-#define ASC_LINUX_KERNEL24 (LINUX_VERSION_CODE >= ASC_LINUX_VERSION(2,4,0))
-
-/* Driver supported only in version 2.2 and version >= 2.4. */
-#if LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,2,0) || \
-    (LINUX_VERSION_CODE > ASC_LINUX_VERSION(2,3,0) && \
-     LINUX_VERSION_CODE < ASC_LINUX_VERSION(2,4,0))
-#error "AdvanSys driver supported only in 2.2 and 2.4 or greater kernels."
-#endif
-
-/*
  * --- Linux Include Files
  */
 
@@ -2123,9 +2080,6 @@
 #define ADV_LIB_VERSION_MAJOR  5
 #define ADV_LIB_VERSION_MINOR  14
 
-/* d_os_dep.h */
-#define ADV_OS_LINUX
-
 /*
  * Define Adv Library required special types.
  */
@@ -3582,19 +3536,6 @@
 
 #define NO_ISA_DMA              0xff        /* No ISA DMA Channel Used */
 
-/*
- * If the Linux kernel version supports freeing initialization code
- * and data after loading, define macros for this purpose. These macros
- * are not used when the driver is built as a module, cf. linux/init.h.
- */
-#if ASC_LINUX_KERNEL24
-#define ASC_INITFUNC(type, func)        type __init func
-#elif ASC_LINUX_KERNEL22
-#define ASC_INITFUNC(type, func)        __initfunc(type func)
-#endif
-#define ASC_INITDATA                    __initdata
-#define ASC_INIT                        __init
-
 #define ASC_INFO_SIZE           128            /* advansys_info() line size */
 
 #ifdef CONFIG_PROC_FS
@@ -4146,19 +4087,6 @@
 
 /* Note: All driver global data should be initialized. */
 
-#if ASC_LINUX_KERNEL22
-#ifdef CONFIG_PROC_FS
-struct proc_dir_entry proc_scsi_advansys =
-{
-    PROC_SCSI_ADVANSYS,              /* unsigned short low_ino */
-    8,                               /* unsigned short namelen */
-    "advansys",                      /* const char *name */
-    S_IFDIR | S_IRUGO | S_IXUGO,     /* mode_t mode */
-    2                                /* nlink_t nlink */
-};
-#endif /* CONFIG_PROC_FS */
-#endif /* ASC_LINUX_KERNEL22 */
-
 /* Number of boards detected in system. */
 STATIC int asc_board_count = 0;
 STATIC struct Scsi_Host    *asc_host[ASC_NUM_BOARD_SUPPORTED] = { 0 };
@@ -4173,7 +4101,7 @@
 STATIC ASC_SG_HEAD asc_sg_head = { 0 };
 
 /* List of supported bus types. */
-STATIC ushort asc_bus[ASC_NUM_BUS] ASC_INITDATA = {
+STATIC ushort asc_bus[ASC_NUM_BUS] __initdata = {
     ASC_IS_ISA,
     ASC_IS_VL,
     ASC_IS_EISA,
@@ -4506,10 +4434,8 @@
  * it must not call SCSI mid-level functions including scsi_malloc()
  * and scsi_free().
  */
-ASC_INITFUNC(
-int,
+int __init
 advansys_detect(Scsi_Host_Template *tpnt)
-)
 {
     static int          detect_called = ASC_FALSE;
     int                 iop;
@@ -4551,11 +4477,7 @@
 
     ASC_DBG(1, "advansys_detect: begin\n");
 
-#if ASC_LINUX_KERNEL24
     tpnt->proc_name = "advansys";
-#elif ASC_LINUX_KERNEL22
-    tpnt->proc_dir = &proc_scsi_advansys;
-#endif
 
     asc_board_count = 0;
 
@@ -4682,13 +4604,9 @@
                             NULL) {
                             pci_device_id_cnt++;
                         } else {
-#if ASC_LINUX_KERNEL24
                             if (pci_enable_device(pci_devp) == 0) {
                                 pci_devicep[pci_card_cnt_max++] = pci_devp;
                             }
-#elif ASC_LINUX_KERNEL22
-                            pci_devicep[pci_card_cnt_max++] = pci_devp;
-#endif
                         }
                     }
 
@@ -4725,11 +4643,7 @@
                     ASC_DBG2(2,
                         "advansys_detect: devfn %d, bus number %d\n",
                         pci_devp->devfn, pci_devp->bus->number);
-#if ASC_LINUX_KERNEL24
                     iop = pci_resource_start(pci_devp, 0);
-#elif ASC_LINUX_KERNEL22
-                    iop = pci_devp->base_address[0] & PCI_IOADDRESS_MASK;
-#endif
                     ASC_DBG2(1,
                         "advansys_detect: vendorID %X, deviceID %X\n",
                         pci_devp->vendor, pci_devp->device);
@@ -4850,11 +4764,7 @@
                     iolen = ADV_38C1600_IOLEN;
                 }
 #ifdef CONFIG_PCI
-#if ASC_LINUX_KERNEL24
                 pci_memory_address = pci_resource_start(pci_devp, 1);
-#elif ASC_LINUX_KERNEL22
-                pci_memory_address = pci_devp->base_address[1];
-#endif
                 ASC_DBG1(1, "advansys_detect: pci_memory_address: 0x%lx\n",
                     (ulong) pci_memory_address);
                 if ((boardp->ioremap_addr =
@@ -5322,11 +5232,7 @@
 
             /* BIOS start address. */
             if (ASC_NARROW_BOARD(boardp)) {
-#if ASC_LINUX_KERNEL24
                 shp->base =
-#elif ASC_LINUX_KERNEL22
-                shp->base = (char *)
-#endif
                         ((ulong) AscGetChipBiosAddress(
                             asc_dvc_varp->iop_base,
                             asc_dvc_varp->bus_type));
@@ -5362,9 +5268,6 @@
                      * address by shifting left 4.
                      */
                     shp->base =
-#if ASC_LINUX_KERNEL22
-                        (char *)
-#endif
                         ((ulong) boardp->bios_codeseg << 4);
                 } else {
                     shp->base = 0;
@@ -5386,7 +5289,6 @@
             ASC_DBG2(2,
                 "advansys_detect: request_region port 0x%lx, len 0x%x\n",
                 (ulong) shp->io_port, boardp->asc_n_io_port);
-#if ASC_LINUX_KERNEL24
             if (request_region(shp->io_port, boardp->asc_n_io_port,
                                "advansys") == NULL) {
                 ASC_PRINT3(
@@ -5399,9 +5301,6 @@
                 asc_board_count--;
                 continue;
             }
-#elif ASC_LINUX_KERNEL22
-            request_region(shp->io_port, boardp->asc_n_io_port, "advansys");
-#endif
 
             /* Register DMA Channel for Narrow boards. */
             shp->dma_channel = NO_ISA_DMA; /* Default to no ISA DMA. */
@@ -6150,10 +6049,8 @@
  * ints[2] - second argument
  * ...
  */
-ASC_INITFUNC(
-void,
+void __init
 advansys_setup(char *str, int *ints)
-)
 {
     int    i;
 
@@ -7134,7 +7031,6 @@
                 (ASC_SCSI_INQUIRY *) scp->request_buffer);
         }
 
-#if ASC_LINUX_KERNEL24
         /*
          * Check for an underrun condition.
          *
@@ -7147,7 +7043,6 @@
             (unsigned) qdonep->remain_bytes);
             scp->resid = qdonep->remain_bytes;
         }
-#endif
         break;
 
     case QD_WITH_ERROR:
@@ -7233,9 +7128,7 @@
     Scsi_Cmnd           *scp;
     struct Scsi_Host    *shp;
     int                 i;
-#if ASC_LINUX_KERNEL24
     ADV_DCNT            resid_cnt;
-#endif
 
 
     ASC_DBG2(1, "adv_isr_callback: adv_dvc_varp 0x%lx, scsiqp 0x%lx\n",
@@ -7318,7 +7211,6 @@
         ASC_DBG(2, "adv_isr_callback: QD_NO_ERROR\n");
         scp->result = 0;
 
-#if ASC_LINUX_KERNEL24
         /*
          * Check for an underrun condition.
          *
@@ -7332,7 +7224,6 @@
                 (ulong) resid_cnt);
             scp->resid = resid_cnt;
         }
-#endif
         break;
 
     case QD_WITH_ERROR:
@@ -9050,12 +8941,10 @@
 /*
  * Read a PCI configuration byte.
  */
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 DvcReadPCIConfigByte(
         ASC_DVC_VAR *asc_dvc,
         ushort offset)
-)
 {
 #ifdef CONFIG_PCI
     uchar byte_data;
@@ -9069,13 +8958,11 @@
 /*
  * Write a PCI configuration byte.
  */
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 DvcWritePCIConfigByte(
         ASC_DVC_VAR *asc_dvc,
         ushort offset,
         uchar  byte_data)
-)
 {
 #ifdef CONFIG_PCI
     pci_write_config_byte(asc_dvc->cfg->pci_dev, offset, byte_data);
@@ -9086,13 +8973,11 @@
  * Return the BIOS address of the adapter at the specified
  * I/O port and with the specified bus type.
  */
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscGetChipBiosAddress(
         PortAddr iop_base,
         ushort bus_type
 )
-)
 {
     ushort  cfg_lsw;
     ushort  bios_addr;
@@ -9167,12 +9052,10 @@
 /*
  * Read a PCI configuration byte.
  */
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 DvcAdvReadPCIConfigByte(
         ADV_DVC_VAR *asc_dvc,
         ushort offset)
-)
 {
 #ifdef CONFIG_PCI
     uchar byte_data;
@@ -9186,13 +9069,11 @@
 /*
  * Write a PCI configuration byte.
  */
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 DvcAdvWritePCIConfigByte(
         ADV_DVC_VAR *asc_dvc,
         ushort offset,
         uchar  byte_data)
-)
 {
 #ifdef CONFIG_PCI
     pci_write_config_byte(asc_dvc->cfg->pci_dev, offset, byte_data);
@@ -9406,15 +9287,9 @@
         s->host_busy, s->host_no,
         (unsigned) s->last_reset);
 
-#if ASC_LINUX_KERNEL24
     printk(
 " hostt 0x%lx\n",
         (ulong) s->hostt);
-#elif ASC_LINUX_KERNEL22
-    printk(
-" host_queue 0x%lx, hostt 0x%lx, block 0x%lx,\n",
-        (ulong) s->host_queue, (ulong) s->hostt, (ulong) s->block);
-#endif
 
     printk(
 " base 0x%lx, io_port 0x%lx, n_io_port %u, irq 0x%x,\n",
@@ -9452,11 +9327,9 @@
 
     asc_prt_hex(" CDB", s->cmnd, s->cmd_len);
 
-#if ASC_LINUX_KERNEL24
     printk (
 "sc_data_direction %u, resid %d\n",
         s->sc_data_direction, s->resid);
-#endif
 
     printk(
 " use_sg %u, sglist_len %u, abort_reason 0x%x\n",
@@ -9471,15 +9344,9 @@
 " timeout_per_command %d, timeout_total %d, timeout %d\n",
         s->timeout_per_command, s->timeout_total, s->timeout);
 
-#if ASC_LINUX_KERNEL24
     printk(
 " internal_timeout %u, flags %u\n",
         s->internal_timeout, s->flags);
-#elif ASC_LINUX_KERNEL22
-    printk(
-" internal_timeout %u, flags %u, this_count %d\n",
-        s->internal_timeout, s->flags,s->this_count);
-#endif
 
     printk(
 " scsi_done 0x%lx, done 0x%lx, host_scribble 0x%lx, result 0x%x\n",
@@ -9835,12 +9702,10 @@
  * --- Asc Library Functions
  */
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscGetEisaChipCfg(
                      PortAddr iop_base
 )
-)
 {
     PortAddr            eisa_cfg_iop;
 
@@ -9849,13 +9714,11 @@
     return (inpw(eisa_cfg_iop));
 }
 
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 AscSetChipScsiID(
                     PortAddr iop_base,
                     uchar new_host_id
 )
-)
 {
     ushort              cfg_lsw;
 
@@ -9869,12 +9732,10 @@
     return (AscGetChipScsiID(iop_base));
 }
 
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 AscGetChipScsiCtrl(
                       PortAddr iop_base
 )
-)
 {
     uchar               sc;
 
@@ -9884,13 +9745,11 @@
     return (sc);
 }
 
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 AscGetChipVersion(
                      PortAddr iop_base,
                      ushort bus_type
 )
-)
 {
     if ((bus_type & ASC_IS_EISA) != 0) {
         PortAddr            eisa_iop;
@@ -9903,12 +9762,10 @@
     return (AscGetChipVerNo(iop_base));
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscGetChipBusType(
                      PortAddr iop_base
 )
-)
 {
     ushort              chip_ver;
 
@@ -9988,22 +9845,20 @@
     return (0);
 }
 
-STATIC PortAddr _asc_def_iop_base[ASC_IOADR_TABLE_MAX_IX] ASC_INITDATA =
+STATIC PortAddr _asc_def_iop_base[ASC_IOADR_TABLE_MAX_IX] __initdata =
 {
     0x100, ASC_IOADR_1, 0x120, ASC_IOADR_2, 0x140, ASC_IOADR_3, ASC_IOADR_4,
     ASC_IOADR_5, ASC_IOADR_6, ASC_IOADR_7, ASC_IOADR_8
 };
 
 #ifdef CONFIG_ISA
-STATIC uchar _isa_pnp_inited ASC_INITDATA = 0;
+STATIC uchar _isa_pnp_inited __initdata = 0;
 
-ASC_INITFUNC(
-STATIC PortAddr,
+STATIC PortAddr __init
 AscSearchIOPortAddr(
                        PortAddr iop_beg,
                        ushort bus_type
 )
-)
 {
     if (bus_type & ASC_IS_VL) {
         while ((iop_beg = AscSearchIOPortAddr11(iop_beg)) != 0) {
@@ -10034,12 +9889,10 @@
     return (0);
 }
 
-ASC_INITFUNC(
-STATIC PortAddr,
+STATIC PortAddr __init
 AscSearchIOPortAddr11(
                          PortAddr s_addr
 )
-)
 {
     int                 i;
     PortAddr            iop_base;
@@ -10065,11 +9918,9 @@
     return (0);
 }
 
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 AscSetISAPNPWaitForKey(
     void)
-)
 {
     outp(ASC_ISA_PNP_PORT_ADDR, 0x02);
     outp(ASC_ISA_PNP_PORT_WRITE, 0x02);
@@ -10077,25 +9928,21 @@
 }
 #endif /* CONFIG_ISA */
 
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 AscToggleIRQAct(
                    PortAddr iop_base
 )
-)
 {
     AscSetChipStatus(iop_base, CIW_IRQ_ACT);
     AscSetChipStatus(iop_base, 0);
     return;
 }
 
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 AscGetChipIRQ(
                  PortAddr iop_base,
                  ushort bus_type
 )
-)
 {
     ushort              cfg_lsw;
     uchar               chip_irq;
@@ -10125,14 +9972,12 @@
     return ((uchar) (chip_irq + ASC_MIN_IRQ_NO));
 }
 
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 AscSetChipIRQ(
                  PortAddr iop_base,
                  uchar irq_no,
                  ushort bus_type
 )
-)
 {
     ushort              cfg_lsw;
 
@@ -10167,12 +10012,10 @@
 }
 
 #ifdef CONFIG_ISA
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 AscEnableIsaDma(
                    uchar dma_channel
 )
-)
 {
     if (dma_channel < 4) {
         outp(0x000B, (ushort) (0xC0 | dma_channel));
@@ -11910,12 +11753,10 @@
 }
 
 #ifdef CONFIG_ISA
-ASC_INITFUNC(
-STATIC ASC_DCNT,
+STATIC ASC_DCNT __init
 AscGetEisaProductID(
                        PortAddr iop_base
 )
-)
 {
     PortAddr            eisa_iop;
     ushort              product_id_high, product_id_low;
@@ -11929,12 +11770,10 @@
     return (product_id);
 }
 
-ASC_INITFUNC(
-STATIC PortAddr,
+STATIC PortAddr __init
 AscSearchIOPortAddrEISA(
                            PortAddr iop_base
 )
-)
 {
     ASC_DCNT            eisa_product_id;
 
@@ -12128,12 +11967,10 @@
     return (AscIsChipHalted(iop_base));
 }
 
-ASC_INITFUNC(
-STATIC ASC_DCNT,
+STATIC ASC_DCNT __init
 AscGetMaxDmaCount(
                      ushort bus_type
 )
-)
 {
     if (bus_type & ASC_IS_ISA)
         return (ASC_MAX_ISA_DMA_COUNT);
@@ -12143,12 +11980,10 @@
 }
 
 #ifdef CONFIG_ISA
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscGetIsaDmaChannel(
                        PortAddr iop_base
 )
-)
 {
     ushort              channel;
 
@@ -12160,13 +11995,11 @@
     return (channel + 4);
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscSetIsaDmaChannel(
                        PortAddr iop_base,
                        ushort dma_channel
 )
-)
 {
     ushort              cfg_lsw;
     uchar               value;
@@ -12184,13 +12017,11 @@
     return (0);
 }
 
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 AscSetIsaDmaSpeed(
                      PortAddr iop_base,
                      uchar speed_value
 )
-)
 {
     speed_value &= 0x07;
     AscSetBank(iop_base, 1);
@@ -12199,12 +12030,10 @@
     return (AscGetIsaDmaSpeed(iop_base));
 }
 
-ASC_INITFUNC(
-STATIC uchar,
+STATIC uchar __init
 AscGetIsaDmaSpeed(
                      PortAddr iop_base
 )
-)
 {
     uchar               speed_value;
 
@@ -12216,12 +12045,10 @@
 }
 #endif /* CONFIG_ISA */
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscReadPCIConfigWord(
     ASC_DVC_VAR *asc_dvc,
     ushort pci_config_offset)
-)
 {
     uchar       lsb, msb;
 
@@ -12230,12 +12057,10 @@
     return ((ushort) ((msb << 8) | lsb));
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscInitGetConfig(
         ASC_DVC_VAR *asc_dvc
 )
-)
 {
     ushort              warn_code;
     PortAddr            iop_base;
@@ -12315,12 +12140,10 @@
     return(warn_code);
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscInitSetConfig(
                     ASC_DVC_VAR *asc_dvc
 )
-)
 {
     ushort              warn_code = 0;
 
@@ -12336,12 +12159,10 @@
     return (warn_code);
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscInitFromAscDvcVar(
                         ASC_DVC_VAR *asc_dvc
 )
-)
 {
     PortAddr            iop_base;
     ushort              cfg_msw;
@@ -12441,12 +12262,10 @@
     return (warn_code);
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscInitAscDvcVar(
                     ASC_DVC_VAR *asc_dvc
 )
-)
 {
     int                 i;
     PortAddr            iop_base;
@@ -12556,12 +12375,10 @@
     return (warn_code);
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscInitFromEEP(
                   ASC_DVC_VAR *asc_dvc
 )
-)
 {
     ASCEEP_CONFIG       eep_config_buf;
     ASCEEP_CONFIG       *eep_config;
@@ -12777,12 +12594,10 @@
     return (warn_code);
 }
 
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AscTestExternalLram(
                        ASC_DVC_VAR *asc_dvc
 )
-)
 {
     PortAddr            iop_base;
     ushort              q_addr;
@@ -12804,13 +12619,11 @@
     return (sta);
 }
 
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AscWriteEEPCmdReg(
                      PortAddr iop_base,
                      uchar cmd_reg
 )
-)
 {
     uchar               read_back;
     int                 retry;
@@ -12829,13 +12642,11 @@
     }
 }
 
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AscWriteEEPDataReg(
                       PortAddr iop_base,
                       ushort data_reg
 )
-)
 {
     ushort              read_back;
     int                 retry;
@@ -12854,35 +12665,29 @@
     }
 }
 
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 AscWaitEEPRead(
                   void
 )
-)
 {
     DvcSleepMilliSecond(1);
     return;
 }
 
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 AscWaitEEPWrite(
                    void
 )
-)
 {
     DvcSleepMilliSecond(20);
     return;
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscReadEEPWord(
                   PortAddr iop_base,
                   uchar addr
 )
-)
 {
     ushort              read_wval;
     uchar               cmd_reg;
@@ -12897,14 +12702,12 @@
     return (read_wval);
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscWriteEEPWord(
                    PortAddr iop_base,
                    uchar addr,
                    ushort word_val
 )
-)
 {
     ushort              read_wval;
 
@@ -12924,13 +12727,11 @@
     return (read_wval);
 }
 
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AscGetEEPConfig(
                    PortAddr iop_base,
                    ASCEEP_CONFIG * cfg_buf, ushort bus_type
 )
-)
 {
     ushort              wval;
     ushort              sum;
@@ -12976,13 +12777,11 @@
     return (sum);
 }
 
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AscSetEEPConfigOnce(
                        PortAddr iop_base,
                        ASCEEP_CONFIG * cfg_buf, ushort bus_type
 )
-)
 {
     int                 n_error;
     ushort              *wbuf;
@@ -13074,13 +12873,11 @@
     return (n_error);
 }
 
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AscSetEEPConfig(
                    PortAddr iop_base,
                    ASCEEP_CONFIG * cfg_buf, ushort bus_type
 )
-)
 {
     int            retry;
     int            n_error;
@@ -14518,7 +14315,7 @@
  * unswapped on big-endian platforms.
  */
 STATIC ADVEEP_3550_CONFIG
-Default_3550_EEPROM_Config ASC_INITDATA = {
+Default_3550_EEPROM_Config __initdata = {
     ADV_EEPROM_BIOS_ENABLE,     /* cfg_lsw */
     0x0000,                     /* cfg_msw */
     0xFFFF,                     /* disc_enable */
@@ -14556,7 +14353,7 @@
 };
 
 STATIC ADVEEP_3550_CONFIG
-ADVEEP_3550_Config_Field_IsChar ASC_INITDATA = {
+ADVEEP_3550_Config_Field_IsChar __initdata = {
     0,                          /* cfg_lsw */
     0,                          /* cfg_msw */
     0,                          /* -disc_enable */
@@ -14594,7 +14391,7 @@
 };
 
 STATIC ADVEEP_38C0800_CONFIG
-Default_38C0800_EEPROM_Config ASC_INITDATA = {
+Default_38C0800_EEPROM_Config __initdata = {
     ADV_EEPROM_BIOS_ENABLE,     /* 00 cfg_lsw */
     0x0000,                     /* 01 cfg_msw */
     0xFFFF,                     /* 02 disc_enable */
@@ -14659,7 +14456,7 @@
 };
 
 STATIC ADVEEP_38C0800_CONFIG
-ADVEEP_38C0800_Config_Field_IsChar ASC_INITDATA = {
+ADVEEP_38C0800_Config_Field_IsChar __initdata = {
     0,                          /* 00 cfg_lsw */
     0,                          /* 01 cfg_msw */
     0,                          /* 02 disc_enable */
@@ -14724,7 +14521,7 @@
 };
 
 STATIC ADVEEP_38C1600_CONFIG
-Default_38C1600_EEPROM_Config ASC_INITDATA = {
+Default_38C1600_EEPROM_Config __initdata = {
     ADV_EEPROM_BIOS_ENABLE,     /* 00 cfg_lsw */
     0x0000,                     /* 01 cfg_msw */
     0xFFFF,                     /* 02 disc_enable */
@@ -14789,7 +14586,7 @@
 };
 
 STATIC ADVEEP_38C1600_CONFIG
-ADVEEP_38C1600_Config_Field_IsChar ASC_INITDATA = {
+ADVEEP_38C1600_Config_Field_IsChar __initdata = {
     0,                          /* 00 cfg_lsw */
     0,                          /* 01 cfg_msw */
     0,                          /* 02 disc_enable */
@@ -14861,10 +14658,8 @@
  * For a non-fatal error return a warning code. If there are no warnings
  * then 0 is returned.
  */
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AdvInitGetConfig(ADV_DVC_VAR *asc_dvc)
-)
 {
     ushort      warn_code;
     AdvPortAddr iop_base;
@@ -16848,10 +16643,8 @@
  *
  * Note: Chip is stopped on entry.
  */
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AdvInitFrom3550EEP(ADV_DVC_VAR *asc_dvc)
-)
 {
     AdvPortAddr         iop_base;
     ushort              warn_code;
@@ -17022,10 +16815,8 @@
  *
  * Note: Chip is stopped on entry.
  */
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AdvInitFrom38C0800EEP(ADV_DVC_VAR *asc_dvc)
-)
 {
     AdvPortAddr              iop_base;
     ushort                   warn_code;
@@ -17257,10 +17048,8 @@
  *
  * Note: Chip is stopped on entry.
  */
-ASC_INITFUNC(
-STATIC int,
+STATIC int __init
 AdvInitFrom38C1600EEP(ADV_DVC_VAR *asc_dvc)
-)
 {
     AdvPortAddr              iop_base;
     ushort                   warn_code;
@@ -17525,10 +17314,8 @@
  *
  * Return a checksum based on the EEPROM configuration read.
  */
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AdvGet3550EEPConfig(AdvPortAddr iop_base, ADVEEP_3550_CONFIG *cfg_buf)
-)
 {
     ushort              wval, chksum;
     ushort              *wbuf;
@@ -17573,11 +17360,9 @@
  *
  * Return a checksum based on the EEPROM configuration read.
  */
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AdvGet38C0800EEPConfig(AdvPortAddr iop_base,
                        ADVEEP_38C0800_CONFIG *cfg_buf)
-)
 {
     ushort              wval, chksum;
     ushort              *wbuf;
@@ -17622,11 +17407,9 @@
  *
  * Return a checksum based on the EEPROM configuration read.
  */
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AdvGet38C1600EEPConfig(AdvPortAddr iop_base,
                        ADVEEP_38C1600_CONFIG *cfg_buf)
-)
 {
     ushort              wval, chksum;
     ushort              *wbuf;
@@ -17669,10 +17452,8 @@
 /*
  * Read the EEPROM from specified location
  */
-ASC_INITFUNC(
-STATIC ushort,
+STATIC ushort __init
 AdvReadEEPWord(AdvPortAddr iop_base, int eep_word_addr)
-)
 {
     AdvWriteWordRegister(iop_base, IOPW_EE_CMD,
         ASC_EEP_CMD_READ | eep_word_addr);
@@ -17683,10 +17464,8 @@
 /*
  * Wait for EEPROM command to complete
  */
-ASC_INITFUNC(
-STATIC void,
+STATIC void __init
 AdvWaitEEPCmd(AdvPortAddr iop_base)
-)
 {
     int eep_delay_ms;
 
