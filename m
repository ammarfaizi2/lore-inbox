Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVGJWt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVGJWt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVGJTiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46556 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261848AbVGJTf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:57 -0400
Date: Sun, 10 Jul 2005 19:35:56 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [PATCH 48/82] remove linux/version.h from drivers/scsi/qla1280.c
Message-ID: <20050710193556.48.hTPMEf3548.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
remove code for obsolete kernels

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/scsi/qla1280.c |  277 -------------------------------------------------
1 files changed, 277 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/scsi/qla1280.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/scsi/qla1280.c
+++ linux-2.6.13-rc2-mm1/drivers/scsi/qla1280.c
@@ -332,7 +332,6 @@
#include <linux/config.h>
#include <linux/module.h>

-#include <linux/version.h>
#include <linux/types.h>
#include <linux/string.h>
#include <linux/errno.h>
@@ -356,28 +355,16 @@
#include <asm/types.h>
#include <asm/system.h>

-#if LINUX_VERSION_CODE >= 0x020545
#include <scsi/scsi.h>
#include <scsi/scsi_cmnd.h>
#include <scsi/scsi_device.h>
#include <scsi/scsi_host.h>
#include <scsi/scsi_tcq.h>
-#else
-#include <linux/blk.h>
-#include "scsi.h"
-#include <scsi/scsi_host.h>
-#include "sd.h"
-#endif

#if defined(CONFIG_IA64_GENERIC) || defined(CONFIG_IA64_SGI_SN2)
#include <asm/sn/io.h>
#endif

-#if LINUX_VERSION_CODE < 0x020407
-#error "Kernels older than 2.4.7 are no longer supported"
-#endif
-
-
/*
* Compile time Options:
*            0 - Disable and 1 - Enable
@@ -441,52 +428,8 @@

#define NVRAM_DELAY()			udelay(500)	/* 2 microseconds */

-#if LINUX_VERSION_CODE < 0x020500
-#define HOST_LOCK			&io_request_lock
-#define irqreturn_t			void
-#define IRQ_RETVAL(foo)
-#define MSG_ORDERED_TAG			1
-
-#define DMA_BIDIRECTIONAL	SCSI_DATA_UNKNOWN
-#define DMA_TO_DEVICE		SCSI_DATA_WRITE
-#define DMA_FROM_DEVICE		SCSI_DATA_READ
-#define DMA_NONE		SCSI_DATA_NONE
-
-#ifndef HAVE_SECTOR_T
-typedef unsigned int sector_t;
-#endif
-
-static inline void
-scsi_adjust_queue_depth(struct scsi_device *device, int tag, int depth)
-{
-	if (tag) {
-		device->tagged_queue = tag;
-		device->current_tag = 0;
-	}
-	device->queue_depth = depth;
-}
-static inline struct Scsi_Host *scsi_host_alloc(Scsi_Host_Template *t, size_t s)
-{
-	return scsi_register(t, s);
-}
-static inline void scsi_host_put(struct Scsi_Host *h)
-{
-	scsi_unregister(h);
-}
-#else
#define HOST_LOCK			ha->host->host_lock
-#endif
-#if LINUX_VERSION_CODE < 0x020600
-#define DEV_SIMPLE_TAGS(device)		device->tagged_queue
-/*
- * Hack around that qla1280_remove_one is called from
- * qla1280_release in 2.4
- */
-#undef __devexit
-#define __devexit
-#else
#define DEV_SIMPLE_TAGS(device)		device->simple_tags
-#endif
#if defined(__ia64__) && !defined(ia64_platform_is)
#define ia64_platform_is(foo)		(!strcmp(x, platform_name))
#endif
@@ -506,9 +449,6 @@ static void qla1280_remove_one(struct pc
*  QLogic Driver Support Function Prototypes.
*/
static void qla1280_done(struct scsi_qla_host *);
-#if LINUX_VERSION_CODE < 0x020545
-static void qla1280_get_target_options(struct scsi_cmnd *, struct scsi_qla_host *);
-#endif
static int qla1280_get_token(char *);
static int qla1280_setup(char *s) __init;

@@ -610,11 +550,7 @@ __setup("qla1280=", qla1280_setup);
#define	CMD_SNSLEN(Cmnd)	sizeof(Cmnd->sense_buffer)
#define	CMD_RESULT(Cmnd)	Cmnd->result
#define	CMD_HANDLE(Cmnd)	Cmnd->host_scribble
-#if LINUX_VERSION_CODE < 0x020545
-#define CMD_REQUEST(Cmnd)	Cmnd->request.cmd
-#else
#define CMD_REQUEST(Cmnd)	Cmnd->request->cmd
-#endif

#define CMD_HOST(Cmnd)		Cmnd->device->host
#define SCSI_BUS_32(Cmnd)	Cmnd->device->channel
@@ -1179,97 +1115,6 @@ qla1280_biosparam(struct scsi_device *sd
return 0;
}

-#if LINUX_VERSION_CODE < 0x020600
-static int
-qla1280_detect(Scsi_Host_Template *template)
-{
-	struct pci_device_id *id = &qla1280_pci_tbl[0];
-	struct pci_dev *pdev = NULL;
-	int num_hosts = 0;
-
-	if (sizeof(struct srb) > sizeof(Scsi_Pointer)) {
-		printk(KERN_WARNING
-		       "qla1280: struct srb too big, abortingn");
-		return 0;
-	}
-
-	if ((DMA_BIDIRECTIONAL != PCI_DMA_BIDIRECTIONAL) ||
-	    (DMA_TO_DEVICE != PCI_DMA_TODEVICE) ||
-	    (DMA_FROM_DEVICE != PCI_DMA_FROMDEVICE) ||
-	    (DMA_NONE != PCI_DMA_NONE)) {
-		printk(KERN_WARNING
-		       "qla1280: dma direction bits don't matchn");
-		return 0;
-	}
-
-#ifdef MODULE
-	/*
-	 * If we are called as a module, the qla1280 pointer may not be null
-	 * and it would point to our bootup string, just like on the lilo
-	 * command line.  IF not NULL, then process this config string with
-	 * qla1280_setup
-	 *
-	 * Boot time Options
-	 * To add options at boot time add a line to your lilo.conf file like:
-	 * append="qla1280=verbose,max_tags:{{255,255,255,255},{255,255,255,255}}"
-	 * which will result in the first four devices on the first two
-	 * controllers being set to a tagged queue depth of 32.
-	 */
-	if (qla1280)
-		qla1280_setup(qla1280);
-#endif
-
-	/* First Initialize QLA12160 on PCI Bus 1 Dev 2 */
-	while ((pdev = pci_find_device(id->vendor, id->device, pdev))) {
-		if (pdev->bus->number == 1 && PCI_SLOT(pdev->devfn) == 2) {
-			if (!qla1280_probe_one(pdev, id))
-				num_hosts++;
-		}
-	}
-
-	pdev = NULL;
-	/* Try and find each different type of adapter we support */
-	for (id = &qla1280_pci_tbl[0]; id->device; id++) {
-		while ((pdev = pci_find_device(id->vendor, id->device, pdev))) {
-			/*
-			 * skip QLA12160 already initialized on
-			 * PCI Bus 1 Dev 2 since we already initialized
-			 * and presented it
-			 */
-			if (id->device == PCI_DEVICE_ID_QLOGIC_ISP12160 &&
-			    pdev->bus->number == 1 &&
-			    PCI_SLOT(pdev->devfn) == 2)
-				continue;
-
-			if (!qla1280_probe_one(pdev, id))
-				num_hosts++;
-		}
-	}
-
-	return num_hosts;
-}
-
-/*
- * This looks a bit ugly as we could just pass down host to
- * qla1280_remove_one, but I want to keep qla1280_release purely a wrapper
- * around pci_driver::remove as used from 2.6 onwards.
- */
-static int
-qla1280_release(struct Scsi_Host *host)
-{
-	struct scsi_qla_host *ha = (struct scsi_qla_host *)host->hostdata;
-
-	qla1280_remove_one(ha->pdev);
-	return 0;
-}
-
-static int
-qla1280_biosparam_old(Disk * disk, kdev_t dev, int geom[])
-{
-	return qla1280_biosparam(disk->device, NULL, disk->capacity, geom);
-}
-#endif
-
/**************************************************************************
* qla1280_intr_handler
*   Handles the H/W interrupt
@@ -1388,11 +1233,9 @@ qla1280_slave_configure(struct scsi_devi
scsi_adjust_queue_depth(device, 0, default_depth);
}

-#if LINUX_VERSION_CODE > 0x020500
nv->bus[bus].target[target].parameter.f.enable_sync = device->sdtr;
nv->bus[bus].target[target].parameter.f.enable_wide = device->wdtr;
nv->bus[bus].target[target].ppr_1x160.flags.enable_ppr = device->ppr;
-#endif

if (driver_setup.no_sync ||
(driver_setup.sync_mask &&
@@ -1417,31 +1260,6 @@ qla1280_slave_configure(struct scsi_devi
return status;
}

-#if LINUX_VERSION_CODE < 0x020545
-/**************************************************************************
- *   qla1280_select_queue_depth
- *
- *   Sets the queue depth for each SCSI device hanging off the input
- *   host adapter.  We use a queue depth of 2 for devices that do not
- *   support tagged queueing.
- **************************************************************************/
-static void
-qla1280_select_queue_depth(struct Scsi_Host *host, struct scsi_device *sdev_q)
-{
-	struct scsi_qla_host *ha = (struct scsi_qla_host *)host->hostdata;
-	struct scsi_device *sdev;
-
-	ENTER("qla1280_select_queue_depth");
-	for (sdev = sdev_q; sdev; sdev = sdev->next)
-		if (sdev->host == host)
-			qla1280_slave_configure(sdev);
-
-	if (sdev_q)
-		qla1280_check_for_dead_scsi_bus(ha, sdev_q->channel);
-	LEAVE("qla1280_select_queue_depth");
-}
-#endif
-
/*
* qla1280_done
*      Process completed commands.
@@ -1501,10 +1319,6 @@ qla1280_done(struct scsi_qla_host *ha)
CMD_HANDLE(sp->cmd) = (unsigned char *)INVALID_HANDLE;
ha->actthreads--;

-#if LINUX_VERSION_CODE < 0x020500
-		if (cmd->cmnd[0] == INQUIRY)
-			qla1280_get_target_options(cmd, ha);
-#endif
(*(cmd)->scsi_done)(cmd);

if(sp->wait != NULL)
@@ -1667,9 +1481,7 @@ qla1280_initialize_adapter(struct scsi_q
struct device_reg __iomem *reg;
int status;
int bus;
-#if LINUX_VERSION_CODE > 0x020500
unsigned long flags;
-#endif

ENTER("qla1280_initialize_adapter");

@@ -1708,7 +1520,6 @@ qla1280_initialize_adapter(struct scsi_q
"NVRAMn");
}

-#if LINUX_VERSION_CODE >= 0x020500
/*
* It's necessary to grab the spin here as qla1280_mailbox_command
* needs to be able to drop the lock unconditionally to wait
@@ -1716,7 +1527,6 @@ qla1280_initialize_adapter(struct scsi_q
* In 2.4 ->detect is called with the io_request_lock held.
*/
spin_lock_irqsave(HOST_LOCK, flags);
-#endif

status = qla1280_load_firmware(ha);
if (status) {
@@ -1748,9 +1558,7 @@ qla1280_initialize_adapter(struct scsi_q

ha->flags.online = 1;
out:
-#if LINUX_VERSION_CODE >= 0x020500
spin_unlock_irqrestore(HOST_LOCK, flags);
-#endif
if (status)
dprintk(2, "qla1280_initialize_adapter: **** FAILED ****n");

@@ -3967,51 +3775,6 @@ qla1280_rst_aen(struct scsi_qla_host *ha
LEAVE("qla1280_rst_aen");
}

-
-#if LINUX_VERSION_CODE < 0x020500
-/*
- *
- */
-static void
-qla1280_get_target_options(struct scsi_cmnd *cmd, struct scsi_qla_host *ha)
-{
-	unsigned char *result;
-	struct nvram *n;
-	int bus, target, lun;
-
-	bus = SCSI_BUS_32(cmd);
-	target = SCSI_TCN_32(cmd);
-	lun = SCSI_LUN_32(cmd);
-
-	/*
-	 * Make sure to not touch anything if someone is using the
-	 * sg interface.
-	 */
-	if (cmd->use_sg || (CMD_RESULT(cmd) >> 16) != DID_OK || lun)
-		return;
-
-	result = cmd->request_buffer;
-	n = &ha->nvram;
-
-	n->bus[bus].target[target].parameter.f.enable_wide = 0;
-	n->bus[bus].target[target].parameter.f.enable_sync = 0;
-	n->bus[bus].target[target].ppr_1x160.flags.enable_ppr = 0;
-
-        if (result[7] & 0x60)
-		n->bus[bus].target[target].parameter.f.enable_wide = 1;
-        if (result[7] & 0x10)
-		n->bus[bus].target[target].parameter.f.enable_sync = 1;
-	if ((result[2] >= 3) && (result[4] + 5 > 56) &&
-	    (result[56] & 0x4))
-		n->bus[bus].target[target].ppr_1x160.flags.enable_ppr = 1;
-
-	dprintk(2, "get_target_options(): wide %i, sync %i, ppr %in",
-		n->bus[bus].target[target].parameter.f.enable_wide,
-		n->bus[bus].target[target].parameter.f.enable_sync,
-		n->bus[bus].target[target].ppr_1x160.flags.enable_ppr);
-}
-#endif
-
/*
*  qla1280_status_entry
*      Processes received ISP status entry.
@@ -4564,7 +4327,6 @@ qla1280_get_token(char *str)
return ret;
}

-#if LINUX_VERSION_CODE >= 0x020600
static struct scsi_host_template qla1280_driver_template = {
.module			= THIS_MODULE,
.proc_name		= "qla1280",
@@ -4583,27 +4345,6 @@ static struct scsi_host_template qla1280
.cmd_per_lun		= 1,
.use_clustering		= ENABLE_CLUSTERING,
};
-#else
-static Scsi_Host_Template qla1280_driver_template = {
-	.proc_name		= "qla1280",
-	.name			= "Qlogic ISP 1280/12160",
-	.detect			= qla1280_detect,
-	.release		= qla1280_release,
-	.info			= qla1280_info,
-	.queuecommand		= qla1280_queuecommand,
-	.eh_abort_handler	= qla1280_eh_abort,
-	.eh_device_reset_handler= qla1280_eh_device_reset,
-	.eh_bus_reset_handler	= qla1280_eh_bus_reset,
-	.eh_host_reset_handler	= qla1280_eh_adapter_reset,
-	.bios_param		= qla1280_biosparam_old,
-	.can_queue		= 0xfffff,
-	.this_id		= -1,
-	.sg_tablesize		= SG_ALL,
-	.cmd_per_lun		= 1,
-	.use_clustering		= ENABLE_CLUSTERING,
-	.use_new_eh_code	= 1,
-};
-#endif

static int __devinit
qla1280_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -4694,10 +4435,6 @@ qla1280_probe_one(struct pci_dev *pdev,
host->max_sectors = 1024;
host->unique_id = host->host_no;

-#if LINUX_VERSION_CODE < 0x020545
-	host->select_queue_depths = qla1280_select_queue_depth;
-#endif
-
error = -ENODEV;

#if MEMORY_MAPPED_IO
@@ -4745,21 +4482,15 @@ qla1280_probe_one(struct pci_dev *pdev,

pci_set_drvdata(pdev, host);

-#if LINUX_VERSION_CODE >= 0x020600
error = scsi_add_host(host, &pdev->dev);
if (error)
goto error_disable_adapter;
scsi_scan_host(host);
-#else
-	scsi_set_pci_device(host, pdev);
-#endif

return 0;

-#if LINUX_VERSION_CODE >= 0x020600
error_disable_adapter:
WRT_REG_WORD(&ha->iobase->ictrl, 0);
-#endif
error_free_irq:
free_irq(pdev->irq, ha);
error_release_region:
@@ -4791,9 +4522,7 @@ qla1280_remove_one(struct pci_dev *pdev)
struct Scsi_Host *host = pci_get_drvdata(pdev);
struct scsi_qla_host *ha = (struct scsi_qla_host *)host->hostdata;

-#if LINUX_VERSION_CODE >= 0x020600
scsi_remove_host(host);
-#endif

WRT_REG_WORD(&ha->iobase->ictrl, 0);

@@ -4817,7 +4546,6 @@ qla1280_remove_one(struct pci_dev *pdev)
scsi_host_put(host);
}

-#if LINUX_VERSION_CODE >= 0x020600
static struct pci_driver qla1280_pci_driver = {
.name		= "qla1280",
.id_table	= qla1280_pci_tbl,
@@ -4863,11 +4591,6 @@ qla1280_exit(void)
module_init(qla1280_init);
module_exit(qla1280_exit);

-#else
-# define driver_template qla1280_driver_template
-# include "scsi_module.c"
-#endif
-
MODULE_AUTHOR("Qlogic & Jes Sorensen");
MODULE_DESCRIPTION("Qlogic ISP SCSI (qla1x80/qla1x160) driver");
MODULE_LICENSE("GPL");
