Return-Path: <linux-kernel-owner+w=401wt.eu-S1751223AbWLMWV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWLMWV2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWLMWV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:21:28 -0500
Received: from av1.karneval.cz ([81.27.192.123]:4699 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbWLMWV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:21:28 -0500
X-Greylist: delayed 1171 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 17:21:27 EST
Message-id: <15802280072730218041@karneval.cz>
Subject: [PATCH 1/1] Char: tty, delete wake_up_interruptible after tty_wakeup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Date: Wed, 13 Dec 2006 23:01:46 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tty, delete wake_up_interruptible after tty_wakeup

tty_wakeup calls wake_up_interruptible(&tty->write_wait) itself, it's not
needed to wake up again after tty_wakeup returns.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>

---
commit 740df2239d699c3deda71f3a7790b10fd06c99f8
tree e4b624bb52a581d431b056a0c695b07de2528b97
parent af8e1f039e2f0b822c5b96551b3363da7371b0b5
author Jiri Slaby <jirislaby@gmail.com> Wed, 13 Dec 2006 22:55:22 +0100
committer Jiri Slaby <jirislaby@gmail.com> Wed, 13 Dec 2006 22:55:22 +0100

 drivers/char/tty_io.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 47a6eac..1974d5a 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1612,7 +1612,6 @@ void start_tty(struct tty_struct *tty)
 
 	/* If we have a running line discipline it may need kicking */
 	tty_wakeup(tty);
-	wake_up_interruptible(&tty->write_wait);
 }
 
 EXPORT_SYMBOL(start_tty);
