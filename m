Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933209AbWFZXVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209AbWFZXVA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933203AbWFZWgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:55 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:45983 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933170AbWFZWgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:36:17 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/19] [Suspend2] Fill the suspend header fields.
Date: Tue, 27 Jun 2006 08:36:15 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223614.4219.97131.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Store the image metadata in the suspend header data structure.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index 5c0acdd..b3a997f 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -131,3 +131,33 @@ static void noresume_reset_modules(void)
 		suspend_active_writer->noresume_reset();
 }
 
+/* fill_suspend_header()
+ * 
+ * Description:	Fill the suspend header structure.
+ * Arguments:	struct suspend_header: Header data structure to be filled.
+ */
+
+static void fill_suspend_header(struct suspend_header *sh)
+{
+	int i;
+	
+	memset((char *)sh, 0, sizeof(*sh));
+
+	sh->version_code = LINUX_VERSION_CODE;
+	sh->num_physpages = num_physpages;
+	sh->orig_mem_free = suspend_orig_mem_free;
+	strncpy(sh->machine, system_utsname.machine, 65);
+	strncpy(sh->version, system_utsname.version, 65);
+	sh->page_size = PAGE_SIZE;
+	sh->pagedir = pagedir1;
+	sh->pageset_2_size = pagedir2.pageset_size;
+	sh->param0 = suspend_result;
+	sh->param1 = suspend_action;
+	sh->param2 = suspend_debug_state;
+	sh->param3 = console_loglevel;
+	sh->root_fs = current->fs->rootmnt->mnt_sb->s_dev;
+	for (i = 0; i < 4; i++)
+		sh->io_time[i/2][i%2] =
+		       suspend_io_time[i/2][i%2];
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
