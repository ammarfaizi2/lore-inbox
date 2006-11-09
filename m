Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWKITf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWKITf6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWKITf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:35:58 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:10887 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030393AbWKITf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:35:57 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Linux MM <linux-mm@kvack.org>
Cc: dev@openvz.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       rohitseth@google.com, Balbir Singh <balbir@in.ibm.com>
Date: Fri, 10 Nov 2006 01:05:32 +0530
Message-Id: <20061109193532.21437.66303.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
Subject: [RFC][PATCH 1/8] Fix resource groups parsing, while assigning shares
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



echo adds a "\n" to the end of a string. When this string is copied from
user space, we need to remove it, so that match_token() can parse
the user space string correctly

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/res_group/rgcs.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN kernel/res_group/rgcs.c~container-res-groups-fix-parsing kernel/res_group/rgcs.c
--- linux-2.6.19-rc2/kernel/res_group/rgcs.c~container-res-groups-fix-parsing	2006-11-09 23:08:10.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/rgcs.c	2006-11-09 23:08:10.000000000 +0530
@@ -241,6 +241,12 @@ ssize_t res_group_file_write(struct cont
 	}
 	buf[nbytes] = 0;	/* nul-terminate */
 
+	/*
+	 * Ignore "\n". It might come in from echo(1)
+	 */
+	if (buf[nbytes - 1] == '\n')
+		buf[nbytes - 1] = 0;
+
 	container_manage_lock();
 
 	if (container_is_removed(cont)) {
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
