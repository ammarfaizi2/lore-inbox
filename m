Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270103AbUJTDgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270103AbUJTDgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUJTAcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:32:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:9652 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267363AbUJTATb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:31 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315062289@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:26 -0700
Message-Id: <1098231506642@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2069, 2004/10/19 15:14:51-07:00, khali@linux-fr.org

[PATCH] I2C: Spare 1 byte in lm90 driver

I just noticed the other day that the lm90 driver uses an u16 to store
the value of the 8-bit alarms register. This is most probably due to the
fact that I originally copied the lm90 driver from the lm83 driver,
which actually has two 8-bit registers for alarms, and obviously forgot
to change the variable type.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm90.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2004-10-19 16:54:14 -07:00
+++ b/drivers/i2c/chips/lm90.c	2004-10-19 16:54:14 -07:00
@@ -185,7 +185,7 @@
 	s16 temp_input2, temp_low2, temp_high2; /* remote, combined */
 	s8 temp_crit1, temp_crit2;
 	u8 temp_hyst;
-	u16 alarms; /* bitvector, combined */
+	u8 alarms; /* bitvector */
 };
 
 /*

