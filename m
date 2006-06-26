Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933126AbWFZXng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126AbWFZXng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933131AbWFZWd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:33:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:1771 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933126AbWFZWdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/16] [Suspend2] Check if still keeping an existing image.
Date: Tue, 27 Jun 2006 08:33:35 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223334.3832.50002.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend2 supports a keep-the-image mode, which can be used when the
contents of mounted filesystems don't change. Writeable storage can still
be used, but it needs to be unmounted while suspending and remounted on
resume.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 06ab034..6457d75 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -488,3 +488,17 @@ static void free_metadata(void)
 	free_dyn_pageflags(&in_use_map);
 }
 
+static int check_still_keeping_image(void)
+{
+	if (test_action_state(SUSPEND_KEEP_IMAGE)) {
+		printk("Image already stored: powering down immediately.");
+		suspend_power_down();
+		return 1;	/* Just in case we're using S3 */
+	}
+
+	printk("Invalidating previous image.\n");
+	suspend_active_writer->invalidate_image();
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
