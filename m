Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWF0FOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWF0FOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWF0FOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 01:14:53 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:23766 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933393AbWF0Ehm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:37:42 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 07/13] [Suspend2] Compression debug stats.
Date: Tue, 27 Jun 2006 14:37:41 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627043739.14320.9006.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fill a buffer with debugging information about whether compression was
enabled and (if so) what ratio was achieved.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/compression.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/compression.c b/kernel/power/compression.c
index 5193423..6578e8c 100644
--- a/kernel/power/compression.c
+++ b/kernel/power/compression.c
@@ -374,4 +374,29 @@ static int suspend_compress_read_chunk(s
 	return ret;
 }
 
+/* 
+ * suspend_compress_print_debug_stats
+ * @buffer: Pointer to a buffer into which the debug info will be printed.
+ * @size: Size of the buffer.
+ *
+ * Print information to be recorded for debugging purposes into a buffer.
+ * Returns: Number of characters written to the buffer.
+ */
+
+static int suspend_compress_print_debug_stats(char *buffer, int size)
+{
+	int pages_in = bytes_in >> PAGE_SHIFT, 
+		pages_out = bytes_out >> PAGE_SHIFT;
+	int len;
+	
+	/* Output the compression ratio achieved. */
+	len = snprintf_used(buffer, size, "- Compressor %s enabled.\n",
+			suspend_compressor_name);
+	if (pages_in)
+		len+= snprintf_used(buffer+len, size - len,
+		  "  Compressed %ld bytes into %ld (%d percent compression).\n",
+		  bytes_in, bytes_out, (pages_in - pages_out) * 100 / pages_in);
+	return len;
+}
+
 

--
Nigel Cunningham		nigel at suspend2 dot net
