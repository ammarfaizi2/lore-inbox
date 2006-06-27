Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933418AbWF0ElF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933418AbWF0ElF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933401AbWF0ElD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:03 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:39387 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933415AbWF0Ek5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:57 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/13] [Suspend2] Manually activate/deactivate the storage manager.
Date: Tue, 27 Jun 2006 14:40:56 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044054.14778.22323.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide (via a proc entry) a means whereby the user can manually activate
and deactivate the storage manager for test and configuration purposes.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index fea9276..aa140ea 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -223,3 +223,16 @@ void suspend_cleanup_usm(void)
 	}
 }
 
+static void storage_manager_activate(void)
+{
+	if (storage_manager_action == storage_manager_last_action)
+		return;
+
+	if (storage_manager_action)
+		suspend_prepare_usm();
+	else
+		suspend_cleanup_usm();
+
+	storage_manager_last_action = storage_manager_action;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
