Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933274AbWFZXH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274AbWFZXH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933279AbWFZXHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:07:25 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23735 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933266AbWFZWjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:46 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/35] [Suspend2] Get filewriter storage allocated.
Date: Tue, 27 Jun 2006 08:39:44 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223943.4685.51982.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the amount of filewriter storage that is currently allocated.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 002f73c..74d97a0 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -400,3 +400,18 @@ static int prepare_signature(struct file
 	return 0;
 }
 
+static int filewriter_storage_allocated(void)
+{
+	int result;
+
+	if (!target_inode)
+		return 0;
+
+	if (target_is_normal_file()) {
+		result = (int) target_storage_available;
+	} else
+		result = header_pages + main_pages;
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
