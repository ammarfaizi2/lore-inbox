Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130511AbQLKAvl>; Sun, 10 Dec 2000 19:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbQLKAvb>; Sun, 10 Dec 2000 19:51:31 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:38870 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130511AbQLKAva>; Sun, 10 Dec 2000 19:51:30 -0500
Message-ID: <3A341DE8.B996D54B@haque.net>
Date: Sun, 10 Dec 2000 19:20:56 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] test12-pre8 task queue fix batch 
Content-Type: multipart/mixed;
 boundary="------------04C8CE61CD186DEE3685206F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------04C8CE61CD186DEE3685206F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Lets see if this is the gist of them...

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------04C8CE61CD186DEE3685206F
Content-Type: text/plain; charset=us-ascii;
 name="tq_struct-t12p8-fix-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tq_struct-t12p8-fix-3.diff"

diff -urw linux-2.4.0-test12.old/drivers/char/drm/gamma_dma.c linux-2.4.0-test12/drivers/char/drm/gamma_dma.c
--- linux-2.4.0-test12.old/drivers/char/drm/gamma_dma.c	Tue Oct  3 14:13:53 2000
+++ linux-2.4.0-test12/drivers/char/drm/gamma_dma.c	Sun Dec 10 19:04:01 2000
@@ -651,7 +651,7 @@
 	dev->dma->next_queue  = NULL;
 	dev->dma->this_buffer = NULL;
 
-	dev->tq.next	      = NULL;
+	INIT_LIST_HEAD(&dev->tq.list);
 	dev->tq.sync	      = 0;
 	dev->tq.routine	      = gamma_dma_schedule_tq_wrapper;
 	dev->tq.data	      = dev;
diff -urw linux-2.4.0-test12.old/drivers/char/drm/i810_dma.c linux-2.4.0-test12/drivers/char/drm/i810_dma.c
--- linux-2.4.0-test12.old/drivers/char/drm/i810_dma.c	Tue Oct  3 14:13:53 2000
+++ linux-2.4.0-test12/drivers/char/drm/i810_dma.c	Sun Dec 10 19:04:32 2000
@@ -924,7 +924,7 @@
 	dev->dma->next_queue  = NULL;
 	dev->dma->this_buffer = NULL;
 
-	dev->tq.next	      = NULL;
+	INIT_LIST_HEAD(&dev->tq.list);
 	dev->tq.sync	      = 0;
 	dev->tq.routine	      = i810_dma_task_queue;
 	dev->tq.data	      = dev;
diff -urw linux-2.4.0-test12.old/drivers/char/drm/mga_dma.c linux-2.4.0-test12/drivers/char/drm/mga_dma.c
--- linux-2.4.0-test12.old/drivers/char/drm/mga_dma.c	Sun Dec 10 13:49:22 2000
+++ linux-2.4.0-test12/drivers/char/drm/mga_dma.c	Sun Dec 10 19:05:43 2000
@@ -818,7 +818,7 @@
 	dev->dma->next_buffer = NULL;
 	dev->dma->next_queue  = NULL;
 	dev->dma->this_buffer = NULL;
-	dev->tq.next	      = NULL;
+	INIT_LIST_HEAD(&dev->tq.list);
 	dev->tq.sync	      = 0;
 	dev->tq.routine	      = mga_dma_task_queue;
 	dev->tq.data	      = dev;
diff -urw linux-2.4.0-test12.old/drivers/char/n_r3964.c linux-2.4.0-test12/drivers/char/n_r3964.c
--- linux-2.4.0-test12.old/drivers/char/n_r3964.c	Fri Jul 21 22:51:56 2000
+++ linux-2.4.0-test12/drivers/char/n_r3964.c	Sun Dec 10 19:02:28 2000
@@ -1157,12 +1157,12 @@
     * Add 'on_timer' to timer task queue
     * (will be called from timer bh)
     */
-   pInfo->bh_1.next = NULL;
+   INIT_LIST_HEAD(&pInfo->bh_1.list);
    pInfo->bh_1.sync = 0;
    pInfo->bh_1.routine = &on_timer_1;
    pInfo->bh_1.data = pInfo;
    
-   pInfo->bh_2.next = NULL;
+   INIT_LIST_HEAD(&pInfo->bh_2.list);
    pInfo->bh_2.sync = 0;
    pInfo->bh_2.routine = &on_timer_2;
    pInfo->bh_2.data = pInfo;
diff -urw linux-2.4.0-test12.old/drivers/char/scan_keyb.c linux-2.4.0-test12/drivers/char/scan_keyb.c
--- linux-2.4.0-test12.old/drivers/char/scan_keyb.c	Tue Oct  3 14:13:21 2000
+++ linux-2.4.0-test12/drivers/char/scan_keyb.c	Sun Dec 10 19:06:20 2000
@@ -120,7 +120,7 @@
 void __init scan_kbd_init(void)
 {
 
-	task_scan_kbd.next=NULL;
+	INIT_LIST_HEAD(task_scan_kbd.list);
 	task_scan_kbd.sync=0;
 	task_scan_kbd.routine=scan_kbd;
 	task_scan_kbd.data=NULL;
diff -urw linux-2.4.0-test12.old/drivers/i2o/i2o_lan.c linux-2.4.0-test12/drivers/i2o/i2o_lan.c
--- linux-2.4.0-test12.old/drivers/i2o/i2o_lan.c	Sun Dec 10 19:14:36 2000
+++ linux-2.4.0-test12/drivers/i2o/i2o_lan.c	Sun Dec 10 17:46:07 2000
@@ -112,8 +112,10 @@
 };
 static int lan_context;
 
-static struct tq_struct i2o_post_buckets_task = {
-	0, 0, (void (*)(void *))i2o_lan_receive_post, (void *) 0
+DECLARE_TASK_QUEUE(i2o_post_buckets_task);
+struct tq_struct run_i2o_post_buckets_task = {
+	routine: (void (*)(void *)) run_task_queue,
+	data: (void *) 0
 };
 
 /* Functions to handle message failures and transaction errors:
@@ -379,8 +381,8 @@
 	/* If DDM has already consumed bucket_thresh buckets, post new ones */
 
 	if (atomic_read(&priv->buckets_out) <= priv->max_buckets_out - priv->bucket_thresh) {
-		i2o_post_buckets_task.data = (void *)dev;
-		queue_task(&i2o_post_buckets_task, &tq_immediate);
+		run_i2o_post_buckets_task.data = (void *)dev;
+		queue_task(&run_i2o_post_buckets_task, &tq_immediate);
 		mark_bh(IMMEDIATE_BH);
 	}
 
@@ -1401,7 +1403,7 @@
 	atomic_set(&priv->tx_out, 0);
 	priv->tx_count = 0;
 
-	priv->i2o_batch_send_task.next    = NULL;
+	INIT_LIST_HEAD(&priv->i2o_batch_send_task.list);
 	priv->i2o_batch_send_task.sync    = 0;
 	priv->i2o_batch_send_task.routine = (void *)i2o_lan_batch_send;
 	priv->i2o_batch_send_task.data    = (void *)dev;
diff -urw linux-2.4.0-test12.old/drivers/ieee1394/guid.c linux-2.4.0-test12/drivers/ieee1394/guid.c
--- linux-2.4.0-test12.old/drivers/ieee1394/guid.c	Wed Jul  5 16:03:56 2000
+++ linux-2.4.0-test12/drivers/ieee1394/guid.c	Sun Dec 10 19:10:10 2000
@@ -163,7 +163,7 @@
                         return;
                 }
 
-                greq->tq.next = NULL;
+                INIT_LIST_HEAD(&greq->tq.list);
                 greq->tq.sync = 0;
                 greq->tq.routine = (void (*)(void*))pkt_complete;
                 greq->tq.data = greq;
diff -urw linux-2.4.0-test12.old/drivers/ieee1394/ohci1394.c linux-2.4.0-test12/drivers/ieee1394/ohci1394.c
--- linux-2.4.0-test12.old/drivers/ieee1394/ohci1394.c	Tue Oct  3 14:13:54 2000
+++ linux-2.4.0-test12/drivers/ieee1394/ohci1394.c	Sun Dec 10 19:13:57 2000
@@ -1585,7 +1585,7 @@
 
         /* initialize bottom handler */
         d->task.sync = 0;
-        d->task.next = NULL;
+        INIT_LIST_HEAD(&d->task.list);
         d->task.routine = dma_rcv_bh;
         d->task.data = (void*)d;
 
diff -urw linux-2.4.0-test12.old/drivers/isdn/pcbit/drv.c linux-2.4.0-test12/drivers/isdn/pcbit/drv.c
--- linux-2.4.0-test12.old/drivers/isdn/pcbit/drv.c	Sun Nov 19 21:56:25 2000
+++ linux-2.4.0-test12/drivers/isdn/pcbit/drv.c	Sun Dec 10 19:07:11 2000
@@ -135,7 +135,7 @@
 	dev->b2->id = 1;
 
 
-	dev->qdelivery.next = NULL;
+	INIT_LIST_HEAD(&dev->qdelivery.list);
 	dev->qdelivery.sync = 0;
 	dev->qdelivery.routine = pcbit_deliver;
 	dev->qdelivery.data = dev;
diff -urw linux-2.4.0-test12.old/drivers/net/acenic.c linux-2.4.0-test12/drivers/net/acenic.c
--- linux-2.4.0-test12.old/drivers/net/acenic.c	Sun Nov 19 21:56:27 2000
+++ linux-2.4.0-test12/drivers/net/acenic.c	Sun Dec 10 19:02:42 2000
@@ -2223,7 +2223,7 @@
 	/*
 	 * Setup the bottom half rx ring refill handler
 	 */
-	ap->immediate.next = NULL;
+	INIT_LIST_HEAD(&ap->immediate.list);
 	ap->immediate.sync = 0;
 	ap->immediate.routine = (void *)(void *)ace_bh;
 	ap->immediate.data = dev;
diff -urw linux-2.4.0-test12.old/drivers/net/aironet4500_core.c linux-2.4.0-test12/drivers/net/aironet4500_core.c
--- linux-2.4.0-test12.old/drivers/net/aironet4500_core.c	Sun Dec 10 19:14:36 2000
+++ linux-2.4.0-test12/drivers/net/aironet4500_core.c	Sun Dec 10 17:46:07 2000
@@ -2868,7 +2868,7 @@
 	
 	priv->command_semaphore_on = 0;
 	priv->unlock_command_postponed = 0;
-	priv->immediate_bh.next 	= NULL;
+	INIT_LIST_HEAD(&priv->immediate_bh.list);
 	priv->immediate_bh.sync 	= 0;
 	priv->immediate_bh.routine 	= (void *)(void *)awc_bh;
 	priv->immediate_bh.data 	= dev;
diff -urw linux-2.4.0-test12.old/drivers/net/plip.c linux-2.4.0-test12/drivers/net/plip.c
--- linux-2.4.0-test12.old/drivers/net/plip.c	Sun Dec 10 13:49:23 2000
+++ linux-2.4.0-test12/drivers/net/plip.c	Sun Dec 10 19:03:11 2000
@@ -349,18 +349,18 @@
 	nl->nibble	= PLIP_NIBBLE_WAIT;
 
 	/* Initialize task queue structures */
-	nl->immediate.next = NULL;
+	INIT_LIST_HEAD(&nl->immediate.list);
 	nl->immediate.sync = 0;
 	nl->immediate.routine = (void (*)(void *))plip_bh;
 	nl->immediate.data = dev;
 
-	nl->deferred.next = NULL;
+	INIT_LIST_HEAD(&nl->deferred.list);
 	nl->deferred.sync = 0;
 	nl->deferred.routine = (void (*)(void *))plip_kick_bh;
 	nl->deferred.data = dev;
 
 	if (dev->irq == -1) {
-		nl->timer.next = NULL;
+		INIT_LIST_HEAD(&nl->timer.list);
 		nl->timer.sync = 0;
 		nl->timer.routine = (void (*)(void *))plip_timer_bh;
 		nl->timer.data = dev;
diff -urw linux-2.4.0-test12.old/drivers/s390/net/ctc.c linux-2.4.0-test12/drivers/s390/net/ctc.c
--- linux-2.4.0-test12.old/drivers/s390/net/ctc.c	Fri May 12 14:41:44 2000
+++ linux-2.4.0-test12/drivers/s390/net/ctc.c	Sun Dec 10 19:10:37 2000
@@ -1313,7 +1313,7 @@
                                 return -ENOMEM;
                 }
                 init_waitqueue_head(&privptr->channel[i].wait);
-                privptr->channel[i].tq.next = NULL;
+                INIT_LIST_HEAD(&privptr->channel[i].tq.list);
                 privptr->channel[i].tq.sync = 0;
                 privptr->channel[i].tq.routine = (void *)(void *)ctc_irq_bh;
                 privptr->channel[i].tq.data = &privptr->channel[i]; 
diff -urw linux-2.4.0-test12.old/drivers/sbus/audio/dmy.c linux-2.4.0-test12/drivers/sbus/audio/dmy.c
--- linux-2.4.0-test12.old/drivers/sbus/audio/dmy.c	Tue Dec 21 01:06:42 1999
+++ linux-2.4.0-test12/drivers/sbus/audio/dmy.c	Sun Dec 10 19:08:58 2000
@@ -547,7 +547,7 @@
         dummy_chip->perchip_info.play.active = 1;
 
         /* fake an "interrupt" to deal with this block */
-        dummy_chip->tqueue.next = NULL;
+        INIT_LIST_HEAD(&dummy_chip->tqueue.list);
         dummy_chip->tqueue.sync = 0;
         dummy_chip->tqueue.routine = dummy_output_done_task;
         dummy_chip->tqueue.data = drv;
diff -urw linux-2.4.0-test12.old/drivers/usb/serial/digi_acceleport.c linux-2.4.0-test12/drivers/usb/serial/digi_acceleport.c
--- linux-2.4.0-test12.old/drivers/usb/serial/digi_acceleport.c	Sun Dec 10 13:49:23 2000
+++ linux-2.4.0-test12/drivers/usb/serial/digi_acceleport.c	Sun Dec 10 19:09:38 2000
@@ -1738,7 +1738,7 @@
 		init_waitqueue_head( &priv->dp_flush_wait );
 		priv->dp_in_close = 0;
 		init_waitqueue_head( &priv->dp_close_wait );
-		priv->dp_wakeup_task.next = NULL;
+		INIT_LIST_HEAD(&priv->dp_wakeup_task.list);
 		priv->dp_wakeup_task.sync = 0;
 		priv->dp_wakeup_task.routine = (void *)digi_wakeup_write_lock;
 		priv->dp_wakeup_task.data = (void *)(&serial->port[i]);
diff -urw linux-2.4.0-test12.old/drivers/usb/serial/keyspan_pda.c linux-2.4.0-test12/drivers/usb/serial/keyspan_pda.c
--- linux-2.4.0-test12.old/drivers/usb/serial/keyspan_pda.c	Sun Dec 10 19:14:36 2000
+++ linux-2.4.0-test12/drivers/usb/serial/keyspan_pda.c	Sun Dec 10 17:46:07 2000
@@ -742,11 +742,11 @@
 	if (!priv)
 		return (1); /* error */
 	init_waitqueue_head(&serial->port[0].write_wait);
-	priv->wakeup_task.next = NULL;
+	INIT_LIST_HEAD(&priv->wakeup_task.list);
 	priv->wakeup_task.sync = 0;
 	priv->wakeup_task.routine = (void *)keyspan_pda_wakeup_write;
 	priv->wakeup_task.data = (void *)(&serial->port[0]);
-	priv->unthrottle_task.next = NULL;
+	INIT_LIST_HEAD(&priv->unthrottle_task.list);
 	priv->unthrottle_task.sync = 0;
 	priv->unthrottle_task.routine = (void *)keyspan_pda_request_unthrottle;
 	priv->unthrottle_task.data = (void *)(serial);
diff -urw linux-2.4.0-test12.old/fs/smbfs/sock.c linux-2.4.0-test12/fs/smbfs/sock.c
--- linux-2.4.0-test12.old/fs/smbfs/sock.c	Sun Dec 10 19:14:36 2000
+++ linux-2.4.0-test12/fs/smbfs/sock.c	Sun Dec 10 17:46:07 2000
@@ -163,7 +163,7 @@
 		found_data(sk);
 		return;
 	}
-	job->cb.next = NULL;
+	INIT_LIST_HEAD(&job->cb.list);
 	job->cb.sync = 0;
 	job->cb.routine = smb_data_callback;
 	job->cb.data = job;

--------------04C8CE61CD186DEE3685206F--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
