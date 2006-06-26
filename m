Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933194AbWFZWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933194AbWFZWgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933123AbWFZWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:21 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:39327 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933110AbWFZWfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:32 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/20] [Suspend2] Try to refreeze processes.
Date: Tue, 27 Jun 2006 08:35:31 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223530.4050.47045.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to refreeze processes after thawing kernel threads to eat memory. This
shouldn't fail, but if it does, we ensure it's handled nicely.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 6b3f2c9..4e012a7 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -394,3 +394,11 @@ void suspend_recalculate_image_contents(
 	return;
 }
 
+static void try_freeze_processes(void)
+{
+	if (freeze_processes()) {
+		set_result_state(SUSPEND_FREEZING_FAILED);
+		set_result_state(SUSPEND_ABORTED);
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
