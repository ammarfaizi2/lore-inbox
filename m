Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSHLBjK>; Sun, 11 Aug 2002 21:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318558AbSHLBjK>; Sun, 11 Aug 2002 21:39:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45463 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318560AbSHLBjJ>;
	Sun, 11 Aug 2002 21:39:09 -0400
Date: Sun, 11 Aug 2002 18:29:23 -0700 (PDT)
Message-Id: <20020811.182923.02248401.davem@redhat.com>
To: uzi@uzix.org
Cc: kieran@esperi.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Ultrasparc 1 network freeze
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020811223010.GB16890@uzix.org>
References: <Pine.LNX.4.43.0208112110500.391-100000@amaterasu.srvr.nix>
	<20020811223010.GB16890@uzix.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Joshua Uziel <uzi@uzix.org>
   Date: Sun, 11 Aug 2002 15:30:11 -0700
   
   Yep... known issue with the sunhme driver.
  ...  
   --- drivers/net/sunhme.c.orig	Mon Jul 15 02:38:27 2002
   +++ drivers/net/sunhme.c	Mon Jul 15 03:09:03 2002

Hmmm, can the people who can reproduce this try this patch
instead?

--- drivers/net/sunhme.c.~1~	Sun Aug 11 18:37:34 2002
+++ drivers/net/sunhme.c	Sun Aug 11 18:38:17 2002
@@ -1640,6 +1640,7 @@
 	HMD((", enable global interrupts, "));
 	hme_write32(hp, gregs + GREG_IMASK,
 		    (GREG_IMASK_GOTFRAME | GREG_IMASK_RCNTEXP |
+		     GREG_IMASK_TXALL |
 		     GREG_IMASK_SENTFRAME | GREG_IMASK_TXPERR));
 
 	/* Set the transmit ring buffer size. */
@@ -2125,8 +2126,8 @@
 		happy_meal_mif_interrupt(hp);
 	}
 
-	if (happy_status & GREG_STAT_TXALL) {
-		HMD(("TXALL "));
+	if (happy_status & GREG_STAT_HOSTTOTX) {
+		HMD(("HOSTTOTX "));
 		happy_meal_tx(hp);
 	}
 
@@ -2155,7 +2156,7 @@
 
 		if (!(happy_status & (GREG_STAT_ERRORS |
 				      GREG_STAT_MIFIRQ |
-				      GREG_STAT_TXALL |
+				      GREG_STAT_HOSTTOTX |
 				      GREG_STAT_RXTOHOST)))
 			continue;
 
@@ -2172,8 +2173,8 @@
 			happy_meal_mif_interrupt(hp);
 		}
 
-		if (happy_status & GREG_STAT_TXALL) {
-			HMD(("TXALL "));
+		if (happy_status & GREG_STAT_HOSTTOTX) {
+			HMD(("HOSTTOTX "));
 			happy_meal_tx(hp);
 		}
 
