Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbUKDGiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbUKDGiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbUKDGiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:38:24 -0500
Received: from [211.58.254.17] ([211.58.254.17]:35229 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262095AbUKDGiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:38:10 -0500
Date: Thu, 4 Nov 2004 15:38:06 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 1/15] driver-model: param_array_set num field fix
Message-ID: <20041104063806.GA24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_01_param_array_bug.patch

 This is the 1st patch of 15 patches for devparam.

 This patches fixes param_array_set() to not use arr->max as nump
argument of param_array.  If arr->max is used as nump and the
configuration variable is exported writeable in the syfs, the size of
the array will be limited by the smallest number of elements
specified.  One side effect is that as the actual number of elements
is not recorded anymore when nump is NULL, all elements should be
printed when referencing the corresponding sysfs node.  I don't think
that will cause any problem.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-04 10:25:51.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-04 11:04:07.000000000 +0900
@@ -305,9 +305,10 @@ int param_array(const char *name,
 int param_array_set(const char *val, struct kernel_param *kp)
 {
 	struct kparam_array *arr = kp->arg;
+	unsigned int t;
 
 	return param_array(kp->name, val, 1, arr->max, arr->elem,
-			   arr->elemsize, arr->set, arr->num ?: &arr->max);
+			   arr->elemsize, arr->set, arr->num ?: &t);
 }
 
 int param_array_get(char *buffer, struct kernel_param *kp)
