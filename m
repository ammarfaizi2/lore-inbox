Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWAPRGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWAPRGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWAPRGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:06:10 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19683 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751125AbWAPRGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:06:09 -0500
Subject: PATCH: Remove long dead #if 0 code from rio_param
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:10:23 +0000
Message-Id: <1137431423.15553.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/rioparam.c linux-2.6.15-git12/drivers/char/rio/rioparam.c
--- linux.vanilla-2.6.15-git12/drivers/char/rio/rioparam.c	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/rioparam.c	2006-01-16 16:23:09.574952384 +0000
@@ -195,27 +195,6 @@
 		 ** paramed with OPEN, we want to restore the saved port termio, but
 		 ** only if StoredTermio has been saved, i.e. NOT 1st open after reboot.
 		 */
-#if 0
-		if (PortP->FirstOpen) {
-			PortP->StoredTty.iflag = TtyP->tm.c_iflag;
-			PortP->StoredTty.oflag = TtyP->tm.c_oflag;
-			PortP->StoredTty.cflag = TtyP->tm.c_cflag;
-			PortP->StoredTty.lflag = TtyP->tm.c_lflag;
-			PortP->StoredTty.line = TtyP->tm.c_line;
-			for (i = 0; i < NCC + 5; i++)
-				PortP->StoredTty.cc[i] = TtyP->tm.c_cc[i];
-			PortP->FirstOpen = 0;
-		} else if (PortP->Store || PortP->Lock) {
-			rio_dprintk(RIO_DEBUG_PARAM, "OPEN: Restoring stored/locked params\n");
-			TtyP->tm.c_iflag = PortP->StoredTty.iflag;
-			TtyP->tm.c_oflag = PortP->StoredTty.oflag;
-			TtyP->tm.c_cflag = PortP->StoredTty.cflag;
-			TtyP->tm.c_lflag = PortP->StoredTty.lflag;
-			TtyP->tm.c_line = PortP->StoredTty.line;
-			for (i = 0; i < NCC + 5; i++)
-				TtyP->tm.c_cc[i] = PortP->StoredTty.cc[i];
-		}
-#endif
 	}
 
 	/*
@@ -273,16 +252,6 @@
 	phb_param_ptr = (struct phb_param *) PacketP->data;
 
 
-#if 0
-	/*
-	 ** COR 1
-	 */
-	if (TtyP->tm.c_iflag & INPCK) {
-		rio_dprintk(RIO_DEBUG_PARAM, "Parity checking on input enabled\n");
-		Cor1 |= COR1_INPCK;
-	}
-#endif
-
 	switch (TtyP->termios->c_cflag & CSIZE) {
 	case CS5:
 		{
@@ -524,10 +493,6 @@
 	if (TtyP->termios->c_cflag & XMT1EN)
 		rio_dprintk(RIO_DEBUG_PARAM, "XMT1EN (?)\n");
 #endif
-#if 0
-	if (TtyP->termios->c_cflag & LOBLK)
-		rio_dprintk(RIO_DEBUG_PARAM, "LOBLK - JCL output blocks when not current\n");
-#endif
 	if (TtyP->termios->c_lflag & ISIG)
 		rio_dprintk(RIO_DEBUG_PARAM, "Input character signal generating enabled\n");
 	if (TtyP->termios->c_lflag & ICANON)
@@ -572,14 +537,6 @@
 		rio_dprintk(RIO_DEBUG_PARAM, "Carriage return delay set\n");
 	if (TtyP->termios->c_oflag & TABDLY)
 		rio_dprintk(RIO_DEBUG_PARAM, "Tab delay set\n");
-#if 0
-	if (TtyP->termios->c_oflag & BSDLY)
-		rio_dprintk(RIO_DEBUG_PARAM, "Back-space delay set\n");
-	if (TtyP->termios->c_oflag & VTDLY)
-		rio_dprintk(RIO_DEBUG_PARAM, "Vertical tab delay set\n");
-	if (TtyP->termios->c_oflag & FFDLY)
-		rio_dprintk(RIO_DEBUG_PARAM, "Form-feed delay set\n");
-#endif
 	/*
 	 ** These things are kind of useful in a later life!
 	 */

