Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWF0FN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWF0FN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWF0FMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:12:45 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26070 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030624AbWF0Ehz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/13] [Suspend2] Compression proc entry data.
Date: Tue, 27 Jun 2006 14:37:54 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043753.14320.64798.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the suspend_proc_data structure that allows the user to
configure compression support.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 924d507..54d54a9 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -477,3 +477,46 @@ int suspend_expected_compression_ratio(v
 		return 100 - suspend_expected_compression;
 }
 
+/*
+ * data for our proc entries.
+ */
+static struct suspend_proc_data proc_params[] = {
+{
+	.filename			= "expected_compression",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_INTEGER,
+	.data = {
+		.integer = {
+			.variable	= &suspend_expected_compression,
+			.minimum	= 0,
+			.maximum	= 99,
+		}
+	}
+},
+
+{
+	.filename			= "disable_compression",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_INTEGER,
+	.data = {
+		.integer = {
+			.variable	= &suspend_compression_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	}
+},
+
+{
+	.filename			= "compressor",
+	.permissions			= PROC_RW,
+	.type				= SUSPEND_PROC_DATA_STRING,
+	.data = {
+		.string = {
+			.variable	= suspend_compressor_name,
+			.max_length	= 31,
+		}
+	},
+}
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
