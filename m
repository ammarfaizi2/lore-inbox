Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTARQOp>; Sat, 18 Jan 2003 11:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbTARQOp>; Sat, 18 Jan 2003 11:14:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41961 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264883AbTARQNw>; Sat, 18 Jan 2003 11:13:52 -0500
Date: Sat, 18 Jan 2003 17:22:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: groudier@free.fr, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] MegaRAID driver: remove kernel 2.0 and 2.2 code
Message-ID: <20030118162243.GF10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes obsolete #if'd code for kernel 2.0 and 2.2 from
drivers/scsi/megaraid.{h,c} (this includes the expansion of some
#define's that were definded differently for different kernel versions).

I've tested the compilation with 2.5.59.

Please apply
Adrian


--- linux-2.5.59-full/drivers/scsi/megaraid.h.old	2003-01-18 16:46:52.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/megaraid.h	2003-01-18 16:48:28.000000000 +0100
@@ -1,10 +1,6 @@
 #ifndef __MEGARAID_H__
 #define __MEGARAID_H__
 
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
 /*
  * For state flag. Do not use LSB(8 bits) which are
  * reserved for storing info about channels.
@@ -180,31 +176,6 @@
 #define AMI_SIGNATURE_471	  	0xCCCC
 #define AMI_64BIT_SIGNATURE		0x0299
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)	/*0x20100 */
-#define MEGARAID \
-  { NULL,			      	/* Next				*/\
-    NULL,			        /* Usage Count Pointer		*/\
-    NULL,			       	/* proc Directory Entry		*/\
-    megaraid_proc_info,		 	/* proc Info Function		*/\
-    "MegaRAID",			 	/* Driver Name			*/\
-    megaraid_detect,		    	/* Detect Host Adapter		*/\
-    megaraid_release,		   	/* Release Host Adapter		*/\
-    megaraid_info,		      	/* Driver Info Function		*/\
-    megaraid_command,		   	/* Command Function		*/\
-    megaraid_queue,		     	/* Queue Command Function	*/\
-    megaraid_abort,		     	/* Abort Command Function	*/\
-    megaraid_reset,		     	/* Reset Command Function	*/\
-    NULL,			       	/* Slave Attach Function	*/\
-    megaraid_biosparam,		 	/* Disk BIOS Parameters		*/\
-    MAX_COMMANDS,		       	/* # of cmds that can be\
-					outstanding at any time		*/\
-    7,				  	/* HBA Target ID		*/\
-    MAX_SGLIST,			 	/* Scatter/Gather Table Size	*/\
-    MAX_CMD_PER_LUN,		    	/* SCSI Commands per LUN	*/\
-    0,				  	/* Present			*/\
-    0,				  	/* Default Unchecked ISA DMA	*/\
-    ENABLE_CLUSTERING }			/* Enable Clustering		*/
-#else
 #define MEGARAID \
   {\
     .name	    	= "MegaRAID",		/* Driver Name			*/\
@@ -224,7 +195,6 @@
     .use_clustering   	= ENABLE_CLUSTERING,  	/* Enable Clustering		*/\
 	.highmem_io		= 1,													\
   }
-#endif
 
 /***********************************************************************
  * Structure Declarations for the Firmware supporting 40 Logical Drives
@@ -470,14 +440,13 @@
 #define ENQ_FCLOOP_ACTIVE	1
 #define ENQ_FCLOOP_TRANSIENT	2
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 #define M_RD_DMA_TYPE_NONE	      	0xFFFF
 #define M_RD_PTHRU_WITH_BULK_DATA   	0x0001
 #define M_RD_PTHRU_WITH_SGLIST	  	0x0002
 #define M_RD_BULK_DATA_ONLY	     	0x0004
 #define M_RD_SGLIST_ONLY		0x0008
 #define M_RD_EPTHRU_WITH_BULK_DATA   	0x0010
-#endif
+
 /********************************************
  * ENQUIRY3
  ********************************************/
@@ -663,7 +632,6 @@
 	u32 state;
 	u32 isrcount;
 	u8 mboxData[16];
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	u32 dma_type;
 	dma_addr_t dma_h_bulkdata;	/*Dma handle for bulk data transfter */
 	u32 dma_direction;	/*Dma direction */
@@ -675,16 +643,8 @@
 	dma_addr_t dma_ext_passthruhandle64;
 	dma_addr_t dma_bounce_buffer;
 	u8 *bounce_buffer;
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	mega_passthru *pthru;
 	mega_ext_passthru *epthru;
-#else
-	mega_passthru pthru;
-	mega_ext_passthru epthru;
-#endif
-
 	Scsi_Cmnd *SCpnt;
 	mega_sglist *sgList;
 	mega_64sglist *sg64List;
@@ -713,10 +673,8 @@
 	u32 base;
 #endif
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	dma_addr_t dma_handle64, adjdmahandle64;
 	struct pci_dev *dev;
-#endif
 
 	mega_scb *qFreeH;
 	mega_scb *qFreeT;
@@ -748,12 +706,8 @@
 	volatile mega_mailbox64 *mbox64;	/* ptr to beginning of 64-bit mailbox */
 	volatile mega_mailbox *mbox;	/* ptr to beginning of standard mailbox */
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 /* ptr to beginning of standard mailbox */
 	volatile mega_mailbox64 *mailbox64ptr;
-#else
-	volatile mega_mailbox64 mailbox64;
-#endif
 
 	volatile u8 mega_buffer[2 * 1024L];
 	volatile megaRaidProductInfo productInfo;
@@ -880,10 +834,6 @@
 #define MKADAP(adapno)	  	(MEGAIOC_MAGIC << 8 | (adapno) )
 #define GETADAP(mkadap)	 	( (mkadap) ^ MEGAIOC_MAGIC << 8 )
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)	/*0x20300 */
-extern struct proc_dir_entry proc_scsi_megaraid;
-#endif
-
 /* For Host Re-Ordering */
 #define MAX_CONTROLLERS	32
 
@@ -968,11 +918,6 @@
 
 static int megaraid_reboot_notify (struct notifier_block *,
 				   unsigned long, void *);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)  
-static mega_scb *mega_ioctl (mega_host_config * megaCfg, Scsi_Cmnd * SCpnt);
-static void mega_build_kernel_sg (char *barea, ulong xfersize, mega_scb * pScb,
-			   mega_ioctl_mbox * mbox);
-#endif
 
 static int megadev_ioctl_entry (struct inode *, struct file *,
 				unsigned int, unsigned long);
--- linux-2.5.59-full/drivers/scsi/megaraid.c.old	2003-01-18 16:19:33.000000000 +0100
+++ linux-2.5.59-full/drivers/scsi/megaraid.c	2003-01-18 17:11:47.000000000 +0100
@@ -461,9 +461,6 @@
  *
  *
  * BUGS:
- *     Some older 2.1 kernels (eg. 2.1.90) have a bug in pci.c that
- *     fails to detect the controller as a pci device on the system.
- *
  *     Timeout period for upper scsi layer, i.e. SD_TIMEOUT in
  *     /drivers/scsi/sd.c, is too short for this controller. SD_TIMEOUT
  *     value must be increased to (30 * HZ) otherwise false timeouts
@@ -473,8 +470,6 @@
  *     to properly check the vendor subid in some cases. Setting this then
  *     makes it steal other i960's and crashes some boxes
  *
- *     Far too many ifdefs for versions.
- *
  *===================================================================*/
 
 #include <linux/config.h>
@@ -500,22 +495,12 @@
 #include <linux/sched.h>
 #include <linux/stat.h>
 #include <linux/slab.h>	/* for kmalloc() */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)	/* 0x20100 */
-#include <linux/bios32.h>
-#else
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)	/* 0x20300 */
-#include <asm/spinlock.h>
-#else
 #include <linux/spinlock.h>
-#endif
-#endif
+#include <linux/smp.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
-
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,0,24)	/* 0x020024 */
 #include <asm/uaccess.h>
-#endif
 
 /*
  * These header files are required for Shutdown Notification routines
@@ -558,145 +543,10 @@
 	writel (value, megaCfg->base + 0x2C);
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)	/* 0x020200 */
-#include <linux/smp.h>
-#define cpuid smp_processor_id()
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-#define scsi_set_pci_device(x,y)
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/* 0x020400 */
-
-/*
- *	Linux 2.4 and higher
- *
- *	No driver private lock
- *	Use the io_request_lock not cli/sti
- *	queue task is a simple api without irq forms
- */
-
 MODULE_AUTHOR ("LSI Logic Corporation");
 MODULE_DESCRIPTION ("LSI Logic MegaRAID driver");
 MODULE_LICENSE ("GPL");
 
-#define DRIVER_LOCK_T
-#define DRIVER_LOCK_INIT(p)
-#define DRIVER_LOCK(p)
-#define DRIVER_UNLOCK(p)
-#define IO_LOCK_T unsigned long io_flags = 0
-#define IO_LOCK(host) spin_lock_irqsave(host->host_lock,io_flags)
-#define IO_UNLOCK(host) spin_unlock_irqrestore(host->host_lock,io_flags)
-#define IO_LOCK_IRQ(host) spin_lock_irq(host->host_lock)
-#define IO_UNLOCK_IRQ(host) spin_unlock_irq(host->host_lock)
-
-#define queue_task_irq(a,b)     queue_task(a,b)
-#define queue_task_irq_off(a,b) queue_task(a,b)
-
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)	/* 0x020200 */
-
-/*
- *	Linux 2.2 and higher
- *
- *	No driver private lock
- *	Use the io_request_lock not cli/sti
- *	No pci region api
- *	queue_task is now a single simple API
- */
-
-static char kernel_version[] = UTS_RELEASE;
-MODULE_AUTHOR ("LSI Logic Corporation");
-MODULE_DESCRIPTION ("LSI Logic MegaRAID driver");
-
-#define DRIVER_LOCK_T
-#define DRIVER_LOCK_INIT(p)
-#define DRIVER_LOCK(p)
-#define DRIVER_UNLOCK(p)
-#define IO_LOCK_T unsigned long io_flags = 0
-#define IO_LOCK(host) spin_lock_irqsave(host->host_lock,io_flags);
-#define IO_UNLOCK(host) spin_unlock_irqrestore(host->host_lock,io_flags);
-
-#define pci_free_consistent(a,b,c,d)
-#define pci_unmap_single(a,b,c,d)
-#define pci_enable_device(x) (0)
-#define queue_task_irq(a,b)     queue_task(a,b)
-#define queue_task_irq_off(a,b) queue_task(a,b)
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,19)	/* 0x020219 */
-#define init_MUTEX_LOCKED(x)    (*(x)=MUTEX_LOCKED)
-#define init_MUTEX(x)           (*(x)=MUTEX)
-#define DECLARE_WAIT_QUEUE_HEAD(x)	struct wait_queue *x = NULL
-#endif
-
-
-#else
-
-/*
- *	Linux 2.0 macros. Here we have to provide some of our own
- *	functionality. We also only work little endian 32bit.
- *	Again no pci_alloc/free api
- *	IO_LOCK/IO_LOCK_T were never used in 2.0 so now are empty 
- */
- 
-#define cpuid 0
-#define DRIVER_LOCK_T long cpu_flags;
-#define DRIVER_LOCK_INIT(p)
-#define DRIVER_LOCK(p) \
-       		save_flags(cpu_flags); \
-       		cli();
-#define DRIVER_UNLOCK(p) \
-       		restore_flags(cpu_flags);
-#define IO_LOCK_T
-#define IO_LOCK(p)
-#define IO_UNLOCK(p)
-#define le32_to_cpu(x) (x)
-#define cpu_to_le32(x) (x)
-
-#define pci_free_consistent(a,b,c,d)
-#define pci_unmap_single(a,b,c,d)
-
-#define init_MUTEX_LOCKED(x)    (*(x)=MUTEX_LOCKED)
-#define init_MUTEX(x)           (*(x)=MUTEX)
-
-#define pci_enable_device(x) (0)
-
-/*
- *	2.0 lacks spinlocks, iounmap/ioremap
- */
-
-#define ioremap vremap
-#define iounmap vfree
-
- /* simulate spin locks */
-typedef struct {
-	volatile char lock;
-} spinlock_t;
-
-#define spin_lock_init(x) { (x)->lock = 0;}
-#define spin_lock_irqsave(x,flags) { while ((x)->lock) barrier();\
-                                        (x)->lock=1; save_flags(flags);\
-                                        cli();}
-#define spin_unlock_irqrestore(x,flags) { (x)->lock=0; restore_flags(flags);}
-
-#define DECLARE_WAIT_QUEUE_HEAD(x)	struct wait_queue *x = NULL
-
-#endif
-
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/* 0x020400 */
-#define dma_alloc_consistent pci_alloc_consistent
-#define dma_free_consistent pci_free_consistent
-#else
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,19)	/* 0x020219 */
-typedef unsigned long dma_addr_t;
-#endif
-void *dma_alloc_consistent(void *, size_t, dma_addr_t *);
-void dma_free_consistent(void *, size_t, void *, dma_addr_t);
-int mega_get_order(int);
-int pow_2(int);
-#endif
-
 /* set SERDEBUG to 1 to enable serial debugging */
 #define SERDEBUG 0
 #if SERDEBUG
@@ -731,11 +581,9 @@
     processor id cannot be scanned */
 
 static char *megaraid;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,0)	/* 0x20100 */
-#ifdef MODULE
+
 MODULE_PARM (megaraid, "s");
-#endif
-#endif
+
 static int skip_id = -1;
 static int numCtlrs = 0;
 static mega_host_config *megaCtlrs[FC_MAX_CHANNELS] = { 0 };
@@ -785,13 +633,6 @@
 volatile static spinlock_t serial_lock;
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)	/* 0x20300 */
-static struct proc_dir_entry proc_scsi_megaraid = {
-	PROC_SCSI_MEGARAID, 8, "megaraid",
-	S_IFDIR | S_IRUGO | S_IXUGO, 2
-};
-#endif
-
 #ifdef CONFIG_PROC_FS
 extern struct proc_dir_entry proc_root;
 #endif
@@ -887,7 +728,6 @@
 	if ((pScb == NULL) || (pScb->idx >= 0xFE)) {
 		return;
 	}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	switch (pScb->dma_type) {
 	case M_RD_DMA_TYPE_NONE:
 		break;
@@ -927,7 +767,6 @@
 	default:
 		break;
 	}
-#endif
 
 	/* Unlink from pending queue */
 	if (pScb == megaCfg->qPendingH) {
@@ -990,10 +829,7 @@
 		pScb->next = NULL;
 		pScb->state = SCB_ACTIVE;
 		pScb->SCpnt = SCpnt;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		pScb->dma_type = M_RD_DMA_TYPE_NONE;
-#endif
 
 		return pScb;
 	}
@@ -1059,13 +895,8 @@
 
 	SCpnt = pScb->SCpnt;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	pthru = pScb->pthru;
 	epthru = pScb->epthru;
-#else
-	pthru = &pScb->pthru;
-	epthru = &pScb->epthru;
-#endif
 
 	mbox = (mega_mailbox *) & pScb->mboxData;
 
@@ -1083,7 +914,6 @@
 	islogical = (SCpnt->channel == megaCfg->host->max_channel);
 #endif
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	/* Special Case to handle PassThrough->XferAddrress > 4GB */
 	switch (SCpnt->cmnd[0]) {
 	case INQUIRY:
@@ -1092,7 +922,6 @@
 			pScb->bounce_buffer, SCpnt->request_bufflen);
 		break;
 	}
-#endif
 
 	mega_freeSCB (megaCfg, pScb);
 
@@ -1214,15 +1043,11 @@
 
 	if ((SCpnt->cmnd[0] == M_RD_IOCTL_CMD)
 		    || (SCpnt->cmnd[0] == M_RD_IOCTL_CMD_NEW))
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)  
-		return mega_ioctl (megaCfg, SCpnt);	/* Handle IOCTL command */
-#else
 	{
 		printk(KERN_WARNING "megaraid ioctl: older interface - "
 				"not supported.\n");
 		return NULL;
 	}
-#endif
 
 	islogical = ( (SCpnt->channel >= megaCfg->productInfo.SCSIChanPresent) &&
 					(SCpnt->channel <= megaCfg->host->max_channel) );
@@ -1320,12 +1145,7 @@
 				callDone (SCpnt);
 				return NULL;
 			}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			pthru = pScb->pthru;
-#else
-			pthru = &pScb->pthru;
-#endif
-
 			mbox = (mega_mailbox *) & pScb->mboxData;
 			memset (mbox, 0, sizeof (pScb->mboxData));
 			memset (pthru, 0, sizeof (mega_passthru));
@@ -1336,7 +1156,6 @@
 			pthru->logdrv = lun;
 			pthru->cdblen = SCpnt->cmd_len;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			/*Not sure about the direction */
 			pScb->dma_direction = PCI_DMA_BIDIRECTIONAL;
 			pScb->dma_type = M_RD_PTHRU_WITH_BULK_DATA;
@@ -1356,23 +1175,14 @@
 			pScb->dma_type = M_RD_DMA_TYPE_NONE;
 #endif
 
-#else
-			pthru->dataxferaddr =
-			    virt_to_bus (SCpnt->request_buffer);
-#endif
-
 			pthru->dataxferlen = SCpnt->request_bufflen;
 			memcpy (pthru->cdb, SCpnt->cmnd, SCpnt->cmd_len);
 
 			/* Initialize mailbox area */
 			mbox->cmd = MEGA_MBOXCMD_PASSTHRU;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			mbox->xferaddr = pScb->dma_passthruhandle64;
 			TRACE1 (("M_RD_PTHRU_WITH_BULK_DATA Enabled \n"));
-#else
-			mbox->xferaddr = virt_to_bus (pthru);
-#endif
 			return pScb;
 
 		case READ_6:
@@ -1469,20 +1279,17 @@
 				}
 			}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			if (*SCpnt->cmnd == READ_6 || *SCpnt->cmnd == READ_10
 					|| *SCpnt->cmnd == READ_12) {
 				pScb->dma_direction = PCI_DMA_FROMDEVICE;
 			} else {	/*WRITE_6 or WRITE_10 */
 				pScb->dma_direction = PCI_DMA_TODEVICE;
 			}
-#endif
 
 			/* Calculate Scatter-Gather info */
 			mbox->numsgelements = mega_build_sglist (megaCfg, pScb,
 								 (u32 *)&mbox->xferaddr, (u32 *)&seg);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			pScb->iDataSize = seg;
 
 			if (mbox->numsgelements) {
@@ -1492,7 +1299,6 @@
 				pScb->dma_type = M_RD_BULK_DATA_ONLY;
 				TRACE1 (("M_RD_BULK_DATA_ONLY Enabled \n"));
 			}
-#endif
 
 			return pScb;
 		default:
@@ -1520,7 +1326,6 @@
 		if ( megaCfg->support_ext_cdb && SCpnt->cmd_len > 10 ) {
 			epthru = mega_prepare_extpassthru(megaCfg, pScb, SCpnt);
 			mbox->cmd = MEGA_MBOXCMD_EXTPASSTHRU;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			mbox->xferaddr = pScb->dma_ext_passthruhandle64;
 
 			if(epthru->numsgelements) {
@@ -1528,16 +1333,12 @@
 			} else {
 				pScb->dma_type = M_RD_EPTHRU_WITH_BULK_DATA;
 			}
-#else
-			mbox->xferaddr = virt_to_bus(epthru);
-#endif
 		}
 		else {
 			pthru = mega_prepare_passthru(megaCfg, pScb, SCpnt);
 
 			/* Initialize mailbox */
 			mbox->cmd = MEGA_MBOXCMD_PASSTHRU;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			mbox->xferaddr = pScb->dma_passthruhandle64;
 
 			if (pthru->numsgelements) {
@@ -1545,9 +1346,6 @@
 			} else {
 				pScb->dma_type = M_RD_PTHRU_WITH_BULK_DATA;
 			}
-#else
-			mbox->xferaddr = virt_to_bus(pthru);
-#endif
 		}
 		return pScb;
 	}
@@ -1597,11 +1395,7 @@
 {
 	mega_passthru *pthru;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	pthru = scb->pthru;
-#else
-	pthru = &scb->pthru;
-#endif
 	memset (pthru, 0, sizeof (mega_passthru));
 
 	/* set adapter timeout value to 10 min. for tape drive	*/
@@ -1618,7 +1412,6 @@
 
 	memcpy (pthru->cdb, sc->cmnd, sc->cmd_len);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	/* Not sure about the direction */
 	scb->dma_direction = PCI_DMA_BIDIRECTIONAL;
 
@@ -1638,13 +1431,6 @@
 			);
 		break;
 	}
-#else
-	pthru->numsgelements =
-		mega_build_sglist(
-			megacfg, scb, (u32 *)&pthru->dataxferaddr,
-			(u32 *)&pthru->dataxferlen
-		);
-#endif
 	return pthru;
 }
 
@@ -1653,11 +1439,7 @@
 {
 	mega_ext_passthru *epthru;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	epthru = scb->epthru;
-#else
-	epthru = &scb->epthru;
-#endif
 	memset(epthru, 0, sizeof(mega_ext_passthru));
 
 	/* set adapter timeout value to 10 min. for tape drive	*/
@@ -1674,7 +1456,6 @@
 
 	memcpy(epthru->cdb, sc->cmnd, sc->cmd_len);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	/* Not sure about the direction */
 	scb->dma_direction = PCI_DMA_BIDIRECTIONAL;
 
@@ -1694,13 +1475,6 @@
 			);
 		break;
 	}
-#else
-	epthru->numsgelements =
-		mega_build_sglist(
-			megacfg, scb, (u32 *)&epthru->dataxferaddr,
-			(u32 *)&epthru->dataxferlen
-		);
-#endif
 	return epthru;
 }
 
@@ -1742,7 +1516,6 @@
 		    mega_ioctl_mbox * mbox, u32 direction)
 {
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	switch (direction) {
 	case TO_DEVICE:
 		pScb->dma_direction = PCI_DMA_TODEVICE;
@@ -1762,276 +1535,8 @@
 	mbox->xferaddr = pScb->dma_h_bulkdata;
 	pScb->dma_type = M_RD_BULK_DATA_ONLY;
 	TRACE1 (("M_RD_BULK_DATA_ONLY Enabled \n"));
-#else
-	mbox->xferaddr = virt_to_bus (pScb->buff_ptr);
-#endif
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-
-/*--------------------------------------------------------------------
- * build RAID commands for controller, passed down through ioctl()
- *--------------------------------------------------------------------*/
-static mega_scb *mega_ioctl (mega_host_config * megaCfg, Scsi_Cmnd * SCpnt)
-{
-	mega_scb *pScb;
-	mega_ioctl_mbox *mbox;
-	mega_mailbox *mailbox;
-	mega_passthru *pthru;
-	u8 *mboxdata;
-	long seg, i = 0;
-	unsigned char *data = (unsigned char *) SCpnt->request_buffer;
-
-	if ((pScb = mega_allocateSCB (megaCfg, SCpnt)) == NULL) {
-		SCpnt->result = (DID_ERROR << 16);
-		callDone (SCpnt);
-		return NULL;
-	}
-	pthru = &pScb->pthru;
-
-	mboxdata = (u8 *) & pScb->mboxData;
-	mbox = (mega_ioctl_mbox *) & pScb->mboxData;
-	mailbox = (mega_mailbox *) & pScb->mboxData;
-	memset (mailbox, 0, sizeof (pScb->mboxData));
-
-	if (data[0] == 0x03) {	/* passthrough command */
-		unsigned char cdblen = data[2];
-		memset (pthru, 0, sizeof (mega_passthru));
-		pthru->islogical = (data[cdblen + 3] & 0x80) ? 1 : 0;
-		pthru->timeout = data[cdblen + 3] & 0x07;
-		pthru->reqsenselen = 14;
-		pthru->ars = (data[cdblen + 3] & 0x08) ? 1 : 0;
-		pthru->logdrv = data[cdblen + 4];
-		pthru->channel = data[cdblen + 5];
-		pthru->target = data[cdblen + 6];
-		pthru->cdblen = cdblen;
-		memcpy (pthru->cdb, &data[3], cdblen);
-
-		mailbox->cmd = MEGA_MBOXCMD_PASSTHRU;
-
-
-		pthru->numsgelements = mega_build_sglist (megaCfg, pScb,
-							  (u32 *) & pthru->
-							  dataxferaddr,
-							  (u32 *) & pthru->
-							  dataxferlen);
-
-		mailbox->xferaddr = virt_to_bus (pthru);
-
-		for (i = 0; i < (SCpnt->request_bufflen - cdblen - 7); i++) {
-			data[i] = data[i + cdblen + 7];
-		}
-		return pScb;
-	}
-	/* else normal (nonpassthru) command */
-
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,0,24)	/*0x020024 */
-	/*
-	 *usage of the function copy from user is used in case of data more than
-	 *4KB.This is used only with adapters which supports more than 8 logical
-	 * drives.This feature is disabled on kernels earlier or same as 2.0.36
-	 * as the uaccess.h file is not available with those kernels.
-	 */
-
-	if (SCpnt->cmnd[0] == M_RD_IOCTL_CMD_NEW) {
-		/* use external data area for large xfers  */
-		/* If cmnd[0] is set to M_RD_IOCTL_CMD_NEW then *
-		 *   cmnd[4..7] = external user buffer     *
-		 *   cmnd[8..11] = length of buffer        *
-		 *                                         */
-      	char *user_area = (char *)*((u32*)&SCpnt->cmnd[4]);
-		u32 xfer_size = *((u32 *) & SCpnt->cmnd[8]);
-		switch (data[0]) {
-		case FW_FIRE_WRITE:
-		case FW_FIRE_FLASH:
-			if ((ulong) user_area & (PAGE_SIZE - 1)) {
-				printk
-				    ("megaraid:user address not aligned on 4K boundary.Error.\n");
-				SCpnt->result = (DID_ERROR << 16);
-				callDone (SCpnt);
-				return NULL;
-			}
-			break;
-		default:
-			break;
-		}
-
-		if (!(pScb->buff_ptr = kmalloc (xfer_size, GFP_KERNEL))) {
-			printk
-			    ("megaraid: Insufficient mem for M_RD_IOCTL_CMD_NEW.\n");
-			SCpnt->result = (DID_ERROR << 16);
-			callDone (SCpnt);
-			return NULL;
-		}
-
-		copy_from_user (pScb->buff_ptr, user_area, xfer_size);
-		pScb->iDataSize = xfer_size;
-
-		switch (data[0]) {
-		case DCMD_FC_CMD:
-			switch (data[1]) {
-			case DCMD_FC_READ_NVRAM_CONFIG:
-			case DCMD_GET_DISK_CONFIG:
-				{
-					if ((ulong) pScb->
-					    buff_ptr & (PAGE_SIZE - 1)) {
-						printk
-						    ("megaraid:user address not sufficient Error.\n");
-						SCpnt->result =
-						    (DID_ERROR << 16);
-						callDone (SCpnt);
-						return NULL;
-					}
-
-					/*building SG list */
-					mega_build_kernel_sg (pScb->buff_ptr,
-							      xfer_size,
-							      pScb, mbox);
-					break;
-				}
-			default:
-				break;
-			}	/*switch (data[1]) */
-			break;
-		}
-
-	}
-#endif
-
-	mbox->cmd = data[0];
-	mbox->channel = data[1];
-	mbox->param = data[2];
-	mbox->pad[0] = data[3];
-	mbox->logdrv = data[4];
-
-	if (SCpnt->cmnd[0] == M_RD_IOCTL_CMD_NEW) {
-		switch (data[0]) {
-		case FW_FIRE_WRITE:
-			mbox->cmd = FW_FIRE_WRITE;
-			mbox->channel = data[1];	/* Current Block Number */
-			set_mbox_xfer_addr (megaCfg, pScb, mbox, TO_DEVICE);
-			mbox->numsgelements = 0;
-			break;
-		case FW_FIRE_FLASH:
-			mbox->cmd = FW_FIRE_FLASH;
-			mbox->channel = data[1] | 0x80;	/* Origin */
-			set_mbox_xfer_addr (megaCfg, pScb, mbox, TO_DEVICE);
-			mbox->numsgelements = 0;
-			break;
-		case DCMD_FC_CMD:
-			*(mboxdata + 0) = data[0];	/*mailbox byte 0: DCMD_FC_CMD */
-			*(mboxdata + 2) = data[1];	/*sub command */
-			switch (data[1]) {
-			case DCMD_FC_READ_NVRAM_CONFIG:
-			case DCMD_FC_READ_NVRAM_CONFIG_64:
-				/* number of elements in SG list */
-				*(mboxdata + 3) = mbox->numsgelements;
-				if (megaCfg->flag & BOARD_64BIT)
-					*(mboxdata + 2) =
-					    DCMD_FC_READ_NVRAM_CONFIG_64;
-				break;
-			case DCMD_WRITE_CONFIG:
-			case DCMD_WRITE_CONFIG_64:
-				if (megaCfg->flag & BOARD_64BIT)
-					*(mboxdata + 2) = DCMD_WRITE_CONFIG_64;
-				set_mbox_xfer_addr (megaCfg, pScb, mbox,
-						    TO_DEVICE);
-				mbox->numsgelements = 0;
-				break;
-			case DCMD_GET_DISK_CONFIG:
-			case DCMD_GET_DISK_CONFIG_64:
-				if (megaCfg->flag & BOARD_64BIT)
-					*(mboxdata + 2) =
-					    DCMD_GET_DISK_CONFIG_64;
-				*(mboxdata + 3) = data[2];	/*number of elements in SG list */
-				/*nr of elements in SG list */
-				*(mboxdata + 4) = mbox->numsgelements;
-				break;
-			case DCMD_DELETE_LOGDRV:
-			case DCMD_DELETE_DRIVEGROUP:
-			case NC_SUBOP_ENQUIRY3:
-				*(mboxdata + 3) = data[2];
-				set_mbox_xfer_addr (megaCfg, pScb, mbox,
-						    FROMTO_DEVICE);
-				mbox->numsgelements = 0;
-				break;
-			case DCMD_CHANGE_LDNO:
-			case DCMD_CHANGE_LOOPID:
-				*(mboxdata + 3) = data[2];
-				*(mboxdata + 4) = data[3];
-				set_mbox_xfer_addr (megaCfg, pScb, mbox,
-						    TO_DEVICE);
-				mbox->numsgelements = 0;
-				break;
-			default:
-				set_mbox_xfer_addr (megaCfg, pScb, mbox,
-						    FROMTO_DEVICE);
-				mbox->numsgelements = 0;
-				break;
-			}	/*switch */
-			break;
-		default:
-			set_mbox_xfer_addr (megaCfg, pScb, mbox, FROMTO_DEVICE);
-			mbox->numsgelements = 0;
-			break;
-		}
-	} else {
-
-		mbox->numsgelements = mega_build_sglist (megaCfg, pScb,
-							 (u32 *) & mbox->
-							 xferaddr,
-							 (u32 *) & seg);
-
-		/* Handling some of the fw special commands */
-		switch (data[0]) {
-		case 6:	/* START_DEV */
-			mbox->xferaddr = *((u32 *) & data[i + 6]);
-			break;
-		default:
-			break;
-		}
-
-		for (i = 0; i < (SCpnt->request_bufflen - 6); i++) {
-			data[i] = data[i + 6];
-		}
-	}
-
-	return (pScb);
-}
-
-
-static void mega_build_kernel_sg (char *barea, ulong xfersize, mega_scb * pScb, mega_ioctl_mbox * mbox)
-{
-	ulong i, buffer_area, len, end, end_page, x, idx = 0;
-
-	buffer_area = (ulong) barea;
-	i = buffer_area;
-	end = buffer_area + xfersize;
-	end_page = (end) & ~(PAGE_SIZE - 1);
-
-	do {
-		len = PAGE_SIZE - (i % PAGE_SIZE);
-		x = pScb->sgList[idx].address =
-		    virt_to_bus ((volatile void *) i);
-		pScb->sgList[idx].length = len;
-		i += len;
-		idx++;
-	} while (i < end_page);
-
-	if ((end - i) < 0) {
-		printk ("megaraid:Error in user address\n");
-	}
-
-	if (end - i) {
-		pScb->sgList[idx].address = virt_to_bus ((volatile void *) i);
-		pScb->sgList[idx].length = end - i;
-		idx++;
-	}
-	mbox->xferaddr = virt_to_bus (pScb->sgList);
-	mbox->numsgelements = idx;
-}
-#endif
-
 
 #if DEBUG
 static unsigned int cum_time = 0;
@@ -2058,7 +1563,7 @@
  *--------------------------------------------------------------------*/
 static void megaraid_isr (int irq, void *devp, struct pt_regs *regs)
 {
-	IO_LOCK_T;
+	unsigned long io_flags = 0;
 	mega_host_config * megaCfg;
 	u_char byte, idx, sIdx, tmpBox[MAILBOX_SIZE];
 	u32 dword = 0;
@@ -2103,7 +1608,7 @@
 		for (idx = 0; idx < MAX_FIRMWARE_STATUS; idx++)
 			completed[idx] = 0;
 
-		IO_LOCK(megaCfg->host);
+		spin_lock_irqsave(megaCfg->host->host_lock,io_flags);
 
 		megaCfg->nInterrupts++;
 		qCnt = 0xff;
@@ -2124,24 +1629,14 @@
 		if (megaCfg->flag & BOARD_QUARTZ) {
 			WROUTDOOR (megaCfg, dword);
 			/* Acknowledge interrupt */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-			/* In this case mbox contains physical address */
-#if 0
-			WRINDOOR (megaCfg, megaCfg->adjdmahandle64 | 0x2);
-#else
-			WRINDOOR (megaCfg, 0x2);
-#endif
-
-#else
 
+			/* mbox contains physical address */
 #if 0
-			WRINDOOR (megaCfg, virt_to_bus (megaCfg->mbox) | 0x2);
+			WRINDOOR (megaCfg, megaCfg->adjdmahandle64 | 0x2);
 #else
 			WRINDOOR (megaCfg, 0x2);
 #endif
 
-#endif
-
 #if 0
 			while (RDINDOOR (megaCfg) & 0x02) ;
 #endif
@@ -2222,7 +1717,7 @@
 		megaCfg->flag &= ~IN_ISR;
 		/* Loop through any pending requests */
 		mega_runpendq (megaCfg);
-		IO_UNLOCK(megaCfg->host);
+		spin_unlock_irqrestore(megaCfg->host->host_lock,io_flags);
 
 	}
 
@@ -2266,10 +1761,7 @@
 		mega_scb * pScb, int intr)
 {
 	volatile mega_mailbox *mbox = (mega_mailbox *) megaCfg->mbox;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	volatile mega_mailbox64 *mbox64 = (mega_mailbox64 *) megaCfg->mbox64;
-#endif
 
 	u_char byte;
 
@@ -2283,12 +1775,8 @@
 	mboxData[0x1] = (pScb ? pScb->idx + 1 : 0xFE);	/* Set cmdid */
 	mboxData[0xF] = 1;	/* Set busy */
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-	/* In this case mbox contains physical address */
+	/* mbox contains physical address */
 	phys_mbox = megaCfg->adjdmahandle64;
-#else
-	phys_mbox = virt_to_bus (megaCfg->mbox);
-#endif
 
 #if DEBUG
 	ShowMbox (pScb);
@@ -2320,7 +1808,6 @@
 
 	memcpy ((char *) mbox, mboxData, 16);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	switch (mboxData[0]) {
 	case MEGA_MBOXCMD_LREAD64:
 	case MEGA_MBOXCMD_LWRITE64:
@@ -2329,7 +1816,6 @@
 		mbox->xferaddr = 0xFFFFFFFF;
 		break;
 	}
-#endif
 
 	/* Kick IO */
 	if (intr) {
@@ -2416,10 +1902,7 @@
 {
 	struct scatterlist *sgList;
 	int idx;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	int sgcnt;
-#endif
 
 	mega_mailbox *mbox = NULL;
 
@@ -2427,7 +1910,6 @@
 	/* Scatter-gather not used */
 	if (scb->SCpnt->use_sg == 0) {
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		scb->dma_h_bulkdata = pci_map_single (megaCfg->dev,
 				      scb->SCpnt->request_buffer,
 				      scb->SCpnt->request_bufflen,
@@ -2448,10 +1930,6 @@
 			*buffer = scb->dma_h_bulkdata;
 			*length = (u32) scb->SCpnt->request_bufflen;
 		}
-#else
-		*buffer = virt_to_bus (scb->SCpnt->request_buffer);
-		*length = (u32) scb->SCpnt->request_bufflen;
-#endif
 		return 0;
 	}
 
@@ -2459,7 +1937,6 @@
 #if 0
 	if (scb->SCpnt->use_sg == 1) {
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		scb->dma_h_bulkdata = pci_map_single (megaCfg->dev,
 				      sgList[0].address,
 				      sgList[0].length, scb->dma_direction);
@@ -2477,16 +1954,11 @@
 			*buffer = scb->dma_h_bulkdata;
 			*length = (u32) sgList[0].length;
 		}
-#else
-		*buffer = virt_to_bus (sgList[0].address);
-		*length = (u32) sgList[0].length;
-#endif
 
 		return 0;
 	}
 #endif
 	/* Copy Scatter-Gather list info into controller structure */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	sgcnt = pci_map_sg (megaCfg->dev,
 			    sgList, scb->SCpnt->use_sg, scb->dma_direction);
 
@@ -2508,29 +1980,13 @@
 
 	}
 
-#else
-	for (idx = 0; idx < scb->SCpnt->use_sg; idx++) {
-		scb->sgList[idx].address = virt_to_bus (sgList[idx].address);
-		scb->sgList[idx].length = (u32) sgList[idx].length;
-	}
-#endif
-
 	/* Reset pointer and length fields */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	*buffer = scb->dma_sghandle64;
 	scb->sglist_count = scb->SCpnt->use_sg;
-#else
-	*buffer = virt_to_bus (scb->sgList);
-#endif
 	*length = 0;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	/* Return count of SG requests */
 	return sgcnt;
-#else
-	/* Return count of SG requests */
-	return scb->SCpnt->use_sg;
-#endif
 }
 
 /*--------------------------------------------------------------------
@@ -2553,11 +2009,7 @@
 mega_register_mailbox (mega_host_config * megaCfg, u32 paddr)
 {
 	/* align on 16-byte boundary */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	megaCfg->mbox = &megaCfg->mailbox64ptr->mailbox;
-#else
-	megaCfg->mbox = &megaCfg->mailbox64.mailbox;
-#endif
 
 #ifdef __LP64__
 	megaCfg->mbox = (mega_mailbox *) ((((u64) megaCfg->mbox) + 16) & ((u64) (-1) ^ 0x0F));
@@ -2567,11 +2019,7 @@
 #else
 	megaCfg->mbox
 	    = (mega_mailbox *) ((((u32) megaCfg->mbox) + 16) & 0xFFFFFFF0);
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	megaCfg->adjdmahandle64 = ((megaCfg->dma_handle64 + 16) & 0xFFFFFFF0);
-#endif
-
 	megaCfg->mbox64 = (mega_mailbox64 *) ((u_char *) megaCfg->mbox - 8);
 	paddr = (paddr + 4 + 16) & 0xFFFFFFF0;
 #endif
@@ -2639,9 +2087,7 @@
 	mega_mailbox *mbox;
 	u_char mboxData[16];
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	dma_addr_t raid_inq_dma_handle = 0, prod_info_dma_handle = 0, enquiry3_dma_handle = 0;
-#endif
 	u8 retval;
 
 	/* Initialize adapter inquiry mailbox */
@@ -2657,16 +2103,11 @@
  * if not succeeded, then issue MEGA_MBOXCMD_ADAPTERINQ command and
  * update enquiry3 structure
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	enquiry3_dma_handle = pci_map_single (megaCfg->dev,
 			      (void *) megaCfg->mega_buffer,
 			      (2 * 1024L), PCI_DMA_FROMDEVICE);
 
 	mbox->xferaddr = enquiry3_dma_handle;
-#else
-	/*Taken care */
-	mbox->xferaddr = virt_to_bus ((void *) megaCfg->mega_buffer);
-#endif
 
 	/* Initialize mailbox databuffer addr */
 	enquiry3Pnt = (mega_Enquiry3 *) megaCfg->mega_buffer;
@@ -2681,16 +2122,11 @@
 		mega_RAIDINQ adapterInquiryData;
 		mega_RAIDINQ *adapterInquiryPnt = &adapterInquiryData;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		raid_inq_dma_handle = pci_map_single (megaCfg->dev,
 				      (void *) adapterInquiryPnt,
 				      sizeof (mega_RAIDINQ),
 				      PCI_DMA_FROMDEVICE);
 		mbox->xferaddr = raid_inq_dma_handle;
-#else
-		/*taken care */
-		mbox->xferaddr = virt_to_bus ((void *) adapterInquiryPnt);
-#endif
 
 		mbox->cmd = MEGA_MBOXCMD_ADAPTERINQ;	/*issue old 0x05 command to adapter */
 		/* Issue a blocking command to the card */ ;
@@ -2712,7 +2148,6 @@
 		pci_unmap_single (megaCfg->dev,
 				  enquiry3_dma_handle,
 				  (2 * 1024L), PCI_DMA_FROMDEVICE);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 /*get productInfo, which is static information and will be unchanged*/
 		prod_info_dma_handle
 		    = pci_map_single (megaCfg->dev,
@@ -2720,10 +2155,6 @@
 				      sizeof (megaRaidProductInfo),
 				      PCI_DMA_FROMDEVICE);
 		mbox->xferaddr = prod_info_dma_handle;
-#else
-		/*taken care */
-		mbox->xferaddr = virt_to_bus ((void *) &megaCfg->productInfo);
-#endif
 
 		mboxData[0] = FC_NEW_CONFIG;	/* i.e. mbox->cmd=0xA1 */
 		mboxData[2] = NC_SUBOP_PRODUCT_INFO;	/* i.e. 0x0E */
@@ -2831,9 +2262,7 @@
 	u_char pciBus, pciDevFun, megaIrq;
 
 	u16 magic;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	u32 magic64;
-#endif
 
 	int		i;
 
@@ -2847,23 +2276,13 @@
 	u16 numFound = 0;
 	u16 subsysid, subsysvid;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)	/* 0x20100 */
-	while (!pcibios_find_device
-	       (pciVendor, pciDev, pciIdx, &pciBus, &pciDevFun)) {
-#else
-
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,0)	/*0x20300 */
 	struct pci_dev *pdev = NULL;
-#else
-	struct pci_dev *pdev = pci_devices;
-#endif
 
 	while ((pdev = pci_find_device (pciVendor, pciDev, pdev))) {
 		if(pci_enable_device (pdev))
 			continue;
 		pciBus = pdev->bus->number;
 		pciDevFun = pdev->devfn;
-#endif
 		if ((flag & BOARD_QUARTZ) && (skip_id == -1)) {
 			pci_read_config_word (pdev, PCI_CONF_AMISIG, &magic);
 			if ((magic != AMI_SIGNATURE)
@@ -2871,12 +2290,10 @@
 				pciIdx++;
 				continue;	/* not an AMI board */
 			}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			pci_read_config_dword (pdev, PCI_CONF_AMISIG64, &magic64);
 
 			if (magic64 == AMI_64BIT_SIGNATURE)
 				flag |= BOARD_64BIT;
-#endif
 		}
 
 		/* Hmmm...Should we not make this more modularized so that in future we dont add
@@ -2884,19 +2301,11 @@
 
 		if (flag & BOARD_QUARTZ) {
 			/* Check to see if this is a Dell PERC RAID controller model 466 */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)	/* 0x20100 */
-			pcibios_read_config_word (pciBus, pciDevFun,
-						  PCI_SUBSYSTEM_VENDOR_ID,
-						  &subsysvid);
-			pcibios_read_config_word (pciBus, pciDevFun,
-						  PCI_SUBSYSTEM_ID, &subsysid);
-#else
 			pci_read_config_word (pdev,
 					      PCI_SUBSYSTEM_VENDOR_ID,
 					      &subsysvid);
 			pci_read_config_word (pdev,
 					      PCI_SUBSYSTEM_ID, &subsysid);
-#endif
 
 #if 0
 			/*
@@ -2923,20 +2332,8 @@
 			pciVendor, pciDev, pciIdx, pciBus, PCI_SLOT (pciDevFun),
 			PCI_FUNC (pciDevFun));
 		/* Read the base port and IRQ from PCI */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)	/* 0x20100 */
-		pcibios_read_config_dword (pciBus, pciDevFun,
-					   PCI_BASE_ADDRESS_0,
-					   (u_int *) & megaBase);
-		pcibios_read_config_byte (pciBus, pciDevFun,
-					  PCI_INTERRUPT_LINE, &megaIrq);
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)	/*0x20300 */
-		megaBase = pdev->base_address[0];
-		megaIrq = pdev->irq;
-#else
-
 		megaBase = pci_resource_start (pdev, 0);
 		megaIrq = pdev->irq;
-#endif
 
 		pciIdx++;
 
@@ -2991,10 +2388,7 @@
 		megaCfg->int_qh = NULL;
 		megaCfg->int_qt = NULL;
 		megaCfg->int_qlen = 0;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		megaCfg->dev = pdev;
-#endif
 		megaCfg->host = host;
 		megaCfg->base = megaBase;
 		megaCfg->host->irq = megaIrq;
@@ -3020,7 +2414,6 @@
 			goto err_release;
 		}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		/*
 		 * unmap while releasing the driver, Is it required to be 
 		 * PCI_DMA_BIDIRECTIONAL 
@@ -3032,11 +2425,6 @@
 					    &(megaCfg->dma_handle64));
 
 		mega_register_mailbox (megaCfg, megaCfg->dma_handle64);
-#else
-		mega_register_mailbox (megaCfg,
-				       virt_to_bus ((void *) &megaCfg->
-						    mailbox64));
-#endif
 
 		mega_i_query_adapter (megaCfg);
 
@@ -3147,14 +2535,12 @@
 		numFound++;
 
 		/* Set the Mode of addressing to 64 bit */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		if ((megaCfg->flag & BOARD_64BIT) && BITS_PER_LONG == 64)
 #ifdef __LP64__
 			pdev->dma_mask = 0xffffffffffffffff;
 #else
 			pdev->dma_mask = 0xffffffff;
 #endif
-#endif
 		continue;
 	      err_release:
 		if (flag & BOARD_QUARTZ)
@@ -3176,19 +2562,8 @@
 {
 	int ctlridx = 0, count = 0;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)	/*0x20300 */
-	pHostTmpl->proc_dir = &proc_scsi_megaraid;
-#else
 	pHostTmpl->proc_name = "megaraid";
-#endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,0)	/* 0x20100 */
-	if (!pcibios_present ()) {
-		printk (KERN_WARNING "megaraid: PCI bios not present."
-			M_RD_CRLFSTR);
-		return 0;
-	}
-#endif
 	skip_id = -1;
 	if (megaraid && !strncmp (megaraid, "skip", strlen ("skip"))) {
 		if (megaraid[4] != '\0') {
@@ -3216,13 +2591,7 @@
 
 #ifdef CONFIG_PROC_FS
 	if (count) {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,0)	/*0x20300 */
 		mega_proc_dir_entry = proc_mkdir ("megaraid", &proc_root);
-#else
-		mega_proc_dir_entry = create_proc_entry ("megaraid",
-							 S_IFDIR | S_IRUGO |
-							 S_IXUGO, &proc_root);
-#endif
 		if (!mega_proc_dir_entry)
 			printk ("megaraid: failed to create megaraid root\n");
 		else
@@ -3367,10 +2736,7 @@
 	mega_mailbox *mboxp;
 	unsigned char mbox[16];
 	int		i;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	dma_addr_t	dma_handle;
-#endif
 
 	mboxp = (mega_mailbox *)mbox;
 
@@ -3383,14 +2749,10 @@
 
 	memset((void *)megacfg->mega_buffer, 0, sizeof(megacfg->mega_buffer));
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	dma_handle = pci_map_single(megacfg->dev, (void *)megacfg->mega_buffer,
 			      (2 * 1024L), PCI_DMA_FROMDEVICE);
 
 	mboxp->xferaddr = dma_handle;
-#else
-	mboxp->xferaddr = virt_to_bus((void *)megacfg->mega_buffer);
-#endif
 
 	/*
 	 * Non-ROMB firware fail this command, so all channels
@@ -3408,11 +2770,8 @@
 		mega_ch_class = 0xFF;
 	}
 
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	pci_unmap_single(megacfg->dev, dma_handle,
 				  (2 * 1024L), PCI_DMA_FROMDEVICE);
-#endif
 
 }
 
@@ -3429,10 +2788,7 @@
 	u16		cksum = 0;
 	char	*cksum_p;
 	int		i;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	dma_addr_t	dma_handle;
-#endif
 
 	mboxp = (mega_mailbox *)mbox;
 
@@ -3443,14 +2799,10 @@
 
 	memset((void *)megacfg->mega_buffer, 0, sizeof(megacfg->mega_buffer));
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	dma_handle = pci_map_single(megacfg->dev, (void *)megacfg->mega_buffer,
 			      (2 * 1024L), PCI_DMA_FROMDEVICE);
 
 	mboxp->xferaddr = dma_handle;
-#else
-	mboxp->xferaddr = virt_to_bus((void *)megacfg->mega_buffer);
-#endif
 
 	megacfg->boot_ldrv_enabled = 0;
 	megacfg->boot_ldrv = 0;
@@ -3470,10 +2822,8 @@
 		}
 	}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	pci_unmap_single(megacfg->dev, dma_handle,
 				  (2 * 1024L), PCI_DMA_FROMDEVICE);
-#endif
 
 }
 
@@ -3490,9 +2840,6 @@
 					     megaCfg->scbList[i].sgList,
 					     megaCfg->scbList[i].
 					     dma_sghandle64);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)	/* 0x020400 */
-			kfree (megaCfg->scbList[i].sgList);	/* free sgList */
-#endif
 	}
 }
 
@@ -3531,12 +2878,11 @@
  *-----------------------------------------------------------------*/
 int megaraid_queue (Scsi_Cmnd * SCpnt, void (*pktComp) (Scsi_Cmnd *))
 {
-	DRIVER_LOCK_T mega_host_config * megaCfg;
+	mega_host_config * megaCfg;
 	mega_scb *pScb;
 	char *user_area = NULL;
 
 	megaCfg = (mega_host_config *) SCpnt->host->hostdata;
-	DRIVER_LOCK (megaCfg);
 
 	if (!(megaCfg->flag & (1L << SCpnt->channel))) {
 		if (SCpnt->channel < megaCfg->productInfo.SCSIChanPresent)
@@ -3571,7 +2917,6 @@
 		megaCfg->qCompletedT->host_scribble = (unsigned char *) NULL;
 		megaCfg->qCcnt++;
 
-		DRIVER_UNLOCK (megaCfg);
 		return 0;
 	} else if (megaCfg->flag & IN_RESET) {
 		SCpnt->result = (DID_RESET << 16);
@@ -3586,7 +2931,6 @@
 		megaCfg->qCompletedT->host_scribble = (unsigned char *) NULL;
 		megaCfg->qCcnt++;
 
-		DRIVER_UNLOCK (megaCfg);
 		return 0;
 	}
 
@@ -3611,7 +2955,6 @@
 			megaCfg->qPcnt++;
 
 			if (mega_runpendq (megaCfg) == -1) {
-				DRIVER_UNLOCK (megaCfg);
 				return 0;
 			}
 		}
@@ -3629,7 +2972,7 @@
 
 		if (pScb->SCpnt->cmnd[0] == M_RD_IOCTL_CMD_NEW) {
 			init_MUTEX_LOCKED (&pScb->ioctl_sem);
-			IO_UNLOCK_IRQ(megaCfg->host);
+			spin_unlock_irq(megaCfg->host->host_lock);
 			down (&pScb->ioctl_sem);
     		user_area = (char *)*((u32*)&pScb->SCpnt->cmnd[4]);
 			if (copy_to_user
@@ -3638,21 +2981,18 @@
 				    ("megaraid: Error copying ioctl return value to user buffer.\n");
 				pScb->SCpnt->result = (DID_ERROR << 16);
 			}
-		    IO_LOCK_IRQ(megaCfg->host);
-			DRIVER_LOCK (megaCfg);
+		    spin_lock_irq(megaCfg->host->host_lock);
 			kfree (pScb->buff_ptr);
 			pScb->buff_ptr = NULL;
 			mega_cmd_done (megaCfg, pScb, pScb->SCpnt->result);
 			mega_rundoneq (megaCfg);
 			mega_runpendq (megaCfg);
-			DRIVER_UNLOCK (megaCfg);
 		}
 
 		megaCfg->flag &= ~IN_QUEUE;
 
 	}
 
-	DRIVER_UNLOCK (megaCfg);
 	return 0;
 }
 
@@ -3974,41 +3314,10 @@
 	return count;
 }
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,0)	/*0x20300 */
 #define CREATE_READ_PROC(string, fxn) create_proc_read_entry(string, \
                                          S_IRUSR | S_IFREG,\
                                          controller_proc_dir_entry,\
                                          fxn, megaCfg)
-#else
-#define CREATE_READ_PROC(string, fxn) create_proc_read_entry(string,S_IRUSR | S_IFREG, controller_proc_dir_entry, fxn, megaCfg)
-
-static struct proc_dir_entry *
-create_proc_read_entry (const char *string,
-			int mode,
-			struct proc_dir_entry *parent,
-			read_proc_t * fxn, mega_host_config * megaCfg)
-{
-	struct proc_dir_entry *temp = NULL;
-
-	temp = kmalloc (sizeof (struct proc_dir_entry), GFP_KERNEL);
-	if (!temp)
-		return NULL;
-	memset (temp, 0, sizeof (struct proc_dir_entry));
-
-	if ((temp->name = kmalloc (strlen (string) + 1, GFP_KERNEL)) == NULL) {
-		kfree (temp);
-		return NULL;
-	}
-
-	strcpy ((char *) temp->name, string);
-	temp->namelen = strlen (string);
-	temp->mode = mode; /*S_IFREG | S_IRUSR */ ;
-	temp->data = (void *) megaCfg;
-	temp->read_proc = fxn;
-	proc_register (parent, temp);
-	return temp;
-}
-#endif
 
 static void mega_create_proc_entry (int index, struct proc_dir_entry *parent)
 {
@@ -4018,14 +3327,8 @@
 
 	sprintf (string, "%d", index);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,0)	/*0x20300 */
 	controller_proc_dir_entry =
 	    megaCfg->controller_proc_dir_entry = proc_mkdir (string, parent);
-#else
-	controller_proc_dir_entry =
-	    megaCfg->controller_proc_dir_entry =
-	    create_proc_entry (string, S_IFDIR | S_IRUGO | S_IXUGO, parent);
-#endif
 
 	if (!controller_proc_dir_entry)
 		printk ("\nmegaraid: proc_mkdir failed\n");
@@ -4228,7 +3531,6 @@
 		 * and the mid-layer operations are not connected with this flag.
 		 */
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		megacfg->scbList[idx].sgList =
 		    pci_alloc_consistent (megacfg->dev,
 					  sizeof (mega_64sglist) * MAX_SGLIST,
@@ -4237,9 +3539,6 @@
 
 		megacfg->scbList[idx].sg64List =
 		    (mega_64sglist *) megacfg->scbList[idx].sgList;
-#else
-		megacfg->scbList[idx].sgList = kmalloc (sizeof (mega_sglist) * MAX_SGLIST, GFP_ATOMIC | GFP_DMA);
-#endif
 
 		if (megacfg->scbList[idx].sgList == NULL) {
 			printk (KERN_WARNING
@@ -4247,7 +3546,6 @@
 			mega_freeSgList (megacfg);
 			return -1;
 		}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		megacfg->scbList[idx].pthru = pci_alloc_consistent (megacfg->dev,
 					  sizeof (mega_passthru),
 					  &(megacfg->scbList[idx].
@@ -4281,7 +3579,6 @@
 			    ("megaraid: allocation for bounce buffer failed\n");
 
 		megacfg->scbList[idx].dma_type = M_RD_DMA_TYPE_NONE;
-#endif
 
 		if (idx < MAX_COMMANDS) {
 			/*
@@ -4368,13 +3665,9 @@
 	dma_addr_t	dma_addr;
 	u32		length;
 	mega_host_config *megacfg = NULL;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/* 0x020400 */
 	struct pci_dev pdev;
 	struct pci_dev *pdevp = &pdev;
-#else
-	char *pdevp = NULL;
-#endif
-	IO_LOCK_T;
+	unsigned long io_flags = 0;
 
 	if (!inode)
 		return -EINVAL;
@@ -4506,34 +3799,21 @@
 		shpnt = megaCtlrs[adapno]->host;
 		if(shpnt == NULL)  return -ENODEV;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		scsicmd = (Scsi_Cmnd *)kmalloc(sizeof(Scsi_Cmnd), GFP_KERNEL|GFP_DMA);
-#else
-		scsicmd = (Scsi_Cmnd *)scsi_init_malloc(sizeof(Scsi_Cmnd),
-							  GFP_ATOMIC | GFP_DMA);
-#endif
 		if(scsicmd == NULL) return -ENOMEM;
 
 		memset(scsicmd, 0, sizeof(Scsi_Cmnd));
 		scsicmd->host = shpnt;
 
 		if( outlen || inlen ) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			pdevp = &pdev;
 			memcpy(pdevp, megacfg->dev, sizeof(struct pci_dev));
 			pdevp->dma_mask = 0xffffffff;
-#else
-			pdevp = NULL;
-#endif
-			kvaddr = dma_alloc_consistent(pdevp, length, &dma_addr);
+			kvaddr = pci_alloc_consistent(pdevp, length, &dma_addr);
 
 			if( kvaddr == NULL ) {
 				printk(KERN_WARNING "megaraid:allocation failed\n");
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/*0x20400 */
 				kfree(scsicmd);
-#else
-				scsi_init_free((char *)scsicmd, sizeof(Scsi_Cmnd));
-#endif
 				return -ENOMEM;
 			}
 
@@ -4550,10 +3830,10 @@
 
 		init_MUTEX_LOCKED(&mimd_ioctl_sem);
 
-		IO_LOCK(shpnt);
+		spin_lock_irqsave(shpnt->host_lock,io_flags);
 		megaraid_queue(scsicmd, megadev_ioctl_done);
 
-		IO_UNLOCK(shpnt);
+		spin_unlock_irqrestore(shpnt->host_lock,io_flags);
 
 		down(&mimd_ioctl_sem);
 
@@ -4575,13 +3855,9 @@
 		}
 
 		if (kvaddr) {
-			dma_free_consistent(pdevp, length, kvaddr, dma_addr);
+			pci_free_consistent(pdevp, length, kvaddr, dma_addr);
 		}
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/*0x20400 */
 		kfree (scsicmd);
-#else
-		scsi_init_free((char *)scsicmd, sizeof(Scsi_Cmnd));
-#endif
 
 		/* restore the user address */
 		ioc.ui.fcs.buffer = uaddr;
@@ -4643,37 +3919,25 @@
 			return ret;
 		}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		scsicmd = (Scsi_Cmnd *)kmalloc(sizeof(Scsi_Cmnd), GFP_KERNEL|GFP_DMA);
-#else
-		scsicmd = (Scsi_Cmnd *)scsi_init_malloc(sizeof(Scsi_Cmnd),
-							  GFP_ATOMIC | GFP_DMA);
-#endif
 		if(scsicmd == NULL) return -ENOMEM;
 
 		memset(scsicmd, 0, sizeof(Scsi_Cmnd));
 		scsicmd->host = shpnt;
 
 		if (outlen || inlen) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			pdevp = &pdev;
 			memcpy(pdevp, megacfg->dev, sizeof(struct pci_dev));
 			pdevp->dma_mask = 0xffffffff;
-#else
-			pdevp = NULL;
-#endif
+
 			/*
 			 * Allocate a page of kernel space.
 			 */
-			kvaddr = dma_alloc_consistent(pdevp, PAGE_SIZE, &dma_addr);
+			kvaddr = pci_alloc_consistent(pdevp, PAGE_SIZE, &dma_addr);
 
 			if( kvaddr == NULL ) {
 				printk (KERN_WARNING "megaraid:allocation failed\n");
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)	/*0x20400 */
 				kfree(scsicmd);
-#else
-				scsi_init_free((char *)scsicmd, sizeof(Scsi_Cmnd));
-#endif
 				return -ENOMEM;
 			}
 
@@ -4694,10 +3958,10 @@
 
 		init_MUTEX_LOCKED (&mimd_ioctl_sem);
 
-		IO_LOCK(shpnt);
+		spin_lock_irqsave(shpnt->host_lock,io_flags);
 		megaraid_queue (scsicmd, megadev_ioctl_done);
 
-		IO_UNLOCK(shpnt);
+		spin_unlock_irqrestore(shpnt->host_lock,io_flags);
 		down (&mimd_ioctl_sem);
 
 		if (!scsicmd->result && outlen) {
@@ -4721,14 +3985,10 @@
 		}
 
 		if (kvaddr) {
-			dma_free_consistent(pdevp, PAGE_SIZE, kvaddr, dma_addr );
+			pci_free_consistent(pdevp, PAGE_SIZE, kvaddr, dma_addr );
 		}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		kfree (scsicmd);
-#else
-		scsi_init_free((char *)scsicmd, sizeof(Scsi_Cmnd));
-#endif
 
 		/* restore user pointer */
 		ioc.data = uaddr;
@@ -4783,14 +4043,9 @@
 		/*
 		   * prepare the SCB with information from the user ioctl structure
 		 */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		pthru = scb->pthru;
-#else
-		pthru = &scb->pthru;
-#endif
 		memcpy (pthru, &ioc->pthru, sizeof (mega_passthru));
 		mboxpthru = (struct mbox_passthru *) scb->mboxData;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 		if (megacfg->flag & BOARD_64BIT) {
 			/* This is just a sample with one element 
 			   * This if executes onlu on 2.4 kernels
@@ -4813,14 +4068,6 @@
 			pthru->numsgelements = 0;
 		}
 
-#else
-		{
-			mboxpthru->dataxferaddr = virt_to_bus (&scb->pthru);
-			pthru->dataxferaddr = virt_to_bus (ioc->data);
-			pthru->numsgelements = 0;
-		}
-#endif
-
 		pthru->reqsenselen = 14;
 		break;
 
@@ -4895,7 +4142,7 @@
 mega_del_logdrv(mega_host_config *this_hba, int logdrv)
 {
 	int		rval;
-	IO_LOCK_T;
+	unsigned long io_flags = 0;
 	DECLARE_WAIT_QUEUE_HEAD(wq);
 	mega_scb	*scbp;
 
@@ -4903,16 +4150,16 @@
 	 * Stop sending commands to the controller, queue them internally.
 	 * When deletion is complete, ISR will flush the queue.
 	 */
-	IO_LOCK(this_hba->host);
+	spin_lock_irqsave(this_hba->host->host_lock,io_flags);
 	this_hba->quiescent = 1;
-	IO_UNLOCK(this_hba->host);
+	spin_unlock_irqrestore(this_hba->host->host_lock,io_flags);
 
 	while( this_hba->qPcnt ) {
 			sleep_on_timeout( &wq, 1*HZ );	/* sleep for 1s */
 	}
 	rval = mega_do_del_logdrv(this_hba, logdrv);
 
-	IO_LOCK(this_hba->host);
+	spin_lock_irqsave(this_hba->host->host_lock,io_flags);
 	/*
 	 * Attach the internal queue to the pending queue
 	 */
@@ -4946,18 +4193,13 @@
 	 */
 	if( this_hba->read_ldidmap) {
 		for( scbp = this_hba->qPendingH; scbp; scbp = scbp->next ) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 			if( scbp->pthru->logdrv < 0x80 )
 				scbp->pthru->logdrv += 0x80;
-#else
-			if( scbp->pthru.logdrv < 0x80 )
-				scbp->pthru.logdrv += 0x80;
-#endif
 		}
 	}
 	this_hba->quiescent = 0;
 
-	IO_UNLOCK(this_hba->host);
+	spin_unlock_irqrestore(this_hba->host->host_lock,io_flags);
 
 	return rval;
 }
@@ -4998,100 +4240,8 @@
 	return rval;
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-void *
-dma_alloc_consistent(void *dev, size_t size, dma_addr_t *dma_addr)
-{
-	void	*_tv;
-	int		npages;
-	int		order = 0;
-
-	/*
-	 * How many pages application needs
-	 */
-	npages = size / PAGE_SIZE;
-
-	/* Do we need one more page */
-	if(size % PAGE_SIZE)
-		npages++;
-
-	order = mega_get_order(npages);
-
-	_tv = (void *)__get_free_pages(GFP_DMA, order);
-
-	if( _tv != NULL ) {
-		memset(_tv, 0, size);
-		*(dma_addr) = virt_to_bus(_tv);
-	}
-
-	return _tv;
-}
-
-/*
- * int mega_get_order(int)
- *
- * returns the order to be used as 2nd argument to __get_free_pages() - which
- * return pages equal to pow(2, order) - AM
- */
-int
-mega_get_order(int n)
-{
-	int		i = 0;
-
-	while( pow_2(i++) < n )
-		; /* null statement */
-
-	return i-1;
-}
-
-/*
- * int pow_2(int)
- *
- * calculates pow(2, i)
- */
-int
-pow_2(int i)
-{
-	unsigned int	v = 1;
-	
-	while(i--)
-		v <<= 1;
-
-	return v;
-}
-
-void
-dma_free_consistent(void *dev, size_t size, void *vaddr, dma_addr_t dma_addr)
-{
-	int		npages;
-	int		order = 0;
-
-	npages = size / PAGE_SIZE;
-
-	if(size % PAGE_SIZE)
-		npages++;
-
-	if (npages == 1)
-		order = 0;
-	else if (npages == 2)
-		order = 1;
-	else if (npages <= 4)
-		order = 2;
-	else
-		order = 3;
-
-	free_pages((unsigned long)vaddr, order);
-
-}
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-static
-#endif				/* LINUX VERSION 2.4.XX */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) || defined(MODULE)
-Scsi_Host_Template driver_template = MEGARAID;
+static Scsi_Host_Template driver_template = MEGARAID;
 
 #include "scsi_module.c"
-#endif				/* LINUX VERSION 2.4.XX || MODULE */
 
 /* vi: set ts=4: */
