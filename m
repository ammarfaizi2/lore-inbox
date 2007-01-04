Return-Path: <linux-kernel-owner+w=401wt.eu-S1030210AbXADVHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbXADVHw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbXADVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:07:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:7205 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030191AbXADVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:07:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=f7EnX0JS5wrsGqe/9/OH36SNO6nIiaThkeGxElKr+6Qg1OcMiK98zPGajq8kCfbUZrtmznDVMsqTfXCMB5QTW7MzbUjpF0PdEzoMwA58tWOI7pMgDBWc2B7BASX7X3Xnl1vWhA2jgIZSzlE2ETEl4dxrsnOSG98jSAar27NBBdg=
Message-ID: <459D6CA2.8000703@gmail.com>
Date: Thu, 04 Jan 2007 22:07:46 +0100
From: Matthijs van Otterdijk <thotter@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: hmacht@suse.de
CC: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: [PATCH] fix the toshiba_acpi write_lcd return value 
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the write_lcd function in toshiba_acpi returns 0 on success since the big ACPI
patch merged in 2.6.20-rc2. It should return count.

Signed-off-by: Matthijs van Otterdijk <thotter@gmail.com>
---
 drivers/acpi/toshiba_acpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -up a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
--- a/drivers/acpi/toshiba_acpi.c	2007-01-04 18:41:03.000000000 +0100
+++ b/drivers/acpi/toshiba_acpi.c	2007-01-04 19:36:32.000000000 +0100
@@ -321,11 +321,11 @@ static int set_lcd_status(struct backlig
 static unsigned long write_lcd(const char *buffer, unsigned long count)
 {
 	int value;
-	int ret = count;
+	int ret;
 
 	if (sscanf(buffer, " brightness : %i", &value) == 1 &&
 	    value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS)
-		ret = set_lcd(value);
+		ret = (ret = set_lcd(value)) == 0 ? count : ret;
 	else
 		ret = -EINVAL;
 	return ret;
