Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRE0TkO>; Sun, 27 May 2001 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbRE0Tjy>; Sun, 27 May 2001 15:39:54 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:30273
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262021AbRE0Tju>; Sun, 27 May 2001 15:39:50 -0400
Date: Sun, 27 May 2001 21:39:43 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] missing rio_spin_unlock_irqrestore in rioroute.c (244ac18)
Message-ID: <20010527213943.I857@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<sigh> Forgot l-k when sending this off..

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Hi.

The following patch fixes a missing rio_spin_unlock_irqrestore
in drivers/char/rio/rioroute.c as per the stanford team's
report a way back. It applies against 244ac18.


--- linux-244-ac18-clean/drivers/char/rio/rioroute.c	Sat May 19 20:58:18 2001
+++ linux-244-ac18/drivers/char/rio/rioroute.c	Sun May 27 20:46:34 2001
@@ -657,6 +657,7 @@
 			*/
 			if (PortP->TxStart == 0) {
 					rio_dprintk (RIO_DEBUG_ROUTE, "Tx pkts not set up yet\n");
+					rio_spin_unlock_irqrestore(&PortP->portSem, flags);
 					break;
 			}
 
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

While the Melissa license is a bit unclear, Melissa aggressively
encourages free distribution of its source code.
  -- Kevin Dalley on Melissa being Open Source

----- End forwarded message -----
