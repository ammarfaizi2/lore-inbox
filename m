Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUDNXD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDNWeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:34:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:60319 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262014AbUDNWZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:30 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814533933@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:13 -0700
Message-Id: <10819814532188@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.28, 2004/04/12 15:17:24-07:00, khali@linux-fr.org

[PATCH] I2C: Fix voltage rounding in lm80

This one line patch fixes voltage rounding in the lm80 chip driver.


 drivers/i2c/chips/lm80.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	Wed Apr 14 15:12:26 2004
+++ b/drivers/i2c/chips/lm80.c	Wed Apr 14 15:12:26 2004
@@ -68,7 +68,7 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 
-#define IN_TO_REG(val)		(SENSORS_LIMIT((val)/10,0,255))
+#define IN_TO_REG(val)		(SENSORS_LIMIT(((val)+5)/10,0,255))
 #define IN_FROM_REG(val)	((val)*10)
 
 static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)

