Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264161AbUE1WMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUE1WMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUE1WJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:09:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:33982 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264058AbUE1WB2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:01:28 -0400
Subject: Re: [PATCH] I2C update for 2.6.7-rc1
In-Reply-To: <10857816431296@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 28 May 2004 15:00:43 -0700
Message-Id: <10857816431433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.29, 2004/05/28 13:47:51-07:00, khali@linux-fr.org

[PATCH] I2C: i2c-parport: support the ADM1031 evaluation board

The following patch adds support for the ADM1030 and ADM1031 evaluation
boards to the i2c-parport and i2c-parport-light drivers. They are almost
compatible with the already supported ADM1025 and ADM1032 boards, except
that the ADM1032 board needs some pins to be set high to draw its power,
while the same pins power up heating resistors on the ADM1031 board. I
considered it was a bit dangerous to do that by default, so I ended up
with two different device definitions, one with powering pins set, and
one with these pins cleared.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-parport.h |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-parport.h
--- a/drivers/i2c/busses/i2c-parport.h	Fri May 28 14:52:07 2004
+++ b/drivers/i2c/busses/i2c-parport.h	Fri May 28 14:52:07 2004
@@ -67,13 +67,18 @@
 		.getsda	= { 0x40, STAT, 1 },
 		.getscl	= { 0x08, STAT, 1 },
 	},
-	/* type 4: ADM1025 and ADM1032 evaluation boards */
+	/* type 4: ADM1032 evaluation board */
+	{
+		.setsda	= { 0x02, DATA, 1 },
+		.setscl	= { 0x01, DATA, 1 },
+		.getsda	= { 0x10, STAT, 1 },
+		.init	= { 0xf0, DATA, 0 },
+	},
+	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
-		.init	= { 0xf0, DATA, 0 }, /* ADM1025 doesn't need this,
-						but it doesn't hurt */
 	},
 };
 
@@ -85,4 +90,5 @@
 	" 1 = home brew teletext adapter\n"
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
-	" 4 = ADM1025 and ADM1032 evaluation boards\n");
+	" 4 = ADM1032 evaluation board\n"
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");

