Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVCYUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVCYUTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVCYUTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:19:16 -0500
Received: from mail.dif.dk ([193.138.115.101]:23725 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261768AbVCYURk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:17:40 -0500
Date: Fri, 25 Mar 2005 21:19:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Howells <dhowells@redhat.com>
Cc: Derek Atkins <warlord@MIT.EDU>, linux-kernel@vger.kernel.org
Subject: [PATCH] redundant NULL check before kfree cleanup for fs/afs/
Message-ID: <Pine.LNX.4.62.0503252116280.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() handles NULL pointers just fine, checking first is not needed.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -upr linux-2.6.12-rc1-mm3-orig/fs/afs/file.c linux-2.6.12-rc1-mm3/fs/afs/file.c
--- linux-2.6.12-rc1-mm3-orig/fs/afs/file.c	2005-03-25 15:28:58.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/afs/file.c	2005-03-25 20:55:17.000000000 +0100
@@ -308,8 +308,7 @@ static int afs_file_releasepage(struct p
 		page->private = 0;
 		ClearPagePrivate(page);
 
-		if (pageio)
-			kfree(pageio);
+		kfree(pageio);
 	}
 
 	_leave(" = 0");


