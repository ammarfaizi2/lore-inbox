Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269540AbUJWEeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269540AbUJWEeo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUJWEdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:33:25 -0400
Received: from [211.58.254.17] ([211.58.254.17]:7569 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269049AbUJWE2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:28:55 -0400
Date: Sat, 23 Oct 2004 13:28:51 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (8/16)
Message-ID: <20041023042851.GI3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_08_export_param_next_arg.diff

 This is the 8th patch of 16 patches for devparam.

 Rename next_arg to param_next_arg and make it global function.  This
function is used by devparam.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
@@ -100,6 +100,9 @@ struct kparam_flag
 #define module_param_invflag(name, flags, flag, perm)			\
 	__module_param_flag(name, flags, flag, 1, perm)
 
+/* Used by deviceparam */
+extern char *param_next_arg(char *args, char **param, char **val);
+
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
 		      char *args,
Index: linux-devparam-export/kernel/params.c
===================================================================
--- linux-devparam-export.orig/kernel/params.c	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/kernel/params.c	2004-10-23 11:09:29.000000000 +0900
@@ -71,7 +71,7 @@ static int parse_one(char *param,
 
 /* You can use " around spaces, but can't escape ". */
 /* Hyphens and underscores equivalent in parameter names. */
-static char *next_arg(char *args, char **param, char **val)
+char *param_next_arg(char *args, char **param, char **val)
 {
 	unsigned int i, equals = 0;
 	int in_quote = 0;
@@ -126,7 +126,7 @@ int parse_args(const char *name,
 	while (*args) {
 		int ret;
 
-		args = next_arg(args, &param, &val);
+		args = param_next_arg(args, &param, &val);
 		ret = parse_one(param, val, params, num, unknown);
 		switch (ret) {
 		case -ENOENT:
