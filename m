Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSGYN3y>; Thu, 25 Jul 2002 09:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSGYN2v>; Thu, 25 Jul 2002 09:28:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:765 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314325AbSGYN2h>; Thu, 25 Jul 2002 09:28:37 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251445.g6PEjLCT010405@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) epca and specialix warning fixes
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:45:21 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Event is just used for internal flags and with set_bit for atomicity. This
kills the warning the obvious way

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/char/epca.h linux-2.5.28-ac1/drivers/char/epca.h
--- linux-2.5.28/drivers/char/epca.h	Thu Jul 25 10:48:50 2002
+++ linux-2.5.28-ac1/drivers/char/epca.h	Sun Jul 21 15:31:27 2002
@@ -121,7 +121,7 @@
 	int    close_delay;
 	int    count;
 	int    blocked_open;
-	int    event;
+	ulong  event;
 	int    asyncflags;
 	uint   dev;
 	long   session;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/char/specialix_io8.h linux-2.5.28-ac1/drivers/char/specialix_io8.h
--- linux-2.5.28/drivers/char/specialix_io8.h	Thu Jul 25 10:48:49 2002
+++ linux-2.5.28-ac1/drivers/char/specialix_io8.h	Sun Jul 21 15:35:45 2002
@@ -110,7 +110,7 @@
 	struct tty_struct 	* tty;
 	int			count;
 	int			blocked_open;
-	int			event;
+	ulong			event;
 	int			timeout;
 	int			close_delay;
 	long			session;
