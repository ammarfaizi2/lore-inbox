Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWCXSOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWCXSOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCXSOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:14:12 -0500
Received: from [198.99.130.12] ([198.99.130.12]:49814 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751388AbWCXSN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:56 -0500
Message-Id: <200603241815.k2OIF6Ts005575@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Oleg Drokin <green@linuxhacker.ru>
Subject: [PATCH 16/16] UML - Fix hostfs stack corruption
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:15:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noted by Oleg Drokin:
We initialized an extra slot of struct kstatfs.spare, sometimes
causing stack corruption.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/fs/hostfs/hostfs_user.c
===================================================================
--- linux-2.6.16.orig/fs/hostfs/hostfs_user.c	2006-03-23 16:49:38.000000000 -0500
+++ linux-2.6.16/fs/hostfs/hostfs_user.c	2006-03-23 17:46:09.000000000 -0500
@@ -360,7 +360,6 @@ int do_statfs(char *root, long *bsize_ou
 	spare_out[2] = buf.f_spare[2];
 	spare_out[3] = buf.f_spare[3];
 	spare_out[4] = buf.f_spare[4];
-	spare_out[5] = buf.f_spare[5];
 	return(0);
 }
 

