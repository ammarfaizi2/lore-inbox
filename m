Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSFJMnl>; Mon, 10 Jun 2002 08:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSFJMnB>; Mon, 10 Jun 2002 08:43:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:22535 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314227AbSFJMly>; Mon, 10 Jun 2002 08:41:54 -0400
Message-ID: <3D0490D0.5070200@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:43:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 12/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030100000906040900090107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030100000906040900090107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The irda people use shreddy editors saga continues.

--------------030100000906040900090107
Content-Type: text/plain;
 name="warn-2.5.21-12.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-12.diff"

diff -urN linux-2.5.21/net/irda/irlap.c linux/net/irda/irlap.c
--- linux-2.5.21/net/irda/irlap.c	2002-06-09 07:29:10.000000000 +0200
+++ linux/net/irda/irlap.c	2002-06-09 21:32:20.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *                
+ *
  * Filename:      irlap.c
  * Version:       1.0
  * Description:   IrLAP implementation for Linux
@@ -8,25 +8,25 @@
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Tue Dec 14 09:26:44 1999
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * 
+ *
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
  *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
- *     
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
- * 
+ *
  *     This program is distributed in the hope that it will be useful,
  *     but WITHOUT ANY WARRANTY; without even the implied warranty of
  *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  *     GNU General Public License for more details.
- * 
- *     You should have received a copy of the GNU General Public License 
- *     along with this program; if not, write to the Free Software 
- *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
+ *
+ *     You should have received a copy of the GNU General Public License
+ *     along with this program; if not, write to the Free Software
+ *     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  *     MA 02111-1307 USA
- *     
+ *
  ********************************************************************/
 
 #include <linux/config.h>
@@ -82,7 +82,7 @@
 	/* Allocate master array */
 	irlap = hashbin_new(HB_LOCAL);
 	if (irlap == NULL) {
-	        ERROR(__FUNCTION__ "(), can't allocate irlap hashbin!\n");
+	        ERROR("%s: can't allocate irlap hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -108,12 +108,12 @@
 	struct irlap_cb *self;
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
+
 	/* Initialize the irlap structure. */
 	self = kmalloc(sizeof(struct irlap_cb), GFP_KERNEL);
 	if (self == NULL)
 		return NULL;
-	
+
 	memset(self, 0, sizeof(struct irlap_cb));
 	self->magic = LAP_MAGIC;
 
@@ -145,22 +145,22 @@
 	init_timer(&self->slot_timer);
 	init_timer(&self->query_timer);
 	init_timer(&self->discovery_timer);
-	init_timer(&self->final_timer);		
+	init_timer(&self->final_timer);
 	init_timer(&self->poll_timer);
 	init_timer(&self->wd_timer);
 	init_timer(&self->backoff_timer);
-	init_timer(&self->media_busy_timer);	
+	init_timer(&self->media_busy_timer);
 
 	irlap_apply_default_connection_parameters(self);
 
 	self->N3 = 3; /* # connections attemts to try before giving up */
-	
+
 	self->state = LAP_NDM;
 
 	hashbin_insert(irlap, (irda_queue_t *) self, self->saddr, NULL);
 
 	irlmp_register_link(self, self->saddr, &self->notify);
-	
+
 	return self;
 }
 
@@ -179,16 +179,16 @@
 	del_timer(&self->slot_timer);
 	del_timer(&self->query_timer);
 	del_timer(&self->discovery_timer);
-	del_timer(&self->final_timer);		
+	del_timer(&self->final_timer);
 	del_timer(&self->poll_timer);
 	del_timer(&self->wd_timer);
 	del_timer(&self->backoff_timer);
 	del_timer(&self->media_busy_timer);
 
 	irlap_flush_all_queues(self);
-       
+
 	self->magic = 0;
-	
+
 	kfree(self);
 }
 
@@ -198,12 +198,12 @@
  *    Remove IrLAP instance
  *
  */
-void irlap_close(struct irlap_cb *self) 
+void irlap_close(struct irlap_cb *self)
 {
 	struct irlap_cb *lap;
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
+
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
@@ -227,7 +227,7 @@
  *    Another device is attempting to make a connection
  *
  */
-void irlap_connect_indication(struct irlap_cb *self, struct sk_buff *skb) 
+void irlap_connect_indication(struct irlap_cb *self, struct sk_buff *skb)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
@@ -237,7 +237,7 @@
 	irlap_init_qos_capabilities(self, NULL); /* No user QoS! */
 
 	skb_get(skb); /*LEVEL4*/
-	irlmp_link_connect_indication(self->notify.instance, self->saddr, 
+	irlmp_link_connect_indication(self->notify.instance, self->saddr,
 				      self->daddr, &self->qos_tx, skb);
 }
 
@@ -247,10 +247,10 @@
  *    Service user has accepted incoming connection
  *
  */
-void irlap_connect_response(struct irlap_cb *self, struct sk_buff *skb) 
+void irlap_connect_response(struct irlap_cb *self, struct sk_buff *skb)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
+
 	irlap_do_event(self, CONNECT_RESPONSE, skb, NULL);
 	kfree_skb(skb);
 }
@@ -258,26 +258,26 @@
 /*
  * Function irlap_connect_request (self, daddr, qos_user, sniff)
  *
- *    Request connection with another device, sniffing is not implemented 
+ *    Request connection with another device, sniffing is not implemented
  *    yet.
  *
  */
-void irlap_connect_request(struct irlap_cb *self, __u32 daddr, 
-			   struct qos_info *qos_user, int sniff) 
+void irlap_connect_request(struct irlap_cb *self, __u32 daddr,
+			   struct qos_info *qos_user, int sniff)
 {
 	IRDA_DEBUG(3, __FUNCTION__ "(), daddr=0x%08x\n", daddr);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
- 	self->daddr = daddr;
-	
+	self->daddr = daddr;
+
 	/*
-	 *  If the service user specifies QoS values for this connection, 
+	 *  If the service user specifies QoS values for this connection,
 	 *  then use them
 	 */
 	irlap_init_qos_capabilities(self, qos_user);
-	
+
 	if ((self->state == LAP_NDM) && !self->media_busy)
 		irlap_do_event(self, CONNECT_REQUEST, NULL, NULL);
 	else
@@ -304,12 +304,12 @@
 /*
  * Function irlap_data_indication (self, skb)
  *
- *    Received data frames from IR-port, so we just pass them up to 
+ *    Received data frames from IR-port, so we just pass them up to
  *    IrLMP for further processing
  *
  */
 void irlap_data_indication(struct irlap_cb *self, struct sk_buff *skb,
-			   int unreliable) 
+			   int unreliable)
 {
 	/* Hide LAP header from IrLMP layer */
 	skb_pull(skb, LAP_ADDR_HEADER+LAP_CTRL_HEADER);
@@ -325,7 +325,7 @@
  *    Queue data for transmission, must wait until XMIT state
  *
  */
-void irlap_data_request(struct irlap_cb *self, struct sk_buff *skb, 
+void irlap_data_request(struct irlap_cb *self, struct sk_buff *skb,
 			int unreliable)
 {
 	ASSERT(self != NULL, return;);
@@ -333,12 +333,12 @@
 
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
 
-	ASSERT(skb_headroom(skb) >= (LAP_ADDR_HEADER+LAP_CTRL_HEADER), 
+	ASSERT(skb_headroom(skb) >= (LAP_ADDR_HEADER+LAP_CTRL_HEADER),
 	       return;);
 	skb_push(skb, LAP_ADDR_HEADER+LAP_CTRL_HEADER);
 
-	/*  
-	 *  Must set frame format now so that the rest of the code knows 
+	/*
+	 *  Must set frame format now so that the rest of the code knows
 	 *  if its dealing with an I or an UI frame
 	 */
 	if (unreliable)
@@ -349,11 +349,11 @@
 	/* Add at the end of the queue (keep ordering) - Jean II */
 	skb_queue_tail(&self->txq, skb);
 
-	/* 
-	 *  Send event if this frame only if we are in the right state 
+	/*
+	 *  Send event if this frame only if we are in the right state
 	 *  FIXME: udata should be sent first! (skb_queue_head?)
 	 */
-  	if ((self->state == LAP_XMIT_P) || (self->state == LAP_XMIT_S)) {
+	if ((self->state == LAP_XMIT_P) || (self->state == LAP_XMIT_S)) {
 		/* If we are not already processing the Tx queue, trigger
 		 * transmission immediately - Jean II */
 		if((skb_queue_len(&self->txq) <= 1) && (!self->local_busy))
@@ -377,7 +377,7 @@
 
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
 
-	ASSERT(skb_headroom(skb) >= (LAP_ADDR_HEADER+LAP_CTRL_HEADER), 
+	ASSERT(skb_headroom(skb) >= (LAP_ADDR_HEADER+LAP_CTRL_HEADER),
 	       return;);
 	skb_push(skb, LAP_ADDR_HEADER+LAP_CTRL_HEADER);
 
@@ -399,7 +399,7 @@
 #ifdef CONFIG_IRDA_ULTRA
 void irlap_unitdata_indication(struct irlap_cb *self, struct sk_buff *skb)
 {
-	IRDA_DEBUG(1, __FUNCTION__ "()\n"); 
+	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
@@ -418,17 +418,17 @@
  *
  *    Request to disconnect connection by service user
  */
-void irlap_disconnect_request(struct irlap_cb *self) 
+void irlap_disconnect_request(struct irlap_cb *self)
 {
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
-	
+
 	/* Don't disconnect until all data frames are successfully sent */
 	if (skb_queue_len(&self->txq) > 0) {
 		self->disconnect_pending = TRUE;
-		
+
 		return;
 	}
 
@@ -436,9 +436,9 @@
 	switch (self->state) {
 	case LAP_XMIT_P:        /* FALLTROUGH */
 	case LAP_XMIT_S:        /* FALLTROUGH */
- 	case LAP_CONN:          /* FALLTROUGH */
- 	case LAP_RESET_WAIT:    /* FALLTROUGH */
- 	case LAP_RESET_CHECK:   
+	case LAP_CONN:          /* FALLTROUGH */
+	case LAP_RESET_WAIT:    /* FALLTROUGH */
+	case LAP_RESET_CHECK:
 		irlap_do_event(self, DISCONNECT_REQUEST, NULL, NULL);
 		break;
 	default:
@@ -454,30 +454,30 @@
  *    Disconnect request from other device
  *
  */
-void irlap_disconnect_indication(struct irlap_cb *self, LAP_REASON reason) 
+void irlap_disconnect_indication(struct irlap_cb *self, LAP_REASON reason)
 {
-	IRDA_DEBUG(1, __FUNCTION__ "(), reason=%s\n", lap_reasons[reason]); 
+	IRDA_DEBUG(1, __FUNCTION__ "(), reason=%s\n", lap_reasons[reason]);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
 	/* Flush queues */
 	irlap_flush_all_queues(self);
-	
+
 	switch (reason) {
 	case LAP_RESET_INDICATION:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Sending reset request!\n");
 		irlap_do_event(self, RESET_REQUEST, NULL, NULL);
 		break;
-	case LAP_NO_RESPONSE:	   /* FALLTROUGH */	
+	case LAP_NO_RESPONSE:	   /* FALLTROUGH */
 	case LAP_DISC_INDICATION:  /* FALLTROUGH */
 	case LAP_FOUND_NONE:       /* FALLTROUGH */
 	case LAP_MEDIA_BUSY:
-		irlmp_link_disconnect_indication(self->notify.instance, self, 
+		irlmp_link_disconnect_indication(self->notify.instance, self,
 						 reason, NULL);
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), Unknown reason %d\n", reason);
+		ERROR("%s: Unknown reason %d\n", __FUNCTION__, reason);
 	}
 }
 
@@ -487,23 +487,23 @@
  *    Start one single discovery operation.
  *
  */
-void irlap_discovery_request(struct irlap_cb *self, discovery_t *discovery) 
+void irlap_discovery_request(struct irlap_cb *self, discovery_t *discovery)
 {
 	struct irlap_info info;
-	
+
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 	ASSERT(discovery != NULL, return;);
-	
+
 	IRDA_DEBUG(4, __FUNCTION__ "(), nslots = %d\n", discovery->nslots);
 
 	ASSERT((discovery->nslots == 1) || (discovery->nslots == 6) ||
-	       (discovery->nslots == 8) || (discovery->nslots == 16), 
+	       (discovery->nslots == 8) || (discovery->nslots == 16),
 	       return;);
-	
-  	/* Discovery is only possible in NDM mode */
+
+	/* Discovery is only possible in NDM mode */
 	if (self->state != LAP_NDM) {
-		IRDA_DEBUG(4, __FUNCTION__ 
+		IRDA_DEBUG(4, __FUNCTION__
 			   "(), discovery only possible in NDM mode\n");
 		irlap_discovery_confirm(self, NULL);
 		/* Note : in theory, if we are not in NDM, we could postpone
@@ -521,18 +521,18 @@
 		hashbin_delete(self->discovery_log, (FREE_FUNC) kfree);
 		self->discovery_log = NULL;
 	}
-	
+
 	self->discovery_log= hashbin_new(HB_LOCAL);
-	
+
 	info.S = discovery->nslots; /* Number of slots */
 	info.s = 0; /* Current slot */
-	
+
 	self->discovery_cmd = discovery;
 	info.discovery = discovery;
-	
+
 	/* sysctl_slot_timeout bounds are checked in irsysctl.c - Jean II */
 	self->slot_timeout = sysctl_slot_timeout * HZ / 1000;
-	
+
 	irlap_do_event(self, DISCOVERY_REQUEST, NULL, &info);
 }
 
@@ -542,15 +542,15 @@
  *    A device has been discovered in front of this station, we
  *    report directly to LMP.
  */
-void irlap_discovery_confirm(struct irlap_cb *self, hashbin_t *discovery_log) 
+void irlap_discovery_confirm(struct irlap_cb *self, hashbin_t *discovery_log)
 {
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
-	
+
 	ASSERT(self->notify.instance != NULL, return;);
-	
-	/* 
-	 * Check for successful discovery, since we are then allowed to clear 
+
+	/*
+	 * Check for successful discovery, since we are then allowed to clear
 	 * the media busy condition (IrLAP 6.13.4 - p.94). This should allow
 	 * us to make connection attempts much faster and easier (i.e. no
 	 * collisions).
@@ -562,7 +562,7 @@
 	 */
 	if (discovery_log)
 		irda_device_set_media_busy(self->netdev, FALSE);
-	
+
 	/* Inform IrLMP */
 	irlmp_link_discovery_confirm(self->notify.instance, discovery_log);
 }
@@ -573,7 +573,7 @@
  *    Somebody is trying to discover us!
  *
  */
-void irlap_discovery_indication(struct irlap_cb *self, discovery_t *discovery) 
+void irlap_discovery_indication(struct irlap_cb *self, discovery_t *discovery)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
@@ -599,11 +599,8 @@
 
 /*
  * Function irlap_status_indication (quality_of_link)
- *
- *    
- *
  */
-void irlap_status_indication(struct irlap_cb *self, int quality_of_link) 
+void irlap_status_indication(struct irlap_cb *self, int quality_of_link)
 {
 	switch (quality_of_link) {
 	case STATUS_NO_ACTIVITY:
@@ -621,9 +618,6 @@
 
 /*
  * Function irlap_reset_indication (void)
- *
- *    
- *
  */
 void irlap_reset_indication(struct irlap_cb *self)
 {
@@ -631,7 +625,7 @@
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
-	
+
 	if (self->state == LAP_RESET_WAIT)
 		irlap_do_event(self, RESET_REQUEST, NULL, NULL);
 	else
@@ -640,13 +634,10 @@
 
 /*
  * Function irlap_reset_confirm (void)
- *
- *    
- *
  */
 void irlap_reset_confirm(void)
 {
- 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 }
 
 /*
@@ -656,11 +647,11 @@
  *    S = Number of slots (0 -> S-1)
  *    s = Current slot
  */
-int irlap_generate_rand_time_slot(int S, int s) 
+int irlap_generate_rand_time_slot(int S, int s)
 {
 	static int rand;
 	int slot;
-	
+
 	ASSERT((S - s) > 0, return 0;);
 
 	rand += jiffies;
@@ -668,20 +659,20 @@
 	rand ^= (rand >> 20);
 
 	slot = s + rand % (S-s);
-	
+
 	ASSERT((slot >= s) || (slot < S), return 0;);
-	
+
 	return slot;
 }
 
 /*
  * Function irlap_update_nr_received (nr)
  *
- *    Remove all acknowledged frames in current window queue. This code is 
+ *    Remove all acknowledged frames in current window queue. This code is
  *    not intuitive and you should not try to change it. If you think it
  *    contains bugs, please mail a patch to the author instead.
  */
-void irlap_update_nr_received(struct irlap_cb *self, int nr) 
+void irlap_update_nr_received(struct irlap_cb *self, int nr)
 {
 	struct sk_buff *skb = NULL;
 	int count = 0;
@@ -690,7 +681,7 @@
          * Remove all the ack-ed frames from the window queue.
          */
 
-	/* 
+	/*
 	 *  Optimize for the common case. It is most likely that the receiver
 	 *  will acknowledge all the frames we have sent! So in that case we
 	 *  delete all frames stored in window.
@@ -703,17 +694,17 @@
 		self->va = nr - 1;
 	} else {
 		/* Remove all acknowledged frames in current window */
-		while ((skb_peek(&self->wx_list) != NULL) && 
-		       (((self->va+1) % 8) != nr)) 
+		while ((skb_peek(&self->wx_list) != NULL) &&
+		       (((self->va+1) % 8) != nr))
 		{
 			skb = skb_dequeue(&self->wx_list);
 			dev_kfree_skb(skb);
-			
+
 			self->va = (self->va + 1) % 8;
 			count++;
 		}
 	}
-	
+
 	/* Advance window */
 	self->window = self->window_size - skb_queue_len(&self->wx_list);
 }
@@ -723,7 +714,7 @@
  *
  *    Validate the next to send (ns) field from received frame.
  */
-int irlap_validate_ns_received(struct irlap_cb *self, int ns) 
+int irlap_validate_ns_received(struct irlap_cb *self, int ns)
 {
 	/*  ns as expected?  */
 	if (ns == self->vr)
@@ -733,7 +724,7 @@
 	 *  IrLAP, Recv ... with-invalid-Ns. p. 84
 	 */
 	return NS_UNEXPECTED;
-	
+
 	/* return NR_INVALID; */
 }
 /*
@@ -742,7 +733,7 @@
  *    Validate the next to receive (nr) field from received frame.
  *
  */
-int irlap_validate_nr_received(struct irlap_cb *self, int nr) 
+int irlap_validate_nr_received(struct irlap_cb *self, int nr)
 {
 	/*  nr as expected?  */
 	if (nr == self->vs) {
@@ -751,17 +742,17 @@
 	}
 
 	/*
-	 *  unexpected nr? (but within current window), first we check if the 
+	 *  unexpected nr? (but within current window), first we check if the
 	 *  ns numbers of the frames in the current window wrap.
 	 */
 	if (self->va < self->vs) {
 		if ((nr >= self->va) && (nr <= self->vs))
 			return NR_UNEXPECTED;
 	} else {
-		if ((nr >= self->va) || (nr <= self->vs)) 
+		if ((nr >= self->va) || (nr <= self->vs))
 			return NR_UNEXPECTED;
 	}
-	
+
 	/* Invalid nr!  */
 	return NR_INVALID;
 }
@@ -772,10 +763,10 @@
  *    Initialize the connection state parameters
  *
  */
-void irlap_initiate_connection_state(struct irlap_cb *self) 
+void irlap_initiate_connection_state(struct irlap_cb *self)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
+
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
@@ -799,11 +790,11 @@
  *    frame in order to delay for the specified amount of time. This is
  *    done to avoid using timers, and the forbidden udelay!
  */
-void irlap_wait_min_turn_around(struct irlap_cb *self, struct qos_info *qos) 
+void irlap_wait_min_turn_around(struct irlap_cb *self, struct qos_info *qos)
 {
 	__u32 min_turn_time;
 	__u32 speed;
-	
+
 	/* Get QoS values.  */
 	speed = qos->baud_rate.value;
 	min_turn_time = qos->min_turn_time.value;
@@ -813,10 +804,10 @@
 		self->mtt_required = min_turn_time;
 		return;
 	}
-	
-	/*  
+
+	/*
 	 *  Send additional BOF's for the next frame for the requested
-	 *  min turn time, so now we must calculate how many chars (XBOF's) we 
+	 *  min turn time, so now we must calculate how many chars (XBOF's) we
 	 *  must send for the requested time period (min turn time)
 	 */
 	self->xbofs_delay = irlap_min_turn_time_in_bytes(speed, min_turn_time);
@@ -828,7 +819,7 @@
  *    Flush all queues
  *
  */
-void irlap_flush_all_queues(struct irlap_cb *self) 
+void irlap_flush_all_queues(struct irlap_cb *self)
 {
 	struct sk_buff* skb;
 
@@ -838,7 +829,7 @@
 	/* Free transmission queue */
 	while ((skb = skb_dequeue(&self->txq)) != NULL)
 		dev_kfree_skb(skb);
-	
+
 	while ((skb = skb_dequeue(&self->txq_ultra)) != NULL)
 		dev_kfree_skb(skb);
 
@@ -894,7 +885,7 @@
 	irda_qos_compute_intersection(&self->qos_rx, self->qos_dev);
 
 	/*
-	 *  Check for user supplied QoS parameters. The service user is only 
+	 *  Check for user supplied QoS parameters. The service user is only
 	 *  allowed to supply these values. We check each parameter since the
 	 *  user may not have set all of them.
 	 */
@@ -926,7 +917,6 @@
  * Function irlap_apply_default_connection_parameters (void, now)
  *
  *    Use the default connection and transmission parameters
- * 
  */
 void irlap_apply_default_connection_parameters(struct irlap_cb *self)
 {
@@ -945,9 +935,9 @@
 	/* Set mbusy when going to NDM state */
 	irda_device_set_media_busy(self->netdev, TRUE);
 
-	/* 
+	/*
 	 * Generate random connection address for this session, which must
-	 * be 7 bits wide and different from 0x00 and 0xfe 
+	 * be 7 bits wide and different from 0x00 and 0xfe
 	 */
 	while ((self->caddr == 0x00) || (self->caddr == 0xfe)) {
 		get_random_bytes(&self->caddr, sizeof(self->caddr));
@@ -991,10 +981,10 @@
  * frame is sent.
  * If 'now' is true, the speed and xbofs is changed immediately
  */
-void irlap_apply_connection_parameters(struct irlap_cb *self, int now) 
+void irlap_apply_connection_parameters(struct irlap_cb *self, int now)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
+
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
@@ -1014,15 +1004,15 @@
 	 *  Calculate how many bytes it is possible to transmit before the
 	 *  link must be turned around
 	 */
-	self->line_capacity = 
+	self->line_capacity =
 		irlap_max_line_capacity(self->qos_tx.baud_rate.value,
 					self->qos_tx.max_turn_time.value);
 	self->bytes_left = self->line_capacity;
 #endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
 
-	
-	/* 
-	 *  Initialize timeout values, some of the rules are listed on 
+
+	/*
+	 *  Initialize timeout values, some of the rules are listed on
 	 *  page 92 in IrLAP.
 	 */
 	ASSERT(self->qos_tx.max_turn_time.value != 0, return;);
@@ -1056,27 +1046,27 @@
 	 */
 
 	/*
-	 *  Set N1 to 0 if Link Disconnect/Threshold Time = 3 and set it to 
+	 *  Set N1 to 0 if Link Disconnect/Threshold Time = 3 and set it to
 	 *  3 seconds otherwise. See page 71 in IrLAP for more details.
 	 *  Actually, it's not always 3 seconds, as we allow to set
 	 *  it via sysctl... Max maxtt is 500ms, and N1 need to be multiple
 	 *  of 2, so 1 second is minimum we can allow. - Jean II
 	 */
 	if (self->qos_tx.link_disc_time.value == sysctl_warn_noreply_time)
-		/* 
+		/*
 		 * If we set N1 to 0, it will trigger immediately, which is
 		 * not what we want. What we really want is to disable it,
-		 * Jean II 
+		 * Jean II
 		 */
 		self->N1 = -2; /* Disable - Need to be multiple of 2*/
 	else
 		self->N1 = sysctl_warn_noreply_time * 1000 /
 		  self->qos_rx.max_turn_time.value;
-	
+
 	IRDA_DEBUG(4, "Setting N1 = %d\n", self->N1);
-	
+
 	/* Set N2 to match our own disconnect time */
-	self->N2 = self->qos_tx.link_disc_time.value * 1000 / 
+	self->N2 = self->qos_tx.link_disc_time.value * 1000 /
 		self->qos_rx.max_turn_time.value;
 	IRDA_DEBUG(4, "Setting N2 = %d\n", self->N2);
 }
@@ -1093,7 +1083,7 @@
 	struct irlap_cb *self;
 	unsigned long flags;
 	int i = 0;
-     
+
 	save_flags(flags);
 	cli();
 
@@ -1105,9 +1095,9 @@
 		ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
 
 		len += sprintf(buf+len, "irlap%d ", i++);
-		len += sprintf(buf+len, "state: %s\n", 
+		len += sprintf(buf+len, "state: %s\n",
 			       irlap_state[self->state]);
-		
+
 		len += sprintf(buf+len, "  device name: %s, ",
 			       (self->netdev) ? self->netdev->name : "bug");
 		len += sprintf(buf+len, "hardware name: %s\n", self->hw_name);
@@ -1115,34 +1105,34 @@
 		len += sprintf(buf+len, "  caddr: %#02x, ", self->caddr);
 		len += sprintf(buf+len, "saddr: %#08x, ", self->saddr);
 		len += sprintf(buf+len, "daddr: %#08x\n", self->daddr);
-		
-		len += sprintf(buf+len, "  win size: %d, ", 
+
+		len += sprintf(buf+len, "  win size: %d, ",
 			       self->window_size);
 		len += sprintf(buf+len, "win: %d, ", self->window);
 #if CONFIG_IRDA_DYNAMIC_WINDOW
-		len += sprintf(buf+len, "line capacity: %d, ", 
+		len += sprintf(buf+len, "line capacity: %d, ",
 			       self->line_capacity);
 		len += sprintf(buf+len, "bytes left: %d\n", self->bytes_left);
 #endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
-		len += sprintf(buf+len, "  tx queue len: %d ", 
+		len += sprintf(buf+len, "  tx queue len: %d ",
 			       skb_queue_len(&self->txq));
-		len += sprintf(buf+len, "win queue len: %d ", 
+		len += sprintf(buf+len, "win queue len: %d ",
 			       skb_queue_len(&self->wx_list));
 		len += sprintf(buf+len, "rbusy: %s", self->remote_busy ?
 			       "TRUE" : "FALSE");
 		len += sprintf(buf+len, " mbusy: %s\n", self->media_busy ?
 			       "TRUE" : "FALSE");
-		
+
 		len += sprintf(buf+len, "  retrans: %d ", self->retry_count);
 		len += sprintf(buf+len, "vs: %d ", self->vs);
 		len += sprintf(buf+len, "vr: %d ", self->vr);
 		len += sprintf(buf+len, "va: %d\n", self->va);
-		
+
 		len += sprintf(buf+len, "  qos\tbps\tmaxtt\tdsize\twinsize\taddbofs\tmintt\tldisc\tcomp\n");
-		
-		len += sprintf(buf+len, "  tx\t%d\t", 
+
+		len += sprintf(buf+len, "  tx\t%d\t",
 			       self->qos_tx.baud_rate.value);
-		len += sprintf(buf+len, "%d\t", 
+		len += sprintf(buf+len, "%d\t",
 			       self->qos_tx.max_turn_time.value);
 		len += sprintf(buf+len, "%d\t",
 			       self->qos_tx.data_size.value);
@@ -1150,15 +1140,15 @@
 			       self->qos_tx.window_size.value);
 		len += sprintf(buf+len, "%d\t",
 			       self->qos_tx.additional_bofs.value);
-		len += sprintf(buf+len, "%d\t", 
+		len += sprintf(buf+len, "%d\t",
 			       self->qos_tx.min_turn_time.value);
-		len += sprintf(buf+len, "%d\t", 
+		len += sprintf(buf+len, "%d\t",
 			       self->qos_tx.link_disc_time.value);
 		len += sprintf(buf+len, "\n");
 
-		len += sprintf(buf+len, "  rx\t%d\t", 
+		len += sprintf(buf+len, "  rx\t%d\t",
 			       self->qos_rx.baud_rate.value);
-		len += sprintf(buf+len, "%d\t", 
+		len += sprintf(buf+len, "%d\t",
 			       self->qos_rx.max_turn_time.value);
 		len += sprintf(buf+len, "%d\t",
 			       self->qos_rx.data_size.value);
@@ -1166,12 +1156,12 @@
 			       self->qos_rx.window_size.value);
 		len += sprintf(buf+len, "%d\t",
 			       self->qos_rx.additional_bofs.value);
-		len += sprintf(buf+len, "%d\t", 
+		len += sprintf(buf+len, "%d\t",
 			       self->qos_rx.min_turn_time.value);
-		len += sprintf(buf+len, "%d\t", 
+		len += sprintf(buf+len, "%d\t",
 			       self->qos_rx.link_disc_time.value);
 		len += sprintf(buf+len, "\n");
-		
+
 		self = (struct irlap_cb *) hashbin_get_next(irlap);
 	}
 	restore_flags(flags);
@@ -1180,4 +1170,3 @@
 }
 
 #endif /* CONFIG_PROC_FS */
-

--------------030100000906040900090107--

