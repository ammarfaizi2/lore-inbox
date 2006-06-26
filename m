Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933158AbWFZWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbWFZWfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933160AbWFZWfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:35231 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933158AbWFZWfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:06 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/20] [Suspend2] Get the amount of storage needed for the image proper.
Date: Tue, 27 Jun 2006 08:35:04 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223502.4050.64496.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the amount of storage required for the image proper, possibly
taking into account the expected compression ratio and possibly also
ignoring the extra pagedir1 allowance.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 271f904..9f1eb74 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -107,3 +107,16 @@ static void get_extra_pd1_allowance(void
 		MIN_EXTRA_PAGES_ALLOWANCE);
 }
 
+/*
+ * Amount of storage needed, possibly taking into account the
+ * expected compression ratio and possibly also ignoring our
+ * allowance for extra pages.
+ */
+static long main_storage_needed(int use_ecr,
+		int ignore_extra_pd1_allow)
+{
+	return ((pagedir1.pageset_size + pagedir2.pageset_size +
+	  (ignore_extra_pd1_allow ? 0 : extra_pd1_pages_allowance)) *
+	 (use_ecr ? suspend_expected_compression_ratio() : 100) / 100);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
