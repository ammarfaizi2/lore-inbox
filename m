Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbTHVHmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbTHVHlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:41:44 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:17682 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263070AbTHVHiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 03:38:13 -0400
Date: Fri, 22 Aug 2003 04:37:26 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH][resend] 13/13 2.4.22-rc2 fix __FUNCTION__ warnings net/irda
 [7/7]
Message-Id: <20030822043726.01b5c42f.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 irda_device.c  |   48 +++++++++++------------
 irias_object.c |   35 ++++++++---------
 irqueue.c      |   10 ++--
 irttp.c        |  116 ++++++++++++++++++++++++++++-----------------------------
 parameters.c   |   54 +++++++++++++-------------
 qos.c          |   30 ++++++--------
 wrapper.c      |   25 +++++-------
 7 files changed, 156 insertions(+), 162 deletions(-)

--- linux-2.4.22-rc2/net/irda/irda_device.c	2003-08-21 00:05:16.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irda_device.c	2003-08-21 00:08:28.000000000 -0300
@@ -174,7 +174,7 @@
 
 void irda_device_cleanup(void)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	hashbin_delete(tasks, (FREE_FUNC) __irda_task_delete);
 	hashbin_delete(dongles, NULL);
@@ -190,7 +190,7 @@
 {
 	struct irlap_cb *self;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(%s)\n", status ? "TRUE" : "FALSE");
+	IRDA_DEBUG(4, "%s(%s)\n", __FUNCTION__, status ? "TRUE" : "FALSE");
 
 	self = (struct irlap_cb *) dev->atalk_ptr;
 
@@ -215,11 +215,11 @@
 	struct if_irda_req req;
 	int ret;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), do_ioctl not impl. by "
-		      "device driver\n");
+		ERROR("%s(), do_ioctl not impl. by device driver\n",
+		      __FUNCTION__);
 		return -1;
 	}
 
@@ -236,11 +236,11 @@
 	struct if_irda_req req;
 	int ret;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), do_ioctl not impl. by "
-		      "device driver\n");
+		ERROR("%s(), do_ioctl not impl. by device driver\n",
+		      __FUNCTION__);
 		return -1;
 	}
 
@@ -262,11 +262,11 @@
 	struct if_irda_req req;
 	int ret;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), do_ioctl not impl. by "
-		      "device driver\n");
+		ERROR("%s(), do_ioctl not impl. by device driver\n",
+		      __FUNCTION__);
 		return -1;
 	}
 
@@ -279,7 +279,7 @@
 
 void irda_task_next_state(struct irda_task *task, IRDA_TASK_STATE state)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "(), state = %s\n", task_state[state]);
+	IRDA_DEBUG(2, "%s(), state = %s\n", __FUNCTION__, task_state[state]);
 
 	task->state = state;
 }
@@ -313,7 +313,7 @@
 	int count = 0;
 	int timeout;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(task != NULL, return -1;);
 	ASSERT(task->magic == IRDA_TASK_MAGIC, return -1;);
@@ -322,14 +322,14 @@
 	do {
 		timeout = task->function(task);
 		if (count++ > 100) {
-			ERROR(__FUNCTION__ "(), error in task handler!\n");
+			ERROR("%s(), error in task handler!\n", __FUNCTION__);
 			irda_task_delete(task);
 			return TRUE;
 		}			
 	} while ((timeout == 0) && (task->state != IRDA_TASK_DONE));
 
 	if (timeout < 0) {
-		ERROR(__FUNCTION__ "(), Error executing task!\n");
+		ERROR("%s(), Error executing task!\n", __FUNCTION__);
 		irda_task_delete(task);
 		return TRUE;
 	}
@@ -361,8 +361,8 @@
 				 irda_task_timer_expired);
 		finished = FALSE;
 	} else {
-		IRDA_DEBUG(0, __FUNCTION__ 
-			   "(), not finished, and no timeout!\n");
+		IRDA_DEBUG(0, "%s(), not finished, and no timeout!\n",
+			   __FUNCTION__);
 		finished = FALSE;
 	}
 
@@ -391,7 +391,7 @@
 	struct irda_task *task;
 	int ret;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	task = kmalloc(sizeof(struct irda_task), GFP_ATOMIC);
 	if (!task)
@@ -428,7 +428,7 @@
 {
 	struct irda_task *task;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	task = (struct irda_task *) data;
 
@@ -547,7 +547,7 @@
 {
 	/* Check if this dongle has been registred before */
 	if (hashbin_find(dongles, new->type, NULL)) {
-		MESSAGE(__FUNCTION__ "(), Dongle already registered\n");
+		MESSAGE("%s(), Dongle already registered\n", __FUNCTION__);
                 return 0;
         }
 	
@@ -569,7 +569,7 @@
 
 	node = hashbin_remove(dongles, dongle->type, NULL);
 	if (!node) {
-		ERROR(__FUNCTION__ "(), dongle not found!\n");
+		ERROR("%s(), dongle not found!\n", __FUNCTION__);
 		return;
 	}
 }
@@ -586,11 +586,11 @@
 	struct if_irda_req req;
 	int ret;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(0, "%s()\n", __FUNCTION__);
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), set_raw_mode not impl. by "
-		      "device driver\n");
+		ERROR("%s(), set_raw_mode not impl. by device driver\n",
+		      __FUNCTION__);
 		return -1;
 	}
 	
--- linux-2.4.22-rc2/net/irda/irias_object.c	2001-10-04 22:41:09.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irias_object.c	2003-08-21 00:08:28.000000000 -0300
@@ -59,7 +59,7 @@
 	/* Allocate new string */
         new_str = kmalloc(len + 1, GFP_ATOMIC);
         if (new_str == NULL) {
-		WARNING(__FUNCTION__"(), Unable to kmalloc!\n");
+		WARNING("%s(), Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 
@@ -80,12 +80,12 @@
 {
         struct ias_object *obj;
 	
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	obj = (struct ias_object *) kmalloc(sizeof(struct ias_object), 
 					    GFP_ATOMIC);
 	if (obj == NULL) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unable to allocate object!\n");
+		IRDA_DEBUG(0, "%s(), Unable to allocate object!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(obj, 0, sizeof( struct ias_object));
@@ -272,7 +272,7 @@
 	/* Find object */
 	obj = hashbin_find(objects, 0, obj_name);
 	if (obj == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to find object: %s\n",
+		WARNING("%s(), Unable to find object: %s\n", __FUNCTION__,
 			obj_name);
 		return -1;
 	}
@@ -280,14 +280,14 @@
 	/* Find attribute */
 	attrib = hashbin_find(obj->attribs, 0, attrib_name);
 	if (attrib == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to find attribute: %s\n",
+		WARNING("%s(), Unable to find attribute: %s\n", __FUNCTION__,
 			attrib_name);
 		return -1;
 	}
 	
 	if ( attrib->value->type != new_value->type) {
-		IRDA_DEBUG( 0, __FUNCTION__ 
-		       "(), changing value type not allowed!\n");
+		IRDA_DEBUG(0, "%s(), changing value type not allowed!\n",
+			   __FUNCTION__);
 		return -1;
 	}
 
@@ -319,7 +319,7 @@
 	attrib = (struct ias_attrib *) kmalloc(sizeof(struct ias_attrib), 
 					       GFP_ATOMIC);
 	if (attrib == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to allocate attribute!\n");
+		WARNING("%s(), Unable to allocate attribute!\n", __FUNCTION__);
 		return;
 	}
 	memset(attrib, 0, sizeof( struct ias_attrib));
@@ -354,8 +354,7 @@
 	attrib = (struct ias_attrib *) kmalloc(sizeof(struct ias_attrib), 
 					       GFP_ATOMIC);
 	if (attrib == NULL) {
-		WARNING(__FUNCTION__ 
-			"(), Unable to allocate attribute!\n");
+		WARNING("%s(), Unable to allocate attribute!\n", __FUNCTION__);
 		return;
 	}
 	memset(attrib, 0, sizeof( struct ias_attrib));
@@ -388,7 +387,7 @@
 	attrib = (struct ias_attrib *) kmalloc(sizeof( struct ias_attrib), 
 					       GFP_ATOMIC);
 	if (attrib == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to allocate attribute!\n");
+		WARNING("%s(), Unable to allocate attribute!\n", __FUNCTION__);
 		return;
 	}
 	memset(attrib, 0, sizeof( struct ias_attrib));
@@ -413,7 +412,7 @@
 
 	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s(), Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(value, 0, sizeof(struct ias_value));
@@ -438,7 +437,7 @@
 
 	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s(), Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset( value, 0, sizeof( struct ias_value));
@@ -465,7 +464,7 @@
 
 	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s(), Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(value, 0, sizeof(struct ias_value));
@@ -478,7 +477,7 @@
 
 	value->t.oct_seq = kmalloc(len, GFP_ATOMIC);
 	if (value->t.oct_seq == NULL){
-		WARNING(__FUNCTION__"(), Unable to kmalloc!\n");
+		WARNING("%s(), Unable to kmalloc!\n", __FUNCTION__);
 		kfree(value);
 		return NULL;
 	}
@@ -492,7 +491,7 @@
 
 	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s(), Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(value, 0, sizeof(struct ias_value));
@@ -511,7 +510,7 @@
  */
 void irias_delete_value(struct ias_value *value)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(value != NULL, return;);
 
@@ -531,7 +530,7 @@
 			 kfree(value->t.oct_seq);
 		 break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown value type!\n");
+		IRDA_DEBUG(0, "%s(), Unknown value type!\n", __FUNCTION__);
 		break;
 	}
 	kfree(value);
--- linux-2.4.22-rc2/net/irda/irqueue.c	2001-07-04 15:50:38.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irqueue.c	2003-08-21 00:08:28.000000000 -0300
@@ -154,7 +154,7 @@
 	unsigned long flags = 0;
 	int bin;
 
-	IRDA_DEBUG( 4, __FUNCTION__"()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT( hashbin != NULL, return;);
 	ASSERT( hashbin->magic == HB_MAGIC, return;);
@@ -308,7 +308,7 @@
 	unsigned long flags = 0;
 	irda_queue_t* entry;
 
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT( hashbin != NULL, return NULL;);
 	ASSERT( hashbin->magic == HB_MAGIC, return NULL;);
@@ -407,7 +407,7 @@
 	int	bin;
 	__u32	hashv;
 
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT( hashbin != NULL, return NULL;);
 	ASSERT( hashbin->magic == HB_MAGIC, return NULL;);
@@ -553,7 +553,7 @@
  */
 static void __enqueue_last( irda_queue_t **queue, irda_queue_t* element)
 {
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/*
 	 * Check if queue is empty.
@@ -596,7 +596,7 @@
 void enqueue_first(irda_queue_t **queue, irda_queue_t* element)
 {
 	
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/*
 	 * Check if queue is empty.
--- linux-2.4.22-rc2/net/irda/irttp.c	2003-06-13 11:51:39.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/irttp.c	2003-08-21 00:08:28.000000000 -0300
@@ -94,7 +94,7 @@
 
 	irttp->tsaps = hashbin_new(HB_LOCAL);
 	if (!irttp->tsaps) {
-		ERROR(__FUNCTION__ "(), can't allocate IrTTP hashbin!\n");
+		ERROR("%s(), can't allocate IrTTP hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
 	
@@ -165,7 +165,7 @@
 	if (!self || self->magic != TTP_TSAP_MAGIC)
 		return;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(instance=%p)\n", self);
+	IRDA_DEBUG(4, "%s(instance=%p)\n", __FUNCTION__, self);
 
 	/* Try to make some progress, especially on Tx side - Jean II */
 	irttp_run_rx_queue(self);
@@ -206,7 +206,7 @@
 {
 	struct sk_buff* skb;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
@@ -239,7 +239,7 @@
       	ASSERT(self != NULL, return NULL;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return NULL;);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), self->rx_sdu_size=%d\n", 
+	IRDA_DEBUG(2, "%s(), self->rx_sdu_size=%d\n", __FUNCTION__, 
 		   self->rx_sdu_size);
 
 	skb = dev_alloc_skb(TTP_HEADER + self->rx_sdu_size);
@@ -262,9 +262,9 @@
 		
 		dev_kfree_skb(frag);
 	}
-	IRDA_DEBUG(2, __FUNCTION__ "(), frame len=%d\n", n);
+	IRDA_DEBUG(2, "%s(), frame len=%d\n", __FUNCTION__, n);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), rx_sdu_size=%d\n", self->rx_sdu_size);
+	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n", __FUNCTION__, self->rx_sdu_size);
 	ASSERT(n <= self->rx_sdu_size, return NULL;);
 
 	/* Set the new length */
@@ -287,7 +287,7 @@
 	struct sk_buff *frag;
 	__u8 *frame;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
@@ -297,7 +297,7 @@
 	 *  Split frame into a number of segments
 	 */
 	while (skb->len > self->max_seg_size) {
-		IRDA_DEBUG(2, __FUNCTION__  "(), fragmenting ...\n");
+		IRDA_DEBUG(2, "%s(), fragmenting ...\n", __FUNCTION__);
 
 		/* Make new segment */
 		frag = dev_alloc_skb(self->max_seg_size+self->max_header_size);
@@ -321,7 +321,7 @@
 		skb_queue_tail(&self->tx_queue, frag);
 	}
 	/* Queue what is left of the original skb */
-	IRDA_DEBUG(2, __FUNCTION__  "(), queuing last segment\n");
+	IRDA_DEBUG(2, "%s(), queuing last segment\n", __FUNCTION__);
 	
 	frame = skb_push(skb, TTP_HEADER);
 	frame[0] = 0x00; /* Clear more bit */
@@ -352,7 +352,7 @@
 	else
 		self->tx_max_sdu_size = param->pv.i;
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), MaxSduSize=%d\n", param->pv.i);
+	IRDA_DEBUG(1, "%s(), MaxSduSize=%d\n", __FUNCTION__, param->pv.i);
 	
 	return 0;
 }
@@ -380,13 +380,13 @@
 	 * JeanII */
 	if((stsap_sel != LSAP_ANY) &&
 	   ((stsap_sel < 0x01) || (stsap_sel >= 0x70))) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), invalid tsap!\n");
+		IRDA_DEBUG(0, "%s(), invalid tsap!\n", __FUNCTION__);
 		return NULL;
 	}
 
 	self = kmalloc(sizeof(struct tsap_cb), GFP_ATOMIC);
 	if (self == NULL) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), unable to kmalloc!\n");
+		IRDA_DEBUG(0, "%s(), unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(self, 0, sizeof(struct tsap_cb));
@@ -421,7 +421,7 @@
 	 */
 	lsap = irlmp_open_lsap(stsap_sel, &ttp_notify, 0);
 	if (lsap == NULL) {
-		WARNING(__FUNCTION__ "(), unable to allocate LSAP!!\n");
+		WARNING("%s(), unable to allocate LSAP!!\n", __FUNCTION__);
 		return NULL;
 	}
 	
@@ -431,7 +431,7 @@
 	 *  the stsap_sel we have might not be valid anymore
 	 */
 	self->stsap_sel = lsap->slsap_sel;
-	IRDA_DEBUG(4, __FUNCTION__ "(), stsap_sel=%02x\n", self->stsap_sel);
+	IRDA_DEBUG(4, "%s(), stsap_sel=%02x\n", __FUNCTION__, self->stsap_sel);
 
 	self->notify = *notify;
 	self->lsap = lsap;
@@ -488,7 +488,7 @@
 {
 	struct tsap_cb *tsap;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
@@ -497,7 +497,7 @@
 	if (self->connected) {
 		/* Check if disconnect is not pending */
 		if (!test_bit(0, &self->disconnect_pend)) {
-			WARNING(__FUNCTION__ "(), TSAP still connected!\n");
+			WARNING("%s(), TSAP still connected!\n", __FUNCTION__);
 			irttp_disconnect_request(self, NULL, P_NORMAL);
 		}
 		self->close_pend = TRUE;
@@ -533,16 +533,16 @@
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
 	ASSERT(skb != NULL, return -1;);
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	/* Check that nothing bad happens */
 	if ((skb->len == 0) || (!self->connected)) {
-		IRDA_DEBUG(1, __FUNCTION__ "(), No data, or not connected\n");
+		IRDA_DEBUG(1, "%s(), No data, or not connected\n", __FUNCTION__);
 		return -1;
 	}
 	
 	if (skb->len > self->max_seg_size) {
-		IRDA_DEBUG(1, __FUNCTION__ "(), UData is to large for IrLAP!\n");
+		IRDA_DEBUG(1, "%s(), UData is to large for IrLAP!\n", __FUNCTION__);
 		return -1;
 	}
 		    
@@ -566,12 +566,12 @@
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
 	ASSERT(skb != NULL, return -1;);
 
-	IRDA_DEBUG(2, __FUNCTION__ " : queue len = %d\n",
+	IRDA_DEBUG(2, "%s : queue len = %d\n", __FUNCTION__,
 		   skb_queue_len(&self->tx_queue));
 
 	/* Check that nothing bad happens */
 	if ((skb->len == 0) || (!self->connected)) {
-		WARNING(__FUNCTION__ "(), No data, or not connected\n");
+		WARNING("%s(), No data, or not connected\n", __FUNCTION__);
 		return -ENOTCONN;
 	}
 
@@ -580,8 +580,8 @@
 	 *  inside an IrLAP frame
 	 */
 	if ((self->tx_max_sdu_size == 0) && (skb->len > self->max_seg_size)) {
-		ERROR(__FUNCTION__ 
-		      "(), SAR disabled, and data is to large for IrLAP!\n");
+		ERROR("%s(), SAR disabled, and data is to large for IrLAP!\n",
+		      __FUNCTION__);
 		return -EMSGSIZE;
 	}
 
@@ -593,8 +593,8 @@
 	    (self->tx_max_sdu_size != TTP_SAR_UNBOUND) && 
 	    (skb->len > self->tx_max_sdu_size))
 	{
-		ERROR(__FUNCTION__ "(), SAR enabled, "
-		      "but data is larger than TxMaxSduSize!\n");
+		ERROR("%s(), SAR enabled, but data is larger "
+		      "than TxMaxSduSize!\n", __FUNCTION__);
 		return -EMSGSIZE;
 	}
 	/* 
@@ -665,7 +665,7 @@
 	unsigned long flags;
 	int n;
 
-	IRDA_DEBUG(2, __FUNCTION__ "() : send_credit = %d, queue_len = %d\n",
+	IRDA_DEBUG(2, "%s() : send_credit = %d, queue_len = %d\n", __FUNCTION__,
 		   self->send_credit, skb_queue_len(&self->tx_queue));
 
 	/* Get exclusive access to the tx queue, otherwise don't touch it */
@@ -773,7 +773,7 @@
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);	
 
-	IRDA_DEBUG(4, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n", 
+	IRDA_DEBUG(4, "%s() send=%d,avail=%d,remote=%d\n", __FUNCTION__, 
 		   self->send_credit, self->avail_credit, self->remote_credit);
 
 	/* Give credit to peer */
@@ -821,7 +821,7 @@
 {
 	struct tsap_cb *self;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	self = (struct tsap_cb *) instance;
 
@@ -933,7 +933,7 @@
 {
 	struct tsap_cb *self;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	self = (struct tsap_cb *) instance;
 	
@@ -947,7 +947,7 @@
 		self->notify.status_indication(self->notify.instance, 
 					       link, lock);
 	else
-		IRDA_DEBUG(2, __FUNCTION__ "(), no handler\n");
+		IRDA_DEBUG(2, "%s(), no handler\n", __FUNCTION__);
 }
 
 /*
@@ -965,7 +965,7 @@
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(instance=%p)\n", self);
+	IRDA_DEBUG(4, "%s(instance=%p)\n", __FUNCTION__, self);
 
 	/* We are "polled" directly from LAP, and the LAP want to fill
 	 * its Tx window. We want to do our best to send it data, so that
@@ -1003,18 +1003,18 @@
  */
 void irttp_flow_request(struct tsap_cb *self, LOCAL_FLOW flow)
 {
-	IRDA_DEBUG(1, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
 
 	switch (flow) {
 	case FLOW_STOP:
-		IRDA_DEBUG(1, __FUNCTION__ "(), flow stop\n");
+		IRDA_DEBUG(1, "%s(), flow stop\n", __FUNCTION__);
 		self->rx_sdu_busy = TRUE;
 		break;
 	case FLOW_START:
-		IRDA_DEBUG(1, __FUNCTION__ "(), flow start\n");
+		IRDA_DEBUG(1, "%s(), flow start\n", __FUNCTION__);
 		self->rx_sdu_busy = FALSE;
 		
 		/* Client say he can accept more data, try to free our
@@ -1023,7 +1023,7 @@
 
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown flow command!\n");
+		IRDA_DEBUG(1, "%s(), Unknown flow command!\n", __FUNCTION__);
 	}
 }
 	
@@ -1042,7 +1042,7 @@
 	__u8 *frame;
 	__u8 n;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), max_sdu_size=%d\n", max_sdu_size); 
+	IRDA_DEBUG(4, "%s(), max_sdu_size=%d\n", __FUNCTION__, max_sdu_size); 
 	
 	ASSERT(self != NULL, return -EBADR;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -EBADR;);
@@ -1134,7 +1134,7 @@
 	__u8 plen;
 	__u8 n;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 	
 	self = (struct tsap_cb *) instance;
 
@@ -1158,7 +1158,7 @@
 
 	n = skb->data[0] & 0x7f;
 	
-	IRDA_DEBUG(4, __FUNCTION__ "(), Initial send_credit=%d\n", n);
+	IRDA_DEBUG(4, "%s(), Initial send_credit=%d\n", __FUNCTION__, n);
 	
 	self->send_credit = n;
 	self->tx_max_sdu_size = 0;
@@ -1178,8 +1178,8 @@
 
 		/* Any errors in the parameter list? */
 		if (ret < 0) {
-			WARNING(__FUNCTION__ 
-				"(), error extracting parameters\n");
+			WARNING("%s(), error extracting parameters\n",
+				__FUNCTION__);
 			dev_kfree_skb(skb);
 
 			/* Do not accept this connection attempt */
@@ -1189,10 +1189,10 @@
 		skb_pull(skb, IRDA_MIN(skb->len, plen+1));
 	}
 	
-	IRDA_DEBUG(4, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n", 
+	IRDA_DEBUG(4, "%s() send=%d,avail=%d,remote=%d\n", __FUNCTION__, 
 	      self->send_credit, self->avail_credit, self->remote_credit);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), MaxSduSize=%d\n", self->tx_max_sdu_size);
+	IRDA_DEBUG(2, "%s(), MaxSduSize=%d\n", __FUNCTION__, self->tx_max_sdu_size);
 
 	if (self->notify.connect_confirm) {
 		self->notify.connect_confirm(self->notify.instance, self, qos,
@@ -1229,7 +1229,7 @@
 	self->max_seg_size = max_seg_size - TTP_HEADER;;
 	self->max_header_size = max_header_size+TTP_HEADER;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), TSAP sel=%02x\n", self->stsap_sel);
+	IRDA_DEBUG(4, "%s(), TSAP sel=%02x\n", __FUNCTION__, self->stsap_sel);
 
 	/* Need to update dtsap_sel if its equal to LSAP_ANY */
 	self->dtsap_sel = lsap->dlsap_sel;
@@ -1253,8 +1253,8 @@
 
 		/* Any errors in the parameter list? */
 		if (ret < 0) {
-			WARNING(__FUNCTION__ 
-				"(), error extracting parameters\n");
+			WARNING("%s(), error extracting parameters\n",
+				__FUNCTION__);
 			dev_kfree_skb(skb);
 			
 			/* Do not accept this connection attempt */
@@ -1291,7 +1291,7 @@
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return -1;);
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), Source TSAP selector=%02x\n", 
+	IRDA_DEBUG(4, "%s(), Source TSAP selector=%02x\n", __FUNCTION__, 
 		   self->stsap_sel);
 	
 	/* Any userdata supplied? */
@@ -1369,15 +1369,15 @@
 {
 	struct tsap_cb *new;
 
-	IRDA_DEBUG(1, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
 	if (!hashbin_find(irttp->tsaps, (int) orig, NULL)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), unable to find TSAP\n");
+		IRDA_DEBUG(0, "%s(), unable to find TSAP\n", __FUNCTION__);
 		return NULL;
 	}
 	new = kmalloc(sizeof(struct tsap_cb), GFP_ATOMIC);
 	if (!new) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), unable to kmalloc\n");
+		IRDA_DEBUG(0, "%s(), unable to kmalloc\n", __FUNCTION__);
 		return NULL;
 	}
 	/* Dup */
@@ -1415,7 +1415,7 @@
 
 	/* Already disconnected? */
 	if (!self->connected) {
-		IRDA_DEBUG(4, __FUNCTION__ "(), already disconnected!\n");
+		IRDA_DEBUG(4, "%s(), already disconnected!\n", __FUNCTION__);
 		if (userdata)
 			dev_kfree_skb(userdata);
 		return -1;
@@ -1427,7 +1427,7 @@
 	 * for following a disconnect_indication() (i.e. net_bh).
 	 * Jean II */
 	if(test_and_set_bit(0, &self->disconnect_pend)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), disconnect already pending\n");
+		IRDA_DEBUG(0, "%s(), disconnect already pending\n", __FUNCTION__);
 		if (userdata)
 			dev_kfree_skb(userdata);
 
@@ -1446,7 +1446,7 @@
 			 *  disconnecting right now since the data will
 			 *  not have any usable connection to be sent on
 			 */
-			IRDA_DEBUG(1, __FUNCTION__  "High priority!!()\n" );
+			IRDA_DEBUG(1, "%s(): High priority!!()\n", __FUNCTION__);
 			irttp_flush_queues(self);
 		} else if (priority == P_NORMAL) {
 			/* 
@@ -1467,7 +1467,7 @@
 	 * be sent at the LMP level (so even if the peer has its Tx queue
 	 * full of data). - Jean II */
 
-	IRDA_DEBUG(1, __FUNCTION__ "(), Disconnecting ...\n");
+	IRDA_DEBUG(1, "%s(), Disconnecting ...\n", __FUNCTION__);
 	self->connected = FALSE;
 
 	if (!userdata) {
@@ -1501,7 +1501,7 @@
 {
 	struct tsap_cb *self;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	self = (struct tsap_cb *) instance;
 	
@@ -1561,7 +1561,7 @@
 	 * give an error back 
 	 */
 	if (err == -ENOMEM) {
-		IRDA_DEBUG(0, __FUNCTION__ "() requeueing skb!\n");
+		IRDA_DEBUG(0, "%s() requeueing skb!\n", __FUNCTION__);
 
 		/* Make sure we take a break */
 		self->rx_sdu_busy = TRUE;
@@ -1586,7 +1586,7 @@
 	struct sk_buff *skb;
 	int more = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "() send=%d,avail=%d,remote=%d\n", 
+	IRDA_DEBUG(2, "%s() send=%d,avail=%d,remote=%d\n", __FUNCTION__, 
 		   self->send_credit, self->avail_credit, self->remote_credit);
 
 	/* Get exclusive access to the rx queue, otherwise don't touch it */
@@ -1626,7 +1626,7 @@
 			 *  limits of the maximum size of the rx_sdu
 			 */
 			if (self->rx_sdu_size <= self->rx_max_sdu_size) {
-				IRDA_DEBUG(4, __FUNCTION__ "(), queueing frag\n");
+				IRDA_DEBUG(4, "%s(), queueing frag\n", __FUNCTION__);
 				skb_queue_tail(&self->rx_fragments, skb);
 			} else {
 				/* Free the part of the SDU that is too big */
@@ -1656,7 +1656,7 @@
 			/* Now we can deliver the reassembled skb */
 			irttp_do_data_indication(self, skb);
 		} else {
-			IRDA_DEBUG(1, __FUNCTION__ "(), Truncated frame\n");
+			IRDA_DEBUG(1, "%s(), Truncated frame\n", __FUNCTION__);
 			
 			/* Free the part of the SDU that is too big */
 			dev_kfree_skb(skb);
--- linux-2.4.22-rc2/net/irda/parameters.c	2003-08-21 00:05:17.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/parameters.c	2003-08-21 00:08:28.000000000 -0300
@@ -150,22 +150,22 @@
 	 */
 	if (p.pl == 0) {
 		if (p.pv.i < 0xff) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), using 1 byte\n");
+			IRDA_DEBUG(2, "%s(), using 1 byte\n", __FUNCTION__);
 			p.pl = 1;
 		} else if (p.pv.i < 0xffff) {
-			IRDA_DEBUG(2, __FUNCTION__ "(), using 2 bytes\n");
+			IRDA_DEBUG(2, "%s(), using 2 bytes\n", __FUNCTION__);
 			p.pl = 2;
 		} else {
-			IRDA_DEBUG(2, __FUNCTION__ "(), using 4 bytes\n");
+			IRDA_DEBUG(2, "%s(), using 4 bytes\n", __FUNCTION__);
 			p.pl = 4; /* Default length */
 		}
 	}
 	/* Check if buffer is long enough for insertion */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for insertion!\n");
+		WARNING("%s(), buffer to short for insertion!\n", __FUNCTION__);
 		return -1;
 	}
-	IRDA_DEBUG(2, __FUNCTION__ "(), pi=%#x, pl=%d, pi=%d\n", p.pi, p.pl, p.pv.i);
+	IRDA_DEBUG(2, "%s(), pi=%#x, pl=%d, pi=%d\n", __FUNCTION__, p.pi, p.pl, p.pv.i);
 	switch (p.pl) {
 	case 1:
 		n += irda_param_pack(buf, "bbb", p.pi, p.pl, (__u8) p.pv.i);
@@ -186,7 +186,7 @@
 
 		break;
 	default:
-		WARNING(__FUNCTION__ "() length %d not supported\n", p.pl);
+		WARNING("%s() length %d not supported\n", __FUNCTION__, p.pl);
 		/* Skip parameter */ 
 		return -1;
 	}
@@ -215,8 +215,8 @@
 
 	/* Check if buffer is long enough for parsing */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for parsing! "
-			"Need %d bytes, but len is only %d\n", p.pl, len);
+		WARNING("%s(), buffer to short for parsing! Need %d bytes, "
+			"but len is only %d\n", __FUNCTION__, p.pl, len);
 		return -1;
 	}
 
@@ -226,8 +226,8 @@
 	 * PV_INTEGER means that the handler is flexible.
 	 */
 	if (((type & PV_MASK) != PV_INTEGER) && ((type & PV_MASK) != p.pl)) {
-		ERROR(__FUNCTION__ "(), invalid parameter length! "
-		      "Expected %d bytes, but value had %d bytes!\n",
+		ERROR("%s(), invalid parameter length! Expected %d bytes, "
+		      "but value had %d bytes!\n", __FUNCTION__,
 		      type & PV_MASK, p.pl);
 		
 		/* Most parameters are bit/byte fields or little endian,
@@ -265,13 +265,13 @@
 			le32_to_cpus(&p.pv.i);
 		break;
 	default:
-		WARNING(__FUNCTION__ "() length %d not supported\n", p.pl);
+		WARNING("%s() length %d not supported\n", __FUNCTION__, p.pl);
 
 		/* Skip parameter */ 
 		return p.pl+2;
 	}
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), pi=%#x, pl=%d, pi=%d\n", p.pi, p.pl, p.pv.i);
+	IRDA_DEBUG(2, "%s(), pi=%#x, pl=%d, pi=%d\n", __FUNCTION__, p.pi, p.pl, p.pv.i);
 	/* Call handler for this parameter */
 	err = (*func)(self, &p, PV_PUT);
 	if (err < 0)
@@ -293,17 +293,17 @@
 	irda_param_t p;
 	int err;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	p.pi = pi;     /* In case handler needs to know */
 	p.pl = buf[1]; /* Extract lenght of value */
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), pi=%#x, pl=%d\n", p.pi, p.pl);
+	IRDA_DEBUG(2, "%s(), pi=%#x, pl=%d\n", __FUNCTION__, p.pi, p.pl);
 
 	/* Check if buffer is long enough for parsing */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for parsing! "
-			"Need %d bytes, but len is only %d\n", p.pl, len);
+		WARNING("%s(), buffer to short for parsing! Need %d bytes, "
+			"but len is only %d\n", __FUNCTION__, p.pl, len);
 		return -1;
 	}
 
@@ -311,7 +311,7 @@
 	 * checked that the buffer is long enough */
 	strncpy(str, buf+2, p.pl);
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), str=0x%02x 0x%02x\n", (__u8) str[0], 
+	IRDA_DEBUG(2, "%s(), str=0x%02x 0x%02x\n", __FUNCTION__, (__u8) str[0], 
 	      (__u8) str[1]);
 	
 	/* Null terminate string */
@@ -343,12 +343,12 @@
 
 	/* Check if buffer is long enough for parsing */
 	if (len < (2+p.pl)) {
-		WARNING(__FUNCTION__ "(), buffer to short for parsing! "
-			"Need %d bytes, but len is only %d\n", p.pl, len);
+		WARNING("%s(), buffer to short for parsing! Need %d bytes, "
+			"but len is only %d\n", __FUNCTION__, p.pl, len);
 		return -1;
 	}
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), not impl\n");
+	IRDA_DEBUG(0, "%s(), not impl\n", __FUNCTION__);
 	
 	return p.pl+2; /* Extracted pl+2 bytes */
 }
@@ -474,8 +474,8 @@
 	if ((pi_major > info->len-1) || 
 	    (pi_minor > info->tables[pi_major].len-1))
 	{
-		IRDA_DEBUG(0, __FUNCTION__ 
-		      "(), no handler for parameter=0x%02x\n", pi);
+		IRDA_DEBUG(0, "%s(), no handler for parameter=0x%02x\n",
+			   __FUNCTION__, pi);
 		
 		/* Skip this parameter */
 		return -1;
@@ -489,7 +489,7 @@
 
 	/*  Check if handler has been implemented */
 	if (!pi_minor_info->func) {
-		MESSAGE(__FUNCTION__"(), no handler for pi=%#x\n", pi);
+		MESSAGE("%s(), no handler for pi=%#x\n", __FUNCTION__, pi);
 		/* Skip this parameter */
 		return -1;
 	}
@@ -526,8 +526,8 @@
 	if ((pi_major > info->len-1) || 
 	    (pi_minor > info->tables[pi_major].len-1))
 	{
-		IRDA_DEBUG(0, __FUNCTION__ "(), no handler for parameter=0x%02x\n",
-		      buf[0]);
+		IRDA_DEBUG(0, "%s(), no handler for parameter=0x%02x\n",
+		      __FUNCTION__, buf[0]);
 		
 		/* Skip this parameter */
 		return 2 + buf[n + 1];  /* Continue */
@@ -539,12 +539,12 @@
 	/* Find expected data type for this parameter identifier (pi)*/
 	type = pi_minor_info->type;
 	
-	IRDA_DEBUG(3, __FUNCTION__ "(), pi=[%d,%d], type=%d\n",
+	IRDA_DEBUG(3, "%s(), pi=[%d,%d], type=%d\n", __FUNCTION__,
 	      pi_major, pi_minor, type);
 	
 	/*  Check if handler has been implemented */
 	if (!pi_minor_info->func) {
-		MESSAGE(__FUNCTION__"(), no handler for pi=%#x\n", buf[n]);
+		MESSAGE("%s(), no handler for pi=%#x\n", __FUNCTION__, buf[n]);
 		/* Skip this parameter */
 		return 2 + buf[n + 1]; /* Continue */
 	}
--- linux-2.4.22-rc2/net/irda/qos.c	2003-08-21 00:05:17.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/qos.c	2003-08-21 00:08:28.000000000 -0300
@@ -348,7 +348,7 @@
 	__u32 line_capacity;
 	int index;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/*
 	 * Make sure the mintt is sensible.
@@ -374,9 +374,8 @@
 	if ((qos->baud_rate.value < 115200) && 
 	    (qos->max_turn_time.value < 500))
 	{
-		IRDA_DEBUG(0, __FUNCTION__ 
-			   "(), adjusting max turn time from %d to 500 ms\n",
-			   qos->max_turn_time.value);
+		IRDA_DEBUG(0, "%s(), adjusting max turn time from %d to 500 ms\n",
+			   __FUNCTION__, qos->max_turn_time.value);
 		qos->max_turn_time.value = 500;
 	}
 	
@@ -391,8 +390,7 @@
 #ifdef CONFIG_IRDA_DYNAMIC_WINDOW
 	while ((qos->data_size.value > line_capacity) && (index > 0)) {
 		qos->data_size.value = data_sizes[index--];
-		IRDA_DEBUG(2, __FUNCTION__ 
-			   "(), reducing data size to %d\n",
+		IRDA_DEBUG(2, "%s(), reducing data size to %d\n", __FUNCTION__,
 			   qos->data_size.value);
 	}
 #else /* Use method described in section 6.6.11 of IrLAP */
@@ -402,16 +400,14 @@
 		/* Must be able to send at least one frame */
 		if (qos->window_size.value > 1) {
 			qos->window_size.value--;
-			IRDA_DEBUG(2, __FUNCTION__ 
-				   "(), reducing window size to %d\n",
-				   qos->window_size.value);
+			IRDA_DEBUG(2, "%s(), reducing window size to %d\n",
+				   __FUNCTION__, qos->window_size.value);
 		} else if (index > 1) {
 			qos->data_size.value = data_sizes[index--];
-			IRDA_DEBUG(2, __FUNCTION__ 
-				   "(), reducing data size to %d\n",
-				   qos->data_size.value);
+			IRDA_DEBUG(2, "%s(), reducing data size to %d\n",
+				   __FUNCTION__, qos->data_size.value);
 		} else {
-			WARNING(__FUNCTION__ "(), nothing more we can do!\n");
+			WARNING("%s(), nothing more we can do!\n", __FUNCTION__);
 		}
 	}
 #endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
@@ -545,7 +541,7 @@
 
 	if (get) {
 		param->pv.i = self->qos_rx.baud_rate.bits;
-		IRDA_DEBUG(2, __FUNCTION__ "(), baud rate = 0x%02x\n", 
+		IRDA_DEBUG(2, "%s(), baud rate = 0x%02x\n", __FUNCTION__, 
 			   param->pv.i);		
 	} else {
 		/* 
@@ -718,7 +714,7 @@
 	__u32 line_capacity;
 	int i,j;
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), speed=%d, max_turn_time=%d\n",
+	IRDA_DEBUG(2, "%s(), speed=%d, max_turn_time=%d\n", __FUNCTION__,
 		   speed, max_turn_time);
 
 	i = value_index(speed, baud_rates, 10);
@@ -729,7 +725,7 @@
 
 	line_capacity = max_line_capacities[i][j];
 
-	IRDA_DEBUG(2, __FUNCTION__ "(), line capacity=%d bytes\n", 
+	IRDA_DEBUG(2, "%s(), line capacity=%d bytes\n", __FUNCTION__, 
 		   line_capacity);
 	
 	return line_capacity;
@@ -743,7 +739,7 @@
 		irlap_min_turn_time_in_bytes(qos->baud_rate.value, 
 					     qos->min_turn_time.value);
 	
-	IRDA_DEBUG(2, __FUNCTION__ "(), requested line capacity=%d\n",
+	IRDA_DEBUG(2, "%s(), requested line capacity=%d\n", __FUNCTION__,
 		   line_capacity);
 	
 	return line_capacity;			       		  
--- linux-2.4.22-rc2/net/irda/wrapper.c	2001-04-30 20:26:09.000000000 -0300
+++ linux-2.4.22-rc2-fix/net/irda/wrapper.c	2003-08-21 00:08:28.000000000 -0300
@@ -93,16 +93,16 @@
 		 * Nothing to worry about, but we set the default number of 
 		 * BOF's
 		 */
-		IRDA_DEBUG(1, __FUNCTION__ "(), wrong magic in skb!\n");
+		IRDA_DEBUG(1, "%s(), wrong magic in skb!\n", __FUNCTION__);
 		xbofs = 10;
 	} else
 		xbofs = cb->xbofs + cb->xbofs_delay;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), xbofs=%d\n", xbofs);
+	IRDA_DEBUG(4, "%s(), xbofs=%d\n", __FUNCTION__, xbofs);
 
 	/* Check that we never use more than 115 + 48 xbofs */
 	if (xbofs > 163) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), too many xbofs (%d)\n", xbofs);
+		IRDA_DEBUG(0, "%s(), too many xbofs (%d)\n", __FUNCTION__, xbofs);
 		xbofs = 163;
 	}
 
@@ -265,7 +265,7 @@
 	case EOF:
 		/* Abort frame */
 		rx_buff->state = OUTSIDE_FRAME;
-		IRDA_DEBUG(1, __FUNCTION__ "(), abort frame\n");
+		IRDA_DEBUG(1, "%s(), abort frame\n", __FUNCTION__);
 		stats->rx_errors++;
 		stats->rx_frame_errors++;
 		break;
@@ -289,13 +289,13 @@
 {
 	switch (byte) {
 	case BOF: /* New frame? */
-		IRDA_DEBUG(1, __FUNCTION__ 
-			   "(), Discarding incomplete frame\n");
+		IRDA_DEBUG(1, "%s(), Discarding incomplete frame\n",
+			   __FUNCTION__);
 		rx_buff->state = BEGIN_FRAME;
 		irda_device_set_media_busy(dev, TRUE);
 		break;
 	case CE:
-		WARNING(__FUNCTION__ "(), state not defined\n");
+		WARNING("%s(), state not defined\n", __FUNCTION__);
 		break;
 	case EOF: /* Abort frame */
 		rx_buff->state = OUTSIDE_FRAME;
@@ -311,7 +311,7 @@
 			rx_buff->fcs = irda_fcs(rx_buff->fcs, byte);
 			rx_buff->state = INSIDE_FRAME;
 		} else {
-			IRDA_DEBUG(1, __FUNCTION__ "(), rx buffer overflow\n");
+			IRDA_DEBUG(1, "%s(), rx buffer overflow\n", __FUNCTION__);
 			rx_buff->state = OUTSIDE_FRAME;
 		}
 		break;
@@ -332,8 +332,7 @@
 
 	switch (byte) {
 	case BOF: /* New frame? */
-		IRDA_DEBUG(1, __FUNCTION__ 
-			   "(), Discarding incomplete frame\n");
+		IRDA_DEBUG(1, "%s(), Discarding incomplete frame\n", __FUNCTION__);
 		rx_buff->state = BEGIN_FRAME;
 		irda_device_set_media_busy(dev, TRUE);
 		break;
@@ -354,7 +353,7 @@
 			/* Wrong CRC, discard frame!  */
 			irda_device_set_media_busy(dev, TRUE); 
 
-			IRDA_DEBUG(1, __FUNCTION__ "(), crc error\n");
+			IRDA_DEBUG(1, "%s(), crc error\n", __FUNCTION__);
 			stats->rx_errors++;
 			stats->rx_crc_errors++;
 		}			
@@ -364,8 +363,8 @@
 			rx_buff->data[rx_buff->len++] = byte;
 			rx_buff->fcs = irda_fcs(rx_buff->fcs, byte);
 		} else {
-			IRDA_DEBUG(1, __FUNCTION__ 
-			      "(), Rx buffer overflow, aborting\n");
+			IRDA_DEBUG(1, "%s(), Rx buffer overflow, aborting\n",
+				   __FUNCTION__);
 			rx_buff->state = OUTSIDE_FRAME;
 		}
 		break;

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
