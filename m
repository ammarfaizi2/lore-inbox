Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUDNXKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUDNWeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:34:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:60831 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262019AbUDNWZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:30 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <1081981453937@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:14 -0700
Message-Id: <10819814543859@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.30, 2004/04/14 13:10:38-07:00, khali@linux-fr.org

[PATCH] I2C: Fix voltage rounding in asb100

This one line patch fixes voltage rounding in the asb100 chip driver.
It's very similar to a patch I submitted for the lm80 a few days ago.


 drivers/i2c/chips/asb100.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:13 2004
+++ b/drivers/i2c/chips/asb100.c	Wed Apr 14 15:12:13 2004
@@ -124,7 +124,7 @@
 static u8 IN_TO_REG(unsigned val)
 {
 	unsigned nval = SENSORS_LIMIT(val, ASB100_IN_MIN, ASB100_IN_MAX);
-	return nval / 16;
+	return (nval + 8) / 16;
 }
 
 static unsigned IN_FROM_REG(u8 reg)

