Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTBDPdF>; Tue, 4 Feb 2003 10:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTBDPdF>; Tue, 4 Feb 2003 10:33:05 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:50618 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267275AbTBDPdE>; Tue, 4 Feb 2003 10:33:04 -0500
Date: Tue, 4 Feb 2003 16:42:31 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: support@stallion.oz.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fixed type in drivers/char/istallion.c (untested)
Message-ID: <20030204154231.GA22154@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The condition "(portp->brdnr < 0) && (portp->brdnr >= stli_nrbrds)" is
very hard to fulfill. I guess, this is a simple typo.

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law

--- linux-2.4.21-pre3-ac4/drivers/char/istallion.c	Sat Aug  3 02:39:43 2002
+++ scratch/drivers/char/istallion.c	Tue Feb  4 16:09:19 2003
@@ -1501,27 +1501,27 @@
 static int stli_setport(stliport_t *portp)
 {
 	stlibrd_t	*brdp;
 	asyport_t	aport;
 
 #if DEBUG
 	printk("stli_setport(portp=%x)\n", (int) portp);
 #endif
 
 	if (portp == (stliport_t *) NULL)
 		return(-ENODEV);
 	if (portp->tty == (struct tty_struct *) NULL)
 		return(-ENODEV);
-	if ((portp->brdnr < 0) && (portp->brdnr >= stli_nrbrds))
+	if ((portp->brdnr < 0) || (portp->brdnr >= stli_nrbrds))
 		return(-ENODEV);
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == (stlibrd_t *) NULL)
 		return(-ENODEV);
 
 	stli_mkasyport(portp, &aport, portp->tty->termios);
 	return(stli_cmdwait(brdp, portp, A_SETPORT, &aport, sizeof(asyport_t), 0));
 }
 
 /*****************************************************************************/
 
 /*
  *	Wait for a specified delay period, this is not a busy-loop. It will
