Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWJAMnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWJAMnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWJAMnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:43:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:48102 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932135AbWJAMnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:43:53 -0400
Date: Sun, 1 Oct 2006 08:43:52 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Cc: davidel@xmailserver.org
Subject: [PATCH] fs/eventpoll: error handling micro-cleanup
Message-ID: <20061001124352.GA30263@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While reviewing the 'may be used uninitialized' bogus gcc warnings,
I noticed that an error code assignment was only needed if an error had
actually occured.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8d54433..557d5b6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -720,9 +720,10 @@ static int ep_getfd(int *efd, struct ino
 
 	/* Allocates an inode from the eventpoll file system */
 	inode = ep_eventpoll_inode();
-	error = PTR_ERR(inode);
-	if (IS_ERR(inode))
+	if (IS_ERR(inode)) {
+		error = PTR_ERR(inode);
 		goto eexit_2;
+	}
 
 	/* Allocates a free descriptor to plug the file onto */
 	error = get_unused_fd();
