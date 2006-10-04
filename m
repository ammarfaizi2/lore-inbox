Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWJDHdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWJDHdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030641AbWJDHdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:33:32 -0400
Received: from server6.greatnet.de ([83.133.96.26]:11150 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030639AbWJDHda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:33:30 -0400
Message-ID: <452363DB.60107@nachtwindheim.de>
Date: Wed, 04 Oct 2006 09:33:47 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Scsi_Cmnd convertion in aic7xxx_old.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the obsolete Scsi_Cmnd to struct scsi_cmnd in aic7xxx_old.c.
Also replacing lots of whitespaces with tabs in structures and functions 
which have been changed.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---
Saves 1084 bytes in the source.

 aic7xxx_old.c |  299 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 145 insertions(+), 154 deletions(-)

diff --git a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
index 1035337..dc03270 100644
--- a/drivers/scsi/aic7xxx_old.c
+++ b/drivers/scsi/aic7xxx_old.c
@@ -780,24 +780,26 @@ typedef enum {
 } ahc_bugs;
 
 struct aic7xxx_scb {
-        struct aic7xxx_hwscb  *hscb;          /* corresponding hardware scb */
-        Scsi_Cmnd             *cmd;              /* Scsi_Cmnd for this scb */
-        struct aic7xxx_scb    *q_next;        /* next scb in queue */
-        volatile scb_flag_type flags;         /* current state of scb */
-        struct hw_scatterlist *sg_list;       /* SG list in adapter format */
-        unsigned char          tag_action;
-        unsigned char          sg_count;
-        unsigned char          *sense_cmd;    /*
-                                               * Allocate 6 characters for
-                                               * sense command.
-                                               */
-	unsigned char	       *cmnd;
-        unsigned int           sg_length; /* We init this during buildscb so we
-                                           * don't have to calculate anything
-                                           * during underflow/overflow/stat code
-                                           */
-        void                  *kmalloc_ptr;
-	struct aic7xxx_scb_dma *scb_dma;
+	struct aic7xxx_hwscb	*hscb;		/* corresponding hardware scb */
+	struct scsi_cmnd	*cmd;		/* scsi_cmnd for this scb */
+	struct aic7xxx_scb	*q_next;        /* next scb in queue */
+	volatile scb_flag_type	flags;		/* current state of scb */
+	struct hw_scatterlist	*sg_list;	/* SG list in adapter format */
+	unsigned char		tag_action;
+	unsigned char		sg_count;
+	unsigned char		*sense_cmd;	/*
+						 * Allocate 6 characters for
+						 * sense command.
+						 */
+	unsigned char		*cmnd;
+	unsigned int		sg_length;	/*
+						 * We init this during
+						 * buildscb so we don't have
+						 * to calculate anything during
+						 * underflow/overflow/stat code
+						 */
+	void			*kmalloc_ptr;
+	struct aic7xxx_scb_dma	*scb_dma;
 };
 
 /*
@@ -918,79 +920,77 @@ struct aic7xxx_host {
    * We are grouping things here....first, items that get either read or
    * written with nearly every interrupt
    */
-  volatile long            flags;
-  ahc_feature              features;         /* chip features */
-  unsigned long            base;             /* card base address */
-  volatile unsigned char  __iomem *maddr;            /* memory mapped address */
-  unsigned long            isr_count;        /* Interrupt count */
-  unsigned long            spurious_int;
-  scb_data_type           *scb_data;
-  struct aic7xxx_cmd_queue {
-    Scsi_Cmnd *head;
-    Scsi_Cmnd *tail;
-  } completeq;
+	volatile long	flags;
+	ahc_feature	features;	/* chip features */
+	unsigned long	base;		/* card base address */
+	volatile unsigned char  __iomem *maddr;	/* memory mapped address */
+	unsigned long	isr_count;	/* Interrupt count */
+	unsigned long	spurious_int;
+	scb_data_type	*scb_data;
+	struct aic7xxx_cmd_queue {
+		struct scsi_cmnd *head;
+		struct scsi_cmnd *tail;
+	} completeq;
 
-  /*
-   * Things read/written on nearly every entry into aic7xxx_queue()
-   */
-  volatile scb_queue_type  waiting_scbs;
-  unsigned char            unpause;          /* unpause value for HCNTRL */
-  unsigned char            pause;            /* pause value for HCNTRL */
-  volatile unsigned char   qoutfifonext;
-  volatile unsigned char   activescbs;       /* active scbs */
-  volatile unsigned char   max_activescbs;
-  volatile unsigned char   qinfifonext;
-  volatile unsigned char  *untagged_scbs;
-  volatile unsigned char  *qoutfifo;
-  volatile unsigned char  *qinfifo;
-
-  unsigned char            dev_last_queue_full[MAX_TARGETS];
-  unsigned char            dev_last_queue_full_count[MAX_TARGETS];
-  unsigned short	   ultraenb;         /* Gets downloaded to card as a
-						bitmap */
-  unsigned short	   discenable;       /* Gets downloaded to card as a
-						bitmap */
-  transinfo_type           user[MAX_TARGETS];
-
-  unsigned char            msg_buf[13];      /* The message for the target */
-  unsigned char            msg_type;
+	/*
+	* Things read/written on nearly every entry into aic7xxx_queue()
+	*/
+	volatile scb_queue_type	waiting_scbs;
+	unsigned char	unpause;	/* unpause value for HCNTRL */
+	unsigned char	pause;		/* pause value for HCNTRL */
+	volatile unsigned char	qoutfifonext;
+	volatile unsigned char	activescbs;	/* active scbs */
+	volatile unsigned char	max_activescbs;
+	volatile unsigned char	qinfifonext;
+	volatile unsigned char	*untagged_scbs;
+	volatile unsigned char	*qoutfifo;
+	volatile unsigned char	*qinfifo;
+
+	unsigned char	dev_last_queue_full[MAX_TARGETS];
+	unsigned char	dev_last_queue_full_count[MAX_TARGETS];
+	unsigned short	ultraenb; /* Gets downloaded to card as a bitmap */
+	unsigned short	discenable; /* Gets downloaded to card as a bitmap */
+	transinfo_type	user[MAX_TARGETS];
+
+	unsigned char	msg_buf[13];	/* The message for the target */
+	unsigned char	msg_type;
 #define MSG_TYPE_NONE              0x00
 #define MSG_TYPE_INITIATOR_MSGOUT  0x01
 #define MSG_TYPE_INITIATOR_MSGIN   0x02
-  unsigned char            msg_len;          /* Length of message */
-  unsigned char            msg_index;        /* Index into msg_buf array */
+	unsigned char	msg_len;	/* Length of message */
+	unsigned char	msg_index;	/* Index into msg_buf array */
 
 
-  /*
-   * We put the less frequently used host structure items after the more
-   * frequently used items to try and ease the burden on the cache subsystem.
-   * These entries are not *commonly* accessed, whereas the preceding entries
-   * are accessed very often.
-   */
-
-  unsigned int             irq;              /* IRQ for this adapter */
-  int                      instance;         /* aic7xxx instance number */
-  int                      scsi_id;          /* host adapter SCSI ID */
-  int                      scsi_id_b;        /* channel B for twin adapters */
-  unsigned int             bios_address;
-  int                      board_name_index;
-  unsigned short           bios_control;     /* bios control - SEEPROM */
-  unsigned short           adapter_control;  /* adapter control - SEEPROM */
-  struct pci_dev	  *pdev;
-  unsigned char            pci_bus;
-  unsigned char            pci_device_fn;
-  struct seeprom_config    sc;
-  unsigned short           sc_type;
-  unsigned short           sc_size;
-  struct aic7xxx_host     *next;             /* allow for multiple IRQs */
-  struct Scsi_Host        *host;             /* pointer to scsi host */
-  struct list_head	   aic_devs;	     /* all aic_dev structs on host */
-  int                      host_no;          /* SCSI host number */
-  unsigned long            mbase;            /* I/O memory address */
-  ahc_chip                 chip;             /* chip type */
-  ahc_bugs                 bugs;
-  dma_addr_t		   fifo_dma;	     /* DMA handle for fifo arrays */
+	/*
+	 * We put the less frequently used host structure items
+	 * after the more frequently used items to try and ease
+	 * the burden on the cache subsystem.
+	 * These entries are not *commonly* accessed, whereas
+	 * the preceding entries are accessed very often.
+	 */
 
+	unsigned int	irq;		/* IRQ for this adapter */
+	int		instance;	/* aic7xxx instance number */
+	int		scsi_id;	/* host adapter SCSI ID */
+	int		scsi_id_b;	/* channel B for twin adapters */
+	unsigned int	bios_address;
+	int		board_name_index;
+	unsigned short	bios_control;		/* bios control - SEEPROM */
+	unsigned short	adapter_control;	/* adapter control - SEEPROM */
+	struct pci_dev	*pdev;
+	unsigned char	pci_bus;
+	unsigned char	pci_device_fn;
+	struct seeprom_config	sc;
+	unsigned short	sc_type;
+	unsigned short	sc_size;
+	struct aic7xxx_host	*next;	/* allow for multiple IRQs */
+	struct Scsi_Host	*host;	/* pointer to scsi host */
+	struct list_head	 aic_devs; /* all aic_dev structs on host */
+	int		host_no;	/* SCSI host number */
+	unsigned long	mbase;		/* I/O memory address */
+	ahc_chip	chip;		/* chip type */
+	ahc_bugs	bugs;
+	dma_addr_t	fifo_dma;	/* DMA handle for fifo arrays */
 };
 
 /*
@@ -1271,7 +1271,7 @@ static void aic7xxx_set_syncrate(struct 
 static void aic7xxx_set_width(struct aic7xxx_host *p, int target, int channel,
 		int lun, unsigned int width, unsigned int type,
 		struct aic_dev_data *aic_dev);
-static void aic7xxx_panic_abort(struct aic7xxx_host *p, Scsi_Cmnd *cmd);
+static void aic7xxx_panic_abort(struct aic7xxx_host *p, struct scsi_cmnd *cmd);
 static void aic7xxx_print_card(struct aic7xxx_host *p);
 static void aic7xxx_print_scratch_ram(struct aic7xxx_host *p);
 static void aic7xxx_print_sequencer(struct aic7xxx_host *p, int downloaded);
@@ -2626,7 +2626,7 @@ #endif
  *   we're finished.  This function queues the completed commands.
  *-F*************************************************************************/
 static void
-aic7xxx_queue_cmd_complete(struct aic7xxx_host *p, Scsi_Cmnd *cmd)
+aic7xxx_queue_cmd_complete(struct aic7xxx_host *p, struct scsi_cmnd *cmd)
 {
   aic7xxx_position(cmd) = SCB_LIST_NULL;
   cmd->host_scribble = (char *)p->completeq.head;
@@ -2640,18 +2640,17 @@ aic7xxx_queue_cmd_complete(struct aic7xx
  * Description:
  *   Process the completed command queue.
  *-F*************************************************************************/
-static void
-aic7xxx_done_cmds_complete(struct aic7xxx_host *p)
+static void aic7xxx_done_cmds_complete(struct aic7xxx_host *p)
 {
-  Scsi_Cmnd *cmd;
-  
-  while (p->completeq.head != NULL)
-  {
-    cmd = p->completeq.head;
-    p->completeq.head = (Scsi_Cmnd *)cmd->host_scribble;
-    cmd->host_scribble = NULL;
-    cmd->scsi_done(cmd);
-  }
+	
+	struct scsi_cmnd *cmd;
+	
+	while (p->completeq.head != NULL) {
+		cmd = p->completeq.head;
+		p->completeq.head = (struct scsi_Cmnd *) cmd->host_scribble;
+		cmd->host_scribble = NULL;
+		cmd->scsi_done(cmd);
+	}
 }
 
 /*+F*************************************************************************
@@ -2687,11 +2686,11 @@ aic7xxx_free_scb(struct aic7xxx_host *p,
 static void
 aic7xxx_done(struct aic7xxx_host *p, struct aic7xxx_scb *scb)
 {
-  Scsi_Cmnd *cmd = scb->cmd;
-  struct aic_dev_data *aic_dev = cmd->device->hostdata;
-  int tindex = TARGET_INDEX(cmd);
-  struct aic7xxx_scb *scbp;
-  unsigned char queue_depth;
+	struct scsi_cmnd *cmd = scb->cmd;
+	struct aic_dev_data *aic_dev = cmd->device->hostdata;
+	int tindex = TARGET_INDEX(cmd);
+	struct aic7xxx_scb *scbp;
+	unsigned char queue_depth;
 
   if (cmd->use_sg > 1)
   {
@@ -2891,7 +2890,7 @@ #endif
  *   aic7xxx_run_done_queue
  *
  * Description:
- *   Calls the aic7xxx_done() for the Scsi_Cmnd of each scb in the
+ *   Calls the aic7xxx_done() for the scsi_cmnd of each scb in the
  *   aborted list, and adds each scb to the free list.  If complete
  *   is TRUE, we also process the commands complete list.
  *-F*************************************************************************/
@@ -3826,9 +3825,9 @@ aic7xxx_construct_wdtr(struct aic7xxx_ho
 static void
 aic7xxx_calculate_residual (struct aic7xxx_host *p, struct aic7xxx_scb *scb)
 {
-  struct aic7xxx_hwscb *hscb;
-  Scsi_Cmnd *cmd;
-  int actual, i;
+	struct aic7xxx_hwscb *hscb;
+	struct scsi_cmnd *cmd;
+	int actual, i;
 
   cmd = scb->cmd;
   hscb = scb->hscb;
@@ -4219,20 +4218,20 @@ #endif
 
     case BAD_STATUS:
       {
-        unsigned char scb_index;
-        struct aic7xxx_hwscb *hscb;
-        Scsi_Cmnd *cmd;
-
-        /* The sequencer will notify us when a command has an error that
-         * would be of interest to the kernel.  This allows us to leave
-         * the sequencer running in the common case of command completes
-         * without error.  The sequencer will have DMA'd the SCB back
-         * up to us, so we can reference the drivers SCB array.
-         *
-         * Set the default return value to 0 indicating not to send
-         * sense.  The sense code will change this if needed and this
-         * reduces code duplication.
-         */
+	unsigned char scb_index;
+	struct aic7xxx_hwscb *hscb;
+	struct scsi_cmnd *cmd;
+
+	/* The sequencer will notify us when a command has an error that
+	 * would be of interest to the kernel.  This allows us to leave
+	 * the sequencer running in the common case of command completes
+	 * without error.  The sequencer will have DMA'd the SCB back
+	 * up to us, so we can reference the drivers SCB array.
+	 *
+	 * Set the default return value to 0 indicating not to send
+	 * sense.  The sense code will change this if needed and this
+	 * reduces code duplication.
+	 */
         aic_outb(p, 0, RETURN_1);
         scb_index = aic_inb(p, SCB_TAG);
         if (scb_index > p->scb_data->numscbs)
@@ -5800,9 +5799,9 @@ aic7xxx_handle_scsiint(struct aic7xxx_ho
   }
   else if ((status & SELTO) != 0)
   {
-    unsigned char scbptr;
-    unsigned char nextscb;
-    Scsi_Cmnd *cmd;
+	unsigned char scbptr;
+	unsigned char nextscb;
+	struct scsi_cmnd *cmd;
 
     scbptr = aic_inb(p, WAITING_SCBH);
     if (scbptr > p->scb_data->maxhscbs)
@@ -5941,11 +5940,11 @@ #endif
     /*
      * Determine the bus phase and queue an appropriate message.
      */
-    char  *phase;
-    Scsi_Cmnd *cmd;
-    unsigned char mesg_out = MSG_NOOP;
-    unsigned char lastphase = aic_inb(p, LASTPHASE);
-    unsigned char sstat2 = aic_inb(p, SSTAT2);
+	char  *phase;
+	struct scsi_cmnd *cmd;
+	unsigned char mesg_out = MSG_NOOP;
+	unsigned char lastphase = aic_inb(p, LASTPHASE);
+	unsigned char sstat2 = aic_inb(p, SSTAT2);
 
     cmd = scb->cmd;
     switch (lastphase)
@@ -6248,10 +6247,10 @@ #endif
 static void
 aic7xxx_handle_command_completion_intr(struct aic7xxx_host *p)
 {
-  struct aic7xxx_scb *scb = NULL;
-  struct aic_dev_data *aic_dev;
-  Scsi_Cmnd *cmd;
-  unsigned char scb_index, tindex;
+	struct aic7xxx_scb *scb = NULL;
+	struct aic_dev_data *aic_dev;
+	struct scsi_cmnd *cmd;
+	unsigned char scb_index, tindex;
 
 #ifdef AIC7XXX_VERBOSE_DEBUGGING
   if( (p->isr_count < 16) && (aic7xxx_verbose > 0xffff) )
@@ -10131,9 +10130,8 @@ #endif /* defined(__i386__) || defined(_
  * Description:
  *   Build a SCB.
  *-F*************************************************************************/
-static void
-aic7xxx_buildscb(struct aic7xxx_host *p, Scsi_Cmnd *cmd,
-    struct aic7xxx_scb *scb)
+static void aic7xxx_buildscb(struct aic7xxx_host *p, struct scsi_cmnd *cmd,
+			     struct aic7xxx_scb *scb)
 {
   unsigned short mask;
   struct aic7xxx_hwscb *hscb;
@@ -10285,8 +10283,7 @@ aic7xxx_buildscb(struct aic7xxx_host *p,
  * Description:
  *   Queue a SCB to the controller.
  *-F*************************************************************************/
-static int
-aic7xxx_queue(Scsi_Cmnd *cmd, void (*fn)(Scsi_Cmnd *))
+static int aic7xxx_queue(struct scsi_cmnd *cmd, void (*fn)(struct scsi_cmnd *))
 {
   struct aic7xxx_host *p;
   struct aic7xxx_scb *scb;
@@ -10319,11 +10316,11 @@ #endif
   }
   scb->cmd = cmd;
 
-  /*
-   * Make sure the Scsi_Cmnd pointer is saved, the struct it points to
-   * is set up properly, and the parity error flag is reset, then send
-   * the SCB to the sequencer and watch the fun begin.
-   */
+	/*
+	* Make sure the scsi_cmnd pointer is saved, the struct it points to
+	* is set up properly, and the parity error flag is reset, then send
+	* the SCB to the sequencer and watch the fun begin.
+	*/
   aic7xxx_position(cmd) = scb->hscb->tag;
   cmd->scsi_done = fn;
   cmd->result = DID_OK;
@@ -10356,8 +10353,7 @@ #endif
  *   aborted, then we will reset the channel and have all devices renegotiate.
  *   Returns an enumerated type that indicates the status of the operation.
  *-F*************************************************************************/
-static int
-__aic7xxx_bus_device_reset(Scsi_Cmnd *cmd)
+static int __aic7xxx_bus_device_reset(struct scsi_cmnd *cmd)
 {
   struct aic7xxx_host  *p;
   struct aic7xxx_scb   *scb;
@@ -10550,8 +10546,7 @@ __aic7xxx_bus_device_reset(Scsi_Cmnd *cm
     return SUCCESS;
 }
 
-static int
-aic7xxx_bus_device_reset(Scsi_Cmnd *cmd)
+static int aic7xxx_bus_device_reset(struct scsi_cmnd *cmd)
 {
       int rc;
 
@@ -10570,8 +10565,7 @@ aic7xxx_bus_device_reset(Scsi_Cmnd *cmd)
  * Description:
  *   Abort the current SCSI command(s).
  *-F*************************************************************************/
-static void
-aic7xxx_panic_abort(struct aic7xxx_host *p, Scsi_Cmnd *cmd)
+static void aic7xxx_panic_abort(struct aic7xxx_host *p, struct scsi_cmnd *cmd)
 {
 
   printk("aic7xxx driver version %s\n", AIC7XXX_C_VERSION);
@@ -10595,8 +10589,7 @@ aic7xxx_panic_abort(struct aic7xxx_host 
  * Description:
  *   Abort the current SCSI command(s).
  *-F*************************************************************************/
-static int
-__aic7xxx_abort(Scsi_Cmnd *cmd)
+static int __aic7xxx_abort(struct scsi_cmnd *cmd)
 {
   struct aic7xxx_scb  *scb = NULL;
   struct aic7xxx_host *p;
@@ -10813,8 +10806,7 @@ success:
   return SUCCESS;
 }
 
-static int
-aic7xxx_abort(Scsi_Cmnd *cmd)
+static int aic7xxx_abort(struct scsi_cmnd *cmd)
 {
 	int rc;
 
@@ -10836,8 +10828,7 @@ aic7xxx_abort(Scsi_Cmnd *cmd)
  *   DEVICE RESET message - on the offending target before pulling
  *   the SCSI bus reset line.
  *-F*************************************************************************/
-static int
-aic7xxx_reset(Scsi_Cmnd *cmd)
+static int aic7xxx_reset(struct scsi_cmnd *cmd)
 {
   struct aic7xxx_scb *scb;
   struct aic7xxx_host *p;


