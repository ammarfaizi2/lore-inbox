Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUFLGmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUFLGmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 02:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbUFLGmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 02:42:20 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:56589 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264655AbUFLGmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 02:42:18 -0400
Date: Sat, 12 Jun 2004 14:35:46 +0800 (WST)
From: raven@themaw.net
To: Marcello Tosatti <marcelo.tosatti@cyclades.com>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] kernel 2.4 autofs4 namei patch
Message-ID: <Pine.LNX.4.58.0406121428300.1475@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.8, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, RCVD_IN_ORBS, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcello,

As part of work on autofs version 4 I package an updated autofs4
kernel module. This is used to provide an updated autofs4 module
without the need to recompile the kernel. I keep this up to date
wrt my changes in 2.6 (currently included in 2.6.7-rc3).

Recent work on autofs4 in 2.6 has resulted in the need for a small  
change, outside of the autofs4 module, in fs/namei.c. The change
allows the removal of some long time troublesome code in the
module and allows the handling of the sys_chdir and sys_chroot
to work correctly with recent autofs module and userspace package
updates.

I'm including two patches for your consideration. The one
mentioned above and another which updates the location of the
autofs version 4 software.

The first patch applies cleanly to 2.4.27-pre5 while the
second applies correctly with a sizable offset.

Ian

diff -Nur linux-2.4.20.orig/fs/namei.c linux-2.4.20/fs/namei.c
--- linux-2.4.20.orig/fs/namei.c	2004-04-15 22:13:55.000000000 +0800
+++ linux-2.4.20/fs/namei.c	2004-04-24 14:43:56.000000000 +0800
@@ -583,9 +583,9 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
+		dentry = cached_lookup(nd->dentry, &this, nd->flags);
 		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, 0);
+			dentry = real_lookup(nd->dentry, &this, nd->flags);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
 				break;
diff -Nur linux-2.4.22.orig/Documentation/Configure.help linux-2.4.22/Documentation/Configure.help
--- linux-2.4.22.orig/Documentation/Configure.help	2003-08-25 19:44:39.000000000 +0800
+++ linux-2.4.22/Documentation/Configure.help	2004-04-24 15:11:14.000000000 +0800
@@ -16397,7 +16397,7 @@
   automounter (amd), which is a pure user space daemon.
 
   To use the automounter you need the user-space tools from
-  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/testing-v4/>; you also
+  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/>; you also
   want to answer Y to "NFS file system support", below.
 
   If you want to compile this as a module ( = code which can be
