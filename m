Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTHVHfR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTHVHe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:34:28 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:21260 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263017AbTHVHZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 03:25:25 -0400
Date: Fri, 22 Aug 2003 04:24:41 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][resend] 8/13 2.4.22-rc2 fix __FUNCTION__ warnings
 net/irda/ircomm [2/7]
Message-Id: <20030822042441.7efb55dd.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 ircomm_core.c       |   46 ++++++++++++++---------------
 ircomm_event.c      |   12 +++----
 ircomm_lmp.c        |   30 +++++++++----------
 ircomm_param.c      |   34 ++++++++++-----------
 ircomm_ttp.c        |   26 ++++++++--------
 ircomm_tty_attach.c |   81 +++++++++++++++++++++++++---------------------------
 ircomm_tty_ioctl.c  |   18 +++++------
 7 files changed, 123 insertions(+), 124 deletions(-)

--- linux-2.4.22-rc2/net/irda/ircomm/ircomm_core.c	2003-06-13 11:51:39.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/ircomm/ircomm_core.c	2003-08-21 00:08:28.000000000 -0300
@@ -63,7 +63,7 @@
 {
 	ircomm = hashbin_new(HB_LOCAL); 
 	if (ircomm == NULL) {
-		ERROR(__FUNCTION__ "(), can't allocate hashbin!\n");
+		ERROR("%s(), can't allocate hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 	
@@ -79,7 +79,7 @@
 #ifdef MODULE
 void ircomm_cleanup(void)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	hashbin_delete(ircomm, (FREE_FUNC) __ircomm_close);
 
@@ -100,7 +100,7 @@
 	struct ircomm_cb *self = NULL;
 	int ret;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), service_type=0x%02x\n",
+	IRDA_DEBUG(2, "%s(), service_type=0x%02x\n", __FUNCTION__,
 		   service_type);
 
 	ASSERT(ircomm != NULL, return NULL;);
@@ -144,7 +144,7 @@
  */
 static int __ircomm_close(struct ircomm_cb *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__"()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Disconnect link if any */
 	ircomm_do_event(self, IRCOMM_DISCONNECT_REQUEST, NULL, NULL);
@@ -180,7 +180,7 @@
 	ASSERT(self != NULL, return -EIO;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -EIO;);
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	entry = hashbin_remove(ircomm, self->line, NULL);
 
@@ -203,7 +203,7 @@
 	struct ircomm_info info;
 	int ret;
 
-	IRDA_DEBUG(2 , __FUNCTION__"()\n");
+	IRDA_DEBUG(2 , "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -1;);
@@ -230,7 +230,7 @@
 {
 	int clen = 0;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Check if the packet contains data on the control channel */
 	if (skb->len > 0)
@@ -246,7 +246,7 @@
 						info->qos, info->max_data_size,
 						info->max_header_size, skb);
 	else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), missing handler\n");
+		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 }
@@ -264,7 +264,7 @@
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -1;);
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ret = ircomm_do_event(self, IRCOMM_CONNECT_RESPONSE, userdata, NULL);
 
@@ -280,7 +280,7 @@
 void ircomm_connect_confirm(struct ircomm_cb *self, struct sk_buff *skb,
 			    struct ircomm_info *info)
 {
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	if (self->notify.connect_confirm )
 		self->notify.connect_confirm(self->notify.instance,
@@ -288,7 +288,7 @@
 					     info->max_data_size,
 					     info->max_header_size, skb);
 	else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), missing handler\n");
+		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 }
@@ -303,7 +303,7 @@
 {
 	int ret;
 
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -EFAULT;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -EFAULT;);
@@ -322,14 +322,14 @@
  */
 void ircomm_data_indication(struct ircomm_cb *self, struct sk_buff *skb)
 {	
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(skb->len > 0, return;);
 
 	if (self->notify.data_indication)
 		self->notify.data_indication(self->notify.instance, self, skb);
 	else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), missing handler\n");
+		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 }
@@ -362,8 +362,8 @@
 	if (skb->len)
 		ircomm_data_indication(self, skb);		
 	else {
-		IRDA_DEBUG(4, __FUNCTION__ 
-			   "(), data was control info only!\n");
+		IRDA_DEBUG(4, "%s(), data was control info only!\n",
+			   __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 }
@@ -378,7 +378,7 @@
 {
 	int ret;
 	
-	IRDA_DEBUG(2, __FUNCTION__"()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -EFAULT;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -EFAULT;);
@@ -400,7 +400,7 @@
 {
 	struct sk_buff *ctrl_skb;
 
-	IRDA_DEBUG(2, __FUNCTION__"()\n");	
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);	
 
 	ctrl_skb = skb_clone(skb, GFP_ATOMIC);
 	if (!ctrl_skb)
@@ -414,7 +414,7 @@
 		self->notify.udata_indication(self->notify.instance, self, 
 					      ctrl_skb);
 	else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), missing handler\n");
+		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 }
@@ -430,7 +430,7 @@
 	struct ircomm_info info;
 	int ret;
 
-	IRDA_DEBUG(2, __FUNCTION__"()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -1;);
@@ -449,7 +449,7 @@
 void ircomm_disconnect_indication(struct ircomm_cb *self, struct sk_buff *skb,
 				  struct ircomm_info *info)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
        
 	ASSERT(info != NULL, return;);
 
@@ -457,7 +457,7 @@
 		self->notify.disconnect_indication(self->notify.instance, self,
 						   info->reason, skb);
 	} else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), missing handler\n");
+		IRDA_DEBUG(0, "%s(), missing handler\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 }
@@ -470,7 +470,7 @@
  */
 void ircomm_flow_request(struct ircomm_cb *self, LOCAL_FLOW flow)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
--- linux-2.4.22-rc2/net/irda/ircomm/ircomm_event.c	2001-03-02 16:12:12.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/ircomm/ircomm_event.c	2003-08-21 00:08:28.000000000 -0300
@@ -107,7 +107,7 @@
 		ircomm_connect_indication(self, skb, info);
 		break;
 	default:
-		IRDA_DEBUG(4, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(4, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_event[event]);
 		if (skb)
 			dev_kfree_skb(skb);
@@ -139,7 +139,7 @@
 		ircomm_disconnect_indication(self, skb, info);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(0, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_event[event]);
 		if (skb)
 			dev_kfree_skb(skb);
@@ -174,7 +174,7 @@
 		ircomm_disconnect_indication(self, skb, info);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), unknown event = %s\n",
+		IRDA_DEBUG(0, "%s(), unknown event = %s\n", __FUNCTION__,
 			   ircomm_event[event]);
 		if (skb)
 			dev_kfree_skb(skb);
@@ -218,7 +218,7 @@
 		ret = self->issue.disconnect_request(self, skb, info);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), unknown event = %s\n",
+		IRDA_DEBUG(0, "%s(), unknown event = %s\n", __FUNCTION__,
 			   ircomm_event[event]);
 		if (skb)
 			dev_kfree_skb(skb);
@@ -236,7 +236,7 @@
 int ircomm_do_event(struct ircomm_cb *self, IRCOMM_EVENT event,
 		    struct sk_buff *skb, struct ircomm_info *info) 
 {
-	IRDA_DEBUG(4, __FUNCTION__": state=%s, event=%s\n",
+	IRDA_DEBUG(4, "%s: state=%s, event=%s\n", __FUNCTION__,
 		   ircomm_state[self->state], ircomm_event[event]);
 
 	return (*state[self->state])(self, event, skb, info);
@@ -252,6 +252,6 @@
 {
 	self->state = state;
 	
-	IRDA_DEBUG(4, __FUNCTION__": next state=%s, service type=%d\n", 
+	IRDA_DEBUG(4, "%s: next state=%s, service type=%d\n", __FUNCTION__, 
 		   ircomm_state[self->state], self->service_type);
 }
--- linux-2.4.22-rc2/net/irda/ircomm/ircomm_lmp.c	2002-02-25 16:38:14.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/ircomm/ircomm_lmp.c	2003-08-21 00:08:28.000000000 -0300
@@ -49,7 +49,7 @@
 {
 	notify_t notify;
 	
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 	
         /* Register callbacks */
         irda_notify_init(&notify);
@@ -62,7 +62,7 @@
 
 	self->lsap = irlmp_open_lsap(LSAP_ANY, &notify, 0);
 	if (!self->lsap) {
-		IRDA_DEBUG(0,__FUNCTION__"failed to allocate tsap\n");
+		IRDA_DEBUG(0,"%s failed to allocate tsap\n", __FUNCTION__);
 		return -1;
 	}
 	self->slsap_sel = self->lsap->slsap_sel;
@@ -90,7 +90,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ret = irlmp_connect_request(self->lsap, info->dlsap_sel,
 				    info->saddr, info->daddr, NULL, userdata); 
@@ -108,7 +108,7 @@
 	struct sk_buff *skb;
 	int ret;
 
-	IRDA_DEBUG(0, __FUNCTION__"()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 	
 	/* Any userdata supplied? */
 	if (userdata == NULL) {
@@ -139,7 +139,7 @@
         struct sk_buff *skb;
 	int ret;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
         if (!userdata) {
                 skb = dev_alloc_skb(64);
@@ -172,13 +172,13 @@
 
 	cb = (struct irda_skb_cb *) skb->cb;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
  
         line = cb->line;
 
 	self = (struct ircomm_cb *) hashbin_find(ircomm, line, NULL);
         if (!self) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), didn't find myself\n");
+		IRDA_DEBUG(2, "%s(), didn't find myself\n", __FUNCTION__);
                 return;
 	}
 
@@ -188,7 +188,7 @@
 	self->pkt_count--;
 
         if ((self->pkt_count < 2) && (self->flow_status == FLOW_STOP)) {
-                IRDA_DEBUG(2, __FUNCTION__ "(), asking TTY to start again!\n");
+                IRDA_DEBUG(2, "%s(), asking TTY to start again!\n", __FUNCTION__);
                 self->flow_status = FLOW_START;
                 if (self->notify.flow_indication)
                         self->notify.flow_indication(self->notify.instance, 
@@ -214,12 +214,12 @@
 	
         cb->line = self->line;
 
-	IRDA_DEBUG(4, __FUNCTION__"(), sending frame\n");
+	IRDA_DEBUG(4, "%s(), sending frame\n", __FUNCTION__);
 
 	skb->destructor = ircomm_lmp_flow_control;
 	
         if ((self->pkt_count++ > 7) && (self->flow_status == FLOW_START)) {
-		IRDA_DEBUG(2, __FUNCTION__ "(), asking TTY to slow down!\n");
+		IRDA_DEBUG(2, "%s(), asking TTY to slow down!\n", __FUNCTION__);
 	        self->flow_status = FLOW_STOP;
                 if (self->notify.flow_indication)
              	        self->notify.flow_indication(self->notify.instance, 
@@ -227,7 +227,7 @@
         }
 	ret = irlmp_data_request(self->lsap, skb);
 	if (ret) {
-		ERROR(__FUNCTION__ "(), failed\n");
+		ERROR("%s(), failed\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 
@@ -245,7 +245,7 @@
 {
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -1;);
@@ -272,7 +272,7 @@
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 	struct ircomm_info info;
 
-	IRDA_DEBUG(0, __FUNCTION__"()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
@@ -302,7 +302,7 @@
 	struct ircomm_cb *self = (struct ircomm_cb *)instance;
 	struct ircomm_info info;
 
-	IRDA_DEBUG(0, __FUNCTION__"()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
@@ -329,7 +329,7 @@
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 	struct ircomm_info info;
 
-	IRDA_DEBUG(0, __FUNCTION__"()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
--- linux-2.4.22-rc2/net/irda/ircomm/ircomm_param.c	2003-08-21 00:05:16.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/ircomm/ircomm_param.c	2003-08-21 00:08:28.000000000 -0300
@@ -118,7 +118,7 @@
 	struct sk_buff *skb;
 	int count;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
@@ -152,7 +152,7 @@
 	count = irda_param_insert(self, pi, skb->tail, skb_tailroom(skb),
 				  &ircomm_param_info);
 	if (count < 0) {
-		WARNING(__FUNCTION__ "(), no room for parameter!\n");
+		WARNING("%s(), no room for parameter!\n", __FUNCTION__);
 		restore_flags(flags);
 		return -1;
 	}
@@ -160,7 +160,7 @@
 
 	restore_flags(flags);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), skb->len=%d\n", skb->len);
+	IRDA_DEBUG(2, "%s(), skb->len=%d\n", __FUNCTION__, skb->len);
 
 	if (flush) {
 		/* ircomm_tty_do_softint will take care of the rest */
@@ -195,11 +195,11 @@
 	/* Find all common service types */
 	service_type &= self->service_type;
 	if (!service_type) {
-		IRDA_DEBUG(2, __FUNCTION__
-			   "(), No common service type to use!\n");
+		IRDA_DEBUG(2, "%s(), No common service type to use!\n",
+			   __FUNCTION__);
 		return -1;
 	}
-	IRDA_DEBUG(0, __FUNCTION__ "(), services in common=%02x\n",
+	IRDA_DEBUG(0, "%s(), services in common=%02x\n", __FUNCTION__,
 		   service_type);
 
 	/*
@@ -214,7 +214,7 @@
 	else if (service_type & IRCOMM_3_WIRE_RAW)
 		self->settings.service_type = IRCOMM_3_WIRE_RAW;
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), resulting service type=0x%02x\n", 
+	IRDA_DEBUG(0, "%s(), resulting service type=0x%02x\n", __FUNCTION__, 
 		   self->settings.service_type);
 
 	/* 
@@ -257,7 +257,7 @@
 	else {
 		self->settings.port_type = (__u8) param->pv.i;
 
-		IRDA_DEBUG(0, __FUNCTION__ "(), port type=%d\n", 
+		IRDA_DEBUG(0, "%s(), port type=%d\n", __FUNCTION__, 
 			   self->settings.port_type);
 	}
 	return 0;
@@ -277,9 +277,9 @@
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
 	if (get) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), not imp!\n");
+		IRDA_DEBUG(0, "%s(), not imp!\n", __FUNCTION__);
 	} else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), port-name=%s\n", param->pv.c);
+		IRDA_DEBUG(0, "%s(), port-name=%s\n", __FUNCTION__, param->pv.c);
 		strncpy(self->settings.port_name, param->pv.c, 32);
 	}
 
@@ -304,7 +304,7 @@
 	else
 		self->settings.data_rate = param->pv.i;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), data rate = %d\n", param->pv.i);
+	IRDA_DEBUG(2, "%s(), data rate = %d\n", __FUNCTION__, param->pv.i);
 
 	return 0;
 }
@@ -350,7 +350,7 @@
 	else
 		self->settings.flow_control = (__u8) param->pv.i;
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), flow control = 0x%02x\n", (__u8) param->pv.i);
+	IRDA_DEBUG(1, "%s(), flow control = 0x%02x\n", __FUNCTION__, (__u8) param->pv.i);
 
 	return 0;
 }
@@ -376,7 +376,7 @@
 		self->settings.xonxoff[1] = (__u16) param->pv.i >> 8;
 	}
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), XON/XOFF = 0x%02x,0x%02x\n", 
+	IRDA_DEBUG(0, "%s(), XON/XOFF = 0x%02x,0x%02x\n", __FUNCTION__, 
 		   param->pv.i & 0xff, param->pv.i >> 8);
 
 	return 0;
@@ -403,7 +403,7 @@
 		self->settings.enqack[1] = (__u16) param->pv.i >> 8;
 	}
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), ENQ/ACK = 0x%02x,0x%02x\n",
+	IRDA_DEBUG(0, "%s(), ENQ/ACK = 0x%02x,0x%02x\n", __FUNCTION__,
 		   param->pv.i & 0xff, param->pv.i >> 8);
 
 	return 0;
@@ -418,7 +418,7 @@
 static int ircomm_param_line_status(void *instance, irda_param_t *param, 
 				    int get)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(), not impl.\n");
+	IRDA_DEBUG(2, "%s(), not impl.\n", __FUNCTION__);
 
 	return 0;
 }
@@ -477,7 +477,7 @@
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
 	__u8 dce;
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), dce = 0x%02x\n", (__u8) param->pv.i);
+	IRDA_DEBUG(1, "%s(), dce = 0x%02x\n", __FUNCTION__, (__u8) param->pv.i);
 
 	dce = (__u8) param->pv.i;
 
@@ -489,7 +489,7 @@
 	/* Check if any of the settings have changed */
 	if (dce & 0x0f) {
 		if (dce & IRCOMM_DELTA_CTS) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), CTS \n");
+			IRDA_DEBUG(2, "%s(), CTS \n", __FUNCTION__);
 		}
 	}
 
--- linux-2.4.22-rc2/net/irda/ircomm/ircomm_ttp.c	2001-03-02 16:12:12.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/ircomm/ircomm_ttp.c	2003-08-21 00:08:28.000000000 -0300
@@ -49,7 +49,7 @@
 {
 	notify_t notify;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/* Register callbacks */
 	irda_notify_init(&notify);
@@ -64,7 +64,7 @@
 	self->tsap = irttp_open_tsap(LSAP_ANY, DEFAULT_INITIAL_CREDIT,
 				     &notify);
 	if (!self->tsap) {
-		IRDA_DEBUG(0, __FUNCTION__"failed to allocate tsap\n");
+		IRDA_DEBUG(0, "%s failed to allocate tsap\n", __FUNCTION__);
 		return -1;
 	}
 	self->slsap_sel = self->tsap->stsap_sel;
@@ -92,7 +92,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ret = irttp_connect_request(self->tsap, info->dlsap_sel,
 				    info->saddr, info->daddr, NULL, 
@@ -110,7 +110,7 @@
 {
 	int ret;
 
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ret = irttp_connect_response(self->tsap, TTP_SAR_DISABLE, skb);
 
@@ -133,7 +133,7 @@
 
 	ASSERT(skb != NULL, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__"(), clen=%d\n", clen);
+	IRDA_DEBUG(2, "%s(), clen=%d\n", __FUNCTION__, clen);
 
 	/* 
 	 * Insert clen field, currently we either send data only, or control
@@ -146,7 +146,7 @@
 
 	ret = irttp_data_request(self->tsap, skb);
 	if (ret) {
-		ERROR(__FUNCTION__ "(), failed\n");
+		ERROR("%s(), failed\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	}
 
@@ -164,7 +164,7 @@
 {
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return -1;);
@@ -184,7 +184,7 @@
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 	struct ircomm_info info;
 
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
@@ -192,7 +192,7 @@
 	ASSERT(qos != NULL, return;);
 
 	if (max_sdu_size != TTP_SAR_DISABLE) {
-		ERROR(__FUNCTION__ "(), SAR not allowed for IrCOMM!\n");
+		ERROR("%s(), SAR not allowed for IrCOMM!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 		return;
 	}
@@ -221,7 +221,7 @@
 	struct ircomm_cb *self = (struct ircomm_cb *)instance;
 	struct ircomm_info info;
 
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
@@ -229,7 +229,7 @@
 	ASSERT(qos != NULL, return;);
 
 	if (max_sdu_size != TTP_SAR_DISABLE) {
-		ERROR(__FUNCTION__ "(), SAR not allowed for IrCOMM!\n");
+		ERROR("%s(), SAR not allowed for IrCOMM!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 		return;
 	}
@@ -272,7 +272,7 @@
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 	struct ircomm_info info;
 
-	IRDA_DEBUG(2, __FUNCTION__"()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
@@ -292,7 +292,7 @@
 {
 	struct ircomm_cb *self = (struct ircomm_cb *) instance;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_MAGIC, return;);
--- linux-2.4.22-rc2/net/irda/ircomm/ircomm_tty_attach.c	2003-08-21 00:05:16.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/ircomm/ircomm_tty_attach.c	2003-08-21 00:08:28.000000000 -0300
@@ -126,14 +126,14 @@
  */
 int ircomm_tty_attach_cable(struct ircomm_tty_cb *self)
 {
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
        	/* Check if somebody has already connected to us */
 	if (ircomm_is_connected(self->ircomm)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), already connected!\n");
+		IRDA_DEBUG(0, "%s(), already connected!\n", __FUNCTION__);
 		return 0;
 	}
 
@@ -144,7 +144,7 @@
 
 	/* Check if somebody has already connected to us */
 	if (ircomm_is_connected(self->ircomm)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), already connected!\n");
+		IRDA_DEBUG(0, "%s(), already connected!\n", __FUNCTION__);
 		return 0;
 	}
 
@@ -161,7 +161,7 @@
  */
 void ircomm_tty_detach_cable(struct ircomm_tty_cb *self)
 {
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -203,7 +203,7 @@
 	__u8 oct_seq[6];
 	__u16 hints;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -258,16 +258,16 @@
 	 * Set default values, but only if the application for some reason 
 	 * haven't set them already
 	 */
-	IRDA_DEBUG(2, __FUNCTION__ "(), data-rate = %d\n", 
+	IRDA_DEBUG(2, "%s(), data-rate = %d\n", __FUNCTION__, 
 		   self->settings.data_rate);
 	if (!self->settings.data_rate)
 		self->settings.data_rate = 9600;
-	IRDA_DEBUG(2, __FUNCTION__ "(), data-format = %d\n", 
+	IRDA_DEBUG(2, "%s(), data-format = %d\n", __FUNCTION__, 
 		   self->settings.data_format);
 	if (!self->settings.data_format)
 		self->settings.data_format = IRCOMM_WSIZE_8;  /* 8N1 */
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), flow-control = %d\n", 
+	IRDA_DEBUG(2, "%s(), flow-control = %d\n", __FUNCTION__, 
 		   self->settings.flow_control);
 	/*self->settings.flow_control = IRCOMM_RTS_CTS_IN|IRCOMM_RTS_CTS_OUT;*/
 
@@ -312,7 +312,7 @@
 	struct ircomm_tty_cb *self;
 	struct ircomm_tty_info info;
 
-	IRDA_DEBUG(2, __FUNCTION__"()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Important note :
 	 * We need to drop all passive discoveries.
@@ -354,7 +354,7 @@
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -384,7 +384,7 @@
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) priv;
 
-	IRDA_DEBUG(2, __FUNCTION__"()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -395,13 +395,13 @@
 
 	/* Check if request succeeded */
 	if (result != IAS_SUCCESS) {
-		IRDA_DEBUG(4, __FUNCTION__ "(), got NULL value!\n");
+		IRDA_DEBUG(4, "%s(), got NULL value!\n", __FUNCTION__);
 		return;
 	}
 
 	switch (value->type) {
  	case IAS_OCT_SEQ:
-		IRDA_DEBUG(2, __FUNCTION__"(), got octet sequence\n");
+		IRDA_DEBUG(2, "%s(), got octet sequence\n", __FUNCTION__);
 
 		irda_param_extract_all(self, value->t.oct_seq, value->len,
 				       &ircomm_param_info);
@@ -411,21 +411,21 @@
 		break;
 	case IAS_INTEGER:
 		/* Got LSAP selector */	
-		IRDA_DEBUG(2, __FUNCTION__"(), got lsapsel = %d\n", 
+		IRDA_DEBUG(2, "%s(), got lsapsel = %d\n", __FUNCTION__, 
 			   value->t.integer);
 
 		if (value->t.integer == -1) {
-			IRDA_DEBUG(0, __FUNCTION__"(), invalid value!\n");
+			IRDA_DEBUG(0, "%s(), invalid value!\n", __FUNCTION__);
 		} else
 			self->dlsap_sel = value->t.integer;
 
 		ircomm_tty_do_event(self, IRCOMM_TTY_GOT_LSAPSEL, NULL, NULL);
 		break;
 	case IAS_MISSING:
-		IRDA_DEBUG(0, __FUNCTION__"(), got IAS_MISSING\n");
+		IRDA_DEBUG(0, "%s(), got IAS_MISSING\n", __FUNCTION__);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__"(), got unknown type!\n");
+		IRDA_DEBUG(0, "%s(), got unknown type!\n", __FUNCTION__);
 		break;
 	}
 	irias_delete_value(value);
@@ -445,7 +445,7 @@
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -476,7 +476,7 @@
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) instance;
 	int clen;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -505,7 +505,7 @@
  */
 void ircomm_tty_link_established(struct ircomm_tty_cb *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -580,7 +580,7 @@
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) data;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
@@ -601,7 +601,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__": state=%s, event=%s\n",
+	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__,
 		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
 	switch (event) {
 	case IRCOMM_TTY_ATTACH_CABLE:
@@ -616,8 +616,8 @@
 		self->saddr = info->saddr;
 
 		if (self->iriap) {
-			WARNING(__FUNCTION__ 
-				"(), busy with a previous query\n");
+			WARNING("%s(), busy with a previous query\n",
+				__FUNCTION__);
 			return -EBUSY;
 		}
 
@@ -645,7 +645,7 @@
 		ircomm_tty_next_state(self, IRCOMM_TTY_IDLE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_tty_event[event]);
 		return -EINVAL;
 	}
@@ -665,7 +665,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__": state=%s, event=%s\n",
+	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__,
 		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
 
 	switch (event) {
@@ -674,8 +674,7 @@
 		self->saddr = info->saddr;
 
 		if (self->iriap) {
-			WARNING(__FUNCTION__ 
-				"(), busy with a previous query\n");
+			WARNING("%s(), busy with a previous query\n", __FUNCTION__);
 			return -EBUSY;
 		}
 		
@@ -717,7 +716,7 @@
 		ircomm_tty_next_state(self, IRCOMM_TTY_IDLE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_tty_event[event]);
 		return -EINVAL;
 	}
@@ -737,14 +736,14 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__": state=%s, event=%s\n",
+	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__,
 		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
 
 	switch (event) {
 	case IRCOMM_TTY_GOT_PARAMETERS:
 		if (self->iriap) {
-			WARNING(__FUNCTION__ 
-				"(), busy with a previous query\n");
+			WARNING("%s(), busy with a previous query\n",
+				__FUNCTION__);
 			return -EBUSY;
 		}
 		
@@ -774,7 +773,7 @@
 		ircomm_tty_next_state(self, IRCOMM_TTY_IDLE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_tty_event[event]);
 		return -EINVAL;
 	}
@@ -794,7 +793,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__": state=%s, event=%s\n",
+	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__,
 		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
 
 	switch (event) {
@@ -822,7 +821,7 @@
 		ircomm_tty_next_state(self, IRCOMM_TTY_IDLE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_tty_event[event]);
 		return -EINVAL;
 	}
@@ -842,7 +841,7 @@
 {
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__": state=%s, event=%s\n",
+	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__,
 		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
 
 	switch (event) {
@@ -874,7 +873,7 @@
 		ircomm_tty_next_state(self, IRCOMM_TTY_IDLE);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_tty_event[event]);
 		return -EINVAL;
 	}
@@ -911,13 +910,13 @@
 			self->settings.dce = IRCOMM_DELTA_CD;
 			ircomm_tty_check_modem_status(self);
 		} else {
-			IRDA_DEBUG(0, __FUNCTION__ "(), hanging up!\n");
+			IRDA_DEBUG(0, "%s(), hanging up!\n", __FUNCTION__);
 			if (self->tty)
 				tty_hangup(self->tty);
 		}
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__"(), unknown event: %s\n",
+		IRDA_DEBUG(2, "%s(), unknown event: %s\n", __FUNCTION__,
 			   ircomm_tty_event[event]);
 		return -EINVAL;
 	}
@@ -936,7 +935,7 @@
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__": state=%s, event=%s\n",
+	IRDA_DEBUG(2, "%s: state=%s, event=%s\n", __FUNCTION__,
 		   ircomm_tty_state[self->state], ircomm_tty_event[event]);
 	
 	return (*state[self->state])(self, event, skb, info);
@@ -955,7 +954,7 @@
 
 	self->state = state;
 	
-	IRDA_DEBUG(2, __FUNCTION__": next state=%s, service type=%d\n", 
+	IRDA_DEBUG(2, "%s: next state=%s, service type=%d\n", __FUNCTION__, 
 		   ircomm_tty_state[self->state], self->service_type);
 }
 
--- linux-2.4.22-rc2/net/irda/ircomm/ircomm_tty_ioctl.c	2002-11-28 20:53:16.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/ircomm/ircomm_tty_ioctl.c	2003-08-21 00:08:28.000000000 -0300
@@ -59,7 +59,7 @@
 	unsigned cflag, cval;
 	int baud;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if (!self->tty || !self->tty->termios || !self->ircomm)
 		return;
@@ -96,7 +96,7 @@
 		self->settings.flow_control |= IRCOMM_RTS_CTS_IN;
 		/* This got me. Bummer. Jean II */
 		if (self->service_type == IRCOMM_3_WIRE_RAW)
-			WARNING(__FUNCTION__ "(), enabling RTS/CTS on link that doesn't support it (3-wire-raw)\n");
+			WARNING("%s(), enabling RTS/CTS on link that doesn't support it (3-wire-raw)\n", __FUNCTION__);
 	} else {
 		self->flags &= ~ASYNC_CTS_FLOW;
 		self->settings.flow_control &= ~IRCOMM_RTS_CTS_IN;
@@ -152,7 +152,7 @@
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 	unsigned int cflag = tty->termios->c_cflag;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if ((cflag == old_termios->c_cflag) && 
 	    (RELEVANT_IFLAG(tty->termios->c_iflag) == 
@@ -201,7 +201,7 @@
 {
 	unsigned int result;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	result =  ((self->settings.dte & IRCOMM_RTS) ? TIOCM_RTS : 0)
 		| ((self->settings.dte & IRCOMM_DTR) ? TIOCM_DTR : 0)
@@ -225,7 +225,7 @@
 	unsigned int arg;
 	__u8 old_rts, old_dtr;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
@@ -287,7 +287,7 @@
 	if (!retinfo)
 		return -EFAULT;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	memset(&info, 0, sizeof(info));
 	info.line = self->line;
@@ -323,7 +323,7 @@
 	struct serial_struct new_serial;
 	struct ircomm_tty_cb old_state, *state;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
 		return -EFAULT;
@@ -397,7 +397,7 @@
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
@@ -426,7 +426,7 @@
 		break;
 
 	case TIOCGICOUNT:
-		IRDA_DEBUG(0, __FUNCTION__ "(), TIOCGICOUNT not impl!\n");
+		IRDA_DEBUG(0, "%s(), TIOCGICOUNT not impl!\n", __FUNCTION__);
 #if 0
 		save_flags(flags); cli();
 		cnow = driver->icount;

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
