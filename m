Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWFZWyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWFZWyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWFZWyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:54:11 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33463 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933308AbWFZWkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 31/35] [Suspend2] Serialise filewriter config in image header.
Date: Tue, 27 Jun 2006 08:40:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224048.4685.40506.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines to save and load the target in the image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index ee371ce..d0730fc 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -988,3 +988,28 @@ out:
 	return result;
 }
 
+/* filewriter_save_config_info
+ *
+ * Description:	Save the target's name, not for resume time, but for all_settings.
+ * Arguments:	Buffer:		Pointer to a buffer of size PAGE_SIZE.
+ * Returns:	Number of bytes used for saving our data.
+ */
+
+static int filewriter_save_config_info(char *buffer)
+{
+	strcpy(buffer, filewriter_target);
+	return strlen(filewriter_target) + 1;
+}
+
+/* filewriter_load_config_info
+ *
+ * Description:	Reload target's name.
+ * Arguments:	Buffer:		Pointer to the start of the data.
+ *		Size:		Number of bytes that were saved.
+ */
+
+static void filewriter_load_config_info(char *buffer, int size)
+{
+	strcpy(filewriter_target, buffer);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
