Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUKDGvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUKDGvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUKDGuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:50:10 -0500
Received: from [211.58.254.17] ([211.58.254.17]:31390 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262103AbUKDGsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:48:20 -0500
Date: Thu, 4 Nov 2004 15:48:12 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 7/15] driver-model: next_arg() renamed to param_next_arg() and became global
Message-ID: <20041104064812.GG24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_07_export_param_next_arg.patch

 This is the 7th patch of 15 patches for devparam.

 Rename next_arg to param_next_arg and make it global function.  This
function is used by devparam.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 14:25:58.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 14:25:59.000000000 +0900
@@ -106,6 +106,9 @@ struct kparam_flag
 #define module_param_invflag(name, flags, flag, perm)			\
 	__module_param_flag(name, flags, flag, 1, perm)
 
+/* Used by deviceparam */
+extern char *param_next_arg(char *args, char **param, char **val);
+
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
 		      char *args,
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-04 14:25:58.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-04 14:25:59.000000000 +0900
@@ -74,7 +74,7 @@ static int parse_one(char *param,
 
 /* You can use " around spaces, but can't escape ". */
 /* Hyphens and underscores equivalent in parameter names. */
-static char *next_arg(char *args, char **param, char **val)
+char *param_next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
 	int in_quote = 0;
@@ -129,7 +129,7 @@ int parse_args(const char *name,
 	while (*args) {
 		int ret;
 
-		args = next_arg(args, &param, &val);
+		args = param_next_arg(args, &param, &val);
 		ret = parse_one(param, val, params, num, unknown);
 		switch (ret) {
 		case -ENOENT:
