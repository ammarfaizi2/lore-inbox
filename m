Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWFZXey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWFZXey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWFZXeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:34:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:35743 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933154AbWFZWfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:09 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/20] [Suspend2] Calculate header storage needed.
Date: Tue, 27 Jun 2006 08:35:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223506.4050.44990.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the total amount of storage needed (in pages) for the image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 9f1eb74..5070735 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -120,3 +120,16 @@ static long main_storage_needed(int use_
 	 (use_ecr ? suspend_expected_compression_ratio() : 100) / 100);
 }
 
+/*
+ * Storage needed for the image header, in bytes until the return.
+ */
+static int header_storage_needed(void)
+{
+	unsigned long bytes =
+		sizeof(struct suspend_header) +
+	 	(int) suspend_header_storage_for_modules() +
+		suspend_pageflags_space_needed();
+
+	return ((int) ((bytes + (int) PAGE_SIZE - 1) >> PAGE_SHIFT));
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
