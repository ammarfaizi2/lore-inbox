Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVCVWzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVCVWzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVCVWza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:55:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:63681 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262280AbVCVWx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:53:29 -0500
Date: Tue, 22 Mar 2005 23:55:17 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Richard Gooch <rgooch@atnf.csiro.au>
Subject: [PATCH] devfs: remove a redundant NULL pointer check prior to kfree()
Message-ID: <Pine.LNX.4.62.0503222351350.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove a redundant NULL pointer check prior to kfree(). kfree() has no 
problem with NULL pointers.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1-orig/fs/devfs/base.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/devfs/base.c	2005-03-22 23:51:23.000000000 +0100
@@ -2738,10 +2738,8 @@ static int devfsd_close(struct inode *in
 	entry = fs_info->devfsd_first_event;
 	fs_info->devfsd_first_event = NULL;
 	fs_info->devfsd_last_event = NULL;
-	if (fs_info->devfsd_info) {
-		kfree(fs_info->devfsd_info);
-		fs_info->devfsd_info = NULL;
-	}
+	kfree(fs_info->devfsd_info);
+	fs_info->devfsd_info = NULL;
 	spin_unlock(&fs_info->devfsd_buffer_lock);
 	fs_info->devfsd_pgrp = 0;
 	fs_info->devfsd_task = NULL;


