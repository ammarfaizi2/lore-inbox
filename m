Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933121AbWFZWdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933121AbWFZWdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933113AbWFZWby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:31:54 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:61930 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933108AbWFZWbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:45 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 4/7] [Suspend2] Space needed to store one set of pageflags.
Date: Tue, 27 Jun 2006 08:31:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223141.3725.33148.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
References: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the number of bytes in the image header required to store one set of
pageflags.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pageflags.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pageflags.c b/kernel/power/pageflags.c
index ec028d3..7c00257 100644
--- a/kernel/power/pageflags.c
+++ b/kernel/power/pageflags.c
@@ -43,3 +43,16 @@ static int pages_for_zone(struct zone *z
 			(PAGE_SIZE << 3);
 }
 
+int suspend_pageflags_space_needed(void)
+{
+	int total = 0;
+	struct zone *zone;
+
+	for_each_zone(zone)
+		total += sizeof(int) * 2 + pages_for_zone(zone) * PAGE_SIZE;
+
+	total += sizeof(int);
+
+	return total;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
