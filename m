Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbULIBxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbULIBxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbULIBxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:53:32 -0500
Received: from palrel12.hp.com ([156.153.255.237]:22729 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261437AbULIBwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:52:50 -0500
Date: Wed, 8 Dec 2004 17:52:28 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Use kill_urb() in stir4200
Message-ID: <20041209015228.GC2298@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_stir4200-kill-1.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
USB changed behaviour of unlink_urb so that it gives warning and backtrace when
being used synchronously. The correct current behaviour is to us kill_urb
in that case.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -Nru a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
--- a/drivers/net/irda/stir4200.c	2004-11-29 10:11:58 -08:00
+++ b/drivers/net/irda/stir4200.c	2004-11-29 10:11:58 -08:00
@@ -705,7 +705,7 @@
 static void receive_stop(struct stir_cb *stir)
 {
 	stir->receiving = 0;
-	usb_unlink_urb(stir->rx_urb);
+	usb_kill_urb(stir->rx_urb);
 
 	if (stir->rx_buff.in_frame) 
 		stir->stats.collisions++;
@@ -974,7 +974,7 @@
 	kfree(stir->fifo_status);
 
 	/* Mop up receive urb's */
-	usb_unlink_urb(stir->rx_urb);
+	usb_kill_urb(stir->rx_urb);
 	
 	kfree(stir->io_buf);
 	usb_free_urb(stir->rx_urb);
