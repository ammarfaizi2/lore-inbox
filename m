Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbVJQRKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbVJQRKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVJQRKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:10:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20427 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750997AbVJQRJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:09:56 -0400
Date: Mon, 17 Oct 2005 12:04:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, acpi-devel@lists.sourceforge.net
Subject: Fix /proc/acpi/events around suspend
Message-ID: <20051017100438.GA2971@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -EIO on /proc/acpi/events after suspends. This actually breaks
suspending by power button in many setups.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit a6660667ecd52e68a1b51ab9135d722d974ba171
tree e915e150ec69ec6b1cf15a8d9302bf06665ad1f6
parent cce1c483de7404e3d6320d650af23373be4c39af
author <pavel@amd.(none)> Tue, 11 Oct 2005 23:10:55 +0200
committer <pavel@amd.(none)> Tue, 11 Oct 2005 23:10:55 +0200

 drivers/acpi/event.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -58,9 +58,8 @@ acpi_system_read_event(struct file *file
 			return_VALUE(-EAGAIN);
 
 		result = acpi_bus_receive_event(&event);
-		if (result) {
-			return_VALUE(-EIO);
-		}
+		if (result)
+			return_VALUE(result);
 
 		chars_remaining = sprintf(str, "%s %s %08x %08x\n",
 					  event.device_class ? event.

-- 
Thanks, Sharp!
