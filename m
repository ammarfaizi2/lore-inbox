Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbTHVMk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTHVMhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:37:39 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:40054 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263147AbTHVLvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:51:55 -0400
Date: Fri, 22 Aug 2003 04:27:10 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][resend] 9/13 2.4.22-rc2 fix __FUNCTION__ warnings
 net/irda/irlan [3/7]
Message-Id: <20030822042710.47949c36.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 irlan_client.c         |   50 +++++++++++++++++------------------
 irlan_client_event.c   |   65 ++++++++++++++++++++++-----------------------
 irlan_common.c         |   70 ++++++++++++++++++++++++-------------------------
 irlan_eth.c            |   16 +++++------
 irlan_event.c          |    4 +-
 irlan_filter.c         |    4 +-
 irlan_provider.c       |   30 ++++++++++-----------
 irlan_provider_event.c |   16 +++++------
 8 files changed, 127 insertions(+), 128 deletions(-)

--- linux-2.4.22-rc2/net/irda/irlan/irlan_client.c	2002-11-28 20:53:16.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_client.c	2003-08-21 00:08:28.000000000 -0300
@@ -71,7 +71,7 @@
 {
 	struct irlan_cb *self = (struct irlan_cb *) data;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -90,7 +90,7 @@
 
 void irlan_client_start_kick_timer(struct irlan_cb *self, int timeout)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	irda_start_timer(&self->client.kick_timer, timeout, (void *) self, 
 			 irlan_client_kick_timer_expired);
@@ -104,7 +104,7 @@
  */
 void irlan_client_wakeup(struct irlan_cb *self, __u32 saddr, __u32 daddr)
 {
-	IRDA_DEBUG(1, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -116,7 +116,7 @@
 	if ((self->client.state != IRLAN_IDLE) || 
 	    (self->provider.access_type == ACCESS_DIRECT))
 	{
-			IRDA_DEBUG(0, __FUNCTION__ "(), already awake!\n");
+			IRDA_DEBUG(0, "%s(), already awake!\n", __FUNCTION__);
 			return;
 	}
 
@@ -125,7 +125,7 @@
 	self->daddr = daddr;
 
 	if (self->disconnect_reason == LM_USER_REQUEST) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), still stopped by user\n");
+			IRDA_DEBUG(0, "%s(), still stopped by user\n", __FUNCTION__);
 			return;
 	}
 
@@ -152,7 +152,7 @@
 	struct irlan_cb *self;
 	__u32 saddr, daddr;
 	
-	IRDA_DEBUG(1, __FUNCTION__"()\n");
+	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
 	ASSERT(irlan != NULL, return;);
 	ASSERT(discovery != NULL, return;);
@@ -174,7 +174,7 @@
 	if (self) {
 		ASSERT(self->magic == IRLAN_MAGIC, return;);
 
-		IRDA_DEBUG(1, __FUNCTION__ "(), Found instance (%08x)!\n",
+		IRDA_DEBUG(1, "%s(), Found instance (%08x)!\n", __FUNCTION__,
 		      daddr);
 		
 		irlan_client_wakeup(self, saddr, daddr);
@@ -192,7 +192,7 @@
 {
 	struct irlan_cb *self;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	self = (struct irlan_cb *) instance;
 	
@@ -203,7 +203,7 @@
 	irlan_do_client_event(self, IRLAN_DATA_INDICATION, skb); 
 
 	/* Ready for a new command */	
-	IRDA_DEBUG(2, __FUNCTION__ "(), clearing tx_busy\n");
+	IRDA_DEBUG(2, "%s(), clearing tx_busy\n", __FUNCTION__);
 	self->client.tx_busy = FALSE;
 
 	/* Check if we have some queued commands waiting to be sent */
@@ -220,7 +220,7 @@
 	struct tsap_cb *tsap;
 	struct sk_buff *skb;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), reason=%d\n", reason);
+	IRDA_DEBUG(4, "%s(), reason=%d\n", __FUNCTION__, reason);
 	
 	self = (struct irlan_cb *) instance;
 	tsap = (struct tsap_cb *) sap;
@@ -252,7 +252,7 @@
 	struct tsap_cb *tsap;
 	notify_t notify;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -272,7 +272,7 @@
 	
 	tsap = irttp_open_tsap(LSAP_ANY, DEFAULT_INITIAL_CREDIT, &notify);
 	if (!tsap) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), Got no tsap!\n");
+		IRDA_DEBUG(2, "%s(), Got no tsap!\n", __FUNCTION__);
 		return;
 	}
 	self->client.tsap_ctrl = tsap;
@@ -292,7 +292,7 @@
 {
 	struct irlan_cb *self;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	self = (struct irlan_cb *) instance;
 
@@ -318,7 +318,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 		
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -361,13 +361,13 @@
 
 	ASSERT(skb != NULL, return;);	
 	
-	IRDA_DEBUG(4, __FUNCTION__ "() skb->len=%d\n", (int) skb->len);
+	IRDA_DEBUG(4, "%s() skb->len=%d\n", __FUNCTION__, (int) skb->len);
 	
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
 	
 	if (!skb) {
-		ERROR( __FUNCTION__ "(), Got NULL skb!\n");
+		ERROR("%s(), Got NULL skb!\n", __FUNCTION__);
 		return;
 	}
 	frame = skb->data;
@@ -392,7 +392,7 @@
 	/* How many parameters? */
 	count = frame[1];
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), got %d parameters\n", count);
+	IRDA_DEBUG(4, "%s(), got %d parameters\n", __FUNCTION__, count);
 	
 	ptr = frame+2;
 
@@ -400,7 +400,7 @@
  	for (i=0; i<count;i++) {
 		ret = irlan_extract_param(ptr, name, value, &val_len);
 		if (ret < 0) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), IrLAN, Error!\n");
+			IRDA_DEBUG(2, "%s(), IrLAN, Error!\n", __FUNCTION__);
 			break;
 		}
 		ptr += ret;
@@ -424,7 +424,7 @@
 	__u8 *bytes;
 	int i;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), parm=%s\n", param);
+	IRDA_DEBUG(4, "%s(), parm=%s\n", __FUNCTION__, param);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -462,7 +462,7 @@
 		else if (strcmp(value, "HOSTED") == 0)
 			self->client.access_type = ACCESS_HOSTED;
 		else {
-			IRDA_DEBUG(2, __FUNCTION__ "(), unknown access type!\n");
+			IRDA_DEBUG(2, "%s(), unknown access type!\n", __FUNCTION__);
 		}
 	}
 	/* IRLAN version */
@@ -484,14 +484,14 @@
 		memcpy(&tmp_cpu, value, 2); /* Align value */
 		le16_to_cpus(&tmp_cpu);     /* Convert to host order */
 		self->client.recv_arb_val = tmp_cpu;
-		IRDA_DEBUG(2, __FUNCTION__ "(), receive arb val=%d\n", 
+		IRDA_DEBUG(2, "%s(), receive arb val=%d\n", __FUNCTION__, 
 			   self->client.recv_arb_val);
 	}
 	if (strcmp(param, "MAX_FRAME") == 0) {
 		memcpy(&tmp_cpu, value, 2); /* Align value */
 		le16_to_cpus(&tmp_cpu);     /* Convert to host order */
 		self->client.max_frame = tmp_cpu;
-		IRDA_DEBUG(4, __FUNCTION__ "(), max frame=%d\n", 
+		IRDA_DEBUG(4, "%s(), max frame=%d\n", __FUNCTION__, 
 			   self->client.max_frame);
 	}
 	 
@@ -526,7 +526,7 @@
 {
 	struct irlan_cb *self;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(priv != NULL, return;);
 
@@ -539,7 +539,7 @@
 
 	/* Check if request succeeded */
 	if (result != IAS_SUCCESS) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), got NULL value!\n");
+		IRDA_DEBUG(2, "%s(), got NULL value!\n", __FUNCTION__);
 		irlan_do_client_event(self, IRLAN_IAS_PROVIDER_NOT_AVAIL, 
 				      NULL);
 		return;
@@ -557,7 +557,7 @@
 		irias_delete_value(value);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), unknown type!\n");
+		IRDA_DEBUG(2, "%s(), unknown type!\n", __FUNCTION__);
 		break;
 	}
 	irlan_do_client_event(self, IRLAN_IAS_PROVIDER_NOT_AVAIL, NULL);
--- linux-2.4.22-rc2/net/irda/irlan/irlan_client_event.c	2000-11-27 23:07:31.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_client_event.c	2003-08-21 00:08:28.000000000 -0300
@@ -92,7 +92,7 @@
 static int irlan_client_state_idle(struct irlan_cb *self, IRLAN_EVENT event, 
 				   struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRLAN_MAGIC, return -1;);
@@ -100,8 +100,7 @@
 	switch (event) {
 	case IRLAN_DISCOVERY_INDICATION:
 		if (self->client.iriap) {
-			WARNING(__FUNCTION__ 
-				"(), busy with a previous query\n");
+			WARNING("%s(), busy with a previous query\n", __FUNCTION__);
 			return -EBUSY;
 		}
 		
@@ -114,10 +113,10 @@
 					      "IrLAN", "IrDA:TinyTP:LsapSel");
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(4, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(4, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb) 
@@ -136,7 +135,7 @@
 static int irlan_client_state_query(struct irlan_cb *self, IRLAN_EVENT event, 
 				    struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRLAN_MAGIC, return -1;);
@@ -154,7 +153,7 @@
 		irlan_next_client_state(self, IRLAN_CONN);
 		break;
 	case IRLAN_IAS_PROVIDER_NOT_AVAIL:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IAS_PROVIDER_NOT_AVAIL\n");
+		IRDA_DEBUG(2, "%s(), IAS_PROVIDER_NOT_AVAIL\n", __FUNCTION__);
 		irlan_next_client_state(self, IRLAN_IDLE);
 
 		/* Give the client a kick! */
@@ -167,10 +166,10 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__"(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -189,7 +188,7 @@
 static int irlan_client_state_conn(struct irlan_cb *self, IRLAN_EVENT event, 
 				   struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 	
@@ -204,10 +203,10 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -224,7 +223,7 @@
 static int irlan_client_state_info(struct irlan_cb *self, IRLAN_EVENT event, 
 				   struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	
@@ -244,10 +243,10 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -266,7 +265,7 @@
 static int irlan_client_state_media(struct irlan_cb *self, IRLAN_EVENT event, 
 				    struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 
@@ -281,10 +280,10 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -305,7 +304,7 @@
 {
 	struct qos_info qos;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 
@@ -344,7 +343,7 @@
 			irlan_next_client_state(self, IRLAN_DATA);
 			break;
 		default:
-			IRDA_DEBUG(2, __FUNCTION__ "(), unknown access type!\n");
+			IRDA_DEBUG(2, "%s(), unknown access type!\n", __FUNCTION__);
 			break;
 		}
 		break;
@@ -353,10 +352,10 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	
@@ -376,7 +375,7 @@
 static int irlan_client_state_wait(struct irlan_cb *self, IRLAN_EVENT event, 
 				   struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 	
@@ -390,10 +389,10 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -407,7 +406,7 @@
 {
 	struct qos_info qos;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	
@@ -429,7 +428,7 @@
 		} else if (self->client.recv_arb_val >
 			   self->provider.send_arb_val) 
 		{
-			IRDA_DEBUG(2, __FUNCTION__ "(), lost the battle :-(\n");
+			IRDA_DEBUG(2, "%s(), lost the battle :-(\n", __FUNCTION__);
 		}
 		break;
 	case IRLAN_DATA_CONNECT_INDICATION:
@@ -440,10 +439,10 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	case IRLAN_WATCHDOG_TIMEOUT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IRLAN_WATCHDOG_TIMEOUT\n");
+		IRDA_DEBUG(2, "%s(), IRLAN_WATCHDOG_TIMEOUT\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -462,7 +461,7 @@
 static int irlan_client_state_data(struct irlan_cb *self, IRLAN_EVENT event, 
 				   struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRLAN_MAGIC, return -1;);
@@ -476,7 +475,7 @@
 		irlan_next_client_state(self, IRLAN_IDLE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -494,7 +493,7 @@
 static int irlan_client_state_close(struct irlan_cb *self, IRLAN_EVENT event, 
 				    struct sk_buff *skb) 
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if (skb)
 		dev_kfree_skb(skb);
@@ -511,7 +510,7 @@
 static int irlan_client_state_sync(struct irlan_cb *self, IRLAN_EVENT event, 
 				   struct sk_buff *skb) 
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	if (skb)
 		dev_kfree_skb(skb);
--- linux-2.4.22-rc2/net/irda/irlan/irlan_common.c	2002-02-25 16:38:14.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_common.c	2003-08-21 00:08:28.000000000 -0300
@@ -122,7 +122,7 @@
 	struct irlan_cb *new;
 	__u16 hints;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 	/* Allocate master structure */
 	irlan = hashbin_new(HB_LOCAL); 
 	if (irlan == NULL) {
@@ -133,7 +133,7 @@
 	create_proc_info_entry("irlan", 0, proc_irda, irlan_proc_read);
 #endif /* CONFIG_PROC_FS */
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	hints = irlmp_service_to_hint(S_LAN);
 
 	/* Register with IrLMP as a client */
@@ -157,7 +157,7 @@
 
 void irlan_cleanup(void) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	irlmp_unregister_client(ckey);
 	irlmp_unregister_service(skey);
@@ -181,7 +181,7 @@
 {
 	int i=0;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	/* Check if we should call the device eth<x> or irlan<x> */
 	if (!eth) {
@@ -192,7 +192,7 @@
 	}
 	
 	if (register_netdev(&self->dev) != 0) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), register_netdev() failed!\n");
+		IRDA_DEBUG(2, "%s(), register_netdev() failed!\n", __FUNCTION__);
 		return -1;
 	}
 	return 0;
@@ -208,7 +208,7 @@
 {
 	struct irlan_cb *self;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	ASSERT(irlan != NULL, return NULL;);
 
 	/* 
@@ -264,7 +264,7 @@
 {
 	struct sk_buff *skb;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -301,7 +301,7 @@
 	struct irlan_cb *self;
 	struct tsap_cb *tsap;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	self = (struct irlan_cb *) instance;
 	tsap = (struct tsap_cb *) sap;
@@ -390,7 +390,7 @@
 	struct irlan_cb *self;
 	struct tsap_cb *tsap;
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), reason=%d\n", reason);
+	IRDA_DEBUG(0, "%s(), reason=%d\n", __FUNCTION__, reason);
 	
 	self = (struct irlan_cb *) instance;
 	tsap = (struct tsap_cb *) sap;
@@ -409,22 +409,22 @@
 	
 	switch (reason) {
 	case LM_USER_REQUEST: /* User request */
-		IRDA_DEBUG(2, __FUNCTION__ "(), User requested\n");
+		IRDA_DEBUG(2, "%s(), User requested\n", __FUNCTION__);
 		break;
 	case LM_LAP_DISCONNECT: /* Unexpected IrLAP disconnect */
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unexpected IrLAP disconnect\n");
+		IRDA_DEBUG(2, "%s(), Unexpected IrLAP disconnect\n", __FUNCTION__);
 		break;
 	case LM_CONNECT_FAILURE: /* Failed to establish IrLAP connection */
-		IRDA_DEBUG(2, __FUNCTION__ "(), IrLAP connect failed\n");
+		IRDA_DEBUG(2, "%s(), IrLAP connect failed\n", __FUNCTION__);
 		break;
 	case LM_LAP_RESET:  /* IrLAP reset */
-		IRDA_DEBUG(2, __FUNCTION__ "(), IrLAP reset\n");
+		IRDA_DEBUG(2, "%s(), IrLAP reset\n", __FUNCTION__);
 		break;
 	case LM_INIT_DISCONNECT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), IrLMP connect failed\n");
+		IRDA_DEBUG(2, "%s(), IrLMP connect failed\n", __FUNCTION__);
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), Unknown disconnect reason\n");
+		ERROR("%s(), Unknown disconnect reason\n", __FUNCTION__);
 		break;
 	}
 	
@@ -446,7 +446,7 @@
 	struct tsap_cb *tsap;
 	notify_t notify;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -468,7 +468,7 @@
 
 	tsap = irttp_open_tsap(LSAP_ANY, DEFAULT_INITIAL_CREDIT, &notify);
 	if (!tsap) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), Got no tsap!\n");
+		IRDA_DEBUG(2, "%s(), Got no tsap!\n", __FUNCTION__);
 		return;
 	}
 	self->tsap_data = tsap;
@@ -482,7 +482,7 @@
 
 void irlan_close_tsaps(struct irlan_cb *self)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -572,7 +572,7 @@
 {
 	struct sk_buff *skb;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if (irda_lock(&self->client.tx_busy) == FALSE)
 		return -EBUSY;
@@ -591,7 +591,7 @@
 		dev_kfree_skb(skb);
 		return -1;
 	}
-	IRDA_DEBUG(2, __FUNCTION__ "(), sending ...\n");
+	IRDA_DEBUG(2, "%s(), sending ...\n", __FUNCTION__);
 
 	return irttp_data_request(self->client.tsap_ctrl, skb);
 }
@@ -604,7 +604,7 @@
  */
 void irlan_ctrl_data_request(struct irlan_cb *self, struct sk_buff *skb)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Queue command */
 	skb_queue_tail(&self->client.txq, skb);
@@ -624,7 +624,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -656,7 +656,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -688,7 +688,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -727,7 +727,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);	
@@ -765,7 +765,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -804,7 +804,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -844,7 +844,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 		
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -879,7 +879,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -964,7 +964,7 @@
 	int n=0;
 	
 	if (skb == NULL) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), Got NULL skb\n");
+		IRDA_DEBUG(2, "%s(), Got NULL skb\n", __FUNCTION__);
 		return 0;
 	}	
 
@@ -981,7 +981,7 @@
 		ASSERT(value_len > 0, return 0;);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown parameter type!\n");
+		IRDA_DEBUG(2, "%s(), Unknown parameter type!\n", __FUNCTION__);
 		return 0;
 		break;
 	}
@@ -991,7 +991,7 @@
 
 	/* Make space for data */
 	if (skb_tailroom(skb) < (param_len+value_len+3)) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), No more space at end of skb\n");
+		IRDA_DEBUG(2, "%s(), No more space at end of skb\n", __FUNCTION__);
 		return 0;
 	}	
 	skb_put(skb, param_len+value_len+3);
@@ -1038,13 +1038,13 @@
 	__u16 val_len;
 	int n=0;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	/* get length of parameter name (1 byte) */
 	name_len = buf[n++];
 	
 	if (name_len > 254) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), name_len > 254\n");
+		IRDA_DEBUG(2, "%s(), name_len > 254\n", __FUNCTION__);
 		return -RSP_INVALID_COMMAND_FORMAT;
 	}
 	
@@ -1061,7 +1061,7 @@
 	le16_to_cpus(&val_len); n+=2;
 	
 	if (val_len > 1016) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), parameter length to long\n");
+		IRDA_DEBUG(2, "%s(), parameter length to long\n", __FUNCTION__);
 		return -RSP_INVALID_COMMAND_FORMAT;
 	}
 	*len = val_len;
--- linux-2.4.22-rc2/net/irda/irlan/irlan_eth.c	2003-08-21 00:05:17.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_eth.c	2003-08-21 00:08:28.000000000 -0300
@@ -51,7 +51,7 @@
 {
 	struct irlan_cb *self;
 
-	IRDA_DEBUG(2, __FUNCTION__"()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(dev != NULL, return -1;);
        
@@ -109,7 +109,7 @@
 {
 	struct irlan_cb *self;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(dev != NULL, return -1;);
 
@@ -143,7 +143,7 @@
 	struct irlan_cb *self = (struct irlan_cb *) dev->priv;
 	struct sk_buff *skb;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	
 	/* Stop device */
 	netif_stop_queue(dev);
@@ -354,14 +354,14 @@
 
  	self = dev->priv; 
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
  	ASSERT(self != NULL, return;); 
  	ASSERT(self->magic == IRLAN_MAGIC, return;);
 
 	/* Check if data channel has been connected yet */
 	if (self->client.state != IRLAN_DATA) {
-		IRDA_DEBUG(1, __FUNCTION__ "(), delaying!\n");
+		IRDA_DEBUG(1, "%s(), delaying!\n", __FUNCTION__);
 		return;
 	}
 
@@ -371,20 +371,20 @@
 	} 
 	else if ((dev->flags & IFF_ALLMULTI) || dev->mc_count > HW_MAX_ADDRS) {
 		/* Disable promiscuous mode, use normal mode. */
-		IRDA_DEBUG(4, __FUNCTION__ "(), Setting multicast filter\n");
+		IRDA_DEBUG(4, "%s(), Setting multicast filter\n", __FUNCTION__);
 		/* hardware_set_filter(NULL); */
 
 		irlan_set_multicast_filter(self, TRUE);
 	}
 	else if (dev->mc_count) {
-		IRDA_DEBUG(4, __FUNCTION__ "(), Setting multicast filter\n");
+		IRDA_DEBUG(4, "%s(), Setting multicast filter\n", __FUNCTION__);
 		/* Walk the address list, and load the filter */
 		/* hardware_set_filter(dev->mc_list); */
 
 		irlan_set_multicast_filter(self, TRUE);
 	}
 	else {
-		IRDA_DEBUG(4, __FUNCTION__ "(), Clearing multicast filter\n");
+		IRDA_DEBUG(4, "%s(), Clearing multicast filter\n", __FUNCTION__);
 		irlan_set_multicast_filter(self, FALSE);
 	}
 
--- linux-2.4.22-rc2/net/irda/irlan/irlan_event.c	1999-11-02 22:07:55.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_event.c	2003-08-21 00:08:28.000000000 -0300
@@ -40,7 +40,7 @@
 
 void irlan_next_client_state(struct irlan_cb *self, IRLAN_STATE state) 
 {
-	IRDA_DEBUG(2, __FUNCTION__"(), %s\n", irlan_state[state]);
+	IRDA_DEBUG(2, "%s(), %s\n", __FUNCTION__, irlan_state[state]);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -50,7 +50,7 @@
 
 void irlan_next_provider_state(struct irlan_cb *self, IRLAN_STATE state) 
 {
-	IRDA_DEBUG(2, __FUNCTION__"(), %s\n", irlan_state[state]);
+	IRDA_DEBUG(2, "%s(), %s\n", __FUNCTION__, irlan_state[state]);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
--- linux-2.4.22-rc2/net/irda/irlan/irlan_filter.c	1999-11-02 22:07:55.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_filter.c	2003-08-21 00:08:28.000000000 -0300
@@ -143,7 +143,7 @@
 {
 	__u8 *bytes;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	bytes = value;
 
@@ -156,7 +156,7 @@
 	 *  This is experimental!! DB.
 	 */
 	 if (strcmp(param, "MODE") == 0) {
-		IRDA_DEBUG(0, __FUNCTION__ "()\n");
+		IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 		self->use_udata = TRUE;
 		return;
 	}
--- linux-2.4.22-rc2/net/irda/irlan/irlan_provider.c	2001-03-02 16:12:12.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_provider.c	2003-08-21 00:08:28.000000000 -0300
@@ -70,7 +70,7 @@
 	struct irlan_cb *self;
 	__u8 code;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	self = (struct irlan_cb *) instance;
 
@@ -99,15 +99,15 @@
 		irlan_do_provider_event(self, IRLAN_FILTER_CONFIG_CMD, skb);
 		break;
 	case CMD_RECONNECT_DATA_CHAN:
-		IRDA_DEBUG(2, __FUNCTION__"(), Got RECONNECT_DATA_CHAN command\n");
-		IRDA_DEBUG(2, __FUNCTION__"(), NOT IMPLEMENTED\n");
+		IRDA_DEBUG(2, "%s(), Got RECONNECT_DATA_CHAN command\n", __FUNCTION__);
+		IRDA_DEBUG(2, "%s(), NOT IMPLEMENTED\n", __FUNCTION__);
 		break;
 	case CMD_CLOSE_DATA_CHAN:
 		IRDA_DEBUG(2, "Got CLOSE_DATA_CHAN command!\n");
-		IRDA_DEBUG(2, __FUNCTION__"(), NOT IMPLEMENTED\n");
+		IRDA_DEBUG(2, "%s(), NOT IMPLEMENTED\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown command!\n");
+		IRDA_DEBUG(2, "%s(), Unknown command!\n", __FUNCTION__);
 		break;
 	}
 	return 0;
@@ -129,7 +129,7 @@
 	struct tsap_cb *tsap;
 	__u32 saddr, daddr;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 	
 	self = (struct irlan_cb *) instance;
 	tsap = (struct tsap_cb *) sap;
@@ -182,7 +182,7 @@
 	struct irlan_cb *self;
 	struct tsap_cb *tsap;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), reason=%d\n", reason);
+	IRDA_DEBUG(4, "%s(), reason=%d\n", __FUNCTION__, reason);
 	
 	self = (struct irlan_cb *) instance;
 	tsap = (struct tsap_cb *) sap;
@@ -236,7 +236,7 @@
 	
 	ASSERT(skb != NULL, return -RSP_PROTOCOL_ERROR;);
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), skb->len=%d\n", (int)skb->len);
+	IRDA_DEBUG(4, "%s(), skb->len=%d\n", __FUNCTION__, (int)skb->len);
 
 	ASSERT(self != NULL, return -RSP_PROTOCOL_ERROR;);
 	ASSERT(self->magic == IRLAN_MAGIC, return -RSP_PROTOCOL_ERROR;);
@@ -266,7 +266,7 @@
  	for (i=0; i<count;i++) {
 		ret = irlan_extract_param(ptr, name, value, &val_len);
 		if (ret < 0) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), IrLAN, Error!\n");
+			IRDA_DEBUG(2, "%s(), IrLAN, Error!\n", __FUNCTION__);
 			break;
 		}
 		ptr+=ret;
@@ -291,7 +291,7 @@
 {
 	struct sk_buff *skb;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
@@ -316,7 +316,7 @@
 			irlan_insert_string_param(skb, "MEDIA", "802.5");
 			break;
 		default:
-			IRDA_DEBUG(2, __FUNCTION__ "(), unknown media type!\n");
+			IRDA_DEBUG(2, "%s(), unknown media type!\n", __FUNCTION__);
 			break;
 		}
 		irlan_insert_short_param(skb, "IRLAN_VER", 0x0101);
@@ -340,7 +340,7 @@
 			irlan_insert_string_param(skb, "ACCESS_TYPE", "HOSTED");
 			break;
 		default:
-			IRDA_DEBUG(2, __FUNCTION__ "(), Unknown access type\n");
+			IRDA_DEBUG(2, "%s(), Unknown access type\n", __FUNCTION__);
 			break;
 		}
 		irlan_insert_short_param(skb, "MAX_FRAME", 0x05ee);
@@ -361,7 +361,7 @@
 		handle_filter_request(self, skb);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown command!\n");
+		IRDA_DEBUG(2, "%s(), Unknown command!\n", __FUNCTION__);
 		break;
 	}
 
@@ -379,7 +379,7 @@
 	struct tsap_cb *tsap;
 	notify_t notify;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRLAN_MAGIC, return -1;);
@@ -400,7 +400,7 @@
 
 	tsap = irttp_open_tsap(LSAP_ANY, 1, &notify);
 	if (!tsap) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), Got no tsap!\n");
+		IRDA_DEBUG(2, "%s(), Got no tsap!\n", __FUNCTION__);
 		return -1;
 	}
 	self->provider.tsap_ctrl = tsap;
--- linux-2.4.22-rc2/net/irda/irlan/irlan_provider_event.c	1999-11-02 22:07:55.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irlan/irlan_provider_event.c	2003-08-21 00:08:28.000000000 -0300
@@ -72,7 +72,7 @@
 static int irlan_provider_state_idle(struct irlan_cb *self, IRLAN_EVENT event,
 				     struct sk_buff *skb)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 	
@@ -82,7 +82,7 @@
 	     irlan_next_provider_state( self, IRLAN_INFO);
 	     break;
 	default:
-		IRDA_DEBUG(4, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(4, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -101,7 +101,7 @@
 {
 	int ret;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 
@@ -147,7 +147,7 @@
 		irlan_next_provider_state(self, IRLAN_IDLE);
 		break;
 	default:
-		IRDA_DEBUG( 0, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(0, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -166,7 +166,7 @@
 static int irlan_provider_state_open(struct irlan_cb *self, IRLAN_EVENT event, 
 				     struct sk_buff *skb)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 
@@ -186,7 +186,7 @@
 		irlan_next_provider_state(self, IRLAN_IDLE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(2, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)
@@ -205,7 +205,7 @@
 static int irlan_provider_state_data(struct irlan_cb *self, IRLAN_EVENT event, 
 				     struct sk_buff *skb) 
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRLAN_MAGIC, return -1;);
@@ -221,7 +221,7 @@
 		irlan_next_provider_state(self, IRLAN_IDLE);
 		break;
 	default:
-		IRDA_DEBUG( 0, __FUNCTION__ "(), Unknown event %d\n", event);
+		IRDA_DEBUG(0, "%s(), Unknown event %d\n", __FUNCTION__, event);
 		break;
 	}
 	if (skb)

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
