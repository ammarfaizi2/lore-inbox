Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTBOTQy>; Sat, 15 Feb 2003 14:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbTBOTQy>; Sat, 15 Feb 2003 14:16:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57872 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265077AbTBOTQG>; Sat, 15 Feb 2003 14:16:06 -0500
Subject: PATCH: specialix fix from 2.4 missing in 2.5
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:26:18 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7x4-0007Iz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/char/sx.c linux-2.5.61-ac1/drivers/char/sx.c
--- linux-2.5.61/drivers/char/sx.c	2003-02-15 03:39:30.000000000 +0000
+++ linux-2.5.61-ac1/drivers/char/sx.c	2003-02-14 23:16:53.000000000 +0000
@@ -2233,6 +2233,23 @@
 			return 0; 
 	}
 
+	/* Now we're pretty much convinced that there is an SI board here, 
+	   but to prevent trouble, we'd better double check that we don't
+	   have an SI1 board when we're probing for an SI2 board.... */
+
+	write_sx_byte (board, SI2_ISA_ID_BASE,0x10); 
+	if ( IS_SI1_BOARD(board)) {
+		/* This should be an SI1 board, which has this
+		   location writable... */
+		if (read_sx_byte (board, SI2_ISA_ID_BASE) != 0x10)
+			return 0; 
+	} else {
+		/* This should be an SI2 board, which has the bottom
+		   3 bits non-writable... */
+		if (read_sx_byte (board, SI2_ISA_ID_BASE) == 0x10)
+			return 0; 
+	}
+
 	printheader ();
 
 	printk (KERN_DEBUG "sx: Found an SI board at %lx\n", board->hw_base);


--
Dim rhyfel mewn ein enw ni
