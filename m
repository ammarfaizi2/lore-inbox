Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270261AbUJTBNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270261AbUJTBNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbUJTBIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:08:49 -0400
Received: from palrel11.hp.com ([156.153.255.246]:25517 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S270261AbUJTBHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:07:34 -0400
Date: Tue, 19 Oct 2004 18:07:33 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Stir driver usb reset fix
Message-ID: <20041020010733.GJ12932@bougret.hpl.hp.com>
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

irXXX_stir_reset.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] stir4200 - get rid of reset on speed change
The Sigmatel 4200 doesn't accept the address setting which gets done on
USB reset.  The USB core recently changed to resend address (or
something like that), so usb_reset_device is failing.

The device works without doing the USB reset on speed change, it just
will be less robust in recovering when things get wedged (like coming
out of FIR mode).

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -Nru a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
--- a/drivers/net/irda/stir4200.c	2004-10-08 14:01:29 -07:00
+++ b/drivers/net/irda/stir4200.c	2004-10-08 14:01:29 -07:00
@@ -520,11 +520,6 @@
  found:
 	pr_debug("speed change from %d to %d\n", stir->speed, speed);
 
-	/* sometimes needed to get chip out of stuck state */
-	err = usb_reset_device(stir->usbdev);
-	if (err)
-		goto out;
-
 	/* Reset modulator */
 	err = write_reg(stir, REG_CTRL1, CTRL1_SRESET);
 	if (err)


