Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbUDPVmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUDPVjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:39:39 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:48543 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263772AbUDPVik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:38:40 -0400
Date: Fri, 16 Apr 2004 22:37:43 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix notify_change() potential null dereference.
Message-ID: <20040416213743.GS20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.5/fs/attr.c~	2004-04-16 22:36:00.000000000 +0100
+++ linux-2.6.5/fs/attr.c	2004-04-16 22:36:37.000000000 +0100
@@ -130,7 +130,7 @@
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
-	mode_t mode = inode->i_mode;
+	mode_t mode;
 	int error;
 	struct timespec now = CURRENT_TIME;
 	unsigned int ia_valid = attr->ia_valid;
@@ -138,6 +138,7 @@
 	if (!inode)
 		BUG();
 
+	mode = inode->i_mode;
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
 		attr->ia_atime = now;
