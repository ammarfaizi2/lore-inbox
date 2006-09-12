Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWILUHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWILUHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWILUHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:07:11 -0400
Received: from server6.greatnet.de ([83.133.96.26]:19105 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030292AbWILUHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:07:06 -0400
Message-ID: <45071368.1000206@nachtwindheim.de>
Date: Tue, 12 Sep 2006 22:07:04 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] 53c7xx: Scsi_Cmnd to struct scsi_cmnd convertion
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Changes obsolete typedef'd Scsi_Cmnd into struct scsi_cmnd.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

diff -ruN linux-2.6/drivers/scsi/53c7xx.c devel/drivers/scsi/53c7xx.c
--- linux-2.6/drivers/scsi/53c7xx.c	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/53c7xx.c	2006-09-12 21:50:04.000000000 +0200
@@ -307,7 +307,7 @@
 
 static int check_address (unsigned long addr, int size);
 static void dump_events (struct Scsi_Host *host, int count);
-static Scsi_Cmnd * return_outstanding_commands (struct Scsi_Host *host, 
+static struct scsi_cmnd * return_outstanding_commands (struct Scsi_Host *host, 
     int free, int issue);
 static void hard_reset (struct Scsi_Host *host);
 static void ncr_scsi_reset (struct Scsi_Host *host);
@@ -316,7 +316,7 @@
     int scntl3, int now_connected);
 static int datapath_residual (struct Scsi_Host *host);
 static const char * sbcl_to_phase (int sbcl);
-static void print_progress (Scsi_Cmnd *cmd);
+static void print_progress(struct scsi_cmnd *cmd);
 static void print_queues (struct Scsi_Host *host);
 static void process_issue_queue (unsigned long flags);
 static int shutdown (struct Scsi_Host *host);
@@ -1759,7 +1759,7 @@
 
 static void 
 NCR53c7xx_dsa_fixup (struct NCR53c7x0_cmd *cmd) {
-    Scsi_Cmnd *c = cmd->cmd;
+    struct scsi_cmnd *c = cmd->cmd;
     struct Scsi_Host *host = c->device->host;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
     	host->hostdata[0];
@@ -1845,7 +1845,7 @@
  *
  * Purpose : mark SCSI command as finished, OR'ing the host portion 
  *	of the result word into the result field of the corresponding
- *	Scsi_Cmnd structure, and removing it from the internal queues.
+ *	scsi_cmnd structure, and removing it from the internal queues.
  *
  * Inputs : cmd - command, result - entire result field
  *
@@ -1856,7 +1856,7 @@
 
 static void 
 abnormal_finished (struct NCR53c7x0_cmd *cmd, int result) {
-    Scsi_Cmnd *c = cmd->cmd;
+	struct scsi_cmnd *c = cmd->cmd;
     struct Scsi_Host *host = c->device->host;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
     	host->hostdata[0];
@@ -1975,7 +1975,7 @@
     NCR53c7x0_local_declare();
     struct NCR53c7x0_break *bp;
 #if 0
-    Scsi_Cmnd *c = cmd ? cmd->cmd : NULL;
+	struct scsi_cmnd *c = cmd ? cmd->cmd : NULL;
 #endif
     u32 *dsp;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
@@ -2252,7 +2252,7 @@
     NCR53c7x0_cmd *cmd) {
     NCR53c7x0_local_declare();
     int print;
-    Scsi_Cmnd *c = cmd ? cmd->cmd : NULL;
+	struct scsi_cmnd *c = cmd ? cmd->cmd : NULL;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
 	host->hostdata[0];		
     u32 dsps,*dsp;	/* Argument of the INT instruction */
@@ -3022,7 +3022,7 @@
 
 
 /*
- * Function static struct NCR53c7x0_cmd *allocate_cmd (Scsi_Cmnd *cmd)
+ * Function static struct NCR53c7x0_cmd *allocate_cmd (struct scsi_cmnd *cmd)
  * 
  * Purpose : Return the first free NCR53c7x0_cmd structure (which are 
  * 	reused in a LIFO manner to minimize cache thrashing).
@@ -3048,8 +3048,8 @@
     free_page ((u32)addr);
 }
 
-static struct NCR53c7x0_cmd *
-allocate_cmd (Scsi_Cmnd *cmd) {
+static struct NCR53c7x0_cmd *allocate_cmd(struct scsi_cmnd *cmd)
+{
     struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = 
 	(struct NCR53c7x0_hostdata *) host->hostdata[0];
@@ -3067,7 +3067,7 @@
 
 /*
  * If we have not yet reserved commands for this I_T_L nexus, and
- * the device exists (as indicated by permanent Scsi_Cmnd structures
+ * the device exists (as indicated by permanent scsi_cmnd structures
  * being allocated under 1.3.x, or being outside of scan_scsis in
  * 1.2.x), do so now.
  */
@@ -3136,11 +3136,11 @@
 }
 
 /*
- * Function static struct NCR53c7x0_cmd *create_cmd (Scsi_Cmnd *cmd) 
+ * Function static struct NCR53c7x0_cmd *create_cmd (struct scsi_cmnd *cmd) 
  *
  *
  * Purpose : allocate a NCR53c7x0_cmd structure, initialize it based on the 
- * 	Scsi_Cmnd structure passed in cmd, including dsa and Linux field 
+ * 	scsi_cmnd structure passed in cmd, including dsa and Linux field 
  * 	initialization, and dsa code relocation.
  *
  * Inputs : cmd - SCSI command
@@ -3148,8 +3148,8 @@
  * Returns : NCR53c7x0_cmd structure corresponding to cmd,
  *	NULL on failure.
  */
-static struct NCR53c7x0_cmd *
-create_cmd (Scsi_Cmnd *cmd) {
+static struct NCR53c7x0_cmd *create_cmd(struct scsi_cmnd *cmd)
+{
     NCR53c7x0_local_declare();
     struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
@@ -3173,7 +3173,7 @@
 	return NULL;
 
     /*
-     * Copy CDB and initialised result fields from Scsi_Cmnd to NCR53c7x0_cmd.
+     * Copy CDB and initialised result fields from scsi_cmnd to NCR53c7x0_cmd.
      * We do this because NCR53c7x0_cmd may have a special cache mode
      * selected to cope with lack of bus snooping, etc.
      */
@@ -3316,7 +3316,7 @@
 
     patch_dsa_32(tmp->dsa, dsa_next, 0, 0);
     /*
-     * XXX is this giving 53c710 access to the Scsi_Cmnd in some way?
+     * XXX is this giving 53c710 access to the scsi_cmnd in some way?
      * Do we need to change it for caching reasons?
      */
     patch_dsa_32(tmp->dsa, dsa_cmnd, 0, virt_to_bus(cmd));
@@ -3570,8 +3570,8 @@
 }
 
 /*
- * Function : int NCR53c7xx_queue_command (Scsi_Cmnd *cmd,
- *      void (*done)(Scsi_Cmnd *))
+ * Function : int NCR53c7xx_queue_command(struct scsi_cmnd *cmd,
+ *      void (*done)(struct scsi_cmnd *))
  *
  * Purpose :  enqueues a SCSI command
  *
@@ -3585,18 +3585,19 @@
  *      twiddling done to the host specific fields of cmd.  If the
  *      process_issue_queue coroutine isn't running, it is restarted.
  * 
- * NOTE : we use the host_scribble field of the Scsi_Cmnd structure to 
+ * NOTE : we use the host_scribble field of the scsi_cmnd structure to 
  *	hold our own data, and pervert the ptr field of the SCp field
  *	to create a linked list.
  */
 
-int
-NCR53c7xx_queue_command (Scsi_Cmnd *cmd, void (* done)(Scsi_Cmnd *)) {
+int NCR53c7xx_queue_command(struct scsi_cmnd *cmd,
+			    void (* done) (struct scsi_cmnd *))
+{
     struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = 
 	(struct NCR53c7x0_hostdata *) host->hostdata[0];
     unsigned long flags;
-    Scsi_Cmnd *tmp;
+    struct scsi_cmnd *tmp;
 
     cmd->scsi_done = done;
     cmd->host_scribble = NULL;
@@ -3673,8 +3674,8 @@
 	cmd->SCp.ptr = (unsigned char *) hostdata->issue_queue;
 	hostdata->issue_queue = cmd;
     } else {
-	for (tmp = (Scsi_Cmnd *) hostdata->issue_queue; tmp->SCp.ptr; 
-		tmp = (Scsi_Cmnd *) tmp->SCp.ptr);
+	for (tmp = (struct scsi_cmnd *) hostdata->issue_queue; tmp->SCp.ptr; 
+		tmp = (struct scsi_cmnd *) tmp->SCp.ptr);
 	tmp->SCp.ptr = (unsigned char *) cmd;
     }
     local_irq_restore(flags);
@@ -3684,7 +3685,7 @@
 
 /*
  * Function : void to_schedule_list (struct Scsi_Host *host,
- * 	struct NCR53c7x0_hostdata * hostdata, Scsi_Cmnd *cmd)
+ * 	struct NCR53c7x0_hostdata * hostdata, struct scsi_cmnd *cmd)
  *
  * Purpose : takes a SCSI command which was just removed from the 
  *	issue queue, and deals with it by inserting it in the first
@@ -3705,7 +3706,7 @@
 to_schedule_list (struct Scsi_Host *host, struct NCR53c7x0_hostdata *hostdata,
     struct NCR53c7x0_cmd *cmd) {
     NCR53c7x0_local_declare();
-    Scsi_Cmnd *tmp = cmd->cmd;
+    struct scsi_cmnd *tmp = cmd->cmd;
     unsigned long flags;
     /* dsa start is negative, so subtraction is used */
     volatile u32 *ncrcurrent;
@@ -3786,7 +3787,7 @@
 
 /*
  * Function : busyp (struct Scsi_Host *host, struct NCR53c7x0_hostdata 
- *	*hostdata, Scsi_Cmnd *cmd)
+ *	*hostdata, struct scsi_cmnd *cmd)
  *
  * Purpose : decide if we can pass the given SCSI command on to the 
  *	device in question or not.
@@ -3794,9 +3795,10 @@
  * Returns : non-zero when we're busy, 0 when we aren't.
  */
 
-static __inline__ int
-busyp (struct Scsi_Host *host, struct NCR53c7x0_hostdata *hostdata, 
-    Scsi_Cmnd *cmd) {
+static __inline__ int busyp(struct Scsi_Host *host,
+			    struct NCR53c7x0_hostdata *hostdata,
+			    struct scsi_cmnd *cmd)
+{
     /* FIXME : in the future, this needs to accommodate SCSI-II tagged
        queuing, and we may be able to play with fairness here a bit.
      */
@@ -3822,7 +3824,7 @@
 
 static void 
 process_issue_queue (unsigned long flags) {
-    Scsi_Cmnd *tmp, *prev;
+    struct scsi_cmnd *tmp, *prev;
     struct Scsi_Host *host;
     struct NCR53c7x0_hostdata *hostdata;
     int done;
@@ -3847,8 +3849,8 @@
 	    local_irq_disable();
 	    if (hostdata->issue_queue) {
 	    	if (hostdata->state == STATE_DISABLED) {
-		    tmp = (Scsi_Cmnd *) hostdata->issue_queue;
-		    hostdata->issue_queue = (Scsi_Cmnd *) tmp->SCp.ptr;
+		    tmp = (struct scsi_cmnd *) hostdata->issue_queue;
+		    hostdata->issue_queue = (struct scsi_cmnd *) tmp->SCp.ptr;
 		    tmp->result = (DID_BAD_TARGET << 16);
 		    if (tmp->host_scribble) {
 			((struct NCR53c7x0_cmd *)tmp->host_scribble)->next = 
@@ -3860,15 +3862,15 @@
 		    tmp->scsi_done (tmp);
 		    done = 0;
 		} else 
-		    for (tmp = (Scsi_Cmnd *) hostdata->issue_queue, 
-			prev = NULL; tmp; prev = tmp, tmp = (Scsi_Cmnd *) 
-			tmp->SCp.ptr) 
+		    for (tmp = (struct scsi_cmnd *) hostdata->issue_queue,
+			prev = NULL; tmp; prev = tmp, tmp = (struct scsi_cmnd *)
+			tmp->SCp.ptr)
 			if (!tmp->host_scribble || 
 			    !busyp (host, hostdata, tmp)) {
 				if (prev)
 				    prev->SCp.ptr = tmp->SCp.ptr;
 				else
-				    hostdata->issue_queue = (Scsi_Cmnd *) 
+				    hostdata->issue_queue = (struct scsi_cmnd *)
 					tmp->SCp.ptr;
 			    tmp->SCp.ptr = NULL;
 			    if (tmp->host_scribble) {
@@ -4168,7 +4170,7 @@
 	cmd_prev_ptr = (struct NCR53c7x0_cmd **) &(cmd->next), 
     	cmd = (struct NCR53c7x0_cmd *) cmd->next)
     {
-	Scsi_Cmnd *tmp;
+	struct scsi_cmnd *tmp;
 
 	if (!cmd) {
 	    printk("scsi%d : very weird.\n", host->host_no);
@@ -4176,7 +4178,7 @@
 	}
 
 	if (!(tmp = cmd->cmd)) {
-	    printk("scsi%d : weird.  NCR53c7x0_cmd has no Scsi_Cmnd\n",
+	    printk("scsi%d : weird.  NCR53c7x0_cmd has no scsi_cmnd\n",
 		    host->host_no);
 	    continue;
 	}
@@ -4360,7 +4362,7 @@
  *
  * Purpose : Assuming that the NCR SCSI processor is currently 
  * 	halted, break the currently established nexus.  Clean
- *	up of the NCR53c7x0_cmd and Scsi_Cmnd structures should
+ *	up of the NCR53c7x0_cmd and scsi_cmnd structures should
  *	be done on receipt of the abort interrupt.
  *
  * Inputs : host - SCSI host
@@ -5127,7 +5129,7 @@
 }
 
 /*
- * Function : int NCR53c7xx_abort (Scsi_Cmnd *cmd)
+ * Function : int NCR53c7xx_abort (struct scsi_cmnd *cmd)
  * 
  * Purpose : Abort an errant SCSI command, doing all necessary
  *	cleanup of the issue_queue, running_list, shared Linux/NCR
@@ -5138,15 +5140,15 @@
  * Returns : 0 on success, -1 on failure.
  */
 
-int 
-NCR53c7xx_abort (Scsi_Cmnd *cmd) {
+int NCR53c7xx_abort(struct scsi_cmnd *cmd)
+{
     NCR53c7x0_local_declare();
     struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = host ? (struct NCR53c7x0_hostdata *) 
 	host->hostdata[0] : NULL;
     unsigned long flags;
     struct NCR53c7x0_cmd *curr, **prev;
-    Scsi_Cmnd *me, **last;
+	struct scsi_cmnd *me, **last;
 #if 0
     static long cache_pid = -1;
 #endif
@@ -5201,13 +5203,13 @@
  * pull the command out of the old queue, and call it aborted.
  */
 
-    for (me = (Scsi_Cmnd *) hostdata->issue_queue, 
-         last = (Scsi_Cmnd **) &(hostdata->issue_queue);
-	 me && me != cmd;  last = (Scsi_Cmnd **)&(me->SCp.ptr), 
-	 me = (Scsi_Cmnd *)me->SCp.ptr);
+    for (me = (struct scsi_cmnd *) hostdata->issue_queue, 
+         last = (struct scsi_cmnd **) &(hostdata->issue_queue);
+	 me && me != cmd;  last = (struct scsi_cmnd **)&(me->SCp.ptr), 
+	 me = (struct scsi_cmnd *)me->SCp.ptr);
 
     if (me) {
-	*last = (Scsi_Cmnd *) me->SCp.ptr;
+	*last = (struct scsi_cmnd *) me->SCp.ptr;
 	if (me->host_scribble) {
 	    ((struct NCR53c7x0_cmd *)me->host_scribble)->next = hostdata->free;
 	    hostdata->free = (struct NCR53c7x0_cmd *) me->host_scribble;
@@ -5291,7 +5293,7 @@
 }
 
 /*
- * Function : int NCR53c7xx_reset (Scsi_Cmnd *cmd) 
+ * Function : int NCR53c7xx_reset (struct scsi_cmnd *cmd) 
  * 
  * Purpose : perform a hard reset of the SCSI bus and NCR
  * 	chip.
@@ -5301,13 +5303,13 @@
  * Returns : 0 on success.
  */
  
-int 
-NCR53c7xx_reset (Scsi_Cmnd *cmd, unsigned int reset_flags) {
+int NCR53c7xx_reset(struct scsi_cmnd *cmd, unsigned int reset_flags)
+{
     NCR53c7x0_local_declare();
     unsigned long flags;
     int found = 0;
     struct NCR53c7x0_cmd * c;
-    Scsi_Cmnd *tmp;
+	struct scsi_cmnd *tmp;
     /*
      * When we call scsi_done(), it's going to wake up anything sleeping on the
      * resources which were in use by the aborted commands, and we'll start to 
@@ -5322,7 +5324,7 @@
      * pointer), do our reinitialization, and then call the done function for
      * each command.  
      */
-    Scsi_Cmnd *nuke_list = NULL;
+	struct scsi_cmnd *nuke_list = NULL;
     struct Scsi_Host *host = cmd->device->host;
     struct NCR53c7x0_hostdata *hostdata = 
     	(struct NCR53c7x0_hostdata *) host->hostdata[0];
@@ -5334,7 +5336,7 @@
     dump_events (host, 30);
     ncr_scsi_reset (host);
     for (tmp = nuke_list = return_outstanding_commands (host, 1 /* free */,
-	0 /* issue */ ); tmp; tmp = (Scsi_Cmnd *) tmp->SCp.buffer)
+	0 /* issue */ ); tmp; tmp = (struct scsi_cmnd *) tmp->SCp.buffer)
 	if (tmp == cmd) {
 	    found = 1;
 	    break;
@@ -5364,7 +5366,7 @@
 	--hostdata->resets;
     local_irq_restore(flags);
     for (; nuke_list; nuke_list = tmp) {
-	tmp = (Scsi_Cmnd *) nuke_list->SCp.buffer;
+	tmp = (struct scsi_cmnd *) nuke_list->SCp.buffer;
     	nuke_list->result = DID_RESET << 16;
 	nuke_list->scsi_done (nuke_list);
     }
@@ -5378,7 +5380,7 @@
  */
 
 /*
- * Function : int insn_to_offset (Scsi_Cmnd *cmd, u32 *insn)
+ * Function : int insn_to_offset (struct scsi_cmnd *cmd, u32 *insn)
  *
  * Purpose : convert instructions stored at NCR pointer into data 
  *	pointer offset.
@@ -5390,8 +5392,8 @@
  */
 
 
-static int 
-insn_to_offset (Scsi_Cmnd *cmd, u32 *insn) {
+static int insn_to_offset(struct scsi_cmnd *cmd, u32 *insn)
+{
     struct NCR53c7x0_hostdata *hostdata = 
 	(struct NCR53c7x0_hostdata *) cmd->device->host->hostdata[0];
     struct NCR53c7x0_cmd *ncmd = 
@@ -5445,7 +5447,7 @@
 
 
 /*
- * Function : void print_progress (Scsi_Cmnd *cmd) 
+ * Function : void print_progress (struct scsi_cmnd *cmd) 
  * 
  * Purpose : print the current location of the saved data pointer
  *
@@ -5453,8 +5455,8 @@
  *
  */
 
-static void 
-print_progress (Scsi_Cmnd *cmd) {
+static void print_progress(struct scsi_cmnd *cmd)
+{
     NCR53c7x0_local_declare();
     struct NCR53c7x0_cmd *ncmd = 
 	(struct NCR53c7x0_cmd *) cmd->host_scribble;
@@ -5512,7 +5514,7 @@
 	host->hostdata[0];
     int i, len;
     char *ptr;
-    Scsi_Cmnd *cmd;
+	struct scsi_cmnd *cmd;
 
     if (check_address ((unsigned long) dsa, hostdata->dsa_end - 
 	hostdata->dsa_start) == -1) {
@@ -5548,7 +5550,8 @@
 
     printk("        + %d : select_indirect = 0x%x\n",
 	hostdata->dsa_select, dsa[hostdata->dsa_select / sizeof(u32)]);
-    cmd = (Scsi_Cmnd *) bus_to_virt(dsa[hostdata->dsa_cmnd / sizeof(u32)]);
+    cmd = (struct scsi_cmnd *)
+	    bus_to_virt(dsa[hostdata->dsa_cmnd / sizeof(u32)]);
     printk("        + %d : dsa_cmnd = 0x%x ", hostdata->dsa_cmnd,
 	   (u32) virt_to_bus(cmd));
     /* XXX Maybe we should access cmd->host_scribble->result here. RGH */
@@ -5588,15 +5591,16 @@
     u32 *dsa, *next_dsa;
     volatile u32 *ncrcurrent;
     int left;
-    Scsi_Cmnd *cmd, *next_cmd;
+	struct scsi_cmnd *cmd, *next_cmd;
     unsigned long flags;
 
     printk ("scsi%d : issue queue\n", host->host_no);
 
-    for (left = host->can_queue, cmd = (Scsi_Cmnd *) hostdata->issue_queue; 
+    for (left = host->can_queue,
+	    cmd = (struct scsi_cmnd *) hostdata->issue_queue; 
 	    left >= 0 && cmd; 
 	    cmd = next_cmd) {
-	next_cmd = (Scsi_Cmnd *) cmd->SCp.ptr;
+	next_cmd = (struct scsi_cmnd *) cmd->SCp.ptr;
 	local_irq_save(flags);
 	if (cmd->host_scribble) {
 	    if (check_address ((unsigned long) (cmd->host_scribble), 
@@ -5792,16 +5796,16 @@
 
 
 /*
- * Function : Scsi_Cmnd *return_outstanding_commands (struct Scsi_Host *host,
- *	int free, int issue)
+ * Function : struct scsi_cmnd *return_outstanding_commands(
+ * 	struct Scsi_Host *host,	int free, int issue)
  *
  * Purpose : return a linked list (using the SCp.buffer field as next,
  *	so we don't perturb hostdata.  We don't use a field of the 
  *	NCR53c7x0_cmd structure since we may not have allocated one 
- *	for the command causing the reset.) of Scsi_Cmnd structures that 
+ *	for the command causing the reset.) of scsi_cmnd structures that 
  *  	had propagated below the Linux issue queue level.  If free is set, 
  *	free the NCR53c7x0_cmd structures which are associated with 
- *	the Scsi_Cmnd structures, and clean up any internal 
+ *	the scsi_cmnd structures, and clean up any internal 
  *	NCR lists that the commands were on.  If issue is set,
  *	also return commands in the issue queue.
  *
@@ -5811,14 +5815,15 @@
  *	if the free flag is set. 
  */
 
-static Scsi_Cmnd *
-return_outstanding_commands (struct Scsi_Host *host, int free, int issue) {
+static struct scsi_cmnd * return_outstanding_commands(struct Scsi_Host *host,
+						      int free, int issue)
+{
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
 	host->hostdata[0];
     struct NCR53c7x0_cmd *c;
     int i;
     u32 *ncrcurrent;
-    Scsi_Cmnd *list = NULL, *tmp;
+	struct scsi_cmnd *list = NULL, *tmp;
     for (c = (struct NCR53c7x0_cmd *) hostdata->running_list; c; 
     	c = (struct NCR53c7x0_cmd *) c->next)  {
 	if (c->cmd->SCp.buffer) {
@@ -5847,7 +5852,8 @@
     }
 
     if (issue) {
-	for (tmp = (Scsi_Cmnd *) hostdata->issue_queue; tmp; tmp = tmp->next) {
+	for (tmp = (struct scsi_cmnd *) hostdata->issue_queue;
+			tmp; tmp = tmp->next) {
 	    if (tmp->SCp.buffer) {
 		printk ("scsi%d : loop detected in issue queue!\n", 
 			host->host_no);
@@ -5882,7 +5888,7 @@
     struct NCR53c7x0_hostdata *hostdata = (struct NCR53c7x0_hostdata *)
 	host->hostdata[0];
     unsigned long flags;
-    Scsi_Cmnd *nuke_list, *tmp;
+	struct scsi_cmnd *nuke_list, *tmp;
     local_irq_save(flags);
     if (hostdata->state != STATE_HALTED)
 	ncr_halt (host);
@@ -5892,7 +5898,7 @@
     local_irq_restore(flags);
     printk ("scsi%d : nuking commands\n", host->host_no);
     for (; nuke_list; nuke_list = tmp) {
-	    tmp = (Scsi_Cmnd *) nuke_list->SCp.buffer;
+	    tmp = (struct scsi_cmnd *) nuke_list->SCp.buffer;
 	    nuke_list->result = DID_ERROR << 16;
 	    nuke_list->scsi_done(nuke_list);
     }
diff -ruN linux-2.6/drivers/scsi/53c7xx.h devel/drivers/scsi/53c7xx.h
--- linux-2.6/drivers/scsi/53c7xx.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/53c7xx.h	2006-09-12 21:27:38.000000000 +0200
@@ -997,7 +997,7 @@
     u32 *dsa;			/* What's in the DSA register now (virt) */
 /* 
  * A few things from that SCSI pid so we know what happened after 
- * the Scsi_Cmnd structure in question may have disappeared.
+ * the scsi_cmnd structure in question may have disappeared.
  */
     unsigned long pid;		/* The SCSI PID which caused this 
 				   event */
@@ -1029,8 +1029,8 @@
     void (* free)(void *, int);		/* Command to deallocate; NULL
 					   for structures allocated with
 					   scsi_register, etc. */
-    Scsi_Cmnd *cmd;			/* Associated Scsi_Cmnd 
-					   structure, Scsi_Cmnd points
+    struct scsi_cmnd *cmd;		/* Associated scsi_cmnd 
+					   structure, scsi_cmnd points
 					   at NCR53c7x0_cmd using 
 					   host_scribble structure */
 
@@ -1039,8 +1039,8 @@
 
     int flags;				/* CMD_* flags */
 
-    unsigned char      cmnd[12];	/* CDB, copied from Scsi_Cmnd */
-    int                result;		/* Copy to Scsi_Cmnd when done */
+    unsigned char      cmnd[12];	/* CDB, copied from struct scsi_cmnd */
+    int                result;		/* Copy to struct scsi_cmnd when done */
 
     struct {				/* Private non-cached bounce buffer */
         unsigned char buf[256];
@@ -1339,7 +1339,7 @@
     volatile struct NCR53c7x0_synchronous sync[16]
 	__attribute__ ((aligned (4)));
 
-    volatile Scsi_Cmnd *issue_queue
+    volatile struct scsi_cmnd *issue_queue
 	__attribute__ ((aligned (4)));
 						/* waiting to be issued by
 						   Linux driver */
diff -ruN linux-2.6/drivers/scsi/53c7xx.scr devel/drivers/scsi/53c7xx.scr
--- linux-2.6/drivers/scsi/53c7xx.scr	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/53c7xx.scr	2006-09-12 21:58:21.000000000 +0200
@@ -354,7 +354,7 @@
 				; 	pad 48 bytes (fix this RSN)
 ABSOLUTE dsa_next = 48		; len 4 Next DSA
  				; del 4 Previous DSA address
-ABSOLUTE dsa_cmnd = 56		; len 4 Scsi_Cmnd * for this thread.
+ABSOLUTE dsa_cmnd = 56		; len 4 struct scsi_cmnd * for this thread.
 ABSOLUTE dsa_select = 60	; len 4 Device ID, Period, Offset for 
 			 	;	table indirect select
 ABSOLUTE dsa_msgout = 64	; len 8 table indirect move parameter for 


