Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbULAAX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbULAAX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbULAAUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:20:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:51940 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261296AbULAAO0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:26 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600191194@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:39 -0800
Message-Id: <11018600193456@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.6, 2004/11/24 14:26:15-08:00, aris@cathedrallabs.org

[PATCH] [2/2] i2c-elektor: adding missing casts

[I2C] i2c-elektor: adding missing casts

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-elektor.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2004-11-30 16:00:59 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2004-11-30 16:00:59 -08:00
@@ -80,10 +80,10 @@
 		break;
 	case 2: /* double mapped I/O needed for UP2000 board,
                    I don't know why this... */
-		writeb(val, address);
+		writeb(val, (void *)address);
 		/* fall */
 	case 1: /* memory mapped I/O */
-		writeb(val, address);
+		writeb(val, (void *)address);
 		break;
 	}
 }
@@ -91,7 +91,7 @@
 static int pcf_isa_getbyte(void *data, int ctl)
 {
 	int address = ctl ? (base + 1) : base;
-	int val = mmapped ? readb(address) : inb(address);
+	int val = mmapped ? readb((void *)address) : inb(address);
 
 	pr_debug("i2c-elektor: Read 0x%X 0x%02X\n", address, val);
 

