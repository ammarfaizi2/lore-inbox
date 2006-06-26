Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933333AbWFZWsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333AbWFZWsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933327AbWFZWls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:41:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:39607 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933333AbWFZWlb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/28] [Suspend2] Reset swapwriter when not resuming.
Date: Tue, 27 Jun 2006 08:41:29 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224128.4975.47106.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the device info and close bdevs when we set up when preparing to
resume. This might happen because of a problem, or because noresume2 was
given on the command line and we needed first to invalidate the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 66bb556..a014103 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -233,3 +233,13 @@ static int try_to_parse_resume_device(ch
 	return 0;
 }
 
+/* 
+ * If we have read part of the image, we might have filled  memory with
+ * data that should be zeroed out.
+ */
+static void swapwriter_noresume_reset(void)
+{
+	memset((char *) &devinfo, 0, sizeof(devinfo));
+	close_bdevs();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
