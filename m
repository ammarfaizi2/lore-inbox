Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbUKDHQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUKDHQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUKDHPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:15:21 -0500
Received: from [211.58.254.17] ([211.58.254.17]:3491 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262126AbUKDHEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:04:34 -0500
Date: Thu, 4 Nov 2004 16:04:32 +0900
From: Tejun Heo <tj@home-tj.org>
To: mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 4/5] driver-model: kobject_add() error path reference counting fix
Message-ID: <20041104070431.GE25567@home-tj.org>
References: <20041104070134.GA25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070134.GA25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 df_04_kobject_add_ref_fix.patch

 In kobject_add(), @kobj wasn't put'd properly on error path.  This
patch fixes it.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/lib/kobject.c
===================================================================
--- linux-export.orig/lib/kobject.c	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/lib/kobject.c	2004-11-04 11:04:14.000000000 +0900
@@ -183,6 +183,7 @@ int kobject_add(struct kobject * kobj)
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
+		kobject_put(kobj);
 	} else {
 		kobject_hotplug(kobj, KOBJ_ADD);
 	}
