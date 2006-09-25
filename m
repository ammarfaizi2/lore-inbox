Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWIYBzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWIYBzm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWIYBzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:55:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45969 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751794AbWIYBzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:55:41 -0400
Date: Mon, 25 Sep 2006 02:55:40 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] SCSI gfp_t annotations
Message-ID: <20060925015540.GE29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/aic94xx/aic94xx.h      |    2 +-
 drivers/scsi/aic94xx/aic94xx_hwi.c  |    8 ++++----
 drivers/scsi/aic94xx/aic94xx_hwi.h  |    6 +++---
 drivers/scsi/aic94xx/aic94xx_task.c |   10 +++++-----
 drivers/scsi/libsas/sas_scsi_host.c |    2 +-
 include/scsi/libsas.h               |    4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx.h b/drivers/scsi/aic94xx/aic94xx.h
index 1bd5b4e..71a031d 100644
--- a/drivers/scsi/aic94xx/aic94xx.h
+++ b/drivers/scsi/aic94xx/aic94xx.h
@@ -94,7 +94,7 @@ void asd_dev_gone(struct domain_device *
 
 void asd_invalidate_edb(struct asd_ascb *ascb, int edb_id);
 
-int  asd_execute_task(struct sas_task *, int num, unsigned long gfp_flags);
+int  asd_execute_task(struct sas_task *, int num, gfp_t gfp_flags);
 
 /* ---------- TMFs ---------- */
 int  asd_abort_task(struct sas_task *);
diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index a242013..1d8c5e5 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -267,7 +267,7 @@ static int asd_init_dl(struct asd_ha_str
 
 /* ---------- EDB and ESCB init ---------- */
 
-static int asd_alloc_edbs(struct asd_ha_struct *asd_ha, unsigned int gfp_flags)
+static int asd_alloc_edbs(struct asd_ha_struct *asd_ha, gfp_t gfp_flags)
 {
 	struct asd_seq_data *seq = &asd_ha->seq;
 	int i;
@@ -298,7 +298,7 @@ Err_unroll:
 }
 
 static int asd_alloc_escbs(struct asd_ha_struct *asd_ha,
-			   unsigned int gfp_flags)
+			   gfp_t gfp_flags)
 {
 	struct asd_seq_data *seq = &asd_ha->seq;
 	struct asd_ascb *escb;
@@ -1028,7 +1028,7 @@ irqreturn_t asd_hw_isr(int irq, void *de
 /* ---------- SCB handling ---------- */
 
 static inline struct asd_ascb *asd_ascb_alloc(struct asd_ha_struct *asd_ha,
-					      unsigned int gfp_flags)
+					      gfp_t gfp_flags)
 {
 	extern kmem_cache_t *asd_ascb_cache;
 	struct asd_seq_data *seq = &asd_ha->seq;
@@ -1086,7 +1086,7 @@ undo:
  */
 struct asd_ascb *asd_ascb_alloc_list(struct asd_ha_struct
 				     *asd_ha, int *num,
-				     unsigned int gfp_flags)
+				     gfp_t gfp_flags)
 {
 	struct asd_ascb *first = NULL;
 
diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.h b/drivers/scsi/aic94xx/aic94xx_hwi.h
index c7d5053..8498144 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.h
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.h
@@ -242,7 +242,7 @@ #define PHY_ENABLED(_HA, _I) ((_HA)->hw_
 
 /* ---------- DMA allocs ---------- */
 
-static inline struct asd_dma_tok *asd_dmatok_alloc(unsigned int flags)
+static inline struct asd_dma_tok *asd_dmatok_alloc(gfp_t flags)
 {
 	return kmem_cache_alloc(asd_dma_token_cache, flags);
 }
@@ -254,7 +254,7 @@ static inline void asd_dmatok_free(struc
 
 static inline struct asd_dma_tok *asd_alloc_coherent(struct asd_ha_struct *
 						     asd_ha, size_t size,
-						     unsigned int flags)
+						     gfp_t flags)
 {
 	struct asd_dma_tok *token = asd_dmatok_alloc(flags);
 	if (token) {
@@ -376,7 +376,7 @@ irqreturn_t asd_hw_isr(int irq, void *de
 
 struct asd_ascb *asd_ascb_alloc_list(struct asd_ha_struct
 				     *asd_ha, int *num,
-				     unsigned int gfp_mask);
+				     gfp_t gfp_mask);
 
 int  asd_post_ascb_list(struct asd_ha_struct *asd_ha, struct asd_ascb *ascb,
 			int num);
diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 285e70d..d202ed5 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -53,7 +53,7 @@ static const u8 data_dir_flags[] = {
 
 static inline int asd_map_scatterlist(struct sas_task *task,
 				      struct sg_el *sg_arr,
-				      unsigned long gfp_flags)
+				      gfp_t gfp_flags)
 {
 	struct asd_ascb *ascb = task->lldd_task;
 	struct asd_ha_struct *asd_ha = ascb->ha;
@@ -368,7 +368,7 @@ Again:
 /* ---------- ATA ---------- */
 
 static int asd_build_ata_ascb(struct asd_ascb *ascb, struct sas_task *task,
-			      unsigned long gfp_flags)
+			      gfp_t gfp_flags)
 {
 	struct domain_device *dev = task->dev;
 	struct scb *scb;
@@ -437,7 +437,7 @@ static void asd_unbuild_ata_ascb(struct 
 /* ---------- SMP ---------- */
 
 static int asd_build_smp_ascb(struct asd_ascb *ascb, struct sas_task *task,
-			      unsigned long gfp_flags)
+			      gfp_t gfp_flags)
 {
 	struct asd_ha_struct *asd_ha = ascb->ha;
 	struct domain_device *dev = task->dev;
@@ -487,7 +487,7 @@ static void asd_unbuild_smp_ascb(struct 
 /* ---------- SSP ---------- */
 
 static int asd_build_ssp_ascb(struct asd_ascb *ascb, struct sas_task *task,
-			      unsigned long gfp_flags)
+			      gfp_t gfp_flags)
 {
 	struct domain_device *dev = task->dev;
 	struct scb *scb;
@@ -550,7 +550,7 @@ static inline int asd_can_queue(struct a
 }
 
 int asd_execute_task(struct sas_task *task, const int num,
-		     unsigned long gfp_flags)
+		     gfp_t gfp_flags)
 {
 	int res = 0;
 	LIST_HEAD(alist);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 43e0e4e..7f9e89b 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -134,7 +134,7 @@ static enum task_attribute sas_scsi_get_
 
 static struct sas_task *sas_create_task(struct scsi_cmnd *cmd,
 					       struct domain_device *dev,
-					       unsigned long gfp_flags)
+					       gfp_t gfp_flags)
 {
 	struct sas_task *task = sas_alloc_task(gfp_flags);
 	struct scsi_lun lun;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 30e5321..1d77b63 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -535,7 +535,7 @@ #define SAS_TASK_STATE_PENDING  1
 #define SAS_TASK_STATE_DONE     2
 #define SAS_TASK_STATE_ABORTED  4
 
-static inline struct sas_task *sas_alloc_task(unsigned long flags)
+static inline struct sas_task *sas_alloc_task(gfp_t flags)
 {
 	extern kmem_cache_t *sas_task_cache;
 	struct sas_task *task = kmem_cache_alloc(sas_task_cache, flags);
@@ -571,7 +571,7 @@ struct sas_domain_function_template {
 	void (*lldd_dev_gone)(struct domain_device *);
 
 	int (*lldd_execute_task)(struct sas_task *, int num,
-				 unsigned long gfp_flags);
+				 gfp_t gfp_flags);
 
 	/* Task Management Functions. Must be called from process context. */
 	int (*lldd_abort_task)(struct sas_task *);
-- 
1.4.2.GIT

