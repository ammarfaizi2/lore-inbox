Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424285AbWLBRzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424285AbWLBRzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424301AbWLBRzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:55:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55557 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424285AbWLBRzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:55:00 -0500
Date: Sat, 2 Dec 2006 18:55:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pcmcia/m32r_cfc.c: fix compilation
Message-ID: <20061202175505.GT11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More fallout of the post 2.6.19-rc1 IRQ changes...

<--  snip  -->

...
  CC      drivers/pcmcia/m32r_cfc.o
In function 'pcc_interrupt_wrapper':
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/drivers/pcmcia/m32r_cfc.c:401: 
error: too many arguments to function 'pcc_interrupt'
make[3]: *** [drivers/pcmcia/m32r_cfc.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/drivers/pcmcia/m32r_cfc.c.old	2006-12-02 18:40:16.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/pcmcia/m32r_cfc.c	2006-12-02 18:40:41.000000000 +0100
@@ -398,7 +398,7 @@
 static void pcc_interrupt_wrapper(u_long data)
 {
 	debug(3, "m32r_cfc: pcc_interrupt_wrapper:\n");
-	pcc_interrupt(0, NULL, NULL);
+	pcc_interrupt(0, NULL);
 	init_timer(&poll_timer);
 	poll_timer.expires = jiffies + poll_interval;
 	add_timer(&poll_timer);

