Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933178AbWFZWgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933178AbWFZWgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933189AbWFZWgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:15 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:41375 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933170AbWFZWfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:46 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 17/20] [Suspend2] Calculate the amount of free memory needed.
Date: Tue, 27 Jun 2006 08:35:45 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223543.4050.9541.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the minimum amount of free ram before we will consider ourselves
to have enough to cover all expected needs. We can have the VM freeing
memory for us - that would create an inconsistent image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 604089f..054d0d4 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -520,3 +520,11 @@ long storage_needed(int use_ecr, int ign
 		       + header_storage_needed());
 }
 
+long ram_to_suspend(void)
+{
+	return (1 + 
+		max_t(long, (pagedir1.pageset_size + extra_pd1_pages_allowance - 
+			pageset2_sizelow - extra_pagedir_pages_allocated) / 2, 0) +
+		MIN_FREE_RAM + suspend_memory_for_modules());
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
