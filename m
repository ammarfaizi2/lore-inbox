Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVCaX2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVCaX2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVCaX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:26:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:23264 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262061AbVCaXYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:03 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Delete useless instruction in it87
In-Reply-To: <11123113943693@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:14 -0800
Message-Id: <11123113941998@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2344, 2005/03/31 14:31:02-08:00, khali@linux-fr.org

[PATCH] I2C: Delete useless instruction in it87

The IT8705F doesn't support VID, so it's quite pointless to give a value
to it (and an arbitrary one at that). I think that this instruction was
there for compatibility reasons some times ago, but the reasons went
away while the instruction was left in place. We can safely delete it
now.

Thanks to Rudolf Marek for testing the patch (you never know).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/it87.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-03-31 15:16:38 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-03-31 15:16:38 -08:00
@@ -1122,9 +1122,6 @@
 			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
 		}
 
-		/* The 8705 does not have VID capability */
-		data->vid = 0x1f;
-
 		i = it87_read_value(client, IT87_REG_FAN_DIV);
 		data->fan_div[0] = i & 0x07;
 		data->fan_div[1] = (i >> 3) & 0x07;

