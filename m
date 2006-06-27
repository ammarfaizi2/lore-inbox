Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWF0Ewt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWF0Ewt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030653AbWF0EwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:52:20 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43483 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933416AbWF0ElX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:23 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/21] [Suspend2] Tell userspace to redraw the screen.
Date: Tue, 27 Jun 2006 14:41:22 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044120.14883.56905.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tell userspace to redraw the screen. Used after the atomic restore.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index b952bf7..0441be5 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -83,3 +83,12 @@ static void ui_nl_set_state(int n)
 		wake_up_interruptible(&userui_wait_for_key);
 }
 
+void userui_redraw(void)
+{
+	if (ui_helper_data.pid == -1)
+		return;
+
+	suspend_send_netlink_message(&ui_helper_data,
+			USERUI_MSG_REDRAW, NULL, 0);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
