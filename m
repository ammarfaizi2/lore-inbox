Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbUCQSVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUCQSVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:21:14 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:64415 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261912AbUCQSVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:21:11 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.26-pre4] 2 Gb Core Files
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com
Message-Id: <20040317182109.08FDC1340C9@ldl.fc.hp.com>
Date: Wed, 17 Mar 2004 11:21:09 -0700 (MST)
From: loftin@ldl.fc.hp.com (Terry Loftin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply. This patch allows core files larger than 2GB.
This is just Andrew Morton's 2.6.x patch backported to 2.4.26-pre
source.  TIA.

diff -Nu linux-2.4/fs/exec.c linux-2.4_core/fs/exec.c
--- linux-2.4/fs/exec.c	Mon Mar 15 10:57:07 2004
+++ linux-2.4_core/fs/exec.c	Mon Mar 15 10:59:48 2004
@@ -1126,7 +1126,7 @@
 		goto fail;
 
  	format_corename(corename, core_pattern, signr);
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
+	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
 	if (IS_ERR(file))
 		goto fail;
 	inode = file->f_dentry->d_inode;
