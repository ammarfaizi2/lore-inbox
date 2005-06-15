Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVFOVye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVFOVye (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVFOVko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:40:44 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:30381 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261594AbVFOVha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:37:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Zcro6SAbC3nPMddgloF6Tsw/9pwQQoDnyX1yWfqS/EGtoIvtnHlHADdPaQGdK4NlH23T34qjKNHKaD7H3i5cpvRHFUJEEfmM+dV5QvgBunF1N96xgWuSYAJ4rm5KJhmQBcX+NRHdkpyfQpwdmo3wK03EBBscxU54Iz10h4zhSEg=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] Convert users to tty_unregister_ldisc()
Date: Thu, 16 Jun 2005 01:42:17 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506160142.17467.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tty_register_ldisc(N_FOO, NULL) => tty_unregister_ldisc(N_FOO)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/bluetooth/hci_ldisc.c |    2 +-
 drivers/char/n_hdlc.c         |    2 +-
 drivers/char/n_r3964.c        |    2 +-
 drivers/input/serio/serport.c |    2 +-
 drivers/net/hamradio/6pack.c  |    2 +-
 drivers/net/hamradio/mkiss.c  |    2 +-
 drivers/net/irda/irtty-sir.c  |    2 +-
 drivers/net/ppp_async.c       |    2 +-
 drivers/net/ppp_synctty.c     |    2 +-
 drivers/net/slip.c            |    2 +-
 drivers/net/wan/x25_asy.c     |    2 +-
 drivers/net/wireless/strip.c  |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff -uprN linux-tty_register_ldisc_001/drivers/bluetooth/hci_ldisc.c linux-tty_register_ldisc_002/drivers/bluetooth/hci_ldisc.c
--- linux-tty_register_ldisc_001/drivers/bluetooth/hci_ldisc.c	2005-05-31 20:13:29.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/bluetooth/hci_ldisc.c	2005-05-31 23:30:50.000000000 +0400
@@ -576,7 +576,7 @@ static void __exit hci_uart_exit(void)
 #endif
 
 	/* Release tty registration of line discipline */
-	if ((err = tty_register_ldisc(N_HCI, NULL)))
+	if ((err = tty_unregister_ldisc(N_HCI)))
 		BT_ERR("Can't unregister HCI line discipline (%d)", err);
 }
 
diff -uprN linux-tty_register_ldisc_001/drivers/char/n_hdlc.c linux-tty_register_ldisc_002/drivers/char/n_hdlc.c
--- linux-tty_register_ldisc_001/drivers/char/n_hdlc.c	2005-05-31 20:13:33.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/char/n_hdlc.c	2005-05-31 23:29:30.000000000 +0400
@@ -960,7 +960,7 @@ static char hdlc_unregister_fail[] __exi
 static void __exit n_hdlc_exit(void)
 {
 	/* Release tty registration of line discipline */
-	int status = tty_register_ldisc(N_HDLC, NULL);
+	int status = tty_unregister_ldisc(N_HDLC);
 
 	if (status)
 		printk(hdlc_unregister_fail, status);
diff -uprN linux-tty_register_ldisc_001/drivers/char/n_r3964.c linux-tty_register_ldisc_002/drivers/char/n_r3964.c
--- linux-tty_register_ldisc_001/drivers/char/n_r3964.c	2005-05-31 20:13:33.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/char/n_r3964.c	2005-05-31 23:29:55.000000000 +0400
@@ -200,7 +200,7 @@ static void __exit r3964_exit(void)
    
    TRACE_M ("cleanup_module()");
 
-   status=tty_register_ldisc(N_R3964, NULL);
+   status=tty_unregister_ldisc(N_R3964);
    
    if(status!=0)
    {
diff -uprN linux-tty_register_ldisc_001/drivers/input/serio/serport.c linux-tty_register_ldisc_002/drivers/input/serio/serport.c
--- linux-tty_register_ldisc_001/drivers/input/serio/serport.c	2005-05-31 20:13:40.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/input/serio/serport.c	2005-05-31 23:30:21.000000000 +0400
@@ -257,7 +257,7 @@ static int __init serport_init(void)
 
 static void __exit serport_exit(void)
 {
-	tty_register_ldisc(N_MOUSE, NULL);
+	tty_unregister_ldisc(N_MOUSE);
 }
 
 module_init(serport_init);
diff -uprN linux-tty_register_ldisc_001/drivers/net/hamradio/6pack.c linux-tty_register_ldisc_002/drivers/net/hamradio/6pack.c
--- linux-tty_register_ldisc_001/drivers/net/hamradio/6pack.c	2005-05-31 20:13:52.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/hamradio/6pack.c	2005-05-31 23:28:22.000000000 +0400
@@ -848,7 +848,7 @@ static void __exit sixpack_exit_driver(v
 {
 	int ret;
 
-	if ((ret = tty_register_ldisc(N_6PACK, NULL)))
+	if ((ret = tty_unregister_ldisc(N_6PACK)))
 		printk(msg_unregfail, ret);
 }
 
diff -uprN linux-tty_register_ldisc_001/drivers/net/hamradio/mkiss.c linux-tty_register_ldisc_002/drivers/net/hamradio/mkiss.c
--- linux-tty_register_ldisc_001/drivers/net/hamradio/mkiss.c	2005-05-31 20:13:52.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/hamradio/mkiss.c	2005-05-31 23:27:53.000000000 +0400
@@ -934,7 +934,7 @@ static void __exit mkiss_exit_driver(voi
 	kfree(ax25_ctrls);
 	ax25_ctrls = NULL;
 
-	if ((i = tty_register_ldisc(N_AX25, NULL)))
+	if ((i = tty_unregister_ldisc(N_AX25)))
 		printk(KERN_ERR "mkiss: can't unregister line discipline (err = %d)\n", i);
 }
 
diff -uprN linux-tty_register_ldisc_001/drivers/net/irda/irtty-sir.c linux-tty_register_ldisc_002/drivers/net/irda/irtty-sir.c
--- linux-tty_register_ldisc_001/drivers/net/irda/irtty-sir.c	2005-05-31 20:13:53.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/irda/irtty-sir.c	2005-05-31 23:26:38.000000000 +0400
@@ -626,7 +626,7 @@ static void __exit irtty_sir_cleanup(voi
 {
 	int err;
 
-	if ((err = tty_register_ldisc(N_IRDA, NULL))) {
+	if ((err = tty_unregister_ldisc(N_IRDA))) {
 		IRDA_ERROR("%s(), can't unregister line discipline (err = %d)\n",
 			   __FUNCTION__, err);
 	}
diff -uprN linux-tty_register_ldisc_001/drivers/net/ppp_async.c linux-tty_register_ldisc_002/drivers/net/ppp_async.c
--- linux-tty_register_ldisc_001/drivers/net/ppp_async.c	2005-05-31 20:13:54.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/ppp_async.c	2005-05-31 23:27:26.000000000 +0400
@@ -1025,7 +1025,7 @@ static void async_lcp_peek(struct asyncp
 
 static void __exit ppp_async_cleanup(void)
 {
-	if (tty_register_ldisc(N_PPP, NULL) != 0)
+	if (tty_unregister_ldisc(N_PPP) != 0)
 		printk(KERN_ERR "failed to unregister PPP line discipline\n");
 }
 
diff -uprN linux-tty_register_ldisc_001/drivers/net/ppp_synctty.c linux-tty_register_ldisc_002/drivers/net/ppp_synctty.c
--- linux-tty_register_ldisc_001/drivers/net/ppp_synctty.c	2005-05-31 20:13:54.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/ppp_synctty.c	2005-05-31 23:27:04.000000000 +0400
@@ -793,7 +793,7 @@ err:
 static void __exit
 ppp_sync_cleanup(void)
 {
-	if (tty_register_ldisc(N_SYNC_PPP, NULL) != 0)
+	if (tty_unregister_ldisc(N_SYNC_PPP) != 0)
 		printk(KERN_ERR "failed to unregister Sync PPP line discipline\n");
 }
 
diff -uprN linux-tty_register_ldisc_001/drivers/net/slip.c linux-tty_register_ldisc_002/drivers/net/slip.c
--- linux-tty_register_ldisc_001/drivers/net/slip.c	2005-05-31 20:13:56.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/slip.c	2005-05-31 23:28:43.000000000 +0400
@@ -1430,7 +1430,7 @@ static void __exit slip_exit(void)
 	kfree(slip_devs);
 	slip_devs = NULL;
 
-	if ((i = tty_register_ldisc(N_SLIP, NULL)))
+	if ((i = tty_unregister_ldisc(N_SLIP)))
 	{
 		printk(KERN_ERR "SLIP: can't unregister line discipline (err = %d)\n", i);
 	}
diff -uprN linux-tty_register_ldisc_001/drivers/net/wan/x25_asy.c linux-tty_register_ldisc_002/drivers/net/wan/x25_asy.c
--- linux-tty_register_ldisc_001/drivers/net/wan/x25_asy.c	2005-05-31 20:13:57.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/wan/x25_asy.c	2005-05-31 23:26:07.000000000 +0400
@@ -829,7 +829,7 @@ static void __exit exit_x25_asy(void)
 	}
 
 	kfree(x25_asy_devs);
-	tty_register_ldisc(N_X25, NULL);
+	tty_unregister_ldisc(N_X25);
 }
 
 module_init(init_x25_asy);
diff -uprN linux-tty_register_ldisc_001/drivers/net/wireless/strip.c linux-tty_register_ldisc_002/drivers/net/wireless/strip.c
--- linux-tty_register_ldisc_001/drivers/net/wireless/strip.c	2005-05-31 20:13:58.000000000 +0400
+++ linux-tty_register_ldisc_002/drivers/net/wireless/strip.c	2005-05-31 23:29:01.000000000 +0400
@@ -2828,7 +2828,7 @@ static void __exit strip_exit_driver(voi
 	/* Unregister with the /proc/net file here. */
 	proc_net_remove("strip");
 
-	if ((i = tty_register_ldisc(N_STRIP, NULL)))
+	if ((i = tty_unregister_ldisc(N_STRIP)))
 		printk(KERN_ERR "STRIP: can't unregister line discipline (err = %d)\n", i);
 
 	printk(signoff);
