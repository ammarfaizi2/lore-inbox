Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWBTWhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWBTWhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWBTWhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:37:15 -0500
Received: from linuxhacker.ru ([217.76.32.60]:46486 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S1161055AbWBTWgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:55 -0500
Date: Tue, 21 Feb 2006 00:19:48 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: FMODE_EXEC or alike?
Message-ID: <20060220221948.GC5733@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   We are working on a lustre client that would not require any patches
   to linux kernel. And there are few things that would be nice to have
   that I'd like your input on.

   One of those is FMODE_EXEC - to correctly detect cross-node situations with
   executing a file that is opened for write or the other way around, we need
   something like this extra file mode to be present (and used as a file open
   mode when opening files for exection, e.g. in fs/exec.c)
   Do you think there is a chance this can be included into vanilla kernel,
   or is there a better solution I oversee?
   I am just thinking about something as simple as this
   (with some suitable FMODE_EXEC define, of course):

--- linux/fs/exec.c.orig	2006-02-21 00:11:47.000000000 +0200
+++ linux/fs/exec.c	2006-02-21 00:12:24.000000000 +0200
@@ -127,7 +127,7 @@ asmlinkage long sys_uselib(const char __
 	struct nameidata nd;
 	int error;
 
-	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ);
+	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
 	if (error)
 		goto out;
 
@@ -477,7 +477,7 @@ struct file *open_exec(const char *name)
 	int err;
 	struct file *file;
 
-	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ);
+	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ|FMODE_EXEC);
 	file = ERR_PTR(err);
 
 	if (!err) {

   Thanks.

Bye,
    Oleg
