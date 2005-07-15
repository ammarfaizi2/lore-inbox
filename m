Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263290AbVGOKoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbVGOKoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbVGOKe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:34:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12435 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261810AbVGOKcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:32:16 -0400
Date: Fri, 15 Jul 2005 18:37:12 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 10/12] dlm: release list of root rsbs
Message-ID: <20050715103712.GM17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="release-root-list.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The list of root rsb's created during recovery needs to be released if
recovery is aborted early.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/recoverd.c
===================================================================
--- linux.orig/drivers/dlm/recoverd.c
+++ linux/drivers/dlm/recoverd.c
@@ -205,6 +205,7 @@ static int ls_recover(struct dlm_ls *ls,
 	return 0;
 
  fail:
+	dlm_release_root_list(ls);
 	log_debug(ls, "recover %"PRIx64" error %d", rv->seq, error);
 	up(&ls->ls_recoverd_active);
 	return error;

--
