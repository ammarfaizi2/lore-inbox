Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314054AbSDQEYf>; Wed, 17 Apr 2002 00:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSDQEYe>; Wed, 17 Apr 2002 00:24:34 -0400
Received: from pandora.cantech.net.au ([203.26.6.29]:53254 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S314054AbSDQEYd>; Wed, 17 Apr 2002 00:24:33 -0400
Date: Wed, 17 Apr 2002 12:23:29 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Comments for drivers/char/rio
Message-ID: <Pine.LNX.4.33.0204171211480.14274-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier,
	Here is an updated version of the patch we discussed back in Febuary.
It has been updated to 2.4.19-pre6.

Alan, Marcelo and LKML
	This patch simply adds a few comments to drivers/char/rio/* to stop
spurious email about functions returning "EBLAH" instead of "-EBLAH"


Yours Tony.

/*
 * "The significant problems we face cannot be solved at the 
 * same level of thinking we were at when we created them."
 * --Albert Einstein
 */

--------------------------------------------------------------------------------
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/char/rio/rioboot.c linux-2.4.19-pre6/drivers/char/rio/rioboot.c
--- linux-2.4.19-pre6.clean/drivers/char/rio/rioboot.c	Fri Sep 21 11:10:42 2001
+++ linux-2.4.19-pre6/drivers/char/rio/rioboot.c	Tue Apr 16 16:38:28 2002
@@ -27,6 +27,11 @@
 **
 **  ident @(#)rioboot.c	1.3
 **
+** Changes:
+**    AJBT (Anthony J. Breeds-Taurima, tony@cantech.net.au):
+**       Code review: Resulted in some clarifying comments to prevent
+**       recurring non-fixes...
+**
 ** -----------------------------------------------------------------------------
 */
 
@@ -129,6 +134,8 @@
 		p->RIOError.Error = HOST_FILE_TOO_LARGE;
 		/* restore(oldspl); */
 		func_exit ();
+		/* This IS correct,  any return values will be translated in rio_linux 
+		   Before they are passed out of the driver. -- AJBT & REW */
 		return ENOMEM;
 	}
 
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/char/rio/riocmd.c linux-2.4.19-pre6/drivers/char/rio/riocmd.c
--- linux-2.4.19-pre6.clean/drivers/char/rio/riocmd.c	Mon Feb 18 18:02:06 2002
+++ linux-2.4.19-pre6/drivers/char/rio/riocmd.c	Tue Apr 16 16:38:28 2002
@@ -98,6 +98,8 @@
 
 	if ( !CmdBlkP ) {
 		rio_dprintk (RIO_DEBUG_CMD, "FOAD RTA: GetCmdBlk failed\n");
+		/* This IS correct,  any return values will be translated in rio_linux 
+		   Before they are passed out of the driver. -- AJBT & REW */
 		return ENXIO;
 	}
 
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/char/rio/rioctrl.c linux-2.4.19-pre6/drivers/char/rio/rioctrl.c
--- linux-2.4.19-pre6.clean/drivers/char/rio/rioctrl.c	Mon May 14 15:42:42 2001
+++ linux-2.4.19-pre6/drivers/char/rio/rioctrl.c	Tue Apr 16 16:38:28 2002
@@ -230,6 +230,8 @@
 						}
 					}
 				} else if (host >= p->RIONumHosts) {
+		/* This IS correct,  any return values will be translated in rio_linux 
+		   Before they are passed out of the driver. -- AJBT & REW */
 					return EINVAL;
 				} else {
 					if ( p->RIOHosts[host].Flags == RC_RUNNING ) {
diff -urN -X /usr/src/dontdiff linux-2.4.19-pre6.clean/drivers/char/rio/riotable.c linux-2.4.19-pre6/drivers/char/rio/riotable.c
--- linux-2.4.19-pre6.clean/drivers/char/rio/riotable.c	Mon Oct 22 16:04:39 2001
+++ linux-2.4.19-pre6/drivers/char/rio/riotable.c	Tue Apr 16 16:38:28 2002
@@ -125,6 +125,8 @@
 	rio_dprintk (RIO_DEBUG_TABLE, "RIONewTable: entering(1)\n"); 
 	if ( p->RIOSystemUp ) {		/* (1) */
 		p->RIOError.Error = HOST_HAS_ALREADY_BEEN_BOOTED;
+		/* This IS correct,  any return values will be translated in rio_linux 
+		   Before they are passed out of the driver. -- AJBT & REW */
 		return EBUSY;
 	}
 

