Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTHVMhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbTHVMej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:34:39 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:52581 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263151AbTHVLq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:46:26 -0400
Date: Fri, 22 Aug 2003 04:21:36 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][resend] 7/13 2.4.22-rc2 fix __FUNCTION__ warnings net/irda
 [1/7]
Message-Id: <20030822042136.3d427b17.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 af_irda.c |  220 +++++++++++++++++++++++++++++---------------------------------
 1 files changed, 104 insertions(+), 116 deletions(-)

--- linux-2.4.22-rc2/net/irda/af_irda.c	2002-11-28 20:53:16.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/af_irda.c	2003-08-21 00:08:28.000000000 -0300
@@ -98,7 +98,7 @@
 	struct sock *sk;
 	int err;
 
-	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	self = (struct irda_sock *) instance;
 	ASSERT(self != NULL, return -1;);
@@ -108,7 +108,7 @@
 
 	err = sock_queue_rcv_skb(sk, skb);
 	if (err) {
-		IRDA_DEBUG(1, __FUNCTION__ "(), error: no more mem!\n");
+		IRDA_DEBUG(1, "%s(), error: no more mem!\n", __FUNCTION__);
 		self->rx_flow = FLOW_STOP;
 
 		/* When we return error, TTP will need to requeue the skb */
@@ -132,7 +132,7 @@
 
 	self = (struct irda_sock *) instance;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	/* Don't care about it, but let's not leak it */
 	if(skb)
@@ -194,7 +194,7 @@
 
 	self = (struct irda_sock *) instance;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	sk = self->sk;
 	if (sk == NULL)
@@ -210,14 +210,14 @@
 	switch (sk->type) {
 	case SOCK_STREAM:
 		if (max_sdu_size != 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size must be 0\n");
+			ERROR("%s(), max_sdu_size must be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 		break;
 	case SOCK_SEQPACKET:
 		if (max_sdu_size == 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size cannot be 0\n");
+			ERROR("%s(), max_sdu_size cannot be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = max_sdu_size;
@@ -226,7 +226,7 @@
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 	};
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), max_data_size=%d\n", 
+	IRDA_DEBUG(2, "%s(), max_data_size=%d\n", __FUNCTION__, 
 		   self->max_data_size);
 
 	memcpy(&self->qos_tx, qos, sizeof(struct qos_info));
@@ -253,7 +253,7 @@
 
  	self = (struct irda_sock *) instance;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	sk = self->sk;
 	if (sk == NULL)
@@ -269,14 +269,14 @@
 	switch (sk->type) {
 	case SOCK_STREAM:
 		if (max_sdu_size != 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size must be 0\n");
+			ERROR("%s(), max_sdu_size must be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 		break;
 	case SOCK_SEQPACKET:
 		if (max_sdu_size == 0) {
-			ERROR(__FUNCTION__ "(), max_sdu_size cannot be 0\n");
+			ERROR("%s(), max_sdu_size cannot be 0\n", __FUNCTION__);
 			return;
 		}
 		self->max_data_size = max_sdu_size;
@@ -285,7 +285,7 @@
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 	};
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), max_data_size=%d\n", 
+	IRDA_DEBUG(2, "%s(), max_data_size=%d\n", __FUNCTION__, 
 		   self->max_data_size);
 
 	memcpy(&self->qos_tx, qos, sizeof(struct qos_info));
@@ -304,13 +304,13 @@
 {
 	struct sk_buff *skb;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 
 	skb = dev_alloc_skb(64);
 	if (skb == NULL) {
-		IRDA_DEBUG(0, __FUNCTION__ "() Unable to allocate sk_buff!\n");
+		IRDA_DEBUG(0, "%s() Unable to allocate sk_buff!\n", __FUNCTION__);
 		return;
 	}
 
@@ -331,7 +331,7 @@
 	struct irda_sock *self;
 	struct sock *sk;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	self = (struct irda_sock *) instance;
 	ASSERT(self != NULL, return;);
@@ -341,17 +341,17 @@
 	
 	switch (flow) {
 	case FLOW_STOP:
-		IRDA_DEBUG(1, __FUNCTION__ "(), IrTTP wants us to slow down\n");
+		IRDA_DEBUG(1, "%s(), IrTTP wants us to slow down\n", __FUNCTION__);
 		self->tx_flow = flow;
 		break;
 	case FLOW_START:
 		self->tx_flow = flow;
-		IRDA_DEBUG(1, __FUNCTION__ 
-			   "(), IrTTP wants us to start again\n");
+		IRDA_DEBUG(1, "%s(), IrTTP wants us to start again\n",
+			   __FUNCTION__);
 		wake_up_interruptible(sk->sleep);
 		break;
 	default:
-		IRDA_DEBUG( 0, __FUNCTION__ "(), Unknown flow command!\n");
+		IRDA_DEBUG(0, "%s(), Unknown flow command!\n", __FUNCTION__);
 		/* Unknown flow command, better stop */
 		self->tx_flow = flow;
 		break;
@@ -373,11 +373,11 @@
 	
 	self = (struct irda_sock *) priv;
 	if (!self) {
-		WARNING(__FUNCTION__ "(), lost myself!\n");
+		WARNING("%s(), lost myself!\n", __FUNCTION__);
 		return;
 	}
 
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	/* We probably don't need to make any more queries */
 	iriap_close(self->iriap);
@@ -385,7 +385,7 @@
 
 	/* Check if request succeeded */
 	if (result != IAS_SUCCESS) {
-		IRDA_DEBUG(1, __FUNCTION__ "(), IAS query failed! (%d)\n",
+		IRDA_DEBUG(1, "%s(), IAS query failed! (%d)\n", __FUNCTION__,
 			   result);
 
 		self->errno = result;	/* We really need it later */
@@ -419,11 +419,11 @@
 {
 	struct irda_sock *self;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self = (struct irda_sock *) priv;
 	if (!self) {
-		WARNING(__FUNCTION__ "(), lost myself!\n");
+		WARNING("%s(), lost myself!\n", __FUNCTION__);
 		return;
 	}
 
@@ -456,7 +456,7 @@
 {
 	struct irda_sock *self;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self = (struct irda_sock *) priv;
 	ASSERT(self != NULL, return;);
@@ -481,7 +481,7 @@
 	notify_t notify;
 
 	if (self->tsap) {
-		WARNING(__FUNCTION__ "(), busy!\n");
+		WARNING("%s(), busy!\n", __FUNCTION__);
 		return -EBUSY;
 	}
 	
@@ -499,7 +499,7 @@
 	self->tsap = irttp_open_tsap(tsap_sel, DEFAULT_INITIAL_CREDIT,
 				     &notify);	
 	if (self->tsap == NULL) {
-		IRDA_DEBUG( 0, __FUNCTION__ "(), Unable to allocate TSAP!\n");
+		IRDA_DEBUG(0, "%s(), Unable to allocate TSAP!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 	/* Remember which TSAP selector we actually got */
@@ -520,7 +520,7 @@
 	notify_t notify;
 
 	if (self->lsap) {
-		WARNING(__FUNCTION__ "(), busy!\n");
+		WARNING("%s(), busy!\n", __FUNCTION__);
 		return -EBUSY;
 	}
 	
@@ -532,7 +532,7 @@
 
 	self->lsap = irlmp_open_lsap(LSAP_CONNLESS, &notify, pid);	
 	if (self->lsap == NULL) {
-		IRDA_DEBUG( 0, __FUNCTION__ "(), Unable to allocate LSAP!\n");
+		IRDA_DEBUG(0, "%s(), Unable to allocate LSAP!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -553,12 +553,12 @@
  */
 static int irda_find_lsap_sel(struct irda_sock *self, char *name)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(%p, %s)\n", self, name);
+	IRDA_DEBUG(2, "%s(%p, %s)\n", __FUNCTION__, self, name);
 
 	ASSERT(self != NULL, return -1;);
 
 	if (self->iriap) {
-		WARNING(__FUNCTION__ "(), busy with a previous query\n");
+		WARNING("%s(), busy with a previous query\n", __FUNCTION__);
 		return -EBUSY;
 	}
 
@@ -591,7 +591,7 @@
 	/* Get the remote TSAP selector */
 	switch (self->ias_result->type) {
 	case IAS_INTEGER:
-		IRDA_DEBUG(4, __FUNCTION__ "() int=%d\n",
+		IRDA_DEBUG(4, "%s() int=%d\n", __FUNCTION__,
 			   self->ias_result->t.integer);
 		
 		if (self->ias_result->t.integer != -1)
@@ -601,7 +601,7 @@
 		break;
 	default:
 		self->dtsap_sel = 0;
-		IRDA_DEBUG(0, __FUNCTION__ "(), bad type!\n");
+		IRDA_DEBUG(0, "%s(), bad type!\n", __FUNCTION__);
 		break;
 	}
 	if (self->ias_result)
@@ -639,7 +639,7 @@
 	__u32	daddr = DEV_ADDR_ANY;	/* Address we found the service on */
 	__u8	dtsap_sel = 0x0;	/* TSAP associated with it */
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), name=%s\n", name);
+	IRDA_DEBUG(2, "%s(), name=%s\n", __FUNCTION__, name);
 
 	ASSERT(self != NULL, return -1;);
 
@@ -661,7 +661,7 @@
 		/* Try the address in the log */
 		self->daddr = discoveries[i].daddr;
 		self->saddr = 0x0;
-		IRDA_DEBUG(1, __FUNCTION__ "(), trying daddr = %08x\n",
+		IRDA_DEBUG(1, "%s(), trying daddr = %08x\n", __FUNCTION__,
 			   self->daddr);
 
 		/* Query remote LM-IAS for this service */
@@ -670,9 +670,9 @@
 		case 0:
 			/* We found the requested service */
 			if(daddr != DEV_ADDR_ANY) {
-				IRDA_DEBUG(1, __FUNCTION__
-					   "(), discovered service ''%s'' in two different devices !!!\n",
-					   name);
+				IRDA_DEBUG(1, "%s(), discovered service ''%s'' "
+					   "in two different devices !!!\n",
+					   __FUNCTION__, name);
 				self->daddr = DEV_ADDR_ANY;
 				kfree(discoveries);
 				return(-ENOTUNIQ);
@@ -686,8 +686,8 @@
 			break;
 		default:
 			/* Something bad did happen :-( */
-			IRDA_DEBUG(0, __FUNCTION__
-				   "(), unexpected IAS query failure\n");
+			IRDA_DEBUG(0, "%s(), unexpected IAS query failure\n",
+				   __FUNCTION__);
 			self->daddr = DEV_ADDR_ANY;
 			kfree(discoveries);
 			return(-EHOSTUNREACH);
@@ -699,9 +699,8 @@
 
 	/* Check out what we found */
 	if(daddr == DEV_ADDR_ANY) {
-		IRDA_DEBUG(1, __FUNCTION__
-			   "(), cannot discover service ''%s'' in any device !!!\n",
-			   name);
+		IRDA_DEBUG(1, "%s(), cannot discover service ''%s'' in any "
+			   "device !!!\n", __FUNCTION__, name);
 		self->daddr = DEV_ADDR_ANY;
 		return(-EADDRNOTAVAIL);
 	}
@@ -711,9 +710,8 @@
 	self->saddr = 0x0;
 	self->dtsap_sel = dtsap_sel;
 
-	IRDA_DEBUG(1, __FUNCTION__ 
-		   "(), discovered requested service ''%s'' at address %08x\n",
-		   name, self->daddr);
+	IRDA_DEBUG(1, "%s(), discovered requested service ''%s'' at "
+		   "address %08x\n", __FUNCTION__, name, self->daddr);
 
 	return 0;
 }
@@ -744,8 +742,8 @@
 		saddr.sir_addr = self->saddr;
 	}
 	
-	IRDA_DEBUG(1, __FUNCTION__ "(), tsap_sel = %#x\n", saddr.sir_lsap_sel);
-	IRDA_DEBUG(1, __FUNCTION__ "(), addr = %08x\n", saddr.sir_addr);
+	IRDA_DEBUG(1, "%s(), tsap_sel = %#x\n", __FUNCTION__, saddr.sir_lsap_sel);
+	IRDA_DEBUG(1, "%s(), addr = %08x\n", __FUNCTION__, saddr.sir_addr);
 
 	/* uaddr_len come to us uninitialised */
 	*uaddr_len = sizeof (struct sockaddr_irda);
@@ -764,7 +762,7 @@
 {
 	struct sock *sk = sock->sk;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if ((sk->type != SOCK_STREAM) && (sk->type != SOCK_SEQPACKET) &&
 	    (sk->type != SOCK_DGRAM))
@@ -796,7 +794,7 @@
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	if (addr_len != sizeof(struct sockaddr_irda))
 		return -EINVAL;
@@ -806,8 +804,8 @@
 	if ((sk->type == SOCK_DGRAM) && (sk->protocol == IRDAPROTO_ULTRA)) {
 		self->pid = addr->sir_lsap_sel;
 		if (self->pid & 0x80) {
-			IRDA_DEBUG(0, __FUNCTION__ 
-				   "(), extension in PID not supp!\n");
+			IRDA_DEBUG(0, "%s(), extension in PID not supp!\n",
+				   __FUNCTION__);
 			return -EOPNOTSUPP;
 		}
 		err = irda_open_lsap(self, self->pid);
@@ -852,7 +850,7 @@
 	struct sk_buff *skb;
 	int err;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
@@ -898,7 +896,7 @@
 	/* Now attach up the new socket */
 	new->tsap = irttp_dup(self->tsap, new);
 	if (!new->tsap) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), dup failed!\n");
+		IRDA_DEBUG(0, "%s(), dup failed!\n", __FUNCTION__);
 		return -1;
 	}
 		
@@ -959,7 +957,7 @@
 
 	self = sk->protinfo.irda;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	/* Don't allow connect for Ultra sockets */
 	if ((sk->type == SOCK_DGRAM) && (sk->protocol == IRDAPROTO_ULTRA))
@@ -989,19 +987,19 @@
 		/* Try to find one suitable */
 		err = irda_discover_daddr_and_lsap_sel(self, addr->sir_name);
 		if (err) {
-			IRDA_DEBUG(0, __FUNCTION__ 
-				   "(), auto-connect failed!\n");
+			IRDA_DEBUG(0, "%s(), auto-connect failed!\n",
+				   __FUNCTION__);
 			return err;
 		}
 	} else {
 		/* Use the one provided by the user */
 		self->daddr = addr->sir_addr;
-		IRDA_DEBUG(1, __FUNCTION__ "(), daddr = %08x\n", self->daddr);
+		IRDA_DEBUG(1, "%s(), daddr = %08x\n", __FUNCTION__, self->daddr);
 		
 		/* Query remote LM-IAS */
 		err = irda_find_lsap_sel(self, addr->sir_name);
 		if (err) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), connect failed!\n");
+			IRDA_DEBUG(0, "%s(), connect failed!\n", __FUNCTION__);
 			return err;
 		}
 	}
@@ -1019,7 +1017,7 @@
 				    self->saddr, self->daddr, NULL, 
 				    self->max_sdu_size_rx, NULL);
 	if (err) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), connect failed!\n");
+		IRDA_DEBUG(0, "%s(), connect failed!\n", __FUNCTION__);
 		return err;
 	}
 
@@ -1064,7 +1062,7 @@
 	struct sock *sk;
 	struct irda_sock *self;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	/* Check for valid socket type */
 	switch (sock->type) {
@@ -1088,7 +1086,7 @@
 	}
 	memset(self, 0, sizeof(struct irda_sock));
 
-	IRDA_DEBUG(2, __FUNCTION__ "() : self is %p\n", self);
+	IRDA_DEBUG(2, "%s() : self is %p\n", __FUNCTION__, self);
 
 	init_waitqueue_head(&self->query_wait);
 
@@ -1122,7 +1120,7 @@
 			self->max_sdu_size_rx = TTP_SAR_UNBOUND;
 			break;
 		default:
-			ERROR(__FUNCTION__ "(), protocol not supported!\n");
+			ERROR("%s(), protocol not supported!\n", __FUNCTION__);
 			return -ESOCKTNOSUPPORT;
 		}
 		break;
@@ -1151,7 +1149,7 @@
  */
 void irda_destroy_socket(struct irda_sock *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	ASSERT(self != NULL, return;);
 
@@ -1197,7 +1195,7 @@
 {
 	struct sock *sk = sock->sk;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
         if (sk == NULL) 
 		return 0;
@@ -1266,7 +1264,7 @@
 	unsigned char *asmptr;
 	int err;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), len=%d\n", len);
+	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 
 	/* Note : socket.c set MSG_EOR on SEQPACKET sockets */
 	if (msg->msg_flags & ~(MSG_DONTWAIT | MSG_EOR))
@@ -1285,7 +1283,7 @@
 
 	/* Check if IrTTP is wants us to slow down */
 	while (self->tx_flow == FLOW_STOP) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), IrTTP is busy, going to sleep!\n");
+		IRDA_DEBUG(2, "%s(), IrTTP is busy, going to sleep!\n", __FUNCTION__);
 		interruptible_sleep_on(sk->sleep);
 		
 		/* Check if we are still connected */
@@ -1298,9 +1296,8 @@
 
 	/* Check that we don't send out to big frames */
 	if (len > self->max_data_size) {
-		IRDA_DEBUG(2, __FUNCTION__ 
-			   "(), Chopping frame from %d to %d bytes!\n", len, 
-			   self->max_data_size);
+		IRDA_DEBUG(2, "%s(), Chopping frame from %d to %d bytes!\n",
+			   __FUNCTION__, len, self->max_data_size);
 		len = self->max_data_size;
 	}
 
@@ -1320,7 +1317,7 @@
 	 */
 	err = irttp_data_request(self->tsap, skb);
 	if (err) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), err=%d\n", err);
+		IRDA_DEBUG(0, "%s(), err=%d\n", __FUNCTION__, err);
 		return err;
 	}
 	/* Tell client how much data we actually sent */
@@ -1341,7 +1338,7 @@
 	struct sk_buff *skb;
 	int copied, err;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
@@ -1355,9 +1352,8 @@
 	copied     = skb->len;
 	
 	if (copied > size) {
-		IRDA_DEBUG(2, __FUNCTION__ 
-			   "(), Received truncated frame (%d < %d)!\n",
-			   copied, size);
+		IRDA_DEBUG(2, "%s(), Received truncated frame (%d < %d)!\n",
+			   __FUNCTION__, copied, size);
 		copied = size;
 		msg->msg_flags |= MSG_TRUNC;
 	}
@@ -1373,7 +1369,7 @@
 	 */
 	if (self->rx_flow == FLOW_STOP) {
 		if ((atomic_read(&sk->rmem_alloc) << 2) <= sk->rcvbuf) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), Starting IrTTP\n");
+			IRDA_DEBUG(2, "%s(), Starting IrTTP\n", __FUNCTION__);
 			self->rx_flow = FLOW_START;
 			irttp_flow_request(self->tsap, FLOW_START);
 		}
@@ -1412,7 +1408,7 @@
 	int copied = 0;
 	int target = 1;
 
-	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
@@ -1472,14 +1468,14 @@
 
 			/* put the skb back if we didn't use it up.. */
 			if (skb->len) {
-				IRDA_DEBUG(1, __FUNCTION__ "(), back on q!\n");
+				IRDA_DEBUG(1, "%s(), back on q!\n", __FUNCTION__);
 				skb_queue_head(&sk->receive_queue, skb);
 				break;
 			}
 
 			kfree_skb(skb);			
 		} else {
-			IRDA_DEBUG(0, __FUNCTION__ "() questionable!?\n");
+			IRDA_DEBUG(0, "%s() questionable!?\n", __FUNCTION__);
 
 			/* put message back and return */
 			skb_queue_head(&sk->receive_queue, skb);
@@ -1495,7 +1491,7 @@
 	 */
 	if (self->rx_flow == FLOW_STOP) {
 		if ((atomic_read(&sk->rmem_alloc) << 2) <= sk->rcvbuf) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), Starting IrTTP\n");
+			IRDA_DEBUG(2, "%s(), Starting IrTTP\n", __FUNCTION__);
 			self->rx_flow = FLOW_START;
 			irttp_flow_request(self->tsap, FLOW_START);
 		}
@@ -1520,7 +1516,7 @@
 	unsigned char *asmptr;
 	int err;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), len=%d\n", len);
+	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 	
 	if (msg->msg_flags & ~MSG_DONTWAIT)
 		return -EINVAL;
@@ -1541,9 +1537,8 @@
 	 * service, so we have no fragmentation and no coalescence 
 	 */
 	if (len > self->max_data_size) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Warning to much data! "
-			   "Chopping frame from %d to %d bytes!\n", len, 
-			   self->max_data_size);
+		IRDA_DEBUG(0, "%s(), Warning to much data! Chopping frame from "
+			   "%d to %d bytes!\n", __FUNCTION__, len, self->max_data_size);
 		len = self->max_data_size;
 	}
 
@@ -1554,7 +1549,7 @@
 
 	skb_reserve(skb, self->max_header_size);
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), appending user data\n");
+	IRDA_DEBUG(4, "%s(), appending user data\n", __FUNCTION__);
 	asmptr = skb->h.raw = skb_put(skb, len);
 	memcpy_fromiovec(asmptr, msg->msg_iov, len);
 
@@ -1564,7 +1559,7 @@
 	 */
 	err = irttp_udata_request(self->tsap, skb);
 	if (err) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), err=%d\n", err);
+		IRDA_DEBUG(0, "%s(), err=%d\n", __FUNCTION__, err);
 		return err;
 	}
 	return len;
@@ -1586,7 +1581,7 @@
 	unsigned char *asmptr;
 	int err;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), len=%d\n", len);
+	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 	
 	if (msg->msg_flags & ~MSG_DONTWAIT)
 		return -EINVAL;
@@ -1604,9 +1599,8 @@
 	 * service, so we have no fragmentation and no coalescence 
 	 */
 	if (len > self->max_data_size) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Warning to much data! "
-			   "Chopping frame from %d to %d bytes!\n", len, 
-			   self->max_data_size);
+		IRDA_DEBUG(0, "%s(), Warning to much data! Chopping frame from "
+			   "%d to %d bytes!\n", __FUNCTION__, len, self->max_data_size);
 		len = self->max_data_size;
 	}
 
@@ -1617,13 +1611,13 @@
 
 	skb_reserve(skb, self->max_header_size);
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), appending user data\n");
+	IRDA_DEBUG(4, "%s(), appending user data\n", __FUNCTION__);
 	asmptr = skb->h.raw = skb_put(skb, len);
 	memcpy_fromiovec(asmptr, msg->msg_iov, len);
 
 	err = irlmp_connless_data_request(self->lsap, skb);
 	if (err) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), err=%d\n", err);
+		IRDA_DEBUG(0, "%s(), err=%d\n", __FUNCTION__, err);
 		return err;
 	}
 	return len;
@@ -1644,7 +1638,7 @@
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
 
-	IRDA_DEBUG(1, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(1, "%s(%p)\n", __FUNCTION__, self);
 
 	sk->state       = TCP_CLOSE;
 	sk->shutdown   |= SEND_SHUTDOWN;
@@ -1682,7 +1676,7 @@
 	unsigned int mask;
 	struct irda_sock *self;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	self = sk->protinfo.irda;
 	poll_wait(file, sk->sleep, wait);
@@ -1692,7 +1686,7 @@
 	if (sk->err)
 		mask |= POLLERR;
 	if (sk->shutdown & RCV_SHUTDOWN) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), POLLHUP\n");
+		IRDA_DEBUG(0, "%s(), POLLHUP\n", __FUNCTION__);
 		mask |= POLLHUP;
 	}
 
@@ -1706,7 +1700,7 @@
 	switch (sk->type) {
 	case SOCK_STREAM:
 		if (sk->state == TCP_CLOSE) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), POLLHUP\n");
+			IRDA_DEBUG(0, "%s(), POLLHUP\n", __FUNCTION__);
 			mask |= POLLHUP;
 		}
 
@@ -1745,7 +1739,7 @@
 {
 	struct sock *sk = sock->sk;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), cmd=%#x\n", cmd);
+	IRDA_DEBUG(4, "%s(), cmd=%#x\n", __FUNCTION__, cmd);
 	
 	switch (cmd) {
 	case TIOCOUTQ: {
@@ -1792,7 +1786,7 @@
 	case SIOCSIFMETRIC:
 		return -EINVAL;		
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), doing device ioctl!\n");
+		IRDA_DEBUG(1, "%s(), doing device ioctl!\n", __FUNCTION__);
 		return dev_ioctl(cmd, (void *) arg);
 	}
 
@@ -1819,7 +1813,7 @@
 	self = sk->protinfo.irda;
 	ASSERT(self != NULL, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	if (level != SOL_IRLMP)
 		return -ENOPROTOOPT;
@@ -1981,8 +1975,8 @@
 
 		/* Check is the user space own the object */
 		if(ias_attr->value->owner != IAS_USER_ATTR) {
-			IRDA_DEBUG(1, __FUNCTION__ 
-				   "(), attempting to delete a kernel attribute\n");
+			IRDA_DEBUG(1, "%s(), attempting to delete a kernel attribute\n",
+				   __FUNCTION__);
 			kfree(ias_opt);
 			return -EPERM;
 		}
@@ -2000,13 +1994,11 @@
 		
 		/* Only possible for a seqpacket service (TTP with SAR) */
 		if (sk->type != SOCK_SEQPACKET) {
-			IRDA_DEBUG(2, __FUNCTION__ 
-				   "(), setting max_sdu_size = %d\n", opt);
+			IRDA_DEBUG(2, "%s(), setting max_sdu_size = %d\n", __FUNCTION__, opt);
 			self->max_sdu_size_rx = opt;
 		} else {
-			WARNING(__FUNCTION__ 
-				"(), not allowed to set MAXSDUSIZE for this "
-				"socket type!\n");
+			WARNING("%s(), not allowed to set MAXSDUSIZE for this "
+				"socket type!\n", __FUNCTION__);
 			return -ENOPROTOOPT;
 		}
 		break;
@@ -2123,7 +2115,7 @@
 
 	self = sk->protinfo.irda;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(%p)\n", self);
+	IRDA_DEBUG(2, "%s(%p)\n", __FUNCTION__, self);
 
 	if (level != SOL_IRLMP)
 		return -ENOPROTOOPT;
@@ -2283,8 +2275,7 @@
 
 		/* Check that we can proceed with IAP */
 		if (self->iriap) {
-			WARNING(__FUNCTION__
-				"(), busy with a previous query\n");
+			WARNING("%s(), busy with a previous query\n", __FUNCTION__);
 			kfree(ias_opt);
 			return -EBUSY;
 		}
@@ -2365,8 +2356,7 @@
 		
 		/* Wait until a node is discovered */
 		if (!self->cachediscovery) {
-			IRDA_DEBUG(1, __FUNCTION__ 
-				   "(), nothing discovered yet, going to sleep...\n");
+			IRDA_DEBUG(1, "%s(), nothing discovered yet, going to sleep...\n", __FUNCTION__);
 
 			/* Set watchdog timer to expire in <val> ms. */
 			self->watchdog.function = irda_discovery_timeout;
@@ -2381,12 +2371,10 @@
 			if(timer_pending(&(self->watchdog)))
 				del_timer(&(self->watchdog));
 
-			IRDA_DEBUG(1, __FUNCTION__ 
-				   "(), ...waking up !\n");
+			IRDA_DEBUG(1, "%s(), ...waking up !\n", __FUNCTION__);
 		}
 		else
-			IRDA_DEBUG(1, __FUNCTION__ 
-				   "(), found immediately !\n");
+			IRDA_DEBUG(1, "%s(), found immediately !\n", __FUNCTION__);
 
 		/* Tell IrLMP that we have been notified */
 		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);
@@ -2527,11 +2515,11 @@
 	
         switch (event) {
 	case NETDEV_UP:
-		IRDA_DEBUG(3, __FUNCTION__ "(), NETDEV_UP\n");
+		IRDA_DEBUG(3, "%s(), NETDEV_UP\n", __FUNCTION__);
 		/* irda_dev_device_up(dev); */
 		break;
 	case NETDEV_DOWN:
-		IRDA_DEBUG(3, __FUNCTION__ "(), NETDEV_DOWN\n");
+		IRDA_DEBUG(3, "%s(), NETDEV_DOWN\n", __FUNCTION__);
 		/* irda_kill_by_device(dev); */
 		/* irda_rt_device_down(dev); */
 		/* irda_dev_device_down(dev); */

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
