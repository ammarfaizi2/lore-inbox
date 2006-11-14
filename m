Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966456AbWKNXaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966456AbWKNXaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966465AbWKNXaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:30:24 -0500
Received: from mx0.karneval.cz ([81.27.192.122]:62573 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S966456AbWKNXaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:30:23 -0500
Message-id: <5784263591328927442@karneval.cz>
Subject: [PATCH 1/1] Char: isicom, fix close bug
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Torvalds <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Wed, 15 Nov 2006 00:30:17 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any chance to have this in 2.6.19?

--

isicom, fix close bug

port is dereferenced even if it is NULL. Dereference it _after_ the check
if (!port)... Thanks Eric <ef87@yahoo.com> for reporting this.
[http://bugzilla.kernel.org/show_bug.cgi?id=7527]

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 3b03fd9a68de624866b52b9e9a93d551839c0128
tree 77fff66a8b34516b014e9adbe55a9f1027de14c4
parent 0579e303553655245e8a6616bd8b4428b07d63a2
author Jiri Slaby <jirislaby@gmail.com> Wed, 15 Nov 2006 00:25:30 +0100
committer Jiri Slaby <jirislaby@gmail.com> Wed, 15 Nov 2006 00:25:30 +0100

 drivers/char/isicom.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index e9e9bf3..58c955e 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1062,11 +1062,12 @@ static void isicom_shutdown_port(struct 
 static void isicom_close(struct tty_struct *tty, struct file *filp)
 {
 	struct isi_port *port = tty->driver_data;
-	struct isi_board *card = port->card;
+	struct isi_board *card;
 	unsigned long flags;
 
 	if (!port)
 		return;
+	card = port->card;
 	if (isicom_paranoia_check(port, tty->name, "isicom_close"))
 		return;
 
