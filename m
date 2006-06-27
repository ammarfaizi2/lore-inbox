Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933412AbWF0EyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933412AbWF0EyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933417AbWF0ElF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:05 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:37851 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933413AbWF0Ekr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/13] [Suspend2] Serialise storage manager config in an image header.
Date: Tue, 27 Jun 2006 14:40:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044044.14778.72361.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines to read and write the storage manager configuration.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index 5fdcadd..714e95e 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -154,3 +154,19 @@ static unsigned long usm_storage_needed(
 	return strlen(usm_helper_data.program);
 }
 
+static int usm_save_config_info(char *buf)
+{
+	int len = strlen(usm_helper_data.program);
+	memcpy(buf, usm_helper_data.program, len);
+	return len;
+}
+
+static void usm_load_config_info(char *buf, int size)
+{
+	/* Don't load the saved path if one has already been set */
+	if (usm_helper_data.program[0])
+		return;
+
+	memcpy(usm_helper_data.program, buf, size);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
