Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSDCC1C>; Tue, 2 Apr 2002 21:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313018AbSDCC0s>; Tue, 2 Apr 2002 21:26:48 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:38143 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313019AbSDCCZi>;
	Tue, 2 Apr 2002 21:25:38 -0500
Date: Tue, 2 Apr 2002 18:25:34 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] : ir257_irtty_stats.diff
Message-ID: <20020402182534.I24912@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir257_irtty_stats.diff :
----------------------
        <Following patch from Frank Becker>
	o [FEATURE] Update dev tx stats at the right time

diff -u -p linux/drivers/net/irda/irtty.d5.c linux/drivers/net/irda/irtty.c
--- linux/drivers/net/irda/irtty.d5.c	Thu Mar 21 15:28:08 2002
+++ linux/drivers/net/irda/irtty.c	Thu Mar 21 15:29:38 2002
@@ -713,8 +713,6 @@ static void irtty_write_wakeup(struct tt
 
 		self->tx_buff.data += actual;
 		self->tx_buff.len  -= actual;
-
-		self->stats.tx_packets++;		      
 	} else {		
 		/* 
 		 *  Now serial buffer is almost free & we can start 
@@ -722,6 +720,8 @@ static void irtty_write_wakeup(struct tt
 		 */
 		IRDA_DEBUG(5, __FUNCTION__ "(), finished with frame!\n");
 		
+		self->stats.tx_packets++;		      
+
 		tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
 
 		if (self->new_speed) {
