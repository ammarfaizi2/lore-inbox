Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWFYIQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWFYIQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 04:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWFYIQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 04:16:09 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:30876
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750879AbWFYIQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 04:16:08 -0400
Message-ID: <449E4646.3020805@ed-soft.at>
Date: Sun, 25 Jun 2006 10:16:06 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] Fix acpi dmi blacklisting on Intel Macs
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes acpi dmi blacklisting on
native booted Intel Macs. I'm not sure
if this is also ok for other EFI powerd
Intel Boxes.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--- a/drivers/acpi/blacklist.c	2006-06-25 10:00:40.000000000 +0200
+++ b/drivers/acpi/blacklist.c	2006-06-25 10:04:06.000000000 +0200
@@ -79,6 +79,9 @@
 {
 	int year = dmi_get_year(DMI_BIOS_DATE);
 
+	if (efi_enabled)
+		return 0;
+
 	/* Doesn't exist? Likely an old system */
 	if (year == -1) 
 		return 1;


