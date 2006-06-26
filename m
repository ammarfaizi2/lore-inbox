Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933141AbWFZXnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933141AbWFZXnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933126AbWFZWeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:1259 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933129AbWFZWde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:34 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/16] [Suspend2] Allocate/free bitmaps.
Date: Tue, 27 Jun 2006 08:33:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223331.3832.8920.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation and freeing routines for the bitmaps Suspend2 uses.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 769ae96..06ab034 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -469,3 +469,22 @@ int debuginfo_read_proc(char *page, char
 	return copy_len;
 }
 
+static int allocate_bitmaps(void)
+{
+	if (allocate_dyn_pageflags(&in_use_map) ||
+	    allocate_dyn_pageflags(&pageset1_map) ||
+	    allocate_dyn_pageflags(&pageset1_copy_map) ||
+	    allocate_dyn_pageflags(&pageset2_map))
+		return 1;
+
+	return 0;
+}
+
+static void free_metadata(void)
+{
+	free_dyn_pageflags(&pageset1_map);
+	free_dyn_pageflags(&pageset1_copy_map);
+	free_dyn_pageflags(&pageset2_map);
+	free_dyn_pageflags(&in_use_map);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
