Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbVIHFky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVIHFky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVIHFky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:40:54 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:26818 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932616AbVIHFkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:40:53 -0400
Date: Thu, 8 Sep 2005 14:40:53 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5][BUG] SUBCPUSETS: fix for cpusets minor problem
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050908054053.35DAD70031@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes minor problem that the CPUSETS have when files
in the cpuset filesystem are read after lseek()-ed beyond the EOF.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>

--- from-0001/kernel/cpuset.c
+++ to-work/kernel/cpuset.c	2005-09-05 20:26:18.075772762 +0900
@@ -984,6 +984,10 @@ static ssize_t cpuset_common_file_read(s
 	*s++ = '\n';
 	*s = '\0';
 
+	/* Do nothing if *ppos is at the eof or beyond the eof. */
+	if (s - page <= *ppos)
+		return 0;
+
 	start = page + *ppos;
 	n = s - start;
 	retval = n - copy_to_user(buf, start, min(n, nbytes));
