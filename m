Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSFJMh2>; Mon, 10 Jun 2002 08:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSFJMh0>; Mon, 10 Jun 2002 08:37:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12295 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313181AbSFJMhP>; Mon, 10 Jun 2002 08:37:15 -0400
Message-ID: <3D048FBA.9010900@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:38:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 8/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010104090007010802000701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010104090007010802000701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix improper __FUNCTION__ usage in irda_device.
- Whitepsace cleanup there too.

--------------010104090007010802000701
Content-Type: text/plain;
 name="warn-2.5.21-8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-8.diff"

diff -urN linux-2.5.21/net/irda/irda_device.c linux/net/irda/irda_device.c
--- linux-2.5.21/net/irda/irda_device.c	2002-06-09 07:29:50.000000000 +0200
+++ linux/net/irda/irda_device.c	2002-06-09 20:11:02.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *                
+ *
  * Filename:      irda_device.c
  * Version:       0.9
  * Description:   Utility functions used by the device drivers
@@ -8,25 +8,25 @@
  * Created at:    Sat Oct  9 09:22:27 1999
  * Modified at:   Sun Jan 23 17:41:24 2000
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * 
+ *
  *     Copyright (c) 1999-2000 Dag Brattli, All Rights Reserved.
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
@@ -83,7 +83,7 @@
 #ifdef CONFIG_IRDA_DEBUG
 static const char *task_state[] = {
 	"IRDA_TASK_INIT",
-	"IRDA_TASK_DONE", 
+	"IRDA_TASK_DONE",
 	"IRDA_TASK_WAIT",
 	"IRDA_TASK_WAIT1",
 	"IRDA_TASK_WAIT2",
@@ -97,7 +97,7 @@
 static void irda_task_timer_expired(void *data);
 
 #ifdef CONFIG_PROC_FS
-int irda_device_proc_read(char *buf, char **start, off_t offset, int len, 
+int irda_device_proc_read(char *buf, char **start, off_t offset, int len,
 			  int unused);
 
 #endif /* CONFIG_PROC_FS */
@@ -106,21 +106,19 @@
 {
 	dongles = hashbin_new(HB_GLOBAL);
 	if (dongles == NULL) {
-		printk(KERN_WARNING 
-		       "IrDA: Can't allocate dongles hashbin!\n");
+		printk(KERN_WARNING "IrDA: Can't allocate dongles hashbin!\n");
 		return -ENOMEM;
 	}
 
 	tasks = hashbin_new(HB_GLOBAL);
 	if (tasks == NULL) {
-		printk(KERN_WARNING 
-		       "IrDA: Can't allocate tasks hashbin!\n");
+		printk(KERN_WARNING "IrDA: Can't allocate tasks hashbin!\n");
 		return -ENOMEM;
 	}
 
-	/* 
+	/*
 	 * Call the init function of the device drivers that has not been
-	 * compiled as a module 
+	 * compiled as a module
 	 */
 #ifdef CONFIG_IRTTY_SIR
 	irtty_init();
@@ -156,10 +154,10 @@
 	litelink_init();
 #endif
 #ifdef CONFIG_OLD_BELKIN
- 	old_belkin_init();
+	old_belkin_init();
 #endif
 #ifdef CONFIG_EP7211_IR
- 	ep7211_ir_init();
+	ep7211_ir_init();
 #endif
 	return 0;
 }
@@ -178,7 +176,7 @@
  *    Called when we have detected that another station is transmiting
  *    in contention mode.
  */
-void irda_device_set_media_busy(struct net_device *dev, int status) 
+void irda_device_set_media_busy(struct net_device *dev, int status)
 {
 	struct irlap_cb *self;
 
@@ -203,15 +201,15 @@
 }
 
 int irda_device_set_dtr_rts(struct net_device *dev, int dtr, int rts)
-{	
+{
 	struct if_irda_req req;
 	int ret;
 
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), do_ioctl not impl. by "
-		      "device driver\n");
+		ERROR("%s: do_ioctl not impl. by device driver\n",
+				__FUNCTION__);
 		return -1;
 	}
 
@@ -224,15 +222,15 @@
 }
 
 int irda_device_change_speed(struct net_device *dev, __u32 speed)
-{	
+{
 	struct if_irda_req req;
 	int ret;
 
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), do_ioctl not impl. by "
-		      "device driver\n");
+		ERROR("%s: do_ioctl not impl. by device driver\n",
+				__FUNCTION__);
 		return -1;
 	}
 
@@ -257,8 +255,8 @@
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), do_ioctl not impl. by "
-		      "device driver\n");
+		ERROR("%s: do_ioctl not impl. by device driver\n",
+				__FUNCTION__);
 		return -1;
 	}
 
@@ -279,7 +277,7 @@
 static void __irda_task_delete(struct irda_task *task)
 {
 	del_timer(&task->timer);
-	
+
 	kfree(task);
 }
 
@@ -314,14 +312,14 @@
 	do {
 		timeout = task->function(task);
 		if (count++ > 100) {
-			ERROR(__FUNCTION__ "(), error in task handler!\n");
+			ERROR("%s: error in task handler!\n", __FUNCTION__);
 			irda_task_delete(task);
 			return TRUE;
-		}			
+		}
 	} while ((timeout == 0) && (task->state != IRDA_TASK_DONE));
 
 	if (timeout < 0) {
-		ERROR(__FUNCTION__ "(), Error executing task!\n");
+		ERROR("%s: Error executing task!\n", __FUNCTION__);
 		irda_task_delete(task);
 		return TRUE;
 	}
@@ -346,14 +344,14 @@
 				/* Kick parent task */
 				irda_task_kick(task->parent);
 			}
-		}		
+		}
 		irda_task_delete(task);
 	} else if (timeout > 0) {
-		irda_start_timer(&task->timer, timeout, (void *) task, 
+		irda_start_timer(&task->timer, timeout, (void *) task,
 				 irda_task_timer_expired);
 		finished = FALSE;
 	} else {
-		IRDA_DEBUG(0, __FUNCTION__ 
+		IRDA_DEBUG(0, __FUNCTION__
 			   "(), not finished, and no timeout!\n");
 		finished = FALSE;
 	}
@@ -367,7 +365,7 @@
  *    This function registers and tries to execute tasks that may take some
  *    time to complete. We do it this hairy way since we may have been
  *    called from interrupt context, so it's not possible to use
- *    schedule_timeout() 
+ *    schedule_timeout()
  * Two important notes :
  *	o Make sure you irda_task_delete(task); in case you delete the
  *	  calling instance.
@@ -375,9 +373,9 @@
  *	  want to lock within the task handler.
  * Jean II
  */
-struct irda_task *irda_task_execute(void *instance, 
-				    IRDA_TASK_CALLBACK function, 
-				    IRDA_TASK_CALLBACK finished, 
+struct irda_task *irda_task_execute(void *instance,
+				    IRDA_TASK_CALLBACK function,
+				    IRDA_TASK_CALLBACK finished,
 				    struct irda_task *parent, void *param)
 {
 	struct irda_task *task;
@@ -394,7 +392,7 @@
 	task->function = function;
 	task->finished = finished;
 	task->parent   = parent;
-	task->param    = param;	
+	task->param    = param;
 	task->magic    = IRDA_TASK_MAGIC;
 
 	init_timer(&task->timer);
@@ -433,7 +431,7 @@
  *    This function should be used by low level device drivers in a similar way
  *    as ether_setup() is used by normal network device drivers
  */
-int irda_device_setup(struct net_device *dev) 
+int irda_device_setup(struct net_device *dev)
 {
 	ASSERT(dev != NULL, return -1;);
 
@@ -445,7 +443,7 @@
 
         dev->type            = ARPHRD_IRDA;
         dev->tx_queue_len    = 8; /* Window size + 1 s-frame */
- 
+
 	memset(dev->broadcast, 0xff, 4);
 
 	dev->mtu = 2048;
@@ -491,7 +489,7 @@
 	sprintf(modname, "irda-dongle-%d", type);
 	request_module(modname);
 	}
-#endif /* CONFIG_KMOD */
+#endif
 
 	if (!(reg = hashbin_find(dongles, type, NULL))) {
 		ERROR("IrDA: Unable to find requested dongle\n");
@@ -514,9 +512,6 @@
 
 /*
  * Function irda_device_dongle_cleanup (dongle)
- *
- *    
- *
  */
 int irda_device_dongle_cleanup(dongle_t *dongle)
 {
@@ -531,21 +526,18 @@
 
 /*
  * Function irda_device_register_dongle (dongle)
- *
- *    
- *
  */
 int irda_device_register_dongle(struct dongle_reg *new)
 {
 	/* Check if this dongle has been registred before */
 	if (hashbin_find(dongles, new->type, NULL)) {
-		MESSAGE(__FUNCTION__ "(), Dongle already registered\n");
+		MESSAGE("%s: Dongle already registered\n", __FUNCTION__);
                 return 0;
         }
-	
+
 	/* Insert IrDA dongle into hashbin */
 	hashbin_insert(dongles, (irda_queue_t *) new, new->type, NULL);
-	
+
         return 0;
 }
 
@@ -561,7 +553,7 @@
 
 	node = hashbin_remove(dongles, dongle->type, NULL);
 	if (!node) {
-		ERROR(__FUNCTION__ "(), dongle not found!\n");
+		ERROR("%s: dongle not found!\n", __FUNCTION__);
 		return;
 	}
 }
@@ -574,22 +566,22 @@
  *    driver to find out which modes it support.
  */
 int irda_device_set_mode(struct net_device* dev, int mode)
-{	
+{
 	struct if_irda_req req;
 	int ret;
 
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 
 	if (!dev->do_ioctl) {
-		ERROR(__FUNCTION__ "(), set_raw_mode not impl. by "
-		      "device driver\n");
+		ERROR("%s: set_raw_mode not impl. by device driver\n",
+				__FUNCTION__);
 		return -1;
 	}
-	
+
 	req.ifr_mode = mode;
 
 	ret = dev->do_ioctl(dev, (struct ifreq *) &req, SIOCSMODE);
-	
+
 	return ret;
 }
 
@@ -602,9 +594,9 @@
 void setup_dma(int channel, char *buffer, int count, int mode)
 {
 	unsigned long flags;
-	
+
 	flags = claim_dma_lock();
-	
+
 	disable_dma(channel);
 	clear_dma_ff(channel);
 	set_dma_mode(channel, mode);

--------------010104090007010802000701--

