Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWASVbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWASVbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWASVbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:31:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422644AbWASVbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:31:20 -0500
Date: Thu, 19 Jan 2006 15:30:39 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dlm: missing variable
Message-ID: <20060119213039.GA31387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're supposed to be checking a flag bit but the flags variable was
missing.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c
+++ linux/drivers/dlm/device.c
@@ -800,7 +800,7 @@ static int do_user_lock(struct file_info
 
 		/* If this is a persistent lock we will have to create a
 		   lockinfo again */
-		if (!li && DLM_LKF_PERSISTENT) {
+		if (!li && (kparams->flags & DLM_LKF_PERSISTENT)) {
 			li = allocate_lockinfo(fi, cmd, kparams);
 
 			li->li_lksb.sb_lkid = kparams->lkid;
