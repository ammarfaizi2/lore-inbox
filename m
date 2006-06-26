Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933293AbWFZWkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933293AbWFZWkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933304AbWFZWka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:40:30 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26807 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933293AbWFZWkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:06 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 18/35] [Suspend2] Header reading initialisation specific to files.
Date: Tue, 27 Jun 2006 08:40:04 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224003.4685.44596.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialisation specific to files (as opposed to reading from an initrd).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 6f298fc..1dd082f 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -582,3 +582,15 @@ out:
 	return -EIO;
 }
 
+static int file_init(void)
+{
+	suspend_writer_buffer_posn = 0;
+
+	/* Read filewriter configuration */
+	suspend_bio_ops.bdev_page_io(READ, filewriter_target_bdev,
+			target_header_start,
+			virt_to_page((unsigned long) suspend_writer_buffer));
+	
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
