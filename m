Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTHVMkC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbTHVMiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:38:23 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:6293 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263154AbTHVLzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:55:08 -0400
Date: Fri, 22 Aug 2003 04:08:42 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH][resend] 5/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/net/irda
Message-Id: <20030822040842.1f65d690.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 act200l.c  |   14 +++++++-------
 irda-usb.c |    4 ++--
 ma600.c    |   28 ++++++++++++++--------------
 mcp2120.c  |    6 +++---
 nsc-ircc.c |    2 +-
 5 files changed, 27 insertions(+), 27 deletions(-)

--- linux-2.4.22-rc2/drivers/net/irda/act200l.c	2002-11-28 20:53:13.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/net/irda/act200l.c	2003-08-21 00:08:28.000000000 -0300
@@ -106,7 +106,7 @@
 
 static void act200l_open(dongle_t *self, struct qos_info *qos)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Power on the dongle */
 	self->set_dtr_rts(self->dev, TRUE, TRUE);
@@ -120,7 +120,7 @@
 
 static void act200l_close(dongle_t *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Power off the dongle */
 	self->set_dtr_rts(self->dev, FALSE, FALSE);
@@ -141,7 +141,7 @@
 	__u8 control[3];
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self->speed_task = task;
 
@@ -158,7 +158,7 @@
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
-		WARNING(__FUNCTION__ "(), resetting dongle timed out!\n");
+		WARNING("%s(), resetting dongle timed out!\n", __FUNCTION__);
 		ret = -1;
 		break;
 	case IRDA_TASK_CHILD_DONE:
@@ -203,7 +203,7 @@
 		self->speed_task = NULL;
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		self->speed_task = NULL;
 		ret = -1;
@@ -233,7 +233,7 @@
 	};
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self->reset_task = task;
 
@@ -269,7 +269,7 @@
 		self->reset_task = NULL;
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		self->reset_task = NULL;
 		ret = -1;
--- linux-2.4.22-rc2/drivers/net/irda/irda-usb.c	2003-08-21 00:05:01.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/net/irda/irda-usb.c	2003-08-21 00:08:28.000000000 -0300
@@ -339,7 +339,7 @@
 	int res, mtt;
 	int	err = 1;	/* Failed */
 
-	IRDA_DEBUG(4, __FUNCTION__ "() on %s\n", netdev->name);
+	IRDA_DEBUG(4, "%s() on %s\n",  __FUNCTION__, netdev->name);
 
 	netif_stop_queue(netdev);
 
@@ -542,7 +542,7 @@
 		    (self->new_xbofs != self->xbofs)) {
 			/* We haven't changed speed yet (because of
 			 * IUC_SPEED_BUG), so do it now - Jean II */
-			IRDA_DEBUG(1, __FUNCTION__ "(), Changing speed now...\n");
+			IRDA_DEBUG(1, "%s(), Changing speed now...\n", __FUNCTION__);
 			irda_usb_change_speed_xbofs(self);
 		} else {
 			/* New speed and xbof is now commited in hardware */
--- linux-2.4.22-rc2/drivers/net/irda/ma600.c	2003-08-21 00:05:01.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/net/irda/ma600.c	2003-08-21 00:08:28.000000000 -0300
@@ -48,7 +48,7 @@
 	#undef IRDA_DEBUG
 	#define IRDA_DEBUG(n, args...) (printk(KERN_DEBUG args))
 
-	#undef ASSERT(expr, func)
+	#undef ASSERT
 	#define ASSERT(expr, func) \
 	if(!(expr)) { \
 		printk( "Assertion failed! %s,%s,%s,line=%d\n",\
@@ -86,13 +86,13 @@
 
 int __init ma600_init(void)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	return irda_device_register_dongle(&dongle);
 }
 
 void __exit ma600_cleanup(void)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 	irda_device_unregister_dongle(&dongle);
 }
 
@@ -105,7 +105,7 @@
 */
 static void ma600_open(dongle_t *self, struct qos_info *qos)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	qos->baud_rate.bits &= IR_2400|IR_9600|IR_19200|IR_38400
 				|IR_57600|IR_115200;
@@ -123,7 +123,7 @@
 
 static void ma600_close(dongle_t *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Power off dongle */
 	self->set_dtr_rts(self->dev, FALSE, FALSE);
@@ -184,12 +184,12 @@
 	__u8 byte_echo;
 	int ret = 0;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(task != NULL, return -1;);
 
 	if (self->speed_task && self->speed_task != task) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), busy!\n");
+		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
 		return MSECS_TO_JIFFIES(10);
 	} else {
 		self->speed_task = task;
@@ -215,7 +215,7 @@
 		break;
 
 	case IRDA_TASK_CHILD_WAIT:
-		WARNING(__FUNCTION__ "(), resetting dongle timed out!\n");
+		WARNING("%s(), resetting dongle timed out!\n", __FUNCTION__);
 		ret = -1;
 		break;
 
@@ -246,7 +246,7 @@
 
 		if(byte != byte_echo) {
 			/* if control byte != echo, I don't know what to do */
-			printk(KERN_WARNING __FUNCTION__ "() control byte written != read!\n");
+			printk(KERN_WARNING "%s() control byte written != read!\n", __FUNCTION__);
 			printk(KERN_WARNING "control byte = 0x%c%c\n", 
 			       hexTbl[(byte>>4)&0x0f], hexTbl[byte&0x0f]);
 			printk(KERN_WARNING "byte echo = 0x%c%c\n", 
@@ -254,7 +254,7 @@
 			       hexTbl[byte_echo & 0x0f]);
 		#ifndef NDEBUG
 		} else {
-			IRDA_DEBUG(2, __FUNCTION__ "() control byte write read OK\n");
+			IRDA_DEBUG(2, "%s() control byte write read OK\n", __FUNCTION__);
 		#endif
 		}
 
@@ -273,7 +273,7 @@
 		break;
 
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		self->speed_task = NULL;
 		ret = -1;
@@ -298,12 +298,12 @@
 	dongle_t *self = (dongle_t *) task->instance;
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n",  __FUNCTION__);
 
 	ASSERT(task != NULL, return -1;);
 
 	if (self->reset_task && self->reset_task != task) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), busy!\n");
+		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
 		return MSECS_TO_JIFFIES(10);
 	} else
 		self->reset_task = task;
@@ -326,7 +326,7 @@
 		self->reset_task = NULL;
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);		
 		self->reset_task = NULL;
 		ret = -1;
--- linux-2.4.22-rc2/drivers/net/irda/mcp2120.c	2002-11-28 20:53:13.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/net/irda/mcp2120.c	2003-08-21 00:08:28.000000000 -0300
@@ -110,7 +110,7 @@
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
-		WARNING(__FUNCTION__ "(), resetting dongle timed out!\n");
+		WARNING("%s(), resetting dongle timed out!\n", __FUNCTION__);
 		ret = -1;
 		break;
 	case IRDA_TASK_CHILD_DONE:
@@ -158,7 +158,7 @@
                 //printk("mcp2120_change_speed irda_task_wait\n");
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__, task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		self->speed_task = NULL;
 		ret = -1;
@@ -213,7 +213,7 @@
 		self->reset_task = NULL;
 		break;
 	default:
-		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		ERROR("%s(), unknown state %d\n", __FUNCTION__ , task->state);
 		irda_task_next_state(task, IRDA_TASK_DONE);
 		self->reset_task = NULL;
 		ret = -1;
--- linux-2.4.22-rc2/drivers/net/irda/nsc-ircc.c	2002-11-28 20:53:13.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/net/irda/nsc-ircc.c	2003-08-21 00:08:28.000000000 -0300
@@ -700,7 +700,7 @@
 	switch_bank(iobase, BANK3);
 	version = inb(iobase+MID);
 
-	IRDA_DEBUG(2, __FUNCTION__  "() Driver %s Found chip version %02x\n",
+	IRDA_DEBUG(2, "%s() Driver %s Found chip version %02x\n", __FUNCTION__,
 		   driver_name, version);
 
 	/* Should be 0x2? */

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
