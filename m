Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933189AbWFZX36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933189AbWFZX36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933160AbWFZX3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:29:24 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:38303 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933166AbWFZWf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:26 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/20] [Suspend2] Amount of memory still to be freed.
Date: Tue, 27 Jun 2006 08:35:24 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223522.4050.6529.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the amount of memory that needs to be freed to meet hard
constraints such as available storage and possibly also the soft
user-defined image size limit.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 14ab1a4..c85ce6b 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -343,3 +343,22 @@ static struct pageset_sizes_result count
 	return result;
 }
 
+/* amount_needed
+ *
+ * Calculates the amount by which the image size needs to be reduced to meet
+ * our constraints.
+ */
+static int amount_needed(int use_image_size_limit)
+{
+
+	int max1 = max( (int) (ram_to_suspend() - real_nr_free_pages() - 
+			  nr_free_highpages()),
+			((int) (storage_needed(1, 0) -  
+			  storage_available)));
+	if (use_image_size_limit)
+		return max( max1,
+			    (image_size_limit > 0) ? 
+			    ((int) (storage_needed(1, 0) - (image_size_limit << 8))) : 0);
+	return max1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
