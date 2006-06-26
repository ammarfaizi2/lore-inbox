Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933369AbWFZWws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933369AbWFZWws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933312AbWFZWwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:52:42 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33975 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933315AbWFZWky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 32/35] [Suspend2] Filewriter initialise.
Date: Tue, 27 Jun 2006 08:40:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224051.4685.76572.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the filewriter at the beginning of some work.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index d0730fc..ad35967 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -1013,3 +1013,29 @@ static void filewriter_load_config_info(
 	strcpy(filewriter_target, buffer);
 }
 
+static int filewriter_initialise(int starting_cycle)
+{
+	int result = 0;
+
+	if (starting_cycle) {
+	       if (suspend_active_writer != &filewriterops)
+			return 0;
+
+		if (!*filewriter_target) {
+			printk("Filewriter is the active writer,  but no filename has been set.\n");
+			return 1;
+		}
+	}
+
+	if (filewriter_target)
+		filewriter_get_target_info(filewriter_target, starting_cycle, 0);
+
+	if (starting_cycle && (filewriter_image_exists() == -1)) {
+		printk("%s is does not have a valid signature for suspending.\n",
+				filewriter_target);
+		result = 1;
+	}
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
