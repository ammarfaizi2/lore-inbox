Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311721AbSCUTjI>; Thu, 21 Mar 2002 14:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311836AbSCUTi5>; Thu, 21 Mar 2002 14:38:57 -0500
Received: from air-2.osdl.org ([65.201.151.6]:3200 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S311721AbSCUTim>;
	Thu, 21 Mar 2002 14:38:42 -0500
Date: Thu, 21 Mar 2002 11:38:29 -0800
From: Bob Miller <rem@osdl.org>
To: davej@suse.de, rct@gherkin.frus.com, hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7 acct.c oops
Message-ID: <20020321113829.A1543@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.538  
#	       kernel/acct.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/21	rem@doc.pdx.osdl.net	1.538
# Fixed acct.c code by removing the BUG_ON code because it doesn't work
# on UP systems.
# --------------------------------------------
#
diff -Nru a/kernel/acct.c b/kernel/acct.c
--- a/kernel/acct.c	Thu Mar 21 11:32:05 2002
+++ b/kernel/acct.c	Thu Mar 21 11:32:05 2002
@@ -166,8 +166,6 @@
 {
 	struct file *old_acct = NULL;
 
-	BUG_ON(!spin_is_locked(&acct_globals.lock));
-
 	if (acct_globals.file) {
 		old_acct = acct_globals.file;
 		del_timer(&acct_globals.timer);
