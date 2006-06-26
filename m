Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933292AbWFZWxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933292AbWFZWxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933316AbWFZWwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:52:40 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34487 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933292AbWFZWk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 33/35] [Suspend2] Filewriter proc data.
Date: Tue, 27 Jun 2006 08:40:56 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224055.4685.46370.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Definitions for filewriter proc entries.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index ad35967..4ec51c2 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -1039,3 +1039,33 @@ static int filewriter_initialise(int sta
 	return result;
 }
 
+static struct suspend_proc_data filewriter_proc_data[] = {
+
+	{
+	 .filename			= "filewriter_target",
+	 .permissions			= PROC_RW,
+	 .type				= SUSPEND_PROC_DATA_STRING,
+	 .needs_storage_manager		= 2,
+	 .data = {
+		 .string = {
+			 .variable	= filewriter_target,
+			 .max_length	= 256,
+		 }
+	 },
+	 .write_proc			= test_filewriter_target,
+	},
+
+	{ .filename			= "disable_filewriter",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &filewriterops.disabled,
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
