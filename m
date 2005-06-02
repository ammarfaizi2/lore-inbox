Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFBINe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFBINe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFBH7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:59:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261204AbVFBH7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:59:04 -0400
Date: Thu, 2 Jun 2005 16:03:27 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 9/9] dlm: newline in printks
Message-ID: <20050602080327.GI21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-newline-in-printk.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple printk's were missing \n at the end.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c	2005-06-02 12:58:09.796172200 +0800
+++ linux/drivers/dlm/device.c	2005-06-02 13:16:01.522245072 +0800
@@ -263,7 +263,7 @@
 
 	status = misc_register(&newls->ls_miscinfo);
 	if (status) {
-		printk(KERN_ERR "dlm: misc register failed for %s", name);
+		printk(KERN_ERR "dlm: misc register failed for %s\n", name);
 		dlm_release_lockspace(newls->ls_lockspace, 0);
 		kfree(newls->ls_miscinfo.name);
 		kfree(newls);
@@ -466,7 +466,7 @@
 	     req->version[1] > DLM_DEVICE_VERSION_MINOR)) {
 
 		printk(KERN_DEBUG "dlm: process %s (%d) version mismatch "
-		       "user (%d.%d.%d) kernel (%d.%d.%d),",
+		       "user (%d.%d.%d) kernel (%d.%d.%d)\n",
 		       current->comm,
 		       current->pid,
 		       req->version[0],
@@ -1102,8 +1102,7 @@
 
 	r = misc_register(&ctl_device);
 	if (r) {
-		printk(KERN_ERR "dlm: misc_register failed for control "
-				"device\n");
+		printk(KERN_ERR "dlm: misc_register failed for control dev\n");
 		return r;
 	}
 

--

