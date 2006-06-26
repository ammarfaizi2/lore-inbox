Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933191AbWFZWgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933191AbWFZWgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933178AbWFZWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:17 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:40863 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933171AbWFZWfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:42 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 16/20] [Suspend2] Calculate storage needed for an image.
Date: Tue, 27 Jun 2006 08:35:41 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223540.4050.60649.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the storage (in pages) needed for an image, possibly ignoring the
expected compression ratio and/or allowance for extra pagedir1 pages.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 12d715a..604089f 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -514,3 +514,9 @@ static int attempt_to_freeze(void)
 	return result;
 }
 
+long storage_needed(int use_ecr, int ignore_extra_pd1_allow)
+{
+	return 	(main_storage_needed(use_ecr, ignore_extra_pd1_allow)
+		       + header_storage_needed());
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
