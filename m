Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbVCEAms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbVCEAms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbVCEAjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:39:35 -0500
Received: from palrel13.hp.com ([156.153.255.238]:1473 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263488AbVCEAaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:30:04 -0500
Date: Fri, 4 Mar 2005 16:29:52 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] cleanup obsolete construct in IrCOMM
Message-ID: <20050305002951.GH23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir261_ircomm_write_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] cleanup some construct obsoleted by Linus's patch
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>



diff -u -p linux/net/irda/ircomm/ircomm_tty.d0.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d0.c	Fri Feb  4 16:19:03 2005
+++ linux/net/irda/ircomm/ircomm_tty.c	Fri Feb  4 16:20:54 2005
@@ -671,10 +671,9 @@ static void ircomm_tty_do_softint(void *
  *    accepted for writing. This routine is mandatory.
  */
 static int ircomm_tty_write(struct tty_struct *tty,
-			    const unsigned char *ubuf, int count)
+			    const unsigned char *buf, int count)
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
-	unsigned char *kbuf;		/* Buffer in kernel space */
 	unsigned long flags;
 	struct sk_buff *skb;
 	int tailroom = 0;
@@ -714,9 +713,6 @@ static int ircomm_tty_write(struct tty_s
 	if (count < 1)
 		return 0;
 
-	/* The buffer is already in kernel space */
-	kbuf = (unsigned char *) ubuf;
-
 	/* Protect our manipulation of self->tx_skb and related */
 	spin_lock_irqsave(&self->spinlock, flags);
 
@@ -779,7 +775,7 @@ static int ircomm_tty_write(struct tty_s
 		}
 
 		/* Copy data */
-		memcpy(skb_put(skb,size), kbuf + len, size);
+		memcpy(skb_put(skb,size), buf + len, size);
 
 		count -= size;
 		len += size;
