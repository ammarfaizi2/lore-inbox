Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265223AbUFMRM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUFMRM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUFMRM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:12:58 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:62774 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265223AbUFMRMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:12:24 -0400
Subject: Re: Badness in local_bh_enable with eciadsl driver and kernel 2.6
From: Paul Fulghum <paulkf@microgate.com>
To: areversat@tuxfamily.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1087145610.2266.1.camel@hosts>
References: <1087145610.2266.1.camel@hosts>
Content-Type: multipart/mixed; boundary="=-AUPZyecbS0m8Hz9V8JpV"
Message-Id: <1087146654.2517.1.camel@doobie.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 13 Jun 2004 12:10:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AUPZyecbS0m8Hz9V8JpV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-06-13 at 11:53, areversat wrote:
> Hi,
> here is what most users get when running our driver (usb adsl modem
> driver) with kernel 2.6.x. I'd like to know if it is a kernel bug or if
> it has something to do with our driver.
> 
> Thanks
> 
> Badness in local_bh_enable at kernel/softirq.c:136
> [<0212407a>] local_bh_enable+0x39/0x5c
> [<42f0499e>] ppp_sync_push+0xd2/0x149 [ppp_synctty]
> [<42f044aa>] ppp_sync_wakeup+0x1d/0x35 [ppp_synctty]
> [<021d549f>] do_tty_hangup+0x12d/0x34c
> [<021d652d>] release_dev+0x1c0/0x53f
> [<0222e096>] usb_unbind_interface+0x41/0x50
> [<021f4a8d>] device_release_driver+0x3c/0x46
> [<0222e27e>] usb_driver_release_interface+0x2c/0x40
> [<02235b32>] releaseintf+0x76/0x8f
> [<021d6bc6>] tty_release+0x29/0x4e
> [<02152baf>] __fput+0x3f/0xe3
> [<0215189c>] filp_close+0x59/0x5f
> [<02122006>] put_files_struct+0x57/0xaa
> [<02122b45>] do_exit+0x211/0x390
> [<02122dc0>] sys_exit_group+0x0/0xd
> [<0212986b>] get_signal_to_deliver+0x34c/0x372
> [<02107208>] do_signal+0x4e/0xbb
> [<02160dc3>] file_ioctl+0x167/0x17b
> [<02161010>] sys_ioctl+0x239/0x243
> [<0210729d>] do_notify_resume+0x28/0x37

Try the attached patch.

--
Paul Fulghum
paulkf@microgate.com

--=-AUPZyecbS0m8Hz9V8JpV
Content-Disposition: attachment; filename=patch-ppp_synctty.c
Content-Type: text/x-csrc; name=patch-ppp_synctty.c; charset=utf-8
Content-Transfer-Encoding: 7bit

>From linux-kernel-owner@vger.kernel.org Wed Jun  2 15:57:19 2004
Return-Path:
	<linux-kernel-owner+paulkf=40microgate.com-S264090AbUFBUtX@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	sol.microgate.com (8.11.6/8.11.6) with ESMTP id i52KvIY20222 for
	<paulkf@microgate.com>; Wed, 2 Jun 2004 15:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S264090AbUFBUtX (ORCPT <rfc822;paulkf@microgate.com>); Wed, 2 Jun 2004
	16:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFBUtX
	(ORCPT <rfc822;linux-kernel-outgoing>); Wed, 2 Jun 2004 16:49:23 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:54838
	"EHLO sol.microgate.com") by vger.kernel.org with ESMTP id S264090AbUFBUtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>); Wed, 2 Jun 2004 16:49:13
	-0400
Received: from deimos.microgate.com (deimos.microgate.com [192.168.0.12])
	by sol.microgate.com (8.11.6/8.11.6) with ESMTP id i52KnCY20117; Wed, 2 Jun
	2004 15:49:12 -0500
Subject: [PATCH][RFC] 2.6.6 ppp_synctty.c
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Organization: 
Message-Id: <1086209351.2163.7.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 	02 Jun 2004 15:49:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: 	linux-kernel@vger.kernel.org
Content-Type: text/plain; CHARSET=US-ASCII
X-Evolution-Source: imap://paulkf@mail.microgate.com/
Content-Transfer-Encoding: 8bit

This patch adapts the changes made by Paul Mackerras
to ppp_async.c which allow for the fact that
a line discipline receive and wakeup callbacks
can be called at hard interrupt context and/or
with interrupts disabled.

I have tested with a synchronous serial PPP connection.

Comments and other testing requested.

Thanks,
Paul

--
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.6/drivers/net/ppp_synctty.c	2004-04-03 21:36:57.000000000 -0600
+++ linux-2.6.6-mg1/drivers/net/ppp_synctty.c	2004-06-02 15:01:35.177725315 -0500
@@ -65,7 +65,9 @@
 	struct sk_buff	*tpkt;
 	unsigned long	last_xmit;
 
-	struct sk_buff	*rpkt;
+	struct sk_buff_head rqueue;
+
+	struct tasklet_struct tsk;
 
 	atomic_t	refcnt;
 	struct semaphore dead_sem;
@@ -88,6 +90,7 @@
 static int ppp_sync_send(struct ppp_channel *chan, struct sk_buff *skb);
 static int ppp_sync_ioctl(struct ppp_channel *chan, unsigned int cmd,
 			  unsigned long arg);
+static void ppp_sync_process(unsigned long arg);
 static int ppp_sync_push(struct syncppp *ap);
 static void ppp_sync_flush_output(struct syncppp *ap);
 static void ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
@@ -217,6 +220,9 @@
 	ap->xaccm[3] = 0x60000000U;
 	ap->raccm = ~0U;
 
+	skb_queue_head_init(&ap->rqueue);
+	tasklet_init(&ap->tsk, ppp_sync_process, (unsigned long) ap);
+
 	atomic_set(&ap->refcnt, 1);
 	init_MUTEX_LOCKED(&ap->dead_sem);
 
@@ -267,10 +273,10 @@
 	 */
 	if (!atomic_dec_and_test(&ap->refcnt))
 		down(&ap->dead_sem);
+	tasklet_kill(&ap->tsk);
 
 	ppp_unregister_channel(&ap->chan);
-	if (ap->rpkt != 0)
-		kfree_skb(ap->rpkt);
+	skb_queue_purge(&ap->rqueue);
 	if (ap->tpkt != 0)
 		kfree_skb(ap->tpkt);
 	kfree(ap);
@@ -369,17 +375,24 @@
 	return 65535;
 }
 
+/*
+ * This can now be called from hard interrupt level as well
+ * as soft interrupt level or mainline.
+ */
 static void
 ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
-		  char *flags, int count)
+		  char *cflags, int count)
 {
 	struct syncppp *ap = sp_get(tty);
+	unsigned long flags;
 
 	if (ap == 0)
 		return;
-	spin_lock_bh(&ap->recv_lock);
-	ppp_sync_input(ap, buf, flags, count);
-	spin_unlock_bh(&ap->recv_lock);
+	spin_lock_irqsave(&ap->recv_lock, flags);
+	ppp_sync_input(ap, buf, cflags, count);
+	spin_unlock_irqrestore(&ap->recv_lock, flags);
+	if (skb_queue_len(&ap->rqueue))
+		tasklet_schedule(&ap->tsk);
 	sp_put(ap);
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags)
 	    && tty->driver->unthrottle)
@@ -394,8 +407,8 @@
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	if (ap == 0)
 		return;
-	if (ppp_sync_push(ap))
-		ppp_output_wakeup(&ap->chan);
+	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
+	tasklet_schedule(&ap->tsk);
 	sp_put(ap);
 }
 
@@ -449,9 +462,9 @@
 		if (get_user(val, (int *) arg))
 			break;
 		ap->flags = val & ~SC_RCV_BITS;
-		spin_lock_bh(&ap->recv_lock);
+		spin_lock_irq(&ap->recv_lock);
 		ap->rbits = val & SC_RCV_BITS;
-		spin_unlock_bh(&ap->recv_lock);
+		spin_unlock_irq(&ap->recv_lock);
 		err = 0;
 		break;
 
@@ -512,6 +525,32 @@
 }
 
 /*
+ * This is called at softirq level to deliver received packets
+ * to the ppp_generic code, and to tell the ppp_generic code
+ * if we can accept more output now.
+ */
+static void ppp_sync_process(unsigned long arg)
+{
+	struct syncppp *ap = (struct syncppp *) arg;
+	struct sk_buff *skb;
+
+	/* process received packets */
+	while ((skb = skb_dequeue(&ap->rqueue)) != NULL) {
+		if (skb->len == 0) {
+			/* zero length buffers indicate error */
+			ppp_input_error(&ap->chan, 0);
+			kfree_skb(skb);
+		}
+		else
+			ppp_input(&ap->chan, skb);
+	}
+
+	/* try to push more stuff out */
+	if (test_bit(XMIT_WAKEUP, &ap->xmit_flags) && ppp_sync_push(ap))
+		ppp_output_wakeup(&ap->chan);
+}
+
+/*
  * Procedures for encapsulation and framing.
  */
 
@@ -600,7 +639,6 @@
 	struct tty_struct *tty = ap->tty;
 	int tty_stuffed = 0;
 
-	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
 	if (!spin_trylock_bh(&ap->xmit_lock))
 		return 0;
 	for (;;) {
@@ -667,15 +705,44 @@
  * Receive-side routines.
  */
 
-static inline void
-process_input_packet(struct syncppp *ap)
+/* called when the tty driver has data for us. 
+ *
+ * Data is frame oriented: each call to ppp_sync_input is considered
+ * a whole frame. If the 1st flag byte is non-zero then the whole
+ * frame is considered to be in error and is tossed.
+ */
+static void
+ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
+		char *flags, int count)
 {
 	struct sk_buff *skb;
 	unsigned char *p;
-	int code = 0;
 
-	skb = ap->rpkt;
-	ap->rpkt = 0;
+	if (count == 0)
+		return;
+
+	if (ap->flags & SC_LOG_INPKT)
+		ppp_print_buffer ("receive buffer", buf, count);
+
+	/* stuff the chars in the skb */
+	if ((skb = dev_alloc_skb(ap->mru + PPP_HDRLEN + 2)) == 0) {
+		printk(KERN_ERR "PPPsync: no memory (input pkt)\n");
+		goto err;
+	}
+	/* Try to get the payload 4-byte aligned */
+	if (buf[0] != PPP_ALLSTATIONS)
+		skb_reserve(skb, 2 + (buf[0] & 1));
+
+	if (flags != 0 && *flags) {
+		/* error flag set, ignore frame */
+		goto err;
+	} else if (count > skb_tailroom(skb)) {
+		/* packet overflowed MRU */
+		goto err;
+	}
+
+	p = skb_put(skb, count);
+	memcpy(p, buf, count);
 
 	/* strip address/control field if present */
 	p = skb->data;
@@ -693,59 +760,15 @@
 	} else if (skb->len < 2)
 		goto err;
 
-	/* pass to generic layer */
-	ppp_input(&ap->chan, skb);
+	/* queue the frame to be processed */
+	skb_queue_tail(&ap->rqueue, skb);
 	return;
 
- err:
-	kfree_skb(skb);
-	ppp_input_error(&ap->chan, code);
-}
-
-/* called when the tty driver has data for us. 
- *
- * Data is frame oriented: each call to ppp_sync_input is considered
- * a whole frame. If the 1st flag byte is non-zero then the whole
- * frame is considered to be in error and is tossed.
- */
-static void
-ppp_sync_input(struct syncppp *ap, const unsigned char *buf,
-		char *flags, int count)
-{
-	struct sk_buff *skb;
-	unsigned char *sp;
-
-	if (count == 0)
-		return;
-
-	/* if flag set, then error, ignore frame */
-	if (flags != 0 && *flags) {
-		ppp_input_error(&ap->chan, *flags);
-		return;
-	}
-
-	if (ap->flags & SC_LOG_INPKT)
-		ppp_print_buffer ("receive buffer", buf, count);
-
-	/* stuff the chars in the skb */
-	if ((skb = ap->rpkt) == 0) {
-		if ((skb = dev_alloc_skb(ap->mru + PPP_HDRLEN + 2)) == 0) {
-			printk(KERN_ERR "PPPsync: no memory (input pkt)\n");
-			ppp_input_error(&ap->chan, 0);
-			return;
-		}
-		/* Try to get the payload 4-byte aligned */
-		if (buf[0] != PPP_ALLSTATIONS)
-			skb_reserve(skb, 2 + (buf[0] & 1));
-		ap->rpkt = skb;
-	}
-	if (count > skb_tailroom(skb)) {
-		/* packet overflowed MRU */
-		ppp_input_error(&ap->chan, 1);
-	} else {
-		sp = skb_put(skb, count);
-		memcpy(sp, buf, count);
-		process_input_packet(ap);
+err:
+	/* queue zero length packet as error indication */
+	if (skb || (skb = dev_alloc_skb(0))) {
+		skb_trim(skb, 0);
+		skb_queue_tail(&ap->rqueue, skb);
 	}
 }
 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--=-AUPZyecbS0m8Hz9V8JpV--

