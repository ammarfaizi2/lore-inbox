Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946461AbWJSU14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946461AbWJSU14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946453AbWJSU1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:27:23 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:32412 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1946457AbWJSU0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:49 -0400
Message-id: <2618228894234632957@wsc.cz>
Subject: [PATCH 7/7] Char: isicom, check kmalloc retval
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 22:26:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, check kmalloc retval

Value returned from kamlloc may be NULL, we should check if ENOMEM occured.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a026bdacd388dd774b6e6bd50dcb12adb10115f1
tree f729251fccf62c68dfc4e126574f2e1ee898a35a
parent b298d99f4a779fb54b0035f0f870d5247b13b269
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:47:29 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:47:29 +0200

 drivers/char/isicom.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 2f5be09..a3d59a6 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1708,6 +1708,11 @@ static int __devinit load_firmware(struc
 		}
 
 		data = kmalloc(word_count * 2, GFP_KERNEL);
+		if (data == NULL) {
+			dev_err(&pdev->dev, "Card%d, firmware upload "
+				"failed, not enough memory\n", index + 1);
+			goto errrelfw;
+		}
 		inw(base);
 		insw(base, data, word_count);
 		InterruptTheCard(base);
