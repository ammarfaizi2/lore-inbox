Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVFBIB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVFBIB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFBIBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:01:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261172AbVFBH6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:20 -0400
Date: Thu, 2 Jun 2005 16:02:38 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/9] dlm: don't free lvb twice
Message-ID: <20050602080238.GC21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="double-free-lvb.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't free an rsb's lvb before calling free_rsb() because free_rsb() does
that.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/lockspace.c
===================================================================
--- linux.orig/drivers/dlm/lockspace.c	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/lockspace.c	2005-06-02 12:55:58.290164152 +0800
@@ -460,10 +460,6 @@
 					 res_hashchain);
 
 			list_del(&rsb->res_hashchain);
-
-			if (rsb->res_lvbptr)
-				free_lvb(rsb->res_lvbptr);
-
 			free_rsb(rsb);
 		}
 
@@ -472,10 +468,6 @@
 			rsb = list_entry(head->next, struct dlm_rsb,
 					 res_hashchain);
 			list_del(&rsb->res_hashchain);
-
-			if (rsb->res_lvbptr)
-				free_lvb(rsb->res_lvbptr);
-
 			free_rsb(rsb);
 		}
 	}

--

