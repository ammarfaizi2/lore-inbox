Return-Path: <linux-kernel-owner+w=401wt.eu-S1030534AbWLPBcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbWLPBcz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030538AbWLPBcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:32:55 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:38866 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030534AbWLPBcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:32:54 -0500
Message-id: <30714220511571319076@wsc.cz>
In-reply-to: <2880031291415520798@wsc.cz>
Subject: [PATCH 5/5] Char: isicom, support higher rates
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 16 Dec 2006 02:09:49 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, support higher rates

Add support for higher baud rates (coming from original isi driver).

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 8b380d8b1c3ff7d09d68d467d2f135774cab4086
tree d1e9332d7dc76c5f1d80f936bca71312d0bcb07b
parent 601667e4ee38183358ea8f7980537bb8c09d8728
author Jiri Slaby <jirislaby@gmail.com> Sat, 16 Dec 2006 02:05:20 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 16 Dec 2006 02:05:20 +0059

 drivers/char/isicom.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index f4faa76..60df87c 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -183,7 +183,7 @@ static DEFINE_TIMER(tx, isicom_tx, 0, 0);
 /*   baud index mappings from linux defns to isi */
 
 static signed char linuxb_to_isib[] = {
-	-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 16, 17, 18, 19
+	-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 16, 17, 18, 19, 20, 21
 };
 
 struct	isi_board {
@@ -709,7 +709,8 @@ static void isicom_config_port(struct isi_port *port)
 		 *  respectively.
 		 */
 
-		if (baud < 1 || baud > 2)
+		/* 1,2,3,4 => 57.6, 115.2, 230, 460 kbps resp. */
+		if (baud < 1 || baud > 4)
 			port->tty->termios->c_cflag &= ~CBAUDEX;
 		else
 			baud += 15;
@@ -725,6 +726,10 @@ static void isicom_config_port(struct isi_port *port)
 			baud++; /*  57.6 Kbps */
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
 			baud +=2; /*  115  Kbps */
+		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
+			baud += 3; /* 230 kbps*/
+		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
+			baud += 4; /* 460 kbps*/
 	}
 	if (linuxb_to_isib[baud] == -1) {
 		/* hang up */
