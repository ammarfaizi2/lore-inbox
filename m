Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbSLEFbX>; Thu, 5 Dec 2002 00:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbSLEFbX>; Thu, 5 Dec 2002 00:31:23 -0500
Received: from pandora.cantech.net.au ([203.26.6.29]:11282 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S267227AbSLEFbW>; Thu, 5 Dec 2002 00:31:22 -0500
Date: Thu, 5 Dec 2002 13:38:24 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.50 drivers/char/rio/rioctrl.c
Message-ID: <Pine.LNX.4.44.0212051327020.14195-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	This patch continues the work started by Arnaldo Carvalho de Melo
<acme@conectiva.com.br>.  It converts a couple of possible return EPERM to
return -EPERM.  It also changes a generic return 1 to return -ENOMEM

--------------------------------------------------------------------------------
diff -X dontdiff -urN linux-2.5.50.clean/drivers/char/rio/rioctrl.c linux-2.5.50.rio/drivers/char/rio/rioctrl.c
--- linux-2.5.50.clean/drivers/char/rio/rioctrl.c	2002-12-04 17:50:09.000000000 +0800
+++ linux-2.5.50.rio/drivers/char/rio/rioctrl.c	2002-12-05 11:08:44.000000000 +0800
@@ -524,7 +524,7 @@
 					else {
 		 				rio_dprintk (RIO_DEBUG_CTRL, "p->RIOBindTab full! - Rta %x not added\n",
 		  					(int) arg);
-		 				return 1;
+		 				return -ENOMEM;
 					}
 					return 0;
 				}
@@ -1595,12 +1595,12 @@
 			case RIO_NO_MESG:
 				if ( su )
 					 p->RIONoMessage = 1;
-				return su ? 0 : EPERM;
+				return su ? 0 : -EPERM;
 
 			case RIO_MESG:
 				if ( su )
 					p->RIONoMessage = 0;
-				return su ? 0 : EPERM;
+				return su ? 0 : -EPERM;
 
 			case RIO_WHAT_MESG:
 				if ( copyout( (caddr_t)&p->RIONoMessage, (int)arg, 
--------------------------------------------------------------------------------

Yours Tony

   Jan 22-25 2003           Linux.Conf.AU            http://linux.conf.au/
		  The Australian Linux Technical Conference!

