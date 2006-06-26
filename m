Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933278AbWFZXF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbWFZXF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933286AbWFZXFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:05:17 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24247 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933287AbWFZWjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/35] [Suspend2] Release allocated filewriter storage.
Date: Tue, 27 Jun 2006 08:39:47 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223946.4685.83347.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Free storage allocated for filewriter use.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 74d97a0..257acca 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -415,3 +415,15 @@ static int filewriter_storage_allocated(
 	return result;
 }
 
+static int filewriter_release_storage(void)
+{
+	if ((test_action_state(SUSPEND_KEEP_IMAGE)) &&
+	     test_suspend_state(SUSPEND_NOW_RESUMING))
+		return 0;
+
+	suspend_put_extent_chain(&block_chain);
+
+	header_pages = main_pages = 0;
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
