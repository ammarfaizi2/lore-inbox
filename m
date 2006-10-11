Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161475AbWJKVNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161475AbWJKVNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161470AbWJKVNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:13:34 -0400
Received: from av1.karneval.cz ([81.27.192.123]:2581 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161461AbWJKVNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:13:30 -0400
Message-id: <32432111423423@karneval.cz>
Subject: [PATCH 1/4] Char: mxser_new, correct intr handler proto
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed, 11 Oct 2006 23:13:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, correct intr handler proto

Prototype of the driver's interrupt handler is old-fashioned, past changes
tell us, we won't get pt_regs as the 3rd argument. There are only 2 params.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 945bdc94338eb55b6c4dd1198357abb5acb93dd4
tree 58c36b048ea0409a598fd98087c993b87f36e7a0
parent 6831c804c9fc98965c297a1b6ba47a92d94d2ce7
author Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 21:11:01 +0200
committer Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 21:11:01 +0200

 drivers/char/mxser_new.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 0bc13f7..d9e5400 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2265,7 +2265,7 @@ unlock:
 /*
  * This is the serial driver's generic interrupt routine
  */
-static irqreturn_t mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 {
 	int status, iir, i;
 	struct mxser_board *brd = NULL;
