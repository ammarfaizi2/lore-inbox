Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277105AbRJHTlF>; Mon, 8 Oct 2001 15:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277099AbRJHTkz>; Mon, 8 Oct 2001 15:40:55 -0400
Received: from marvin.nildram.co.uk ([195.112.4.71]:64007 "HELO
	marvin.nildram.co.uk") by vger.kernel.org with SMTP
	id <S277105AbRJHTkl>; Mon, 8 Oct 2001 15:40:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Toby Milne <toby@svector.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.10-ac9 CDRW Packet Fix
Date: Mon, 8 Oct 2001 20:35:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15qgFQ-0004pk-00@avalon.svector.gotadsl.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ac tree is missing some braces - without these the userspace buffer 
contents never get copied into the kernel buffer.

--- linux/drivers/cdrom/cdrom.c	Mon Oct  8 19:20:56 2001
+++ linux-2.4.10-ac9/drivers/cdrom/cdrom.c	Mon Oct  8 19:19:04 2001
@@ -1983,10 +1983,10 @@
 	if (usense && !access_ok(VERIFY_WRITE, usense, sizeof(*usense)))
 		goto out;

-	if (cgc->data_direction == CGC_DATA_READ)
+	if (cgc->data_direction == CGC_DATA_READ) {
 		if (!access_ok(VERIFY_READ, ubuf, cgc->buflen))
 			goto out;
-	else if (cgc->data_direction == CGC_DATA_WRITE)
+	} else if (cgc->data_direction == CGC_DATA_WRITE)
 		if (copy_from_user(cgc->buffer, ubuf, cgc->buflen))
 			goto out;
