Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTHVNBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 09:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbTHVMkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:40:31 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:46715 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263167AbTHVLzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:55:25 -0400
Date: Fri, 22 Aug 2003 04:29:58 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][resend] 10/13 2.4.22-rc2 fix __FUNCTION__ warnings net/irda
 [4/7]
Message-Id: <20030822042958.4d21b1dc.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 irlap_event.c |  163 ++++++++++++++++++++++++++++------------------------------
 irlap_frame.c |   73 ++++++++++++-------------
 2 files changed, 116 insertions(+), 120 deletions(-)

--- linux-2.4.22-rc2/net/irda/irlap_event.c	2003-08-21 00:05:17.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlap_event.c	2003-08-21 00:08:28.000000000 -0300
@@ -217,7 +217,7 @@
 	} else
 		self->fast_RR = FALSE;
 
-	IRDA_DEBUG(3, __FUNCTION__ "(), timeout=%d (%ld)\n", timeout, jiffies);
+	IRDA_DEBUG(3, "%s(), timeout=%d (%ld)\n", __FUNCTION__, timeout, jiffies);
 #endif /* CONFIG_IRDA_FAST_RR */
 
 	if (timeout == 0)
@@ -241,7 +241,7 @@
 	if (!self || self->magic != LAP_MAGIC)
 		return;
 
-  	IRDA_DEBUG(3, __FUNCTION__ "(), event = %s, state = %s\n", 
+  	IRDA_DEBUG(3, "%s(), event = %s, state = %s\n", __FUNCTION__, 
 		   irlap_event[event], irlap_state[self->state]); 
 	
 	ret = (*state[self->state])(self, event, skb, info);
@@ -259,7 +259,7 @@
 		 * try to disconnect link if we send any data frames, since
 		 * that will change the state away form XMIT
 		 */
-		IRDA_DEBUG(2, __FUNCTION__ "() : queue len = %d\n",
+		IRDA_DEBUG(2, "%s() : queue len = %d\n", __FUNCTION__,
 			   skb_queue_len(&self->txq));
 
 		if (skb_queue_len(&self->txq)) {
@@ -353,8 +353,8 @@
 			/* Note : this will never happen, because we test
 			 * media busy in irlap_connect_request() and
 			 * postpone the event... - Jean II */
-			IRDA_DEBUG(0, __FUNCTION__
-				   "(), CONNECT_REQUEST: media busy!\n");
+			IRDA_DEBUG(0, "%s(), CONNECT_REQUEST: media busy!\n",
+				   __FUNCTION__);
 			
 			/* Always switch state before calling upper layers */
 			irlap_next_state(self, LAP_NDM);
@@ -380,15 +380,15 @@
 
 			irlap_connect_indication(self, skb);
 		} else {
-			IRDA_DEBUG(0, __FUNCTION__ "(), SNRM frame does not "
-				   "contain an I field!\n");
+			IRDA_DEBUG(0, "%s(), SNRM frame does not "
+				   "contain an I field!\n", __FUNCTION__);
 		}
 		break;
 	case DISCOVERY_REQUEST:		
 		ASSERT(info != NULL, return -1;);
 
 	 	if (self->media_busy) {
- 			IRDA_DEBUG(0, __FUNCTION__ "(), media busy!\n"); 
+ 			IRDA_DEBUG(0, "%s(), media busy!\n", __FUNCTION__); 
 			/* irlap->log.condition = MEDIA_BUSY; */
 						
 			/* This will make IrLMP try again */
@@ -450,7 +450,7 @@
 		 * log (and post an event).
 		 * Jean II
 		 */
-			IRDA_DEBUG(1, __FUNCTION__ "(), Receiving final discovery request, missed the discovery slots :-(\n");
+			IRDA_DEBUG(1, "%s(), Receiving final discovery request, missed the discovery slots :-(\n", __FUNCTION__);
 
 			/* Last discovery request -> in the log */
 			irlap_discovery_indication(self, info->discovery); 
@@ -526,8 +526,8 @@
 	case RECV_UI_FRAME:
 		/* Only accept broadcast frames in NDM mode */
 		if (info->caddr != CBROADCAST) {
-			IRDA_DEBUG(0, __FUNCTION__ 
-				   "(), not a broadcast frame!\n");
+			IRDA_DEBUG(0, "%s(), not a broadcast frame!\n",
+				   __FUNCTION__);
 		} else
 			irlap_unitdata_indication(self, skb);
 		break;
@@ -543,10 +543,10 @@
 		irlap_send_test_frame(self, CBROADCAST, info->daddr, skb);
 		break;
 	case RECV_TEST_RSP:
-		IRDA_DEBUG(0, __FUNCTION__ "() not implemented!\n");
+		IRDA_DEBUG(0, "%s() not implemented!\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(2, "%s(), Unknown event %s\n", __FUNCTION__, 
 			   irlap_event[event]);
 		
 		ret = -1;
@@ -574,13 +574,13 @@
 		ASSERT(info != NULL, return -1;);
 		ASSERT(info->discovery != NULL, return -1;);
 
-		IRDA_DEBUG(4, __FUNCTION__ "(), daddr=%08x\n", 
+		IRDA_DEBUG(4, "%s(), daddr=%08x\n", __FUNCTION__, 
 			   info->discovery->daddr);
 
 		if (!self->discovery_log) {
-			WARNING(__FUNCTION__ "(), discovery log is gone! "
+			WARNING("%s(), discovery log is gone! "
 				"maybe the discovery timeout has been set to "
-				"short?\n");
+				"short?\n", __FUNCTION__);
 			break;
 		}
 		hashbin_insert(self->discovery_log, 
@@ -605,7 +605,7 @@
 
 		ASSERT(info != NULL, return -1;);
 
-		IRDA_DEBUG(1, __FUNCTION__ "(), Receiving discovery request (s = %d) while performing discovery :-(\n", info->s);
+		IRDA_DEBUG(1, "%s(), Receiving discovery request (s = %d) while performing discovery :-(\n", __FUNCTION__, info->s);
 
 		/* Last discovery request ? */
 		if (info->s == 0xff)
@@ -619,9 +619,8 @@
 		 * timing requirements.
 		 */
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
-			IRDA_DEBUG(2, __FUNCTION__ 
-				   "(), device is slow to answer, "
-				   "waiting some more!\n");
+			IRDA_DEBUG(2, "%s(), device is slow to answer, "
+				   "waiting some more!\n", __FUNCTION__);
 			irlap_start_slot_timer(self, MSECS_TO_JIFFIES(10));
 			self->add_wait = TRUE;
 			return ret;
@@ -657,7 +656,7 @@
 		}
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(2, "%s(), Unknown event %s\n", __FUNCTION__, 
 			   irlap_event[event]);
 
 		ret = -1;
@@ -679,15 +678,15 @@
 	discovery_t *discovery_rsp;
 	int ret=0;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);
 
 	switch (event) {
 	case QUERY_TIMER_EXPIRED:
-		IRDA_DEBUG(2, __FUNCTION__ "(), QUERY_TIMER_EXPIRED <%ld>\n",
-		      jiffies);
+		IRDA_DEBUG(2, "%s(), QUERY_TIMER_EXPIRED <%ld>\n",
+		           __FUNCTION__, jiffies);
 		irlap_next_state(self, LAP_NDM);
 		break;
 	case RECV_DISCOVERY_XID_CMD:
@@ -715,8 +714,8 @@
 		}
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
-			   irlap_event[event]);
+		IRDA_DEBUG(1, "%s(), Unknown event %d, %s\n", __FUNCTION__,
+			   event, irlap_event[event]);
 
 		ret = -1;
 		break;
@@ -736,7 +735,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), event=%s\n", irlap_event[ event]);
+	IRDA_DEBUG(4, "%s(), event=%s\n", __FUNCTION__, irlap_event[event]);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);
@@ -796,20 +795,20 @@
 
 		break;
 	case RECV_DISCOVERY_XID_CMD:
-		IRDA_DEBUG(3, __FUNCTION__ 
-			   "(), event RECV_DISCOVER_XID_CMD!\n");
+		IRDA_DEBUG(3, "%s(), event RECV_DISCOVER_XID_CMD!\n",
+			   __FUNCTION__);
 		irlap_next_state(self, LAP_NDM);
 
 		break;		
 	case DISCONNECT_REQUEST:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Disconnect request!\n");
+		IRDA_DEBUG(0, "%s(), Disconnect request!\n", __FUNCTION__);
 		irlap_send_dm_frame(self);
 		irlap_next_state( self, LAP_NDM);
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
-			   irlap_event[event]);
+		IRDA_DEBUG(1, "%s(), Unknown event %d, %s\n", __FUNCTION__,
+			   event, irlap_event[event]);
 		
 		ret = -1;
 		break;
@@ -830,7 +829,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);
@@ -859,7 +858,7 @@
 		self->retry_count++;
 		break;
 	case RECV_SNRM_CMD:
-		IRDA_DEBUG(4, __FUNCTION__ "(), SNRM battle!\n");
+		IRDA_DEBUG(4, "%s(), SNRM battle!\n", __FUNCTION__);
 
 		ASSERT(skb != NULL, return 0;);
 		ASSERT(info != NULL, return 0;);
@@ -940,8 +939,8 @@
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
-			   irlap_event[event]);		
+		IRDA_DEBUG(1, "%s(), Unknown event %d, %s\n", __FUNCTION__,
+			   event, irlap_event[event]);		
 
 		ret = -1;
 		break;
@@ -958,7 +957,7 @@
 static int irlap_state_offline(struct irlap_cb *self, IRLAP_EVENT event, 
 			       struct sk_buff *skb, struct irlap_info *info) 
 {
-	IRDA_DEBUG( 0, __FUNCTION__ "(), Unknown event\n");
+	IRDA_DEBUG(0, "%s(), Unknown event\n", __FUNCTION__);
 
 	return -1;
 }
@@ -989,9 +988,8 @@
 			 *  speed and turn-around-time.
 			 */
 			if (skb->len > self->bytes_left) {
-				IRDA_DEBUG(4, __FUNCTION__ 
-					   "(), Not allowed to transmit more "
-					   "bytes!\n");
+				IRDA_DEBUG(4, "%s(), Not allowed to transmit more "
+					   "bytes!\n", __FUNCTION__);
 				skb_queue_head(&self->txq, skb_get(skb));
 				/*
 				 *  We should switch state to LAP_NRM_P, but
@@ -1029,8 +1027,8 @@
 			self->fast_RR = FALSE;
 #endif /* CONFIG_IRDA_FAST_RR */
 		} else {
-			IRDA_DEBUG(4, __FUNCTION__ 
-				   "(), Unable to send! remote busy?\n");
+			IRDA_DEBUG(4, "%s(), Unable to send! remote busy?\n",
+				   __FUNCTION__);
 			skb_queue_head(&self->txq, skb_get(skb));
 
 			/*
@@ -1041,7 +1039,7 @@
 		}
 		break;
 	case POLL_TIMER_EXPIRED:
-		IRDA_DEBUG(3, __FUNCTION__ "(), POLL_TIMER_EXPIRED (%ld)\n",
+		IRDA_DEBUG(3, "%s(), POLL_TIMER_EXPIRED (%ld)\n", __FUNCTION__,
 			   jiffies);
 		irlap_send_rr_frame(self, CMD_FRAME);
 		/* Return to NRM properly - Jean II  */
@@ -1067,7 +1065,7 @@
 		 * when we return... - Jean II */
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(0, "%s(), Unknown event %s\n", __FUNCTION__, 
 			   irlap_event[event]);
 
 		ret = -EINVAL;
@@ -1086,7 +1084,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(1, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);	
@@ -1121,7 +1119,7 @@
 		}
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(1, "%s(), Unknown event %d\n", __FUNCTION__, event);
 
 		ret = -1;
 		break;	
@@ -1234,8 +1232,8 @@
 				/* Keep state */
 				irlap_next_state(self, LAP_NRM_P);
 			} else {
-				IRDA_DEBUG(4, __FUNCTION__
-				       "(), missing or duplicate frame!\n");
+				IRDA_DEBUG(4, "%s(), missing or duplicate frame!\n",
+					   __FUNCTION__);
 				
 				/* Update Nr received */
 				irlap_update_nr_received(self, info->nr);
@@ -1299,8 +1297,8 @@
 		if ((ns_status == NS_UNEXPECTED) && 
 		    (nr_status == NR_UNEXPECTED)) 
 		{
-			IRDA_DEBUG(4, __FUNCTION__ 
-				   "(), unexpected nr and ns!\n");
+			IRDA_DEBUG(4, "%s(), unexpected nr and ns!\n",
+				   __FUNCTION__);
 			if (info->pf) {
 				/* Resend rejected frames */
 				irlap_resend_rejected_frames(self, CMD_FRAME);
@@ -1339,10 +1337,9 @@
 			}
 			break;
 		}
-		IRDA_DEBUG(1, __FUNCTION__ "(), Not implemented!\n");
-		IRDA_DEBUG(1, __FUNCTION__ 
-		      "(), event=%s, ns_status=%d, nr_status=%d\n", 
-		      irlap_event[ event], ns_status, nr_status);
+		IRDA_DEBUG(1, "%s(), Not implemented!\n", __FUNCTION__);
+		IRDA_DEBUG(1, "%s(), event=%s, ns_status=%d, nr_status=%d\n",
+			   __FUNCTION__, irlap_event[event], ns_status, nr_status);
 		break;
 	case RECV_UI_FRAME:
 		/* Poll bit cleared? */
@@ -1353,7 +1350,7 @@
 			del_timer(&self->final_timer);
 			irlap_data_indication(self, skb, TRUE);
 			irlap_next_state(self, LAP_XMIT_P);
-			printk(__FUNCTION__ "(): RECV_UI_FRAME: next state %s\n", irlap_state[self->state]);
+			printk("%s(): RECV_UI_FRAME: next state %s\n", __FUNCTION__, irlap_state[self->state]);
 			irlap_start_poll_timer(self, self->poll_timeout);
 		}
 		break;
@@ -1406,8 +1403,8 @@
 			
 			irlap_next_state(self, LAP_NRM_P);
 		} else if (ret == NR_INVALID) {
-			IRDA_DEBUG(1, __FUNCTION__ "(), Received RR with "
-				   "invalid nr !\n");
+			IRDA_DEBUG(1, "%s(), Received RR with invalid nr !\n",
+				   __FUNCTION__);
 			del_timer(&self->final_timer);
 
 			irlap_next_state(self, LAP_RESET_WAIT);
@@ -1507,7 +1504,7 @@
 		irlap_start_final_timer(self, self->final_timeout);
 		break;
 	case RECV_RD_RSP:
-		IRDA_DEBUG(1, __FUNCTION__ "(), RECV_RD_RSP\n");
+		IRDA_DEBUG(1, "%s(), RECV_RD_RSP\n", __FUNCTION__);
 
 		irlap_flush_all_queues(self);
 		irlap_next_state(self, LAP_XMIT_P);
@@ -1515,7 +1512,7 @@
 		irlap_disconnect_request(self);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(1, "%s(), Unknown event %s\n", __FUNCTION__, 
 			   irlap_event[event]);
 
 		ret = -1;
@@ -1536,7 +1533,7 @@
 {
 	int ret = 0;
 	
-	IRDA_DEBUG(3, __FUNCTION__ "(), event = %s\n", irlap_event[event]);
+	IRDA_DEBUG(3, "%s(), event = %s\n", __FUNCTION__, irlap_event[event]);
 	
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);
@@ -1562,7 +1559,7 @@
 		irlap_next_state( self, LAP_PCLOSE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(2, "%s(), Unknown event %s\n", __FUNCTION__, 
 			   irlap_event[event]);
 
 		ret = -1;
@@ -1583,7 +1580,7 @@
 {
 	int ret = 0;
 	
-	IRDA_DEBUG(3, __FUNCTION__ "(), event = %s\n", irlap_event[event]);
+	IRDA_DEBUG(3, "%s(), event = %s\n", __FUNCTION__, irlap_event[event]);
 	
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);
@@ -1641,7 +1638,7 @@
 		 * state
 		 */
 		if (!info) {
-			IRDA_DEBUG(3, __FUNCTION__ "(), RECV_SNRM_CMD\n");
+			IRDA_DEBUG(3, "%s(), RECV_SNRM_CMD\n", __FUNCTION__);
 			irlap_initiate_connection_state(self);
 			irlap_wait_min_turn_around(self, &self->qos_tx);
 			irlap_send_ua_response_frame(self, &self->qos_rx);
@@ -1649,12 +1646,12 @@
 			irlap_start_wd_timer(self, self->wd_timeout);
 			irlap_next_state(self, LAP_NDM);
 		} else {
-			IRDA_DEBUG(0, __FUNCTION__ 
-				   "(), SNRM frame contained an I field!\n");
+			IRDA_DEBUG(0, "%s(), SNRM frame contained an I field!\n",
+				   __FUNCTION__);
 		}
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(1, "%s(), Unknown event %s\n", __FUNCTION__, 
 			   irlap_event[event]);	
 
 		ret = -1;
@@ -1675,7 +1672,7 @@
 {
 	int ret = 0;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), event=%s\n", irlap_event[event]); 
+	IRDA_DEBUG(4, "%s(), event=%s\n", __FUNCTION__, irlap_event[event]); 
 
 	ASSERT(self != NULL, return -ENODEV;);
 	ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
@@ -1731,7 +1728,7 @@
 				ret = -EPROTO;
 			}
 		} else {
-			IRDA_DEBUG(2, __FUNCTION__ "(), Unable to send!\n");
+			IRDA_DEBUG(2, "%s(), Unable to send!\n", __FUNCTION__);
 			skb_queue_head(&self->txq, skb_get(skb));
 			ret = -EPROTO;
 		}
@@ -1747,7 +1744,7 @@
 		 * when we return... - Jean II */
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(2, "%s(), Unknown event %s\n", __FUNCTION__, 
 			   irlap_event[event]);
 
 		ret = -EINVAL;
@@ -1770,7 +1767,7 @@
 	int nr_status;
 	int ret = 0;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), event=%s\n", irlap_event[ event]);
+	IRDA_DEBUG(4, "%s(), event=%s\n", __FUNCTION__, irlap_event[ event]);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == LAP_MAGIC, return -1;);
@@ -1778,8 +1775,8 @@
 	switch (event) {
 	case RECV_I_CMD: /* Optimize for the common case */
 		/* FIXME: must check for remote_busy below */
-		IRDA_DEBUG(4, __FUNCTION__ "(), event=%s nr=%d, vs=%d, ns=%d, "
-			   "vr=%d, pf=%d\n", irlap_event[event], info->nr, 
+		IRDA_DEBUG(4, "%s(), event=%s nr=%d, vs=%d, ns=%d, vr=%d, pf=%d\n",
+			   __FUNCTION__, irlap_event[event], info->nr, 
 			   self->vs, info->ns, self->vr, info->pf);
 
 		self->retry_count = 0;
@@ -2011,21 +2008,21 @@
 			/* Keep state */
 			irlap_next_state(self, LAP_NRM_S); 
 		} else {
-			IRDA_DEBUG(1, __FUNCTION__ 
-				   "(), invalid nr not implemented!\n");
+			IRDA_DEBUG(1, "%s(), invalid nr not implemented!\n",
+				   __FUNCTION__);
 		} 
 		break;
 	case RECV_SNRM_CMD:
 		/* SNRM frame is not allowed to contain an I-field */
 		if (!info) {
 			del_timer(&self->wd_timer);
-			IRDA_DEBUG(1, __FUNCTION__ "(), received SNRM cmd\n");
+			IRDA_DEBUG(1, "%s(), received SNRM cmd\n", __FUNCTION__);
 			irlap_next_state(self, LAP_RESET_CHECK);
 			
 			irlap_reset_indication(self);
 		} else {
-			IRDA_DEBUG(0, __FUNCTION__ 
-				   "(), SNRM frame contained an I-field!\n");
+			IRDA_DEBUG(0, "%s(), SNRM frame contained an I-field!\n",
+				   __FUNCTION__);
 			
 		}
 		break;
@@ -2057,7 +2054,7 @@
 		 *   which explain why we use (self->N2 / 2) here !!!
 		 * Jean II
 		 */
-		IRDA_DEBUG(1, __FUNCTION__ "(), retry_count = %d\n", 
+		IRDA_DEBUG(1, "%s(), retry_count = %d\n", __FUNCTION__, 
 			   self->retry_count);
 
 		if (self->retry_count < (self->N2 / 2)) {
@@ -2110,7 +2107,7 @@
 		irlap_send_test_frame(self, self->caddr, info->daddr, skb);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n", 
+		IRDA_DEBUG(1, "%s(), Unknown event %d, (%s)\n", __FUNCTION__, 
 			   event, irlap_event[event]);
 
 		ret = -EINVAL;
@@ -2130,7 +2127,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(1, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -ENODEV;);
 	ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
@@ -2168,7 +2165,7 @@
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n", 
+		IRDA_DEBUG(1, "%s(), Unknown event %d, (%s)\n", __FUNCTION__, 
 			   event, irlap_event[event]);
 
 		ret = -EINVAL;
@@ -2184,7 +2181,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), event=%s\n", irlap_event[event]); 
+	IRDA_DEBUG(1, "%s(), event=%s\n", __FUNCTION__, irlap_event[event]); 
 
 	ASSERT(self != NULL, return -ENODEV;);
 	ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
@@ -2205,7 +2202,7 @@
 		irlap_next_state(self, LAP_SCLOSE);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n", 
+		IRDA_DEBUG(1, "%s(), Unknown event %d, (%s)\n", __FUNCTION__, 
 			   event, irlap_event[event]);
 
 		ret = -EINVAL;
--- linux-2.4.22-rc2/net/irda/irlap_frame.c	2003-08-21 00:05:17.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlap_frame.c	2003-08-21 00:08:28.000000000 -0300
@@ -167,8 +167,8 @@
 
 		/* Check if the new connection address is valid */
 		if ((info->caddr == 0x00) || (info->caddr == 0xfe)) {
-			IRDA_DEBUG(3, __FUNCTION__ 
-			      "(), invalid connection address!\n");
+			IRDA_DEBUG(3, "%s(), invalid connection address!\n",
+				   __FUNCTION__);
 			return;
 		}
 		
@@ -178,7 +178,7 @@
 		
 		/* Only accept if addressed directly to us */
 		if (info->saddr != self->saddr) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), not addressed to us!\n");
+			IRDA_DEBUG(2, "%s(), not addressed to us!\n", __FUNCTION__);
 			return;
 		}
 		irlap_do_event(self, RECV_SNRM_CMD, skb, info);
@@ -200,7 +200,7 @@
 	struct ua_frame *frame;
 	int ret;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "() <%ld>\n", jiffies);
+	IRDA_DEBUG(2, "%s() <%ld>\n", __FUNCTION__, jiffies);
 	
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
@@ -275,7 +275,7 @@
 	struct sk_buff *skb = NULL;
 	__u8 *frame;
 	
-	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
@@ -306,7 +306,7 @@
 	__u32 bcast = BROADCAST;
 	__u8 *info;
 
- 	IRDA_DEBUG(4, __FUNCTION__ "(), s=%d, S=%d, command=%d\n", s, S, 
+ 	IRDA_DEBUG(4, "%s(), s=%d, S=%d, command=%d\n", __FUNCTION__, s, S, 
 		   command);
 
 	ASSERT(self != NULL, return;);
@@ -398,7 +398,7 @@
 	__u8 *discovery_info;
 	char *text;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
@@ -410,13 +410,13 @@
 
 	/* Make sure frame is addressed to us */
 	if ((info->saddr != self->saddr) && (info->saddr != BROADCAST)) {
-		IRDA_DEBUG(0, __FUNCTION__ 
-			   "(), frame is not addressed to us!\n");
+		IRDA_DEBUG(0, "%s(), frame is not addressed to us!\n",
+			   __FUNCTION__);
 		return;
 	}
 
 	if ((discovery = kmalloc(sizeof(discovery_t), GFP_ATOMIC)) == NULL) {
-		WARNING(__FUNCTION__ "(), kmalloc failed!\n");
+		WARNING("%s(), kmalloc failed!\n", __FUNCTION__);
 		return;
 	}
 	memset(discovery, 0, sizeof(discovery_t));
@@ -425,7 +425,7 @@
 	discovery->saddr = self->saddr;
 	discovery->timestamp = jiffies;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), daddr=%08x\n", discovery->daddr);
+	IRDA_DEBUG(4, "%s(), daddr=%08x\n", __FUNCTION__, discovery->daddr);
 
 	discovery_info = skb_pull(skb, sizeof(struct xid_frame));
 
@@ -476,8 +476,8 @@
 
 	/* Make sure frame is addressed to us */
 	if ((info->saddr != self->saddr) && (info->saddr != BROADCAST)) {
-		IRDA_DEBUG(0, __FUNCTION__ 
-			   "(), frame is not addressed to us!\n");
+		IRDA_DEBUG(0, "%s(), frame is not addressed to us!\n",
+			   __FUNCTION__);
 		return;
 	}
 
@@ -509,7 +509,7 @@
 	if (info->s == 0xff) {
 		/* Check if things are sane at this point... */
 		if((discovery_info == NULL) || (skb->len < 3)) {
-			ERROR(__FUNCTION__ "(), discovery frame to short!\n");
+			ERROR("%s(), discovery frame to short!\n", __FUNCTION__);
 			return;
 		}
 
@@ -518,7 +518,7 @@
 		 */
 		discovery = kmalloc(sizeof(discovery_t), GFP_ATOMIC);
 		if (!discovery) {
-			WARNING(__FUNCTION__ "(), unable to malloc!\n");
+			WARNING("%s(), unable to malloc!\n", __FUNCTION__);
 			return;
 		}
 	      
@@ -642,7 +642,7 @@
 
 	frame[2] = 0;
 
-   	IRDA_DEBUG(4, __FUNCTION__ "(), vr=%d, %ld\n",self->vr, jiffies); 
+   	IRDA_DEBUG(4, "%s(), vr=%d, %ld\n", __FUNCTION__, self->vr, jiffies); 
 
 	irlap_queue_xmit(self, skb);
 }
@@ -658,7 +658,7 @@
 {
 	info->nr = skb->data[1] >> 5;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), nr=%d, %ld\n", info->nr, jiffies);
+	IRDA_DEBUG(4, "%s(), nr=%d, %ld\n", __FUNCTION__, info->nr, jiffies);
 
 	if (command)
 		irlap_do_event(self, RECV_RNR_CMD, skb, info);
@@ -669,7 +669,7 @@
 static void irlap_recv_rej_frame(struct irlap_cb *self, struct sk_buff *skb, 
 				 struct irlap_info *info, int command)
 {
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	info->nr = skb->data[1] >> 5;
 	
@@ -683,7 +683,7 @@
 static void irlap_recv_srej_frame(struct irlap_cb *self, struct sk_buff *skb, 
 				  struct irlap_info *info, int command)
 {
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	info->nr = skb->data[1] >> 5;
 	
@@ -697,7 +697,7 @@
 static void irlap_recv_disc_frame(struct irlap_cb *self, struct sk_buff *skb, 
 				  struct irlap_info *info, int command)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Check if this is a command or a response frame */
 	if (command)
@@ -754,7 +754,7 @@
 
 		irlap_send_i_frame( self, tx_skb, CMD_FRAME);
 	} else {
-		IRDA_DEBUG(4, __FUNCTION__ "(), sending unreliable frame\n");
+		IRDA_DEBUG(4, "%s(), sending unreliable frame\n", __FUNCTION__);
 		irlap_send_ui_frame(self, skb_get(skb), self->caddr, CMD_FRAME);
 		self->window -= 1;
 	}
@@ -803,7 +803,7 @@
 
 		irlap_send_i_frame(self, tx_skb, CMD_FRAME);
 	} else {
-		IRDA_DEBUG(4, __FUNCTION__ "(), sending unreliable frame\n");
+		IRDA_DEBUG(4, "%s(), sending unreliable frame\n", __FUNCTION__);
 
 		if (self->ack_required) {
 			irlap_send_ui_frame(self, skb_get(skb), self->caddr, CMD_FRAME);
@@ -952,7 +952,7 @@
 		/* tx_skb = skb_clone( skb, GFP_ATOMIC); */
 		tx_skb = skb_copy(skb, GFP_ATOMIC);
 		if (!tx_skb) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), unable to copy\n");
+			IRDA_DEBUG(0, "%s(), unable to copy\n", __FUNCTION__);
 			return;
 		}
 		/* Unlink tx_skb from list */
@@ -987,7 +987,7 @@
 	 */
 	while (skb_queue_len( &self->txq) > 0) {
 		
-		IRDA_DEBUG(0, __FUNCTION__ "(), sending additional frames!\n");
+		IRDA_DEBUG(0, "%s(), sending additional frames!\n", __FUNCTION__);
 		if ((skb_queue_len( &self->txq) > 0) && 
 		    (self->window > 0)) {
 			skb = skb_dequeue( &self->txq); 
@@ -1032,7 +1032,7 @@
 		/* tx_skb = skb_clone( skb, GFP_ATOMIC); */
 		tx_skb = skb_copy(skb, GFP_ATOMIC);
 		if (!tx_skb) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), unable to copy\n");
+			IRDA_DEBUG(0, "%s(), unable to copy\n", __FUNCTION__);
 			return;	
 		}
 		/* Unlink tx_skb from list */
@@ -1058,7 +1058,7 @@
 void irlap_send_ui_frame(struct irlap_cb *self, struct sk_buff *skb, 
 			 __u8 caddr, int command)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
@@ -1118,7 +1118,7 @@
 static void irlap_recv_ui_frame(struct irlap_cb *self, struct sk_buff *skb, 
 				struct irlap_info *info)
 {
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	info->pf = skb->data[1] & PF_BIT;      /* Final bit */
 
@@ -1137,7 +1137,7 @@
 	__u8 *frame;
 	int w, x, y, z;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
@@ -1226,15 +1226,15 @@
 {
 	struct test_frame *frame;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	frame = (struct test_frame *) skb->data;
 		
 	/* Broadcast frames must carry saddr and daddr fields */
 	if (info->caddr == CBROADCAST) {
 		if (skb->len < sizeof(struct test_frame)) {
-			IRDA_DEBUG(0, __FUNCTION__ 
-				   "() test frame to short!\n");
+			IRDA_DEBUG(0, "%s() test frame to short!\n",
+				   __FUNCTION__);
 			return;
 		}
 		
@@ -1281,7 +1281,7 @@
 
 	/* Check if frame is large enough for parsing */
 	if (skb->len < 2) {
-		ERROR(__FUNCTION__ "(), frame to short!\n");
+		ERROR("%s(), frame to short!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 		return -1;
 	}
@@ -1296,7 +1296,7 @@
 
 	/*  First we check if this frame has a valid connection address */
 	if ((info.caddr != self->caddr) && (info.caddr != CBROADCAST)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), wrong connection address!\n");
+		IRDA_DEBUG(0, "%s(), wrong connection address!\n", __FUNCTION__);
 		goto out;
 	}
 	/*  
@@ -1330,9 +1330,8 @@
 			irlap_recv_srej_frame(self, skb, &info, command);
 			break;
 		default:
-			WARNING(__FUNCTION__ 
-				"() Unknown S-frame %02x received!\n",
-				info.control);
+			WARNING("%s() Unknown S-frame %02x received!\n",
+				__FUNCTION__, info.control);
 			break;
 		}
 		goto out;
@@ -1369,7 +1368,7 @@
 		irlap_recv_ui_frame(self, skb, &info);
 		break;
 	default:
-		WARNING(__FUNCTION__ "(), Unknown frame %02x received!\n", 
+		WARNING("%s(), Unknown frame %02x received!\n", __FUNCTION__, 
 			info.control);
 		break;
 	}

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
