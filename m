Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTBPUAu>; Sun, 16 Feb 2003 15:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTBPUAu>; Sun, 16 Feb 2003 15:00:50 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:20398 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S267366AbTBPUAt>;
	Sun, 16 Feb 2003 15:00:49 -0500
Date: Sun, 16 Feb 2003 21:09:47 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][2.5] Signal handling changes broke 8139too
Message-ID: <20030216200947.GA5369@k3.hellgate.ch>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.61 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Starting with 2.5.61, 8139too takes forever (30+ seconds) to take an
interface down. This gets the driver back to regular fraction of a second
time. Works for me.

Roger


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8139too.c-2.5.61-sigterm.diff"

--- linux-2.5.61/drivers/net/8139too.c.orig	Sun Feb 16 20:44:00 2003
+++ linux-2.5.61/drivers/net/8139too.c	Sun Feb 16 20:44:16 2003
@@ -1589,7 +1589,7 @@
 	unsigned long timeout;
 
 	daemonize("%s", dev->name);
-	allow_signal(SIGKILL);
+	allow_signal(SIGTERM);
 
 	while (1) {
 		timeout = next_tick;

--WIyZ46R2i8wDzkSu--
