Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWDCPxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWDCPxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWDCPxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:53:22 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:56465 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751754AbWDCPxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:53:21 -0400
Date: Mon, 3 Apr 2006 11:55:37 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Morton Andrew Morton <akpm@osdl.org>,
       "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: [PATCH] kdump proc vmcore size oveflow fix
Message-ID: <20060403155537.GA22971@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Couple of /proc/vmcore data structures overflow with 32bit systems having
  memory more than 4G. This patch fixes those.

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 fs/proc/vmcore.c        |    4 ++--
 include/linux/proc_fs.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN include/linux/proc_fs.h~kdump-vmcore-size-overflow-bug-fix include/linux/proc_fs.h
--- linux-2.6.16-mm2-16M/include/linux/proc_fs.h~kdump-vmcore-size-overflow-bug-fix	2006-04-03 10:20:01.000000000 -0400
+++ linux-2.6.16-mm2-16M-root/include/linux/proc_fs.h	2006-04-03 10:20:01.000000000 -0400
@@ -79,7 +79,7 @@ struct kcore_list {
 struct vmcore {
 	struct list_head list;
 	unsigned long long paddr;
-	unsigned long size;
+	unsigned long long size;
 	loff_t offset;
 };
 
diff -puN fs/proc/vmcore.c~kdump-vmcore-size-overflow-bug-fix fs/proc/vmcore.c
--- linux-2.6.16-mm2-16M/fs/proc/vmcore.c~kdump-vmcore-size-overflow-bug-fix	2006-04-03 10:20:01.000000000 -0400
+++ linux-2.6.16-mm2-16M-root/fs/proc/vmcore.c	2006-04-03 10:34:08.000000000 -0400
@@ -103,8 +103,8 @@ static ssize_t read_vmcore(struct file *
 				size_t buflen, loff_t *fpos)
 {
 	ssize_t acc = 0, tmp;
-	size_t tsz, nr_bytes;
-	u64 start;
+	size_t tsz;
+	u64 start, nr_bytes;
 	struct vmcore *curr_m = NULL;
 
 	if (buflen == 0 || *fpos >= vmcore_size)
_
