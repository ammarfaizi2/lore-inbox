Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKG2O>; Mon, 11 Dec 2000 01:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQLKG2F>; Mon, 11 Dec 2000 01:28:05 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:12202 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129226AbQLKG16>; Mon, 11 Dec 2000 01:27:58 -0500
Date: Sun, 10 Dec 2000 21:57:29 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.0-test12pre8: 17 files with compiler errors due to tq_struct->list.
Message-ID: <20001210215729.A2845@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I believe the following patch should complete the
conversion of tq_struct->next to tq_struct->list, at least for x86
platforms.  There were seventeen files in 2.4.0-test12pre8 for x86 that
needed to be updated.

	Please integrate with caution.  I had never looked at the
contents of struct tq_struct before this.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux.diffs"

diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/char/drm/gamma_dma.c linux-2.4.0-test12pre8.ygg/drivers/char/drm/gamma_dma.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/char/drm/gamma_dma.c	Tue Oct  3 16:29:08 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/char/drm/gamma_dma.c	Sun Dec 10 19:34:25 2000
@@ -651,7 +651,7 @@
 	dev->dma->next_queue  = NULL;
 	dev->dma->this_buffer = NULL;
 
-	dev->tq.next	      = NULL;
+	INIT_LIST_HEAD(&dev->tq.list);
 	dev->tq.sync	      = 0;
 	dev->tq.routine	      = gamma_dma_schedule_tq_wrapper;
 	dev->tq.data	      = dev;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/char/drm/i810_dma.c linux-2.4.0-test12pre8.ygg/drivers/char/drm/i810_dma.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/char/drm/i810_dma.c	Tue Oct  3 16:29:09 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/char/drm/i810_dma.c	Sun Dec 10 19:35:01 2000
@@ -924,7 +924,7 @@
 	dev->dma->next_queue  = NULL;
 	dev->dma->this_buffer = NULL;
 
-	dev->tq.next	      = NULL;
+	INIT_LIST_HEAD(&dev->tq.list);
 	dev->tq.sync	      = 0;
 	dev->tq.routine	      = i810_dma_task_queue;
 	dev->tq.data	      = dev;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/char/drm/mga_dma.c linux-2.4.0-test12pre8.ygg/drivers/char/drm/mga_dma.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/char/drm/mga_dma.c	Mon Dec  4 03:35:45 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/char/drm/mga_dma.c	Sun Dec 10 19:35:44 2000
@@ -818,7 +818,7 @@
 	dev->dma->next_buffer = NULL;
 	dev->dma->next_queue  = NULL;
 	dev->dma->this_buffer = NULL;
-	dev->tq.next	      = NULL;
+	INIT_LIST_HEAD(&dev->tq.list);
 	dev->tq.sync	      = 0;
 	dev->tq.routine	      = mga_dma_task_queue;
 	dev->tq.data	      = dev;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/char/n_r3964.c linux-2.4.0-test12pre8.ygg/drivers/char/n_r3964.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/char/n_r3964.c	Wed May  3 05:34:57 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/char/n_r3964.c	Sun Dec 10 19:30:17 2000
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
@@ -1174,7 +1174,7 @@
 
 static void r3964_close(struct tty_struct *tty)
 {
-   struct tq_struct *tq, *prev;
+   struct list_head *tq, *next;
    struct r3964_info *pInfo=(struct r3964_info*)tty->disc_data;
    struct r3964_client_info *pClient, *pNext;
    struct r3964_message *pMsg;
@@ -1190,14 +1190,13 @@
     save_flags(flags);
     cli();
 
-    for (tq=tq_timer, prev=0; tq; prev=tq, tq=tq->next) {
-         if ((tq == &pInfo->bh_1) || (tq==&pInfo->bh_2)) {
-             if (prev)
-                 prev->next = tq->next;
-             else
-                 tq_timer = tq->next;
-             break;
-         }
+    tq = &tq_timer;
+    while (tq != NULL) {
+         next = tq->next;
+         if ((tq == (struct list_head*) &pInfo->bh_1) ||
+	     (tq == (struct list_head*) &pInfo->bh_2))
+	 	list_del(tq);
+	 tq = next; 
     }
     restore_flags(flags);
 
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/i2o/i2o_lan.c linux-2.4.0-test12pre8.ygg/drivers/i2o/i2o_lan.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/i2o/i2o_lan.c	Wed Dec  6 23:36:42 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/i2o/i2o_lan.c	Sun Dec 10 19:40:09 2000
@@ -113,7 +113,10 @@
 static int lan_context;
 
 static struct tq_struct i2o_post_buckets_task = {
-	0, 0, (void (*)(void *))i2o_lan_receive_post, (void *) 0
+	list: LIST_HEAD_INIT(i2o_post_buckets_task.list),
+	sync: 0,
+	routine: (void (*)(void *))i2o_lan_receive_post,
+	data: (void *) 0
 };
 
 /* Functions to handle message failures and transaction errors:
@@ -1401,7 +1404,7 @@
 	atomic_set(&priv->tx_out, 0);
 	priv->tx_count = 0;
 
-	priv->i2o_batch_send_task.next    = NULL;
+	INIT_LIST_HEAD(&priv->i2o_batch_send_task.list);
 	priv->i2o_batch_send_task.sync    = 0;
 	priv->i2o_batch_send_task.routine = (void *)i2o_lan_batch_send;
 	priv->i2o_batch_send_task.data    = (void *)dev;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/ieee1394/guid.c linux-2.4.0-test12pre8.ygg/drivers/ieee1394/guid.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/ieee1394/guid.c	Thu Jul  6 17:37:48 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/ieee1394/guid.c	Sun Dec 10 19:42:26 2000
@@ -163,7 +163,7 @@
                         return;
                 }
 
-                greq->tq.next = NULL;
+                INIT_LIST_HEAD(&greq->tq.list);
                 greq->tq.sync = 0;
                 greq->tq.routine = (void (*)(void*))pkt_complete;
                 greq->tq.data = greq;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/ieee1394/ohci1394.c linux-2.4.0-test12pre8.ygg/drivers/ieee1394/ohci1394.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/ieee1394/ohci1394.c	Fri Nov 24 22:21:55 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/ieee1394/ohci1394.c	Sun Dec 10 19:41:51 2000
@@ -1589,7 +1589,7 @@
 
         /* initialize bottom handler */
         d->task.sync = 0;
-        d->task.next = NULL;
+        INIT_LIST_HEAD(&d->task.list);
         d->task.routine = dma_rcv_bh;
         d->task.data = (void*)d;
 
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/hisax/config.c linux-2.4.0-test12pre8.ygg/drivers/isdn/hisax/config.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/hisax/config.c	Wed Dec  6 03:41:07 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/isdn/hisax/config.c	Sun Dec 10 19:43:44 2000
@@ -1180,7 +1180,7 @@
 	cs->tx_skb = NULL;
 	cs->tx_cnt = 0;
 	cs->event = 0;
-	cs->tqueue.next = 0;
+	INIT_LIST_HEAD(&cs->tqueue.list);
 	cs->tqueue.sync = 0;
 	cs->tqueue.data = cs;
 
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/hisax/isdnl1.c linux-2.4.0-test12pre8.ygg/drivers/isdn/hisax/isdnl1.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/hisax/isdnl1.c	Wed Nov 29 03:41:40 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/isdn/hisax/isdnl1.c	Sun Dec 10 19:44:19 2000
@@ -343,7 +343,7 @@
 
 	bcs->cs = cs;
 	bcs->channel = bc;
-	bcs->tqueue.next = 0;
+	INIT_LIST_HEAD(&bcs->tqueue.list);
 	bcs->tqueue.sync = 0;
 	bcs->tqueue.routine = (void *) (void *) BChannel_bh;
 	bcs->tqueue.data = bcs;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/hysdn/boardergo.c linux-2.4.0-test12pre8.ygg/drivers/isdn/hysdn/boardergo.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/hysdn/boardergo.c	Wed Nov 29 03:41:45 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/isdn/hysdn/boardergo.c	Sun Dec 10 20:35:59 2000
@@ -458,7 +458,7 @@
 	card->writebootseq = ergo_writebootseq;
 	card->waitpofready = ergo_waitpofready;
 	card->set_errlog_state = ergo_set_errlog_state;
-	card->irq_queue.next = 0;
+	INIT_LIST_HEAD(&card->irq_queue.list);
 	card->irq_queue.sync = 0;
 	card->irq_queue.data = card;	/* init task queue for interrupt */
 	card->irq_queue.routine = (void *) (void *) ergo_irq_bh;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/pcbit/drv.c linux-2.4.0-test12pre8.ygg/drivers/isdn/pcbit/drv.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/isdn/pcbit/drv.c	Sat Nov 11 23:44:14 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/isdn/pcbit/drv.c	Sun Dec 10 20:34:49 2000
@@ -135,7 +135,7 @@
 	dev->b2->id = 1;
 
 
-	dev->qdelivery.next = NULL;
+	INIT_LIST_HEAD(&dev->qdelivery.list);
 	dev->qdelivery.sync = 0;
 	dev->qdelivery.routine = pcbit_deliver;
 	dev->qdelivery.data = dev;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/net/acenic.c linux-2.4.0-test12pre8.ygg/drivers/net/acenic.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/net/acenic.c	Fri Nov 24 22:21:57 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/net/acenic.c	Sun Dec 10 20:39:03 2000
@@ -2293,7 +2293,7 @@
 	/*
 	 * Setup the bottom half rx ring refill handler
 	 */
-	ap->immediate.next = NULL;
+	INIT_LIST_HEAD(&ap->immediate.list);
 	ap->immediate.sync = 0;
 	ap->immediate.routine = (void *)(void *)ace_bh;
 	ap->immediate.data = dev;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/net/aironet4500_core.c linux-2.4.0-test12pre8.ygg/drivers/net/aironet4500_core.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/net/aironet4500_core.c	Thu Nov 16 20:53:57 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/net/aironet4500_core.c	Sun Dec 10 20:37:45 2000
@@ -2868,7 +2868,7 @@
 	
 	priv->command_semaphore_on = 0;
 	priv->unlock_command_postponed = 0;
-	priv->immediate_bh.next 	= NULL;
+	INIT_LIST_HEAD(&priv->immediate_bh.list);
 	priv->immediate_bh.sync 	= 0;
 	priv->immediate_bh.routine 	= (void *)(void *)awc_bh;
 	priv->immediate_bh.data 	= dev;
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/net/plip.c linux-2.4.0-test12pre8.ygg/drivers/net/plip.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/net/plip.c	Wed Dec  6 03:34:30 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/net/plip.c	Sun Dec 10 20:40:52 2000
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
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/usb/serial/digi_acceleport.c linux-2.4.0-test12pre8.ygg/drivers/usb/serial/digi_acceleport.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/usb/serial/digi_acceleport.c	Wed Dec  6 23:40:32 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/usb/serial/digi_acceleport.c	Sun Dec 10 20:46:51 2000
@@ -1738,7 +1738,7 @@
 		init_waitqueue_head( &priv->dp_flush_wait );
 		priv->dp_in_close = 0;
 		init_waitqueue_head( &priv->dp_close_wait );
-		priv->dp_wakeup_task.next = NULL;
+		INIT_LIST_HEAD( &priv->dp_wakeup_task.list );
 		priv->dp_wakeup_task.sync = 0;
 		priv->dp_wakeup_task.routine = (void *)digi_wakeup_write_lock;
 		priv->dp_wakeup_task.data = (void *)(&serial->port[i]);
diff -u -r linux-2.4.0-test12pre8.ygg.orig/drivers/usb/serial/keyspan_pda.c linux-2.4.0-test12pre8.ygg/drivers/usb/serial/keyspan_pda.c
--- linux-2.4.0-test12pre8.ygg.orig/drivers/usb/serial/keyspan_pda.c	Wed Dec  6 23:40:30 2000
+++ linux-2.4.0-test12pre8.ygg/drivers/usb/serial/keyspan_pda.c	Sun Dec 10 20:48:09 2000
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
diff -u -r linux-2.4.0-test12pre8.ygg.orig/fs/smbfs/sock.c linux-2.4.0-test12pre8.ygg/fs/smbfs/sock.c
--- linux-2.4.0-test12pre8.ygg.orig/fs/smbfs/sock.c	Wed Dec  6 23:30:09 2000
+++ linux-2.4.0-test12pre8.ygg/fs/smbfs/sock.c	Sun Dec 10 20:51:46 2000
@@ -163,7 +163,7 @@
 		found_data(sk);
 		return;
 	}
-	job->cb.next = NULL;
+	INIT_LIST_HEAD(&job->cb.list);
 	job->cb.sync = 0;
 	job->cb.routine = smb_data_callback;
 	job->cb.data = job;

--LQksG6bCIzRHxTLp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
