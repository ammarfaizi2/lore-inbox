Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWF0FFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWF0FFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbWF0FFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:05:22 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27099 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030682AbWF0Eji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:39:38 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/13] [Suspend2] Notify userspace of a new message.
Date: Tue, 27 Jun 2006 14:39:37 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043936.14630.83624.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wake up a userspace process when we have a new netlink message for it to
process.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index 82a9f6d..c8c543a 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -65,3 +65,17 @@ static void put_skb(struct user_helper_d
 		kfree_skb(skb);
 }
 
+
+static void suspend_notify_userspace(void* data)
+{
+	struct task_struct *t;
+	struct user_helper_data *uhd = (struct user_helper_data *) data;
+
+	BUG_ON(!uhd);
+
+	read_lock(&tasklist_lock);
+	if ((t = find_task_by_pid(uhd->pid)))
+		wake_up_process(t);
+	read_unlock(&tasklist_lock);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
