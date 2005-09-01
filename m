Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVIABbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVIABbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVIABbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:31:07 -0400
Received: from ozlabs.org ([203.10.76.45]:24720 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965045AbVIAB3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:30 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 17/18] iseries_veth: Remove studly caps from iseries_veth.c
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012927.35CE7681A0@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:27 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having merged iseries_veth.h, let's remove some of the studly caps that came
with it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   74 ++++++++++++++++++++++-----------------------
 1 files changed, 37 insertions(+), 37 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -85,26 +85,26 @@ MODULE_AUTHOR("Kyle Lucke <klucke@us.ibm
 MODULE_DESCRIPTION("iSeries Virtual ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define VethEventTypeCap	(0)
-#define VethEventTypeFrames	(1)
-#define VethEventTypeMonitor	(2)
-#define VethEventTypeFramesAck	(3)
+#define VETH_EVENT_CAP	(0)
+#define VETH_EVENT_FRAMES	(1)
+#define VETH_EVENT_MONITOR	(2)
+#define VETH_EVENT_FRAMES_ACK	(3)
 
 #define VETH_MAX_ACKS_PER_MSG	(20)
 #define VETH_MAX_FRAMES_PER_MSG	(6)
 
-struct VethFramesData {
+struct veth_frames_data {
 	u32 addr[VETH_MAX_FRAMES_PER_MSG];
 	u16 len[VETH_MAX_FRAMES_PER_MSG];
 	u32 eofmask;
 };
 #define VETH_EOF_SHIFT		(32-VETH_MAX_FRAMES_PER_MSG)
 
-struct VethFramesAckData {
+struct veth_frames_ack_data {
 	u16 token[VETH_MAX_ACKS_PER_MSG];
 };
 
-struct VethCapData {
+struct veth_cap_data {
 	u8 caps_version;
 	u8 rsvd1;
 	u16 num_buffers;
@@ -115,12 +115,12 @@ struct VethCapData {
 	u64 rsvd4[3];
 };
 
-struct VethLpEvent {
+struct veth_lpevent {
 	struct HvLpEvent base_event;
 	union {
-		struct VethCapData caps_data;
-		struct VethFramesData frames_data;
-		struct VethFramesAckData frames_ack_data;
+		struct veth_cap_data caps_data;
+		struct veth_frames_data frames_data;
+		struct veth_frames_ack_data frames_ack_data;
 	} u;
 
 };
@@ -153,7 +153,7 @@ struct VethLpEvent {
 
 struct veth_msg {
 	struct veth_msg *next;
-	struct VethFramesData data;
+	struct veth_frames_data data;
 	int token;
 	int in_use;
 	struct sk_buff *skb;
@@ -165,7 +165,7 @@ struct veth_lpar_connection {
 	struct work_struct statemachine_wq;
 	struct veth_msg *msgs;
 	int num_events;
-	struct VethCapData local_caps;
+	struct veth_cap_data local_caps;
 
 	struct kobject kobject;
 	struct timer_list ack_timer;
@@ -179,12 +179,12 @@ struct veth_lpar_connection {
 	unsigned long state;
 	HvLpInstanceId src_inst;
 	HvLpInstanceId dst_inst;
-	struct VethLpEvent cap_event, cap_ack_event;
+	struct veth_lpevent cap_event, cap_ack_event;
 	u16 pending_acks[VETH_MAX_ACKS_PER_MSG];
 	u32 num_pending_acks;
 
 	int num_ack_events;
-	struct VethCapData remote_caps;
+	struct veth_cap_data remote_caps;
 	u32 ack_timeout;
 
 	struct veth_msg *msg_stack_head;
@@ -217,7 +217,7 @@ static int veth_start_xmit(struct sk_buf
 static void veth_recycle_msg(struct veth_lpar_connection *, struct veth_msg *);
 static void veth_wake_queues(struct veth_lpar_connection *cnx);
 static void veth_stop_queues(struct veth_lpar_connection *cnx);
-static void veth_receive(struct veth_lpar_connection *, struct VethLpEvent *);
+static void veth_receive(struct veth_lpar_connection *, struct veth_lpevent *);
 static void veth_release_connection(struct kobject *kobject);
 static void veth_timed_ack(unsigned long ptr);
 static void veth_timed_reset(unsigned long ptr);
@@ -308,7 +308,7 @@ static int veth_allocate_events(HvLpInde
 	struct veth_allocation vc = { COMPLETION_INITIALIZER(vc.c), 0 };
 
 	mf_allocate_lp_events(rlp, HvLpEvent_Type_VirtualLan,
-			    sizeof(struct VethLpEvent), number,
+			    sizeof(struct veth_lpevent), number,
 			    &veth_complete_allocation, &vc);
 	wait_for_completion(&vc.c);
 
@@ -456,7 +456,7 @@ static inline void veth_kick_statemachin
 }
 
 static void veth_take_cap(struct veth_lpar_connection *cnx,
-			  struct VethLpEvent *event)
+			  struct veth_lpevent *event)
 {
 	unsigned long flags;
 
@@ -481,7 +481,7 @@ static void veth_take_cap(struct veth_lp
 }
 
 static void veth_take_cap_ack(struct veth_lpar_connection *cnx,
-			      struct VethLpEvent *event)
+			      struct veth_lpevent *event)
 {
 	unsigned long flags;
 
@@ -499,7 +499,7 @@ static void veth_take_cap_ack(struct vet
 }
 
 static void veth_take_monitor_ack(struct veth_lpar_connection *cnx,
-				  struct VethLpEvent *event)
+				  struct veth_lpevent *event)
 {
 	unsigned long flags;
 
@@ -516,7 +516,7 @@ static void veth_take_monitor_ack(struct
 	spin_unlock_irqrestore(&cnx->lock, flags);
 }
 
-static void veth_handle_ack(struct VethLpEvent *event)
+static void veth_handle_ack(struct veth_lpevent *event)
 {
 	HvLpIndex rlp = event->base_event.xTargetLp;
 	struct veth_lpar_connection *cnx = veth_cnx[rlp];
@@ -524,10 +524,10 @@ static void veth_handle_ack(struct VethL
 	BUG_ON(! cnx);
 
 	switch (event->base_event.xSubtype) {
-	case VethEventTypeCap:
+	case VETH_EVENT_CAP:
 		veth_take_cap_ack(cnx, event);
 		break;
-	case VethEventTypeMonitor:
+	case VETH_EVENT_MONITOR:
 		veth_take_monitor_ack(cnx, event);
 		break;
 	default:
@@ -536,7 +536,7 @@ static void veth_handle_ack(struct VethL
 	};
 }
 
-static void veth_handle_int(struct VethLpEvent *event)
+static void veth_handle_int(struct veth_lpevent *event)
 {
 	HvLpIndex rlp = event->base_event.xSourceLp;
 	struct veth_lpar_connection *cnx = veth_cnx[rlp];
@@ -546,14 +546,14 @@ static void veth_handle_int(struct VethL
 	BUG_ON(! cnx);
 
 	switch (event->base_event.xSubtype) {
-	case VethEventTypeCap:
+	case VETH_EVENT_CAP:
 		veth_take_cap(cnx, event);
 		break;
-	case VethEventTypeMonitor:
+	case VETH_EVENT_MONITOR:
 		/* do nothing... this'll hang out here til we're dead,
 		 * and the hypervisor will return it for us. */
 		break;
-	case VethEventTypeFramesAck:
+	case VETH_EVENT_FRAMES_ACK:
 		spin_lock_irqsave(&cnx->lock, flags);
 
 		for (i = 0; i < VETH_MAX_ACKS_PER_MSG; ++i) {
@@ -573,7 +573,7 @@ static void veth_handle_int(struct VethL
 
 		spin_unlock_irqrestore(&cnx->lock, flags);
 		break;
-	case VethEventTypeFrames:
+	case VETH_EVENT_FRAMES:
 		veth_receive(cnx, event);
 		break;
 	default:
@@ -584,7 +584,7 @@ static void veth_handle_int(struct VethL
 
 static void veth_handle_event(struct HvLpEvent *event, struct pt_regs *regs)
 {
-	struct VethLpEvent *veth_event = (struct VethLpEvent *)event;
+	struct veth_lpevent *veth_event = (struct veth_lpevent *)event;
 
 	if (event->xFlags.xFunction == HvLpEvent_Function_Ack)
 		veth_handle_ack(veth_event);
@@ -594,7 +594,7 @@ static void veth_handle_event(struct HvL
 
 static int veth_process_caps(struct veth_lpar_connection *cnx)
 {
-	struct VethCapData *remote_caps = &cnx->remote_caps;
+	struct veth_cap_data *remote_caps = &cnx->remote_caps;
 	int num_acks_needed;
 
 	/* Convert timer to jiffies */
@@ -710,7 +710,7 @@ static void veth_statemachine(void *p)
 
 	if ( (cnx->state & VETH_STATE_OPEN)
 	     && !(cnx->state & VETH_STATE_SENTMON) ) {
-		rc = veth_signalevent(cnx, VethEventTypeMonitor,
+		rc = veth_signalevent(cnx, VETH_EVENT_MONITOR,
 				      HvLpEvent_AckInd_DoAck,
 				      HvLpEvent_AckType_DeferredAck,
 				      0, 0, 0, 0, 0, 0);
@@ -733,7 +733,7 @@ static void veth_statemachine(void *p)
 	     && !(cnx->state & VETH_STATE_SENTCAPS)) {
 		u64 *rawcap = (u64 *)&cnx->local_caps;
 
-		rc = veth_signalevent(cnx, VethEventTypeCap,
+		rc = veth_signalevent(cnx, VETH_EVENT_CAP,
 				      HvLpEvent_AckInd_DoAck,
 				      HvLpEvent_AckType_ImmediateAck,
 				      0, rawcap[0], rawcap[1], rawcap[2],
@@ -755,7 +755,7 @@ static void veth_statemachine(void *p)
 
 	if ((cnx->state & VETH_STATE_GOTCAPS)
 	    && !(cnx->state & VETH_STATE_SENTCAPACK)) {
-		struct VethCapData *remote_caps = &cnx->remote_caps;
+		struct veth_cap_data *remote_caps = &cnx->remote_caps;
 
 		memcpy(remote_caps, &cnx->cap_event.u.caps_data,
 		       sizeof(*remote_caps));
@@ -1142,7 +1142,7 @@ static int veth_transmit_to_one(struct s
 	msg->data.len[0] = skb->len;
 	msg->data.eofmask = 1 << VETH_EOF_SHIFT;
 
-	rc = veth_signaldata(cnx, VethEventTypeFrames, msg->token, &msg->data);
+	rc = veth_signaldata(cnx, VETH_EVENT_FRAMES, msg->token, &msg->data);
 
 	if (rc != HvLpEvent_Rc_Good)
 		goto recycle_and_drop;
@@ -1409,7 +1409,7 @@ static void veth_flush_acks(struct veth_
 {
 	HvLpEvent_Rc rc;
 
-	rc = veth_signaldata(cnx, VethEventTypeFramesAck,
+	rc = veth_signaldata(cnx, VETH_EVENT_FRAMES_ACK,
 			     0, &cnx->pending_acks);
 
 	if (rc != HvLpEvent_Rc_Good)
@@ -1421,9 +1421,9 @@ static void veth_flush_acks(struct veth_
 }
 
 static void veth_receive(struct veth_lpar_connection *cnx,
-			 struct VethLpEvent *event)
+			 struct veth_lpevent *event)
 {
-	struct VethFramesData *senddata = &event->u.frames_data;
+	struct veth_frames_data *senddata = &event->u.frames_data;
 	int startchunk = 0;
 	int nchunks;
 	unsigned long flags;
