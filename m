Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUKIIBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUKIIBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUKIIBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:01:33 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:33187 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261422AbUKIH6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:58:04 -0500
Date: Tue, 9 Nov 2004 18:57:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [5/6] PPC64 iSeries remove more Studly Caps from MF code
Message-Id: <20041109185759.493d19fd.sfr@canb.auug.org.au>
In-Reply-To: <20041109185547.6eaf99ee.sfr@canb.auug.org.au>
References: <20041109184223.16ea3414.sfr@canb.auug.org.au>
	<20041109184551.03b8a32c.sfr@canb.auug.org.au>
	<20041109184813.1a6e02cf.sfr@canb.auug.org.au>
	<20041109185131.29e6eabd.sfr@canb.auug.org.au>
	<20041109185547.6eaf99ee.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__9_Nov_2004_18_57_59_+1100_z6T=OVKmAq/jxGEH"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__9_Nov_2004_18_57_59_+1100_z6T=OVKmAq/jxGEH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-mf.0.8/arch/ppc64/kernel/mf.c linus-bk-mf.0.9/arch/ppc64/kernel/mf.c
--- linus-bk-mf.0.8/arch/ppc64/kernel/mf.c	2004-11-09 17:57:33.000000000 +1100
+++ linus-bk-mf.0.9/arch/ppc64/kernel/mf.c	2004-11-09 18:19:18.000000000 +1100
@@ -48,7 +48,7 @@
  * This is the structure layout for the Machine Facilites LPAR event
  * flows.
  */
-struct VspCmdData {
+struct vsp_cmd_data {
 	u64 token;
 	u16 cmd;
 	HvLpIndex lp_index;
@@ -77,12 +77,12 @@
 	} sub_data;
 };
 
-struct VspRspData {
+struct vsp_rsp_data {
 	struct completion com;
-	struct VspCmdData *response;
+	struct vsp_cmd_data *response;
 };
 
-struct AllocData {
+struct alloc_data {
 	u16 size;
 	u16 type;
 	u32 count;
@@ -91,30 +91,30 @@
 	HvLpIndex target_lp;
 };
 
-struct CeMsgData;
+struct ce_msg_data;
 
-typedef void (*CeMsgCompleteHandler)(void *token, struct CeMsgData *vspCmdRsp);
+typedef void (*ce_msg_comp_hdlr)(void *token, struct ce_msg_data *vsp_cmd_rsp);
 
-struct CeMsgCompleteData {
-	CeMsgCompleteHandler handler;
+struct ce_msg_comp_data {
+	ce_msg_comp_hdlr handler;
 	void *token;
 };
 
-struct CeMsgData {
+struct ce_msg_data {
 	u8 ce_msg[12];
 	char reserved[4];
-	struct CeMsgCompleteData *completion;
+	struct ce_msg_comp_data *completion;
 };
 
-struct IoMFLpEvent {
+struct io_mf_lp_event {
 	struct HvLpEvent hp_lp_event;
 	u16 subtype_result_code;
 	u16 reserved1;
 	u32 reserved2;
 	union {
-		struct AllocData alloc;
-		struct CeMsgData ce_msg;
-		struct VspCmdData vsp_cmd;
+		struct alloc_data alloc;
+		struct ce_msg_data ce_msg;
+		struct vsp_cmd_data vsp_cmd;
 	} data;
 };
 
@@ -130,7 +130,7 @@
  */
 struct pending_event {
 	struct pending_event *next;
-	struct IoMFLpEvent event;
+	struct io_mf_lp_event event;
 	MFCompleteHandler hdlr;
 	char dma_data[72];
 	unsigned dma_data_length;
@@ -168,7 +168,7 @@
 	unsigned long flags;
 	int go = 1;
 	struct pending_event *ev1;
-	HvLpEvent_Rc hvRc;
+	HvLpEvent_Rc hv_rc;
 
 	/* enqueue the event */
 	if (ev != NULL) {
@@ -195,11 +195,11 @@
 					pending_event_head->dma_data_length,
 					HvLpDma_Direction_LocalToRemote);
 
-		hvRc = HvCallEvent_signalLpEvent(
+		hv_rc = HvCallEvent_signalLpEvent(
 				&pending_event_head->event.hp_lp_event);
-		if (hvRc != HvLpEvent_Rc_Good) {
+		if (hv_rc != HvLpEvent_Rc_Good) {
 			printk(KERN_ERR "mf.c: HvCallEvent_signalLpEvent() failed with %d\n",
-					(int)hvRc);
+					(int)hv_rc);
 
 			spin_lock_irqsave(&pending_event_spinlock, flags);
 			ev1 = pending_event_head;
@@ -228,7 +228,7 @@
 static struct pending_event *new_pending_event(void)
 {
 	struct pending_event *ev = NULL;
-	HvLpIndex primaryLp = HvLpConfig_getPrimaryLpIndex();
+	HvLpIndex primary_lp = HvLpConfig_getPrimaryLpIndex();
 	unsigned long flags;
 	struct HvLpEvent *hev;
 
@@ -253,38 +253,38 @@
 	hev->xFlags.xFunction = HvLpEvent_Function_Int;
 	hev->xType = HvLpEvent_Type_MachineFac;
 	hev->xSourceLp = HvLpConfig_getLpIndex();
-	hev->xTargetLp = primaryLp;
+	hev->xTargetLp = primary_lp;
 	hev->xSizeMinus1 = sizeof(ev->event)-1;
 	hev->xRc = HvLpEvent_Rc_Good;
-	hev->xSourceInstanceId = HvCallEvent_getSourceLpInstanceId(primaryLp,
+	hev->xSourceInstanceId = HvCallEvent_getSourceLpInstanceId(primary_lp,
 			HvLpEvent_Type_MachineFac);
-	hev->xTargetInstanceId = HvCallEvent_getTargetLpInstanceId(primaryLp,
+	hev->xTargetInstanceId = HvCallEvent_getTargetLpInstanceId(primary_lp,
 			HvLpEvent_Type_MachineFac);
 
 	return ev;
 }
 
-static int signal_vsp_instruction(struct VspCmdData *vspCmd)
+static int signal_vsp_instruction(struct vsp_cmd_data *vsp_cmd)
 {
 	struct pending_event *ev = new_pending_event();
 	int rc;
-	struct VspRspData response;
+	struct vsp_rsp_data response;
 
 	if (ev == NULL)
 		return -ENOMEM;
 
 	init_completion(&response.com);
-	response.response = vspCmd;
+	response.response = vsp_cmd;
 	ev->event.hp_lp_event.xSubtype = 6;
 	ev->event.hp_lp_event.x.xSubtypeData =
 		subtype_data('M', 'F',  'V',  'I');
 	ev->event.data.vsp_cmd.token = (u64)&response;
-	ev->event.data.vsp_cmd.cmd = vspCmd->cmd;
+	ev->event.data.vsp_cmd.cmd = vsp_cmd->cmd;
 	ev->event.data.vsp_cmd.lp_index = HvLpConfig_getLpIndex();
 	ev->event.data.vsp_cmd.result_code = 0xFF;
 	ev->event.data.vsp_cmd.reserved = 0;
 	memcpy(&(ev->event.data.vsp_cmd.sub_data),
-			&(vspCmd->sub_data), sizeof(vspCmd->sub_data));
+			&(vsp_cmd->sub_data), sizeof(vsp_cmd->sub_data));
 	mb();
 
 	rc = signal_event(ev);
@@ -297,7 +297,7 @@
 /*
  * Send a 12-byte CE message to the primary partition VSP object
  */
-static int signal_ce_msg(char *ce_msg, struct CeMsgCompleteData *completion)
+static int signal_ce_msg(char *ce_msg, struct ce_msg_comp_data *completion)
 {
 	struct pending_event *ev = new_pending_event();
 
@@ -315,7 +315,7 @@
 /*
  * Send a 12-byte CE message (with no data) to the primary partition VSP object
  */
-static int signal_ce_msg_simple(u8 ce_op, struct CeMsgCompleteData *completion)
+static int signal_ce_msg_simple(u8 ce_op, struct ce_msg_comp_data *completion)
 {
 	u8 ce_msg[12];
 
@@ -328,7 +328,7 @@
  * Send a 12-byte CE message and DMA data to the primary partition VSP object
  */
 static int dma_and_signal_ce_msg(char *ce_msg,
-		struct CeMsgCompleteData *completion, void *dma_data,
+		struct ce_msg_comp_data *completion, void *dma_data,
 		unsigned dma_data_length, unsigned remote_address)
 {
 	struct pending_event *ev = new_pending_event();
@@ -371,9 +371,9 @@
  * The primary partition VSP object is sending us a new
  * event flow.  Handle it...
  */
-static void intReceived(struct IoMFLpEvent *event)
+static void handle_int(struct io_mf_lp_event *event)
 {
-	int freeIt = 0;
+	int free_it = 0;
 	struct pending_event *two = NULL;
 
 	/* ack the interrupt */
@@ -396,9 +396,9 @@
 			    (pending_event_head->event.data.ce_msg.ce_msg[3]
 			     != 0x40))
 				break;
-			freeIt = 1;
+			free_it = 1;
 			if (pending_event_head->event.data.ce_msg.completion != 0) {
-				CeMsgCompleteHandler handler = pending_event_head->event.data.ce_msg.completion->handler;
+				ce_msg_comp_hdlr handler = pending_event_head->event.data.ce_msg.completion->handler;
 				void *token = pending_event_head->event.data.ce_msg.completion->token;
 
 				if (handler != NULL)
@@ -408,7 +408,7 @@
 		}
 
 		/* remove from queue */
-		if (freeIt == 1) {
+		if (free_it == 1) {
 			unsigned long flags;
 
 			spin_lock_irqsave(&pending_event_spinlock, flags);
@@ -439,11 +439,11 @@
  * of a flow we sent to them.  If there are other flows queued
  * up, we must send another one now...
  */
-static void ackReceived(struct IoMFLpEvent *event)
+static void handle_ack(struct io_mf_lp_event *event)
 {
 	unsigned long flags;
 	struct pending_event * two = NULL;
-	unsigned long freeIt = 0;
+	unsigned long free_it = 0;
 
 	/* handle current event */
 	if (pending_event_head != NULL) {
@@ -451,10 +451,10 @@
 		case 0:     /* CE msg */
 			if (event->data.ce_msg.ce_msg[3] == 0x40) {
 				if (event->data.ce_msg.ce_msg[2] != 0) {
-					freeIt = 1;
+					free_it = 1;
 					if (pending_event_head->event.data.ce_msg.completion
 							!= 0) {
-						CeMsgCompleteHandler handler = pending_event_head->event.data.ce_msg.completion->handler;
+						ce_msg_comp_hdlr handler = pending_event_head->event.data.ce_msg.completion->handler;
 						void *token = pending_event_head->event.data.ce_msg.completion->token;
 
 						if (handler != NULL)
@@ -462,18 +462,18 @@
 					}
 				}
 			} else
-				freeIt = 1;
+				free_it = 1;
 			break;
 		case 4:	/* allocate */
 		case 5:	/* deallocate */
 			if (pending_event_head->hdlr != NULL) {
 				(*pending_event_head->hdlr)((void *)event->hp_lp_event.xCorrelationToken, event->data.alloc.count);
 			}
-			freeIt = 1;
+			free_it = 1;
 			break;
 		case 6:
 			{
-				struct VspRspData *rsp = (struct VspRspData *)event->data.vsp_cmd.token;
+				struct vsp_rsp_data *rsp = (struct vsp_rsp_data *)event->data.vsp_cmd.token;
 
 				if (rsp != NULL) {
 					if (rsp->response != NULL)
@@ -481,7 +481,7 @@
 					complete(&rsp->com);
 				} else
 					printk(KERN_ERR "mf.c: no rsp\n");
-				freeIt = 1;
+				free_it = 1;
 			}
 			break;
 		}
@@ -491,7 +491,7 @@
 
 	/* remove from queue */
 	spin_lock_irqsave(&pending_event_spinlock, flags);
-	if ((pending_event_head != NULL) && (freeIt == 1)) {
+	if ((pending_event_head != NULL) && (free_it == 1)) {
 		struct pending_event *oldHead = pending_event_head;
 
 		pending_event_head = pending_event_head->next;
@@ -511,15 +511,15 @@
  * parse it enough to know if it is an interrupt or an
  * acknowledge.
  */
-static void hvHandler(struct HvLpEvent *event, struct pt_regs *regs)
+static void hv_handler(struct HvLpEvent *event, struct pt_regs *regs)
 {
 	if ((event != NULL) && (event->xType == HvLpEvent_Type_MachineFac)) {
 		switch(event->xFlags.xFunction) {
 		case HvLpEvent_Function_Ack:
-			ackReceived((struct IoMFLpEvent *)event);
+			handle_ack((struct io_mf_lp_event *)event);
 			break;
 		case HvLpEvent_Function_Int:
-			intReceived((struct IoMFLpEvent *)event);
+			handle_int((struct io_mf_lp_event *)event);
 			break;
 		default:
 			printk(KERN_ERR "mf.c: non ack/int event received\n");
@@ -533,9 +533,9 @@
  * Global kernel interface to allocate and seed events into the
  * Hypervisor.
  */
-void mf_allocate_lp_events(HvLpIndex targetLp, HvLpEvent_Type type,
+void mf_allocate_lp_events(HvLpIndex target_lp, HvLpEvent_Type type,
 		unsigned size, unsigned count, MFCompleteHandler hdlr,
-		void *userToken)
+		void *user_token)
 {
 	struct pending_event *ev = new_pending_event();
 	int rc;
@@ -544,10 +544,10 @@
 		rc = -ENOMEM;
 	} else {
 		ev->event.hp_lp_event.xSubtype = 4;
-		ev->event.hp_lp_event.xCorrelationToken = (u64)userToken;
+		ev->event.hp_lp_event.xCorrelationToken = (u64)user_token;
 		ev->event.hp_lp_event.x.xSubtypeData =
 			subtype_data('M', 'F', 'M', 'A');
-		ev->event.data.alloc.target_lp = targetLp;
+		ev->event.data.alloc.target_lp = target_lp;
 		ev->event.data.alloc.type = type;
 		ev->event.data.alloc.size = size;
 		ev->event.data.alloc.count = count;
@@ -555,7 +555,7 @@
 		rc = signal_event(ev);
 	}
 	if ((rc != 0) && (hdlr != NULL))
-		(*hdlr)(userToken, rc);
+		(*hdlr)(user_token, rc);
 }
 EXPORT_SYMBOL(mf_allocate_lp_events);
 
@@ -563,8 +563,8 @@
  * Global kernel interface to unseed and deallocate events already in
  * Hypervisor.
  */
-void mf_deallocate_lp_events(HvLpIndex targetLp, HvLpEvent_Type type,
-		unsigned count, MFCompleteHandler hdlr, void *userToken)
+void mf_deallocate_lp_events(HvLpIndex target_lp, HvLpEvent_Type type,
+		unsigned count, MFCompleteHandler hdlr, void *user_token)
 {
 	struct pending_event *ev = new_pending_event();
 	int rc;
@@ -573,17 +573,17 @@
 		rc = -ENOMEM;
 	else {
 		ev->event.hp_lp_event.xSubtype = 5;
-		ev->event.hp_lp_event.xCorrelationToken = (u64)userToken;
+		ev->event.hp_lp_event.xCorrelationToken = (u64)user_token;
 		ev->event.hp_lp_event.x.xSubtypeData =
 			subtype_data('M', 'F', 'M', 'D');
-		ev->event.data.alloc.target_lp = targetLp;
+		ev->event.data.alloc.target_lp = target_lp;
 		ev->event.data.alloc.type = type;
 		ev->event.data.alloc.count = count;
 		ev->hdlr = hdlr;
 		rc = signal_event(ev);
 	}
 	if ((rc != 0) && (hdlr != NULL))
-		(*hdlr)(userToken, rc);
+		(*hdlr)(user_token, rc);
 }
 EXPORT_SYMBOL(mf_deallocate_lp_events);
 
@@ -671,7 +671,7 @@
 	     i < sizeof(pending_event_prealloc) / sizeof(*pending_event_prealloc);
 	     ++i)
 		free_pending_event(&pending_event_prealloc[i]);
-	HvLpEvent_registerHandler(HvLpEvent_Type_MachineFac, &hvHandler);
+	HvLpEvent_registerHandler(HvLpEvent_Type_MachineFac, &hv_handler);
 
 	/* virtual continue ack */
 	signal_ce_msg_simple(0x57, NULL);
@@ -682,60 +682,60 @@
 
 void mf_setSide(char side)
 {
-	u64 newSide;
-	struct VspCmdData myVspCmd;
+	u64 new_side;
+	struct vsp_cmd_data vsp_cmd;
 
-	memset(&myVspCmd, 0, sizeof(myVspCmd));
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
 	switch (side) {
-	case 'A':	newSide = 0;
+	case 'A':	new_side = 0;
 			break;
-	case 'B':	newSide = 1;
+	case 'B':	new_side = 1;
 			break;
-	case 'C':	newSide = 2;
+	case 'C':	new_side = 2;
 			break;
-	default:	newSide = 3;
+	default:	new_side = 3;
 			break;
 	}
-	myVspCmd.sub_data.ipl_type = newSide;
-	myVspCmd.cmd = 10;
+	vsp_cmd.sub_data.ipl_type = new_side;
+	vsp_cmd.cmd = 10;
 
-	(void)signal_vsp_instruction(&myVspCmd);
+	(void)signal_vsp_instruction(&vsp_cmd);
 }
 
 char mf_getSide(void)
 {
-	char returnValue = ' ';
+	char return_value = ' ';
 	int rc = 0;
-	struct VspCmdData myVspCmd;
+	struct vsp_cmd_data vsp_cmd;
 
-	memset(&myVspCmd, 0, sizeof(myVspCmd));
-	myVspCmd.cmd = 2;
-	myVspCmd.sub_data.ipl_type = 0;
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 2;
+	vsp_cmd.sub_data.ipl_type = 0;
 	mb();
-	rc = signal_vsp_instruction(&myVspCmd);
+	rc = signal_vsp_instruction(&vsp_cmd);
 
 	if (rc != 0)
-		return returnValue;
+		return return_value;
 
-	if (myVspCmd.result_code == 0) {
-		switch (myVspCmd.sub_data.ipl_type) {
-		case 0:	returnValue = 'A';
+	if (vsp_cmd.result_code == 0) {
+		switch (vsp_cmd.sub_data.ipl_type) {
+		case 0:	return_value = 'A';
 			break;
-		case 1:	returnValue = 'B';
+		case 1:	return_value = 'B';
 			break;
-		case 2:	returnValue = 'C';
+		case 2:	return_value = 'C';
 			break;
-		default:	returnValue = 'D';
+		default:	return_value = 'D';
 			break;
 		}
 	}
-	return returnValue;
+	return return_value;
 }
 
 void mf_getSrcHistory(char *buffer, int size)
 {
 #if 0
-	struct IplTypeReturnStuff returnStuff;
+	struct IplTypeReturnStuff return_stuff;
 	struct pending_event *ev = new_pending_event();
 	int rc = 0;
 	char *pages[4];
@@ -748,13 +748,13 @@
 			 || (pages[2] == NULL) || (pages[3] == NULL))
 		return -ENOMEM;
 
-	returnStuff.xType = 0;
-	returnStuff.xRc = 0;
-	returnStuff.xDone = 0;
+	return_stuff.xType = 0;
+	return_stuff.xRc = 0;
+	return_stuff.xDone = 0;
 	ev->event.hp_lp_event.xSubtype = 6;
 	ev->event.hp_lp_event.x.xSubtypeData =
 		subtype_data('M', 'F', 'V', 'I');
-	ev->event.data.vsp_cmd.xEvent = &returnStuff;
+	ev->event.data.vsp_cmd.xEvent = &return_stuff;
 	ev->event.data.vsp_cmd.cmd = 4;
 	ev->event.data.vsp_cmd.lp_index = HvLpConfig_getLpIndex();
 	ev->event.data.vsp_cmd.result_code = 0xFF;
@@ -767,9 +767,9 @@
 	if (signal_event(ev) != 0)
 		return;
 
- 	while (returnStuff.xDone != 1)
+ 	while (return_stuff.xDone != 1)
  		udelay(10);
- 	if (returnStuff.xRc == 0)
+ 	if (return_stuff.xRc == 0)
  		memcpy(buffer, pages[0], size);
 	kfree(pages[0]);
 	kfree(pages[1]);
@@ -780,7 +780,7 @@
 
 void mf_setCmdLine(const char *cmdline, int size, u64 side)
 {
-	struct VspCmdData myVspCmd;
+	struct vsp_cmd_data vsp_cmd;
 	dma_addr_t dma_addr = 0;
 	char *page = dma_alloc_coherent(iSeries_vio_dev, size, &dma_addr,
 			GFP_ATOMIC);
@@ -792,21 +792,21 @@
 
 	copy_from_user(page, cmdline, size);
 
-	memset(&myVspCmd, 0, sizeof(myVspCmd));
-	myVspCmd.cmd = 31;
-	myVspCmd.sub_data.kern.token = dma_addr;
-	myVspCmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	myVspCmd.sub_data.kern.side = side;
-	myVspCmd.sub_data.kern.length = size;
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 31;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = side;
+	vsp_cmd.sub_data.kern.length = size;
 	mb();
-	(void)signal_vsp_instruction(&myVspCmd);
+	(void)signal_vsp_instruction(&vsp_cmd);
 
 	dma_free_coherent(iSeries_vio_dev, size, page, dma_addr);
 }
 
 int mf_getCmdLine(char *cmdline, int *size, u64 side)
 {
-	struct VspCmdData myVspCmd;
+	struct vsp_cmd_data vsp_cmd;
 	int rc;
 	int len = *size;
 	dma_addr_t dma_addr;
@@ -814,18 +814,18 @@
 	dma_addr = dma_map_single(iSeries_vio_dev, cmdline, len,
 			DMA_FROM_DEVICE);
 	memset(cmdline, 0, len);
-	memset(&myVspCmd, 0, sizeof(myVspCmd));
-	myVspCmd.cmd = 33;
-	myVspCmd.sub_data.kern.token = dma_addr;
-	myVspCmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	myVspCmd.sub_data.kern.side = side;
-	myVspCmd.sub_data.kern.length = len;
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 33;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = side;
+	vsp_cmd.sub_data.kern.length = len;
 	mb();
-	rc = signal_vsp_instruction(&myVspCmd);
+	rc = signal_vsp_instruction(&vsp_cmd);
 
 	if (rc == 0) {
-		if (myVspCmd.result_code == 0)
-			len = myVspCmd.sub_data.length_out;
+		if (vsp_cmd.result_code == 0)
+			len = vsp_cmd.sub_data.length_out;
 #if 0
 		else
 			memcpy(cmdline, "Bad cmdline", 11);
@@ -840,7 +840,7 @@
 
 int mf_setVmlinuxChunk(const char *buffer, int size, int offset, u64 side)
 {
-	struct VspCmdData myVspCmd;
+	struct vsp_cmd_data vsp_cmd;
 	int rc;
 	dma_addr_t dma_addr = 0;
 	char *page = dma_alloc_coherent(iSeries_vio_dev, size, &dma_addr,
@@ -852,18 +852,18 @@
 	}
 
 	copy_from_user(page, buffer, size);
-	memset(&myVspCmd, 0, sizeof(myVspCmd));
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
 
-	myVspCmd.cmd = 30;
-	myVspCmd.sub_data.kern.token = dma_addr;
-	myVspCmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	myVspCmd.sub_data.kern.side = side;
-	myVspCmd.sub_data.kern.offset = offset;
-	myVspCmd.sub_data.kern.length = size;
+	vsp_cmd.cmd = 30;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = side;
+	vsp_cmd.sub_data.kern.offset = offset;
+	vsp_cmd.sub_data.kern.length = size;
 	mb();
-	rc = signal_vsp_instruction(&myVspCmd);
+	rc = signal_vsp_instruction(&vsp_cmd);
 	if (rc == 0) {
-		if (myVspCmd.result_code == 0)
+		if (vsp_cmd.result_code == 0)
 			rc = 0;
 		else
 			rc = -ENOMEM;
@@ -876,7 +876,7 @@
 
 int mf_getVmlinuxChunk(char *buffer, int *size, int offset, u64 side)
 {
-	struct VspCmdData myVspCmd;
+	struct vsp_cmd_data vsp_cmd;
 	int rc;
 	int len = *size;
 	dma_addr_t dma_addr;
@@ -884,18 +884,18 @@
 	dma_addr = dma_map_single(iSeries_vio_dev, buffer, len,
 			DMA_FROM_DEVICE);
 	memset(buffer, 0, len);
-	memset(&myVspCmd, 0, sizeof(myVspCmd));
-	myVspCmd.cmd = 32;
-	myVspCmd.sub_data.kern.token = dma_addr;
-	myVspCmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	myVspCmd.sub_data.kern.side = side;
-	myVspCmd.sub_data.kern.offset = offset;
-	myVspCmd.sub_data.kern.length = len;
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 32;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = side;
+	vsp_cmd.sub_data.kern.offset = offset;
+	vsp_cmd.sub_data.kern.length = len;
 	mb();
-	rc = signal_vsp_instruction(&myVspCmd);
+	rc = signal_vsp_instruction(&vsp_cmd);
 	if (rc == 0) {
-		if (myVspCmd.result_code == 0)
-			*size = myVspCmd.sub_data.length_out;
+		if (vsp_cmd.result_code == 0)
+			*size = vsp_cmd.sub_data.length_out;
 		else
 			rc = -ENOMEM;
 	}
@@ -905,39 +905,39 @@
 	return rc;
 }
 
-struct RtcTimeData {
+struct rtc_time_data {
 	struct completion com;
-	struct CeMsgData xCeMsg;
-	int xRc;
+	struct ce_msg_data ce_msg;
+	int rc;
 };
 
-void getRtcTimeComplete(void * token, struct CeMsgData *ceMsg)
+static void get_rtc_time_complete(void *token, struct ce_msg_data *ce_msg)
 {
-	struct RtcTimeData *rtc = (struct RtcTimeData *)token;
+	struct rtc_time_data *rtc = token;
 
-	memcpy(&(rtc->xCeMsg), ceMsg, sizeof(rtc->xCeMsg));
-	rtc->xRc = 0;
+	memcpy(&rtc->ce_msg, ce_msg, sizeof(rtc->ce_msg));
+	rtc->rc = 0;
 	complete(&rtc->com);
 }
 
 int mf_get_rtc(struct rtc_time *tm)
 {
-	struct CeMsgCompleteData ceComplete;
-	struct RtcTimeData rtcData;
+	struct ce_msg_comp_data ce_complete;
+	struct rtc_time_data rtc_data;
 	int rc;
 
-	memset(&ceComplete, 0, sizeof(ceComplete));
-	memset(&rtcData, 0, sizeof(rtcData));
-	init_completion(&rtcData.com);
-	ceComplete.handler = &getRtcTimeComplete;
-	ceComplete.token = (void *)&rtcData;
+	memset(&ce_complete, 0, sizeof(ce_complete));
+	memset(&rtc_data, 0, sizeof(rtc_data));
+	init_completion(&rtc_data.com);
+	ce_complete.handler = &get_rtc_time_complete;
+	ce_complete.token = &rtc_data;
 	rc = signal_ce_msg_simple(0x40, &ce_complete);
 	if (rc == 0) {
-		wait_for_completion(&rtcData.com);
+		wait_for_completion(&rtc_data.com);
 
-		if (rtcData.xRc == 0) {
-			if ((rtcData.xCeMsg.ce_msg[2] == 0xa9) ||
-			    (rtcData.xCeMsg.ce_msg[2] == 0xaf)) {
+		if (rtc_data.rc == 0) {
+			if ((rtc_data.ce_msg.ce_msg[2] == 0xa9) ||
+			    (rtc_data.ce_msg.ce_msg[2] == 0xaf)) {
 				/* TOD clock is not set */
 				tm->tm_sec = 1;
 				tm->tm_min = 1;
@@ -948,7 +948,7 @@
 				mf_set_rtc(tm);
 			}
 			{
-				u8 *ce_msg = rtcData.xCeMsg.ce_msg;
+				u8 *ce_msg = rtc_data.ce_msg.ce_msg;
 				u8 year = ce_msg[5];
 				u8 sec = ce_msg[6];
 				u8 min = ce_msg[7];
@@ -974,7 +974,7 @@
 				tm->tm_year = year;
 			}
 		} else {
-			rc = rtcData.xRc;
+			rc = rtc_data.rc;
 			tm->tm_sec = 0;
 			tm->tm_min = 0;
 			tm->tm_hour = 0;
@@ -993,7 +993,7 @@
 
 int mf_set_rtc(struct rtc_time *tm)
 {
-	char ceTime[12] = "\x00\x00\x00\x41\x00\x00\x00\x00\x00\x00\x00\x00";
+	char ce_time[12] = "\x00\x00\x00\x41\x00\x00\x00\x00\x00\x00\x00\x00";
 	u8 day, mon, hour, min, sec, y1, y2;
 	unsigned year;
 
@@ -1015,15 +1015,15 @@
 	BIN_TO_BCD(y1);
 	BIN_TO_BCD(y2);
 
-	ceTime[4] = y1;
-	ceTime[5] = y2;
-	ceTime[6] = sec;
-	ceTime[7] = min;
-	ceTime[8] = hour;
-	ceTime[10] = day;
-	ceTime[11] = mon;
+	ce_time[4] = y1;
+	ce_time[5] = y2;
+	ce_time[6] = sec;
+	ce_time[7] = min;
+	ce_time[8] = hour;
+	ce_time[10] = day;
+	ce_time[11] = mon;
 
-	return signal_ce_msg(ceTime, NULL);
+	return signal_ce_msg(ce_time, NULL);
 }
 
 static int proc_mf_dump_cmdline(char *page, char **start, off_t off,

--Signature=_Tue__9_Nov_2004_18_57_59_+1100_z6T=OVKmAq/jxGEH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkHiH4CJfqux9a+8RApzxAJ9vQkEh5GUarUTkBOV/oVn3rwtKhgCeJ36e
VHqvMeQpms+HLsmetG9xVV4=
=0I9Y
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Nov_2004_18_57_59_+1100_z6T=OVKmAq/jxGEH--
