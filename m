Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933358AbWFZWnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933358AbWFZWnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933352AbWFZWmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:52 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:53943 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933351AbWFZWmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:36 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 26/28] [Suspend2] Swapwriter proc entries.
Date: Tue, 27 Jun 2006 08:42:35 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224234.4975.22313.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Definitions the for the proc entries provided by the swapwriter.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index ee7c36b..e210241 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -1140,3 +1140,41 @@ static int header_locations_read_proc(ch
 	return len;
 }
 
+static struct suspend_proc_data swapwriter_proc_data[] = {
+	{
+	 .filename			= "swapfilename",
+	 .permissions			= PROC_RW,
+	 .type				= SUSPEND_PROC_DATA_STRING,
+	 .data = {
+		.string = {
+			.variable	= swapfilename,
+			.max_length	= 255,
+		}
+	 }
+	},
+
+	{
+	 .filename			= "headerlocations",
+	 .permissions			= PROC_READONLY,
+	 .type				= SUSPEND_PROC_DATA_CUSTOM,
+	 .data = {
+		 .special = {
+			.read_proc 	= header_locations_read_proc,
+		}
+	 }
+	},
+
+	{ .filename			= "disable_swapwriter",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &swapwriterops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  },
+	  .write_proc			= attempt_to_parse_resume_device2,
+	}
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
