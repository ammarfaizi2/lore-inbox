Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVLQR1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVLQR1r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 12:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVLQR1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 12:27:47 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:44433 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932613AbVLQR1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 12:27:46 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] update Toshiba ohci quirk DMI table
Date: Sat, 17 Dec 2005 09:27:50 -0800
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WqEpDdXvTMJc39X"
Message-Id: <200512170927.50760.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WqEpDdXvTMJc39X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I upgraded my Toshiba Satellite BIOS recently to see if it would fix an 
ACPI related problem I have 
(http://bugzilla.kernel.org/show_bug.cgi?id=5727).  Unfortunately, it 
didn't, and moreover, Toshiba chose to change the system version in the 
DMI table with the update, causing the OHCI1394 related quirk to break.  
This patch updates the DMI table for the quirk to include Toshiba's new 
version name for this machine; I've tested it and it seems to work 
fine.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--Boundary-00=_WqEpDdXvTMJc39X
Content-Type: text/x-diff;
  charset="us-ascii";
  name="toshiba-ohci1394-fixup-dmitable-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="toshiba-ohci1394-fixup-dmitable-update.patch"

diff --git a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
index eeb1b1f..65f6707 100644
--- a/arch/i386/pci/fixup.c
+++ b/arch/i386/pci/fixup.c
@@ -413,6 +413,13 @@ static struct dmi_system_id __devinitdat
 			DMI_MATCH(DMI_PRODUCT_VERSION, "PSM4"),
 		},
 	},
+	{
+		.ident = "Toshiba A40 based laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "PSA40U"),
+		},
+	},
 	{ }
 };
 

--Boundary-00=_WqEpDdXvTMJc39X--
