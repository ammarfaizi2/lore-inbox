Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRDGShD>; Sat, 7 Apr 2001 14:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDGSgw>; Sat, 7 Apr 2001 14:36:52 -0400
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129164AbRDGSgm>;
	Sat, 7 Apr 2001 14:36:42 -0400
Message-ID: <20010405225123.A288@bug.ucw.cz>
Date: Thu, 5 Apr 2001 22:51:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: andrew.grover@intel.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Serious bug in ACPI enumeration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My "toshiba workaround" was not toshiba specific: you stopped scanning
at first device that was not present. That's bad, you have to continue
scanning. Here's fix.

								Pavel

--- clean/drivers/acpi/namespace/nsxfobj.c	Sun Apr  1 00:23:00 2001
+++ linux/drivers/acpi/namespace/nsxfobj.c	Thu Apr  5 22:49:18 2001
@@ -592,7 +595,7 @@
 
 	status = acpi_cm_execute_STA (node, &flags);
 	if (ACPI_FAILURE (status)) {
-		return (status);
+		return AE_OK;
 	}
 
 	if (!(flags & 0x01)) {


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
