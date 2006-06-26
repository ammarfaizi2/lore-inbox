Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933175AbWFZWgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933175AbWFZWgC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933124AbWFZWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:29 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:37279 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933110AbWFZWfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:19 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/20] [Suspend2] Get size of a free region.
Date: Tue, 27 Jun 2006 08:35:17 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223516.4050.50770.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the size of a range of free pages beginning at the given page, and
finishing at the end of the zone in which the page is found if not before.
The page given may not itself be free, in which case the return value will
be zero.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index bf38334..0030661 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -222,3 +222,21 @@ static void generate_free_page_map(void)
 	}
 }
 
+/* size_of_free_region
+ * 
+ * Description:	Return the number of pages that are free, beginning with and 
+ * 		including this one.
+ */
+static int size_of_free_region(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	struct page *posn = page, *last_in_zone =
+		pfn_to_page(zone->zone_start_pfn) + zone->spanned_pages - 1;
+
+	while (posn < last_in_zone && !PageInUse(posn)) {
+		BUG_ON(PagePageset2(posn));
+		posn++;
+	}
+	return (posn - page);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
