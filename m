Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTHVHo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTHVHmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:42:36 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:61714 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263060AbTHVHdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 03:33:36 -0400
Date: Fri, 22 Aug 2003 04:32:51 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][resend] 11/13 2.4.22-rc2 fix __FUNCTION__ warnings net/irda
 [5/7]
Message-Id: <20030822043251.4e59e499.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 irlmp.c       |    8 ++++----
 irlmp_frame.c |   47 +++++++++++++++++++++++------------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

--- linux-2.4.22-rc2/net/irda/irlmp.c	2003-06-13 11:51:39.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlmp.c	2003-08-21 00:08:28.000000000 -0300
@@ -1241,7 +1241,7 @@
 	/* Get the number of lsap. That's the only safe way to know
 	 * that we have looped around... - Jean II */
 	lsap_todo = HASHBIN_GET_SIZE(self->lsaps);
-	IRDA_DEBUG(4, __FUNCTION__ "() : %d lsaps to scan\n", lsap_todo);
+	IRDA_DEBUG(4, "%s() : %d lsaps to scan\n", __FUNCTION__, lsap_todo);
 
 	/* Poll lsap in order until the queue is full or until we
 	 * tried them all.
@@ -1255,7 +1255,7 @@
 			/* Note that if there is only one LSAP on the LAP
 			 * (most common case), self->flow_next is always NULL,
 			 * so we always avoid this loop. - Jean II */
-			IRDA_DEBUG(4, __FUNCTION__ "() : searching my LSAP\n");
+			IRDA_DEBUG(4, "%s() : searching my LSAP\n", __FUNCTION__);
 
 			/* We look again in hashbins, because the lsap
 			 * might have gone away... - Jean II */
@@ -1274,14 +1274,14 @@
 
 		/* Next time, we will get the next one (or the first one) */
 		self->flow_next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-		IRDA_DEBUG(4, __FUNCTION__ "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
+		IRDA_DEBUG(4, "%s() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", __FUNCTION__, curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
 
 		/* Inform lsap user that it can send one more packet. */
 		if (curr->notify.flow_indication != NULL)
 			curr->notify.flow_indication(curr->notify.instance, 
 						     curr, flow);
 		else
-			IRDA_DEBUG(1, __FUNCTION__ "(), no handler\n");
+			IRDA_DEBUG(1, "%s(), no handler\n", __FUNCTION__);
 	}
 }
 
--- linux-2.4.22-rc2/net/irda/irlmp_frame.c	2002-11-28 20:53:16.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlmp_frame.c	2003-08-21 00:08:28.000000000 -0300
@@ -45,7 +45,7 @@
 	skb->data[1] = slsap;
 
 	if (expedited) {
-		IRDA_DEBUG(4, __FUNCTION__ "(), sending expedited data\n");
+		IRDA_DEBUG(4, "%s(), sending expedited data\n", __FUNCTION__);
 		irlap_data_request(self->irlap, skb, TRUE);
 	} else
 		irlap_data_request(self->irlap, skb, FALSE);
@@ -61,7 +61,7 @@
 {
 	__u8 *frame;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
@@ -96,7 +96,7 @@
 	__u8   dlsap_sel;   /* Destination LSAP address */
 	__u8   *fp;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
@@ -116,8 +116,8 @@
 	 *  it in a different way than other established connections.
 	 */
 	if ((fp[0] & CONTROL_BIT) && (fp[2] == CONNECT_CMD)) {
-		IRDA_DEBUG(3, __FUNCTION__ "(), incoming connection, "
-			   "source LSAP=%d, dest LSAP=%d\n",
+		IRDA_DEBUG(3, "%s(), incoming connection, "
+			   "source LSAP=%d, dest LSAP=%d\n", __FUNCTION__,
 			   slsap_sel, dlsap_sel);
 		
 		/* Try to find LSAP among the unconnected LSAPs */
@@ -126,7 +126,7 @@
 		
 		/* Maybe LSAP was already connected, so try one more time */
 		if (!lsap) {
-			IRDA_DEBUG(1, __FUNCTION__ "(), incoming connection for LSAP already connected\n");
+			IRDA_DEBUG(1, "%s(), incoming connection for LSAP already connected\n", __FUNCTION__);
 			lsap = irlmp_find_lsap(self, dlsap_sel, slsap_sel, 0,
 					       self->lsaps);
 		}
@@ -136,14 +136,13 @@
 	
 	if (lsap == NULL) {
 		IRDA_DEBUG(2, "IrLMP, Sorry, no LSAP for received frame!\n");
-		IRDA_DEBUG(2, __FUNCTION__ 
-		      "(), slsap_sel = %02x, dlsap_sel = %02x\n", slsap_sel, 
-		      dlsap_sel);
+		IRDA_DEBUG(2, "%s(), slsap_sel = %02x, dlsap_sel = %02x\n",
+			   __FUNCTION__, slsap_sel, dlsap_sel);
 		if (fp[0] & CONTROL_BIT) {
-			IRDA_DEBUG(2, __FUNCTION__ 
-			      "(), received control frame %02x\n", fp[2]);
+			IRDA_DEBUG(2, "%s(), received control frame %02x\n",
+				   __FUNCTION__, fp[2]);
 		} else {
-			IRDA_DEBUG(2, __FUNCTION__ "(), received data frame\n");
+			IRDA_DEBUG(2, "%s(), received data frame\n", __FUNCTION__);
 		}
 		dev_kfree_skb(skb);
 		return;
@@ -162,8 +161,8 @@
 			irlmp_do_lsap_event(lsap, LM_CONNECT_CONFIRM, skb);
 			break;
 		case DISCONNECT:
-			IRDA_DEBUG(4, __FUNCTION__ 
-				   "(), Disconnect indication!\n");
+			IRDA_DEBUG(4, "%s(), Disconnect indication!\n",
+				   __FUNCTION__);
 			irlmp_do_lsap_event(lsap, LM_DISCONNECT_INDICATION, 
 					    skb);
 			break;
@@ -176,8 +175,8 @@
 			dev_kfree_skb(skb);
 			break;
 		default:
-			IRDA_DEBUG(0, __FUNCTION__ 
-				   "(), Unknown control frame %02x\n", fp[2]);
+			IRDA_DEBUG(0, "%s(), Unknown control frame %02x\n",
+				   __FUNCTION__, fp[2]);
 			dev_kfree_skb(skb);
 			break;
 		}
@@ -211,7 +210,7 @@
 	__u8   pid;         /* Protocol identifier */
 	__u8   *fp;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
@@ -228,7 +227,7 @@
 	pid       = fp[2];
 	
 	if (pid & 0x80) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), extension in PID not supp!\n");
+		IRDA_DEBUG(0, "%s(), extension in PID not supp!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 
 		return;
@@ -236,7 +235,7 @@
 
 	/* Check if frame is addressed to the connectionless LSAP */
 	if ((slsap_sel != LSAP_CONNLESS) || (dlsap_sel != LSAP_CONNLESS)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), dropping frame!\n");
+		IRDA_DEBUG(0, "%s(), dropping frame!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 		
 		return;
@@ -258,7 +257,7 @@
 	if (lsap)
 		irlmp_connless_data_indication(lsap, skb);
 	else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), found no matching LSAP!\n");
+		IRDA_DEBUG(0, "%s(), found no matching LSAP!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 }
@@ -275,7 +274,7 @@
 				      LAP_REASON reason, 
 				      struct sk_buff *userdata)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(lap != NULL, return;);
 	ASSERT(lap->magic == LMP_LAP_MAGIC, return;);
@@ -303,7 +302,7 @@
 				   __u32 daddr, struct qos_info *qos,
 				   struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/* Copy QoS settings for this session */
 	self->qos = qos;
@@ -324,7 +323,7 @@
 void irlmp_link_connect_confirm(struct lap_cb *self, struct qos_info *qos, 
 				struct sk_buff *userdata)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);
@@ -391,7 +390,7 @@
  */
 void irlmp_link_discovery_confirm(struct lap_cb *self, hashbin_t *log)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LMP_LAP_MAGIC, return;);

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
