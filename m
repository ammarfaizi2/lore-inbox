Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSHFUwP>; Tue, 6 Aug 2002 16:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSHFUvN>; Tue, 6 Aug 2002 16:51:13 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:34276 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315919AbSHFUuc>;
	Tue, 6 Aug 2002 16:50:32 -0400
Date: Tue, 6 Aug 2002 13:54:09 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_irtty_stats.diff
Message-ID: <20020806205409.GH11677@bougret.hpl.hp.com>
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

ir240_irtty_stats.diff :
----------------------
        <Following patch from Frank Becker>
	o [FEATURE] Update dev tx stats at the right time


--- linux/drivers/net/irda/irtty.d5.c	Thu Jun  6 17:53:06 2002
+++ linux/drivers/net/irda/irtty.c	Thu Jun  6 17:53:16 2002
@@ -714,8 +714,6 @@ static void irtty_write_wakeup(struct tt
 
 		self->tx_buff.data += actual;
 		self->tx_buff.len  -= actual;
-
-		self->stats.tx_packets++;		      
 	} else {		
 		/* 
 		 *  Now serial buffer is almost free & we can start 
@@ -723,6 +721,8 @@ static void irtty_write_wakeup(struct tt
 		 */
 		IRDA_DEBUG(5, __FUNCTION__ "(), finished with frame!\n");
 		
+		self->stats.tx_packets++;		      
+
 		tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
 
 		if (self->new_speed) {
