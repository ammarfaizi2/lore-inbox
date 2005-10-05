Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVJEVJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVJEVJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVJEVJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:09:43 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:62274 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S965072AbVJEVJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:09:42 -0400
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pasi Pirhonen <upi@papat.org>,
       Michael Madore <Michael.Madore@aslab.com>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>,
       Evgeny Rodichev <er@sai.msu.su>
Subject: [PATCH 2.6.14-rc2 2/2] libata: Marvell function headers
References: <20051005210610.EC31826369@lns1058.lss.emc.com>
In-Reply-To: <20051005210610.EC31826369@lns1058.lss.emc.com>
Message-Id: <20051005210853.C63EA26369@lns1058.lss.emc.com>
Date: Wed,  5 Oct 2005 17:08:53 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.10.5.26
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helpful function header comments.

Thanks,
BR

Signed-off-by: Brett Russ <russb@emc.com>


Index: linux-2.6.14-rc2/drivers/scsi/sata_mv.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/scsi/sata_mv.c
+++ linux-2.6.14-rc2/drivers/scsi/sata_mv.c
@@ -35,7 +35,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.23"
+#define DRV_VERSION	"0.24"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -406,6 +406,17 @@ static void mv_irq_clear(struct ata_port
 {
 }
 
+/**
+ *      mv_start_dma - Enable eDMA engine
+ *      @base: port base address
+ *      @pp: port private data
+ *
+ *      Verify the local cache of the eDMA state is accurate with an
+ *      assert.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_start_dma(void __iomem *base, struct mv_port_priv *pp)
 {
 	if (!(MV_PP_FLAG_EDMA_EN & pp->pp_flags)) {
@@ -415,6 +426,16 @@ static void mv_start_dma(void __iomem *b
 	assert(EDMA_EN & readl(base + EDMA_CMD_OFS));
 }
 
+/**
+ *      mv_stop_dma - Disable eDMA engine
+ *      @ap: ATA channel to manipulate
+ *
+ *      Verify the local cache of the eDMA state is accurate with an
+ *      assert.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_stop_dma(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
@@ -561,7 +582,15 @@ static void mv_scr_write(struct ata_port
 	}
 }
 
-/* This routine only applies to 6xxx parts */
+/**
+ *      mv_global_soft_reset - Perform the 6xxx global soft reset
+ *      @mmio_base: base address of the HBA
+ *
+ *      This routine only applies to 6xxx parts.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static int mv_global_soft_reset(void __iomem *mmio_base)
 {
 	void __iomem *reg = mmio_base + PCI_MAIN_CMD_STS_OFS;
@@ -617,6 +646,16 @@ done:
 	return rc;
 }
 
+/**
+ *      mv_host_stop - Host specific cleanup/stop routine.
+ *      @host_set: host data structure
+ *
+ *      Disable ints, cleanup host memory, call general purpose
+ *      host_stop.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_host_stop(struct ata_host_set *host_set)
 {
 	struct mv_host_priv *hpriv = host_set->private_data;
@@ -631,6 +670,16 @@ static void mv_host_stop(struct ata_host
 	ata_host_stop(host_set);
 }
 
+/**
+ *      mv_port_start - Port specific init/start routine.
+ *      @ap: ATA channel to manipulate
+ *
+ *      Allocate and point to DMA memory, init port private memory,
+ *      zero indices.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static int mv_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -699,6 +748,15 @@ static int mv_port_start(struct ata_port
 	return 0;
 }
 
+/**
+ *      mv_port_stop - Port specific cleanup/stop routine.
+ *      @ap: ATA channel to manipulate
+ *
+ *      Stop DMA, cleanup port memory.
+ *
+ *      LOCKING:
+ *      This routine uses the host_set lock to protect the DMA stop.
+ */
 static void mv_port_stop(struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -714,6 +772,15 @@ static void mv_port_stop(struct ata_port
 	kfree(pp);
 }
 
+/**
+ *      mv_fill_sg - Fill out the Marvell ePRD (scatter gather) entries
+ *      @qc: queued command whose SG list to source from
+ *
+ *      Populate the SG list and mark the last entry.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct mv_port_priv *pp = qc->ap->private_data;
@@ -748,6 +815,18 @@ static inline void mv_crqb_pack_cmd(u16 
 		(last ? CRQB_CMD_LAST : 0);
 }
 
+/**
+ *      mv_qc_prep - Host specific command preparation.
+ *      @qc: queued command to prepare
+ *
+ *      This routine simply redirects to the general purpose routine
+ *      if command is not DMA.  Else, it handles prep of the CRQB
+ *      (command request block), does some sanity checking, and calls
+ *      the SG load routine.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -830,6 +909,18 @@ static void mv_qc_prep(struct ata_queued
 	mv_fill_sg(qc);
 }
 
+/**
+ *      mv_qc_issue - Initiate a command to the host
+ *      @qc: queued command to start
+ *
+ *      This routine simply redirects to the general purpose routine
+ *      if command is not DMA.  Else, it sanity checks our local
+ *      caches of the request producer/consumer indices then enables
+ *      DMA and bumps the request producer index.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static int mv_qc_issue(struct ata_queued_cmd *qc)
 {
 	void __iomem *port_mmio = mv_ap_base(qc->ap);
@@ -867,6 +958,19 @@ static int mv_qc_issue(struct ata_queued
 	return 0;
 }
 
+/**
+ *      mv_get_crpb_status - get status from most recently completed cmd
+ *      @ap: ATA channel to manipulate
+ *
+ *      This routine is for use when the port is in DMA mode, when it
+ *      will be using the CRPB (command response block) method of
+ *      returning command completion information.  We assert indices
+ *      are good, grab status, and bump the response consumer index to
+ *      prove that we're up to date.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static u8 mv_get_crpb_status(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
@@ -896,6 +1000,19 @@ static u8 mv_get_crpb_status(struct ata_
 	return (pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT);
 }
 
+/**
+ *      mv_err_intr - Handle error interrupts on the port
+ *      @ap: ATA channel to manipulate
+ *
+ *      In most cases, just clear the interrupt and move on.  However,
+ *      some cases require an eDMA reset, which is done right before
+ *      the COMRESET in mv_phy_reset().  The SERR case requires a
+ *      clear of pending errors in the SATA SERROR register.  Finally,
+ *      if the port disabled DMA, update our cached copy to match.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_err_intr(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
@@ -923,7 +1040,22 @@ static void mv_err_intr(struct ata_port 
 	}
 }
 
-/* Handle any outstanding interrupts in a single SATAHC */
+/**
+ *      mv_host_intr - Handle all interrupts on the given host controller
+ *      @host_set: host specific structure
+ *      @relevant: port error bits relevant to this host controller
+ *      @hc: which host controller we're to look at
+ *
+ *      Read then write clear the HC interrupt status then walk each
+ *      port connected to the HC and see if it needs servicing.  Port
+ *      success ints are reported in the HC interrupt status reg, the
+ *      port error ints are reported in the higher level main
+ *      interrupt status register and thus are passed in via the
+ *      'relevant' argument.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_host_intr(struct ata_host_set *host_set, u32 relevant,
 			 unsigned int hc)
 {
@@ -993,6 +1125,21 @@ static void mv_host_intr(struct ata_host
 	VPRINTK("EXIT\n");
 }
 
+/**
+ *      mv_interrupt - 
+ *      @irq: unused
+ *      @dev_instance: private data; in this case the host structure
+ *      @regs: unused
+ *
+ *      Read the read only register to determine if any host
+ *      controllers have pending interrupts.  If so, call lower level
+ *      routine to handle.  Also check for PCI errors which are only
+ *      reported here.
+ *
+ *      LOCKING: 
+ *      This routine holds the host_set lock while processing pending
+ *      interrupts.
+ */
 static irqreturn_t mv_interrupt(int irq, void *dev_instance,
 				struct pt_regs *regs)
 {
@@ -1035,14 +1182,32 @@ static irqreturn_t mv_interrupt(int irq,
 	return IRQ_RETVAL(handled);
 }
 
+/**
+ *      mv_check_err - Return the error shadow register to caller.
+ *      @ap: ATA channel to manipulate
+ *
+ *      Marvell requires DMA to be stopped before accessing shadow
+ *      registers.  So we do that, then return the needed register.
+ *
+ *      LOCKING:
+ *      Inherited from caller.  FIXME: protect mv_stop_dma with lock?
+ */
 static u8 mv_check_err(struct ata_port *ap)
 {
 	mv_stop_dma(ap);		/* can't read shadow regs if DMA on */
 	return readb((void __iomem *) ap->ioaddr.error_addr);
 }
 
-/* Part of this is taken from __sata_phy_reset and modified to not sleep
- * since this routine gets called from interrupt level.
+/**
+ *      mv_phy_reset - Perform eDMA reset followed by COMRESET
+ *      @ap: ATA channel to manipulate
+ *
+ *      Part of this is taken from __sata_phy_reset and modified to
+ *      not sleep since this routine gets called from interrupt level.
+ *
+ *      LOCKING:
+ *      Inherited from caller.  This is coded to safe to call at
+ *      interrupt level, i.e. it does not sleep.
  */
 static void mv_phy_reset(struct ata_port *ap)
 {
@@ -1105,6 +1270,16 @@ static void mv_phy_reset(struct ata_port
 	VPRINTK("EXIT\n");
 }
 
+/**
+ *      mv_eng_timeout - Routine called by libata when SCSI times out I/O
+ *      @ap: ATA channel to manipulate
+ *
+ *      Intent is to clear all pending error conditions, reset the
+ *      chip/bus, fail the command, and move on.
+ *
+ *      LOCKING:
+ *      This routine holds the host_set lock while failing the command.
+ */
 static void mv_eng_timeout(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
@@ -1140,6 +1315,18 @@ static void mv_eng_timeout(struct ata_po
 	}
 }
 
+/**
+ *      mv_port_init - Perform some early initialization on a single port.
+ *      @port: libata data structure storing shadow register addresses
+ *      @port_mmio: base address of the port
+ *
+ *      Initialize shadow register mmio addresses, clear outstanding
+ *      interrupts on the port, and unmask interrupts for the future
+ *      start of the port.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_port_init(struct ata_ioports *port,  void __iomem *port_mmio)
 {
 	unsigned long shd_base = (unsigned long) port_mmio + SHD_BLK_OFS;
@@ -1177,6 +1364,16 @@ static void mv_port_init(struct ata_iopo
 		readl(port_mmio + EDMA_ERR_IRQ_MASK_OFS));
 }
 
+/**
+ *      mv_host_init - Perform some early initialization of the host.
+ *      @probe_ent: early data struct representing the host
+ *
+ *      If possible, do an early global reset of the host.  Then do
+ *      our port init and clear/unmask all/relevant host interrupts.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static int mv_host_init(struct ata_probe_ent *probe_ent)
 {
 	int rc = 0, n_hc, port, hc;
@@ -1226,7 +1423,15 @@ done:
 	return rc;
 }
 
-/* FIXME: complete this */
+/**
+ *      mv_print_info - Dump key info to kernel log for perusal.
+ *      @probe_ent: early data struct representing the host
+ *
+ *      FIXME: complete this.
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static void mv_print_info(struct ata_probe_ent *probe_ent)
 {
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
@@ -1253,6 +1458,14 @@ static void mv_print_info(struct ata_pro
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }
 
+/**
+ *      mv_init_one - handle a positive probe of a Marvell host
+ *      @pdev: PCI device found
+ *      @ent: PCI device ID entry for the matched host
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
