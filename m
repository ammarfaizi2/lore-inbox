Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWFZXAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWFZXAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933291AbWFZWj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:59 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23223 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933281AbWFZWjm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:42 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/35] [Suspend2] Set the filewriter signature to say we have an image.
Date: Tue, 27 Jun 2006 08:39:41 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223939.4685.90915.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given a pointer to a buffer containng the filewriter signature, modify it
so that it will be recognised as an image that we haven't attempted to
resume from before.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index d5f0310..002f73c 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -385,3 +385,18 @@ int parse_signature(struct filewriter_he
 	return 1;
 }
 
+/* prepare_signature */
+
+static int prepare_signature(struct filewriter_header *current_header,
+		unsigned long first_header_block)
+{
+	/* 
+	 * Explicitly put the \0 that clears the 'tried to resume from
+	 * this image before' flag.
+	 */
+	strncpy(current_header->sig, HaveImage, sizeof(HaveImage));
+	current_header->resumed_before = 0;
+	current_header->first_header_block = first_header_block;
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
