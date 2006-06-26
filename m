Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWFZXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWFZXE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933269AbWFZWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:53 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20151 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933265AbWFZWjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:22 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/35] [Suspend2] Filewriter storage available less ignored pages.
Date: Tue, 27 Jun 2006 08:39:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223919.4685.37558.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the number of pages the filewriter will actually use in the provided
storage.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 41aaed4..9046b80 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -154,3 +154,17 @@ static int has_contiguous_blocks(int pag
 	return (j == devinfo.blocks_per_page);
 }
 
+static int size_ignoring_ignored_pages(void)
+{
+	int mappable = 0, i;
+	
+	if (target_is_normal_file()) {
+		for (i = 0; i < (target_inode->i_size >> PAGE_SHIFT) ; i++)
+			if (has_contiguous_blocks(i))
+				mappable++;
+	
+		return mappable;
+	} else
+		return filewriter_storage_available();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
