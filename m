Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUEMWml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUEMWml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUEMWml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:42:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:58329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265211AbUEMWkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:40:10 -0400
Date: Thu, 13 May 2004 15:41:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: jgarzik@pobox.com, paul@wagland.net, mingo@elte.hu, wli@holomorphy.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davidel@xmailserver.org, Valdis.Kletnieks@vt.edu
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-Id: <20040513154116.6bb639c1.akpm@osdl.org>
In-Reply-To: <20040513154040.6acc8121.akpm@osdl.org>
References: <40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>
	<Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com>
	<200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu>
	<20040512202807.GA16849@elte.hu>
	<20040512203500.GA17999@elte.hu>
	<20040512205028.GA18806@elte.hu>
	<20040512140729.476ace9e.akpm@osdl.org>
	<20040512211748.GB20800@elte.hu>
	<20040512221823.GK1397@holomorphy.com>
	<61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net>
	<20040513121141.37f32035.akpm@osdl.org>
	<40A3CA34.60202@pobox.com>
	<20040513154002.4988b7f2.akpm@osdl.org>
	<20040513154040.6acc8121.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > >
> > > For whomever winds up doing this work, I have two requests:
> > > 
> > > * use a type-safe inline rather than purely a macro, as some drivers do
> > > * replace msecs_to_jiffies() occurrences as well as MSECS_TO_JIFFIES() 
> > > (and ditto for jiffies_to_msecs)
> > 
> > ...
> > Drivers need to be fixed up to use this instead of their private versions.
> 
> ...
> There are various uppercase versions which should be consolidated.



Switch all users of MSEC[S]_TO_JIFFIES and JIFFIES_TO_MSEC[S] over to use
jiffies_to_msecs() and msecs_to_jiffies().  Withdraw MSECS_TO_JIFFIES() and
JIFFIES_TO_MSECS() from the kernel API.


---

 25-akpm/drivers/net/irda/act200l-sir.c |    2 -
 25-akpm/drivers/net/irda/act200l.c     |   10 ++++-----
 25-akpm/drivers/net/irda/actisys.c     |    2 -
 25-akpm/drivers/net/irda/girbil.c      |   10 ++++-----
 25-akpm/drivers/net/irda/irda-usb.c    |    6 ++---
 25-akpm/drivers/net/irda/irport.c      |    4 +--
 25-akpm/drivers/net/irda/irtty-sir.c   |    4 +--
 25-akpm/drivers/net/irda/ma600-sir.c   |    8 +++----
 25-akpm/drivers/net/irda/ma600.c       |   16 +++++++--------
 25-akpm/drivers/net/irda/mcp2120.c     |    8 +++----
 25-akpm/drivers/net/irda/sir_dev.c     |    2 -
 25-akpm/drivers/net/irda/sir_kthread.c |    2 -
 25-akpm/drivers/net/irda/stir4200.c    |    6 ++---
 25-akpm/drivers/net/irda/tekram-sir.c  |    2 -
 25-akpm/drivers/net/irda/tekram.c      |   12 +++++------
 25-akpm/include/linux/time.h           |    3 --
 25-akpm/kernel/sched.c                 |    2 -
 25-akpm/net/irda/ircomm/ircomm_tty.c   |    2 -
 25-akpm/net/irda/irlap_event.c         |    6 ++---
 25-akpm/net/sctp/associola.c           |   10 ++++-----
 25-akpm/net/sctp/chunk.c               |    2 -
 25-akpm/net/sctp/endpointola.c         |    4 +--
 25-akpm/net/sctp/socket.c              |   34 ++++++++++++++++-----------------
 23 files changed, 77 insertions(+), 80 deletions(-)

diff -puN drivers/net/irda/act200l.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/act200l.c
--- 25/drivers/net/irda/act200l.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/act200l.c	Thu May 13 15:35:15 2004
@@ -148,7 +148,7 @@ static int act200l_change_speed(struct i
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -187,7 +187,7 @@ static int act200l_change_speed(struct i
 		/* Write control bytes */
 		self->write(self->dev, control, 3);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(5);
+		ret = msecs_to_jiffies(5);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Go back to normal mode */
@@ -237,14 +237,14 @@ static int act200l_reset(struct irda_tas
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Reset the dongle : set RTS low for 25 ms */
 		self->set_dtr_rts(self->dev, TRUE, FALSE);
 
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Clear DTR and set RTS to enter command mode */
@@ -253,7 +253,7 @@ static int act200l_reset(struct irda_tas
 		/* Write control bytes */
 		self->write(self->dev, control, 9);
 		irda_task_next_state(task, IRDA_TASK_WAIT3);
-		ret = MSECS_TO_JIFFIES(15);
+		ret = msecs_to_jiffies(15);
 		break;
 	case IRDA_TASK_WAIT3:
 		/* Go back to normal mode */
diff -puN drivers/net/irda/act200l-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/act200l-sir.c
--- 25/drivers/net/irda/act200l-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/act200l-sir.c	Thu May 13 15:35:15 2004
@@ -178,7 +178,7 @@ static int act200l_change_speed(struct s
 	/* Write control bytes */
 	sirdev_raw_write(dev, control, 3);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(5));
+	schedule_timeout(msecs_to_jiffies(5));
 
 	/* Go back to normal mode */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
diff -puN drivers/net/irda/actisys.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/actisys.c
--- 25/drivers/net/irda/actisys.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/actisys.c	Thu May 13 15:35:15 2004
@@ -238,7 +238,7 @@ static int actisys_reset(struct irda_tas
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		
 		/* Sleep 50 ms to make sure capacitor is charged */
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 		break;
 	case IRDA_TASK_WAIT:			
diff -puN drivers/net/irda/girbil.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/girbil.c
--- 25/drivers/net/irda/girbil.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/girbil.c	Thu May 13 15:35:15 2004
@@ -119,7 +119,7 @@ static int girbil_change_speed(struct ir
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -153,7 +153,7 @@ static int girbil_change_speed(struct ir
 		/* Write control bytes */
 		self->write(self->dev, control, 2);
 		irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(100);
+		ret = msecs_to_jiffies(100);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Go back to normal mode */
@@ -194,19 +194,19 @@ static int girbil_reset(struct irda_task
 		self->set_dtr_rts(self->dev, TRUE, FALSE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
 		/* Sleep at least 5 ms */
-		ret = MSECS_TO_JIFFIES(20);
+		ret = msecs_to_jiffies(20);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Set DTR and clear RTS to enter command mode */
 		self->set_dtr_rts(self->dev, FALSE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(20);
+		ret = msecs_to_jiffies(20);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Write control byte */
 		self->write(self->dev, &control, 1);
 		irda_task_next_state(task, IRDA_TASK_WAIT3);
-		ret = MSECS_TO_JIFFIES(20);
+		ret = msecs_to_jiffies(20);
 		break;
 	case IRDA_TASK_WAIT3:
 		/* Go back to normal mode */
diff -puN drivers/net/irda/irda-usb.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/irda-usb.c
--- 25/drivers/net/irda/irda-usb.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/irda-usb.c	Thu May 13 15:35:15 2004
@@ -268,7 +268,7 @@ static void irda_usb_change_speed_xbofs(
                       speed_bulk_callback, self);
 	urb->transfer_buffer_length = USB_IRDA_HEADER;
 	urb->transfer_flags = URB_ASYNC_UNLINK;
-	urb->timeout = MSECS_TO_JIFFIES(100);
+	urb->timeout = msecs_to_jiffies(100);
 
 	/* Irq disabled -> GFP_ATOMIC */
 	if ((ret = usb_submit_urb(urb, GFP_ATOMIC))) {
@@ -412,7 +412,7 @@ static int irda_usb_hard_xmit(struct sk_
 	 * This is how the dongle will detect the end of packet - Jean II */
 	urb->transfer_flags |= URB_ZERO_PACKET;
 	/* Timeout need to be shorter than NET watchdog timer */
-	urb->timeout = MSECS_TO_JIFFIES(200);
+	urb->timeout = msecs_to_jiffies(200);
 
 	/* Generate min turn time. FIXME: can we do better than this? */
 	/* Trying to a turnaround time at this level is trying to measure
@@ -1311,7 +1311,7 @@ static inline struct irda_class_desc *ir
 		IU_REQ_GET_CLASS_DESC,
 		USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
 		0, intf->altsetting->desc.bInterfaceNumber, desc,
-		sizeof(*desc), MSECS_TO_JIFFIES(500));
+		sizeof(*desc), msecs_to_jiffies(500));
 	
 	IRDA_DEBUG(1, "%s(), ret=%d\n", __FUNCTION__, ret);
 	if (ret < sizeof(*desc)) {
diff -puN drivers/net/irda/irport.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/irport.c
--- 25/drivers/net/irda/irport.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/irport.c	Thu May 13 15:35:15 2004
@@ -452,7 +452,7 @@ int __irport_change_speed(struct irda_ta
 			task->state = IRDA_TASK_WAIT;
 
 			/* Try again later */
-			ret = MSECS_TO_JIFFIES(20);
+			ret = msecs_to_jiffies(20);
 			break;
 		}
 
@@ -474,7 +474,7 @@ int __irport_change_speed(struct irda_ta
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give dongle 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		} else
 			/* Child finished immediately */
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
diff -puN drivers/net/irda/irtty-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/irtty-sir.c
--- 25/drivers/net/irda/irtty-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/irtty-sir.c	Thu May 13 15:35:15 2004
@@ -93,12 +93,12 @@ static void irtty_wait_until_sent(struct
 	tty = priv->tty;
 	if (tty->driver->wait_until_sent) {
 		lock_kernel();
-		tty->driver->wait_until_sent(tty, MSECS_TO_JIFFIES(100));
+		tty->driver->wait_until_sent(tty, msecs_to_jiffies(100));
 		unlock_kernel();
 	}
 	else {
 		set_task_state(current, TASK_UNINTERRUPTIBLE);
-		schedule_timeout(MSECS_TO_JIFFIES(USBSERIAL_TX_DONE_DELAY));
+		schedule_timeout(msecs_to_jiffies(USBSERIAL_TX_DONE_DELAY));
 	}
 }
 
diff -puN drivers/net/irda/ma600.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/ma600.c
--- 25/drivers/net/irda/ma600.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/ma600.c	Thu May 13 15:35:15 2004
@@ -184,7 +184,7 @@ static int ma600_change_speed(struct ird
 
 	if (self->speed_task && self->speed_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else {
 		self->speed_task = task;
 	}
@@ -202,7 +202,7 @@ static int ma600_change_speed(struct ird
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 	
 			/* give 1 second to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		} else {
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		}
@@ -217,7 +217,7 @@ static int ma600_change_speed(struct ird
 		/* Set DTR, Clear RTS */
 		self->set_dtr_rts(self->dev, TRUE, FALSE);
 	
-		ret = MSECS_TO_JIFFIES(1);		/* Sleep 1 ms */
+		ret = msecs_to_jiffies(1);		/* Sleep 1 ms */
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 		break;
 
@@ -231,7 +231,7 @@ static int ma600_change_speed(struct ird
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
 
 		/* Wait at least 10 ms */
-		ret = MSECS_TO_JIFFIES(15);
+		ret = msecs_to_jiffies(15);
 		break;
 
 	case IRDA_TASK_WAIT1:
@@ -258,7 +258,7 @@ static int ma600_change_speed(struct ird
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
 
 		/* Wait at least 10 ms */
-		ret = MSECS_TO_JIFFIES(10);
+		ret = msecs_to_jiffies(10);
 		break;
 
 	case IRDA_TASK_WAIT2:
@@ -298,7 +298,7 @@ int ma600_reset(struct irda_task *task)
 
 	if (self->reset_task && self->reset_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else
 		self->reset_task = task;
 	
@@ -307,13 +307,13 @@ int ma600_reset(struct irda_task *task)
 		/* Clear DTR and Set RTS */
 		self->set_dtr_rts(self->dev, FALSE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		ret = msecs_to_jiffies(10);		/* Sleep 10 ms */
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Set DTR and RTS */
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		ret = msecs_to_jiffies(10);		/* Sleep 10 ms */
 		break;
 	case IRDA_TASK_WAIT2:
 		irda_task_next_state(task, IRDA_TASK_DONE);
diff -puN drivers/net/irda/ma600-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/ma600-sir.c
--- 25/drivers/net/irda/ma600-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/ma600-sir.c	Thu May 13 15:35:15 2004
@@ -192,7 +192,7 @@ static int ma600_change_speed(struct sir
 
 	/* Wait at least 10ms: fake wait_until_sent - 10 bits at 9600 baud*/
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(15));		/* old ma600 uses 15ms */
+	schedule_timeout(msecs_to_jiffies(15));		/* old ma600 uses 15ms */
 
 #if 1
 	/* read-back of the control byte. ma600 is the first dongle driver
@@ -216,7 +216,7 @@ static int ma600_change_speed(struct sir
 
 	/* Wait at least 10ms */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(msecs_to_jiffies(10));
 
 	/* dongle is now switched to the new speed */
 	dev->speed = speed;
@@ -246,12 +246,12 @@ int ma600_reset(struct sir_dev *dev)
 	/* Reset the dongle : set DTR low for 10 ms */
 	sirdev_set_dtr_rts(dev, FALSE, TRUE);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(msecs_to_jiffies(10));
 
 	/* Go back to normal mode */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(10));
+	schedule_timeout(msecs_to_jiffies(10));
 
 	dev->speed = 9600;      /* That's the dongle-default */
 
diff -puN drivers/net/irda/mcp2120.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/mcp2120.c
--- 25/drivers/net/irda/mcp2120.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/mcp2120.c	Thu May 13 15:35:15 2004
@@ -99,7 +99,7 @@ static int mcp2120_change_speed(struct i
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		}
 		break;
 	case IRDA_TASK_CHILD_WAIT:
@@ -140,7 +140,7 @@ static int mcp2120_change_speed(struct i
                 self->write(self->dev, control, 2);
  
                 irda_task_next_state(task, IRDA_TASK_WAIT);
-		ret = MSECS_TO_JIFFIES(100);
+		ret = msecs_to_jiffies(100);
                 //printk("mcp2120_change_speed irda_child_done\n");
 		break;
 	case IRDA_TASK_WAIT:
@@ -189,14 +189,14 @@ static int mcp2120_reset(struct irda_tas
 		/* Reset dongle by setting RTS*/
 		self->set_dtr_rts(self->dev, TRUE, TRUE);
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT1:
                 //printk("mcp2120_reset irda_task_wait1\n");
                 /* clear RTS and wait for at least 30 ms. */
 		self->set_dtr_rts(self->dev, FALSE, FALSE);
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT2:
                 //printk("mcp2120_reset irda_task_wait2\n");
diff -puN drivers/net/irda/sir_dev.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/sir_dev.c
--- 25/drivers/net/irda/sir_dev.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/sir_dev.c	Thu May 13 15:35:15 2004
@@ -74,7 +74,7 @@ int sirdev_raw_write(struct sir_dev *dev
 	while (dev->tx_buff.len > 0) {			/* wait until tx idle */
 		spin_unlock_irqrestore(&dev->tx_lock, flags);
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(MSECS_TO_JIFFIES(10));
+		schedule_timeout(msecs_to_jiffies(10));
 		spin_lock_irqsave(&dev->tx_lock, flags);
 	}
 
diff -puN drivers/net/irda/sir_kthread.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/sir_kthread.c
--- 25/drivers/net/irda/sir_kthread.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/sir_kthread.c	Thu May 13 15:35:15 2004
@@ -415,7 +415,7 @@ static void irda_config_fsm(void *data)
 		fsm->state = next_state;
 	} while(!delay);
 
-	irda_queue_delayed_request(&fsm->rq, MSECS_TO_JIFFIES(delay));
+	irda_queue_delayed_request(&fsm->rq, msecs_to_jiffies(delay));
 }
 
 /* schedule some device configuration task for execution by kIrDAd
diff -puN drivers/net/irda/stir4200.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/stir4200.c
--- 25/drivers/net/irda/stir4200.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/stir4200.c	Thu May 13 15:35:15 2004
@@ -208,7 +208,7 @@ static int write_reg(struct stir_cb *sti
 			       REQ_WRITE_SINGLE,
 			       USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_DEVICE,
 			       value, reg, NULL, 0,
-			       MSECS_TO_JIFFIES(CTRL_TIMEOUT));
+			       msecs_to_jiffies(CTRL_TIMEOUT));
 }
 
 /* Send control message to read multiple registers */
@@ -221,7 +221,7 @@ static inline int read_reg(struct stir_c
 			       REQ_READ_REG,
 			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			       0, reg, data, count,
-			       MSECS_TO_JIFFIES(CTRL_TIMEOUT));
+			       msecs_to_jiffies(CTRL_TIMEOUT));
 }
 
 static inline int isfir(u32 speed)
@@ -745,7 +745,7 @@ static void stir_send(struct stir_cb *st
 
 	if (usb_bulk_msg(stir->usbdev, usb_sndbulkpipe(stir->usbdev, 1),
 			 stir->io_buf, wraplen,
-			 NULL, MSECS_TO_JIFFIES(TRANSMIT_TIMEOUT))) 
+			 NULL, msecs_to_jiffies(TRANSMIT_TIMEOUT)))
 		stir->stats.tx_errors++;
 }
 
diff -puN drivers/net/irda/tekram.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/tekram.c
--- 25/drivers/net/irda/tekram.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/tekram.c	Thu May 13 15:35:15 2004
@@ -113,7 +113,7 @@ static int tekram_change_speed(struct ir
 
 	if (self->speed_task && self->speed_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__ );
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else
 		self->speed_task = task;
 
@@ -150,7 +150,7 @@ static int tekram_change_speed(struct ir
 			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
 
 			/* Give reset 1 sec to finish */
-			ret = MSECS_TO_JIFFIES(1000);
+			ret = msecs_to_jiffies(1000);
 		} else
 			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
 		break;
@@ -171,7 +171,7 @@ static int tekram_change_speed(struct ir
 		irda_task_next_state(task, IRDA_TASK_WAIT);
 
 		/* Wait at least 100 ms */
-		ret = MSECS_TO_JIFFIES(150);
+		ret = msecs_to_jiffies(150);
 		break;
 	case IRDA_TASK_WAIT:
 		/* Set DTR, Set RTS */
@@ -214,7 +214,7 @@ int tekram_reset(struct irda_task *task)
 
 	if (self->reset_task && self->reset_task != task) {
 		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__ );
-		return MSECS_TO_JIFFIES(10);
+		return msecs_to_jiffies(10);
 	} else
 		self->reset_task = task;
 	
@@ -227,7 +227,7 @@ int tekram_reset(struct irda_task *task)
 		irda_task_next_state(task, IRDA_TASK_WAIT1);
 
 		/* Sleep 50 ms */
-		ret = MSECS_TO_JIFFIES(50);
+		ret = msecs_to_jiffies(50);
 		break;
 	case IRDA_TASK_WAIT1:
 		/* Clear DTR, Set RTS */
@@ -236,7 +236,7 @@ int tekram_reset(struct irda_task *task)
 		irda_task_next_state(task, IRDA_TASK_WAIT2);
 		
 		/* Should sleep 1 ms */
-		ret = MSECS_TO_JIFFIES(1);
+		ret = msecs_to_jiffies(1);
 		break;
 	case IRDA_TASK_WAIT2:
 		/* Set DTR, Set RTS */
diff -puN drivers/net/irda/tekram-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies drivers/net/irda/tekram-sir.c
--- 25/drivers/net/irda/tekram-sir.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/drivers/net/irda/tekram-sir.c	Thu May 13 15:35:15 2004
@@ -211,7 +211,7 @@ static int tekram_reset(struct sir_dev *
 
 	/* Should sleep 1 ms */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(MSECS_TO_JIFFIES(1));
+	schedule_timeout(msecs_to_jiffies(1));
 
 	/* Set DTR, Set RTS */
 	sirdev_set_dtr_rts(dev, TRUE, TRUE);
diff -puN include/linux/time.h~MSEC_TO_JIFFIES-to-msec_to_jiffies include/linux/time.h
--- 25/include/linux/time.h~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/include/linux/time.h	Thu May 13 15:35:15 2004
@@ -205,9 +205,6 @@ static inline unsigned long msecs_to_jif
 #endif
 }
 
-#define JIFFIES_TO_MSECS(j)	jiffies_to_msecs(j)
-#define MSECS_TO_JIFFIES(m)	msecs_to_jiffies(m)
-
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
diff -puN kernel/sched.c~MSEC_TO_JIFFIES-to-msec_to_jiffies kernel/sched.c
--- 25/kernel/sched.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/kernel/sched.c	Thu May 13 15:35:15 2004
@@ -1873,7 +1873,7 @@ static void rebalance_tick(int this_cpu,
 			interval *= sd->busy_factor;
 
 		/* scale ms to jiffies */
-		interval = MSECS_TO_JIFFIES(interval);
+		interval = msecs_to_jiffies(interval);
 		if (unlikely(!interval))
 			interval = 1;
 
diff -puN net/irda/ircomm/ircomm_tty.c~MSEC_TO_JIFFIES-to-msec_to_jiffies net/irda/ircomm/ircomm_tty.c
--- 25/net/irda/ircomm/ircomm_tty.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/net/irda/ircomm/ircomm_tty.c	Thu May 13 15:35:15 2004
@@ -873,7 +873,7 @@ static void ircomm_tty_wait_until_sent(s
 	orig_jiffies = jiffies;
 
 	/* Set poll time to 200 ms */
-	poll_time = IRDA_MIN(timeout, MSECS_TO_JIFFIES(200));
+	poll_time = IRDA_MIN(timeout, msecs_to_jiffies(200));
 
 	spin_lock_irqsave(&self->spinlock, flags);
 	while (self->tx_skb && self->tx_skb->len) {
diff -puN net/irda/irlap_event.c~MSEC_TO_JIFFIES-to-msec_to_jiffies net/irda/irlap_event.c
--- 25/net/irda/irlap_event.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/net/irda/irlap_event.c	Thu May 13 15:35:15 2004
@@ -627,7 +627,7 @@ static int irlap_state_query(struct irla
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
 			IRDA_DEBUG(2, "%s(), device is slow to answer, "
 				   "waiting some more!\n", __FUNCTION__);
-			irlap_start_slot_timer(self, MSECS_TO_JIFFIES(10));
+			irlap_start_slot_timer(self, msecs_to_jiffies(10));
 			self->add_wait = TRUE;
 			return ret;
 		}
@@ -849,7 +849,7 @@ static int irlap_state_setup(struct irla
  *  1.5 times the time taken to transmit a SNRM frame. So this time should
  *  between 15 msecs and 45 msecs.
  */
-			irlap_start_backoff_timer(self, MSECS_TO_JIFFIES(20 +
+			irlap_start_backoff_timer(self, msecs_to_jiffies(20 +
 						        (jiffies % 30)));
 		} else {
 			/* Always switch state before calling upper layers */
@@ -1506,7 +1506,7 @@ static int irlap_state_nrm_p(struct irla
 		if (irda_device_is_receiving(self->netdev) && !self->add_wait) {
 			IRDA_DEBUG(1, "FINAL_TIMER_EXPIRED when receiving a "
 			      "frame! Waiting a little bit more!\n");
-			irlap_start_final_timer(self, MSECS_TO_JIFFIES(300));
+			irlap_start_final_timer(self, msecs_to_jiffies(300));
 
 			/*
 			 *  Don't allow this to happen one more time in a row,
diff -puN net/sctp/associola.c~MSEC_TO_JIFFIES-to-msec_to_jiffies net/sctp/associola.c
--- 25/net/sctp/associola.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/net/sctp/associola.c	Thu May 13 15:35:15 2004
@@ -142,9 +142,9 @@ struct sctp_association *sctp_associatio
 	 * socket values.
 	 */
 	asoc->max_retrans = sp->assocparams.sasoc_asocmaxrxt;
-	asoc->rto_initial = MSECS_TO_JIFFIES(sp->rtoinfo.srto_initial);
-	asoc->rto_max = MSECS_TO_JIFFIES(sp->rtoinfo.srto_max);
-	asoc->rto_min = MSECS_TO_JIFFIES(sp->rtoinfo.srto_min);
+	asoc->rto_initial = msecs_to_jiffies(sp->rtoinfo.srto_initial);
+	asoc->rto_max = msecs_to_jiffies(sp->rtoinfo.srto_max);
+	asoc->rto_min = msecs_to_jiffies(sp->rtoinfo.srto_min);
 
 	asoc->overall_error_count = 0;
 
@@ -170,7 +170,7 @@ struct sctp_association *sctp_associatio
 	asoc->max_init_attempts	= sp->initmsg.sinit_max_attempts;
 
 	asoc->max_init_timeo =
-		 MSECS_TO_JIFFIES(sp->initmsg.sinit_max_init_timeo);
+		 msecs_to_jiffies(sp->initmsg.sinit_max_init_timeo);
 
 	/* Allocate storage for the ssnmap after the inbound and outbound
 	 * streams have been negotiated during Init.
@@ -507,7 +507,7 @@ struct sctp_transport *sctp_assoc_add_pe
 	/* Initialize the peer's heartbeat interval based on the
 	 * sock configured value.
 	 */
-	peer->hb_interval = MSECS_TO_JIFFIES(sp->paddrparam.spp_hbinterval);
+	peer->hb_interval = msecs_to_jiffies(sp->paddrparam.spp_hbinterval);
 
 	/* Set the path max_retrans.  */
 	peer->max_retrans = asoc->max_retrans;
diff -puN net/sctp/chunk.c~MSEC_TO_JIFFIES-to-msec_to_jiffies net/sctp/chunk.c
--- 25/net/sctp/chunk.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/net/sctp/chunk.c	Thu May 13 15:35:15 2004
@@ -186,7 +186,7 @@ struct sctp_datamsg *sctp_datamsg_from_u
 	if (sinfo->sinfo_timetolive) {
 		/* sinfo_timetolive is in milliseconds */
 		msg->expires_at = jiffies +
-				    MSECS_TO_JIFFIES(sinfo->sinfo_timetolive);
+				    msecs_to_jiffies(sinfo->sinfo_timetolive);
 		msg->can_abandon = 1;
 		SCTP_DEBUG_PRINTK("%s: msg:%p expires_at: %ld jiffies:%ld\n",
 				  __FUNCTION__, msg, msg->expires_at, jiffies);
diff -puN net/sctp/endpointola.c~MSEC_TO_JIFFIES-to-msec_to_jiffies net/sctp/endpointola.c
--- 25/net/sctp/endpointola.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/net/sctp/endpointola.c	Thu May 13 15:35:15 2004
@@ -129,7 +129,7 @@ struct sctp_endpoint *sctp_endpoint_init
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T1_INIT] =
 		SCTP_DEFAULT_TIMEOUT_T1_INIT;
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T2_SHUTDOWN] =
-		MSECS_TO_JIFFIES(sp->rtoinfo.srto_initial);
+		msecs_to_jiffies(sp->rtoinfo.srto_initial);
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T3_RTX] = 0;
 	ep->timeouts[SCTP_EVENT_TIMEOUT_T4_RTO] = 0;
 
@@ -138,7 +138,7 @@ struct sctp_endpoint *sctp_endpoint_init
 	 * recommended value of 5 times 'RTO.Max'.
 	 */
         ep->timeouts[SCTP_EVENT_TIMEOUT_T5_SHUTDOWN_GUARD]
-		= 5 * MSECS_TO_JIFFIES(sp->rtoinfo.srto_max);
+		= 5 * msecs_to_jiffies(sp->rtoinfo.srto_max);
 
 	ep->timeouts[SCTP_EVENT_TIMEOUT_HEARTBEAT] =
 		SCTP_DEFAULT_TIMEOUT_HEARTBEAT;
diff -puN net/sctp/socket.c~MSEC_TO_JIFFIES-to-msec_to_jiffies net/sctp/socket.c
--- 25/net/sctp/socket.c~MSEC_TO_JIFFIES-to-msec_to_jiffies	Thu May 13 15:35:15 2004
+++ 25-akpm/net/sctp/socket.c	Thu May 13 15:36:40 2004
@@ -1224,7 +1224,7 @@ SCTP_STATIC int sctp_sendmsg(struct kioc
 			}
 			if (sinit->sinit_max_init_timeo) {
 				asoc->max_init_timeo = 
-				 MSECS_TO_JIFFIES(sinit->sinit_max_init_timeo);
+				 msecs_to_jiffies(sinit->sinit_max_init_timeo);
 			}
 		}
 
@@ -1662,7 +1662,7 @@ static int sctp_setsockopt_peer_addr_par
 		if (params.spp_hbinterval) {
 			trans->hb_allowed = 1;
 			trans->hb_interval = 
-				MSECS_TO_JIFFIES(params.spp_hbinterval);
+				msecs_to_jiffies(params.spp_hbinterval);
 		} else
 			trans->hb_allowed = 0;
 	}
@@ -1835,11 +1835,11 @@ static int sctp_setsockopt_rtoinfo(struc
 	if (asoc) {
 		if (rtoinfo.srto_initial != 0)
 			asoc->rto_initial = 
-				MSECS_TO_JIFFIES(rtoinfo.srto_initial);
+				msecs_to_jiffies(rtoinfo.srto_initial);
 		if (rtoinfo.srto_max != 0)
-			asoc->rto_max = MSECS_TO_JIFFIES(rtoinfo.srto_max);
+			asoc->rto_max = msecs_to_jiffies(rtoinfo.srto_max);
 		if (rtoinfo.srto_min != 0)
-			asoc->rto_min = MSECS_TO_JIFFIES(rtoinfo.srto_min);
+			asoc->rto_min = msecs_to_jiffies(rtoinfo.srto_min);
 	} else {
 		/* If there is no association or the association-id = 0
 		 * set the values to the endpoint.
@@ -2379,14 +2379,14 @@ SCTP_STATIC int sctp_init_sock(struct so
 	sp->initmsg.sinit_num_ostreams   = sctp_max_outstreams;
 	sp->initmsg.sinit_max_instreams  = sctp_max_instreams;
 	sp->initmsg.sinit_max_attempts   = sctp_max_retrans_init;
-	sp->initmsg.sinit_max_init_timeo = JIFFIES_TO_MSECS(sctp_rto_max);
+	sp->initmsg.sinit_max_init_timeo = jiffies_to_msecs(sctp_rto_max);
 
 	/* Initialize default RTO related parameters.  These parameters can
 	 * be modified for with the SCTP_RTOINFO socket option.
 	 */
-	sp->rtoinfo.srto_initial = JIFFIES_TO_MSECS(sctp_rto_initial);
-	sp->rtoinfo.srto_max     = JIFFIES_TO_MSECS(sctp_rto_max);
-	sp->rtoinfo.srto_min     = JIFFIES_TO_MSECS(sctp_rto_min);
+	sp->rtoinfo.srto_initial = jiffies_to_msecs(sctp_rto_initial);
+	sp->rtoinfo.srto_max     = jiffies_to_msecs(sctp_rto_max);
+	sp->rtoinfo.srto_min     = jiffies_to_msecs(sctp_rto_min);
 
 	/* Initialize default association related parameters. These parameters
 	 * can be modified with the SCTP_ASSOCINFO socket option.
@@ -2396,7 +2396,7 @@ SCTP_STATIC int sctp_init_sock(struct so
 	sp->assocparams.sasoc_peer_rwnd = 0;
 	sp->assocparams.sasoc_local_rwnd = 0;
 	sp->assocparams.sasoc_cookie_life = 
-		JIFFIES_TO_MSECS(sctp_valid_cookie_life);
+		jiffies_to_msecs(sctp_valid_cookie_life);
 
 	/* Initialize default event subscriptions. By default, all the
 	 * options are off. 
@@ -2406,7 +2406,7 @@ SCTP_STATIC int sctp_init_sock(struct so
 	/* Default Peer Address Parameters.  These defaults can
 	 * be modified via SCTP_PEER_ADDR_PARAMS
 	 */
-	sp->paddrparam.spp_hbinterval = JIFFIES_TO_MSECS(sctp_hb_interval);
+	sp->paddrparam.spp_hbinterval = jiffies_to_msecs(sctp_hb_interval);
 	sp->paddrparam.spp_pathmaxrxt = sctp_max_retrans_path;
 
 	/* If enabled no SCTP message fragmentation will be performed.
@@ -2552,7 +2552,7 @@ static int sctp_getsockopt_sctp_status(s
 	status.sstat_primary.spinfo_state = transport->active;
 	status.sstat_primary.spinfo_cwnd = transport->cwnd;
 	status.sstat_primary.spinfo_srtt = transport->srtt;
-	status.sstat_primary.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	status.sstat_primary.spinfo_rto = jiffies_to_msecs(transport->rto);
 	status.sstat_primary.spinfo_mtu = transport->pmtu;
 
 	if (put_user(len, optlen)) {
@@ -2607,7 +2607,7 @@ static int sctp_getsockopt_peer_addr_inf
 	pinfo.spinfo_state = transport->active;
 	pinfo.spinfo_cwnd = transport->cwnd;
 	pinfo.spinfo_srtt = transport->srtt;
-	pinfo.spinfo_rto = JIFFIES_TO_MSECS(transport->rto);
+	pinfo.spinfo_rto = jiffies_to_msecs(transport->rto);
 	pinfo.spinfo_mtu = transport->pmtu;
 
 	if (put_user(len, optlen)) {
@@ -2811,7 +2811,7 @@ static int sctp_getsockopt_peer_addr_par
 	if (!trans->hb_allowed)
 		params.spp_hbinterval = 0;
 	else
-		params.spp_hbinterval = JIFFIES_TO_MSECS(trans->hb_interval);
+		params.spp_hbinterval = jiffies_to_msecs(trans->hb_interval);
 
 	/* spp_pathmaxrxt contains the maximum number of retransmissions
 	 * before this address shall be considered unreachable.
@@ -3168,9 +3168,9 @@ static int sctp_getsockopt_rtoinfo(struc
 
 	/* Values corresponding to the specific association. */
 	if (asoc) {
-		rtoinfo.srto_initial = JIFFIES_TO_MSECS(asoc->rto_initial);
-		rtoinfo.srto_max = JIFFIES_TO_MSECS(asoc->rto_max);
-		rtoinfo.srto_min = JIFFIES_TO_MSECS(asoc->rto_min);
+		rtoinfo.srto_initial = jiffies_to_msecs(asoc->rto_initial);
+		rtoinfo.srto_max = jiffies_to_msecs(asoc->rto_max);
+		rtoinfo.srto_min = jiffies_to_msecs(asoc->rto_min);
 	} else {
 		/* Values corresponding to the endpoint. */
 		struct sctp_opt *sp = sctp_sk(sk);

_

