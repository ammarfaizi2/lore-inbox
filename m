Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUJWF6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUJWF6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUJWF46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:56:58 -0400
Received: from [211.58.254.17] ([211.58.254.17]:42128 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266837AbUJWEY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:24:28 -0400
Date: Sat, 23 Oct 2004 13:24:22 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (2/16)
Message-ID: <20041023042421.GC3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_02_param_array_bug.diff

 This is the 2nd patch of 16 patches for devparam.

 This patches fixes param_array_set() to not use arr->max as nump
argument of param_array.  If arr->max is used as nump and the
configuration variable is exported writeable in the syfs, the size of
the array will be limited by the smallest number of elements
specified.  One side effect is that as the actual number of elements
is not recorded anymore when nump is NULL, all elements should be
printed when referencing the corresponding sysfs node.  I don't think
that will cause any problem.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/kernel/params.c
===================================================================
--- linux-devparam-export.orig/kernel/params.c	2004-10-22 17:13:33.000000000 +0900
+++ linux-devparam-export/kernel/params.c	2004-10-23 11:09:28.000000000 +0900
@@ -302,9 +302,10 @@ int param_array(const char *name,
 int param_array_set(const char *val, struct kernel_param *kp)
 {
 	struct kparam_array *arr = kp->arg;
+	unsigned int t;
 
 	return param_array(kp->name, val, 1, arr->max, arr->elem,
-			   arr->elemsize, arr->set, arr->num ?: &arr->max);
+			   arr->elemsize, arr->set, arr->num ?: &t);
 }
 
 int param_array_get(char *buffer, struct kernel_param *kp)
