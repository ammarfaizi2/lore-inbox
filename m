Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUHXAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUHXAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUHWTvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:51:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:47555 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266833AbUHWSgU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:20 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286088677@kroah.com>
Date: Mon, 23 Aug 2004 11:34:48 -0700
Message-Id: <10932860881850@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.38, 2004/08/09 13:42:54-07:00, khali@linux-fr.org

[PATCH] I2C: fix for previous lm83 driver update

Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm83.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2004-08-23 11:03:01 -07:00
+++ b/drivers/i2c/chips/lm83.c	2004-08-23 11:03:01 -07:00
@@ -83,10 +83,10 @@
  * The LM83 uses signed 8-bit values.
  */
 
-#define TEMP_FROM_REG(val)	(((val) > 127 ? (val)-0xFF : (val)) * 1000)
-#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0xFF : (val) >= 127000 ? 127 : \
+#define TEMP_FROM_REG(val)	(((val) > 127 ? (val) - 0x100 : (val)) * 1000)
+#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0x100 : (val) >= 127000 ? 127 : \
 				 (val) > -500 ? ((val)+500) / 1000 : \
-				 ((val)-500) / 1000 + 0xFF)
+				 ((val)-500) / 1000 + 0x100)
 
 static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,

