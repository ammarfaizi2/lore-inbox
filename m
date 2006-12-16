Return-Path: <linux-kernel-owner+w=401wt.eu-S1030526AbWLPBcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWLPBcz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030540AbWLPBcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:32:55 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:38867 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030526AbWLPBcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:32:54 -0500
X-Greylist: delayed 1389 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 20:32:54 EST
Message-id: <3240146701999923690@wsc.cz>
In-reply-to: <2880031291415520798@wsc.cz>
Subject: [PATCH 4/5] Char: isicom, check card state in isr
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 16 Dec 2006 02:09:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, check card state in isr

Check if the card really interrupted us by reading its IO space and
eventualy return IRQ_NONE.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 601667e4ee38183358ea8f7980537bb8c09d8728
tree ccb1c085309ad35178f8d741e7c074308ae277ee
parent 405c17b09b010b41f6ec2388a11777e4048c7976
author Jiri Slaby <jirislaby@gmail.com> Fri, 15 Dec 2006 23:29:57 +0059
committer Jiri Slaby <jirislaby@gmail.com> Fri, 15 Dec 2006 23:29:57 +0059

 drivers/char/isicom.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 7968160..f4faa76 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -539,6 +539,11 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	base = card->base;
+
+	/* did the card interrupt us? */
+	if (!(inw(base + 0x0e) & 0x02))
+		return IRQ_NONE;
+
 	spin_lock(&card->card_lock);
 
 	/*
