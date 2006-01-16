Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWAPAsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWAPAsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 19:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWAPAsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 19:48:33 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:43226 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750969AbWAPAsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 19:48:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=P1eiy770mb/UgI0EEDix5AaU1JUvnY+F+Ta2a4SEY6hiYjWWnV19amhihDel0+RAdQTCW+C54xZOcglne8Me4ttl88pRuBOJFFcUaOUQh9f4PQbVBxABxM8WhArJdOn183+TVcLmmMa6Rc3Ed7cnPFs1q03jkW0N2nK7HSQ+Hmg=
Date: Mon, 16 Jan 2006 01:48:10 +0100
From: Diego Calleja <diegocg@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs missing kmalloc failure check
Message-Id: <20060116014810.84ccf9be.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to http://bugzilla.kernel.org/show_bug.cgi?id=5778
fs/reiserfs/file.c is missing this check?


Signed-off-by: Diego Calleja <diegocg@gmail.com>

Index: test/fs/reiserfs/file.c
===================================================================
--- test.orig/fs/reiserfs/file.c	2006-01-13 02:40:50.000000000 +0100
+++ test/fs/reiserfs/file.c	2006-01-16 01:41:36.000000000 +0100
@@ -192,6 +192,8 @@
 
 	allocated_blocks = kmalloc((blocks_to_allocate + will_prealloc) *
 				   sizeof(b_blocknr_t), GFP_NOFS);
+	if (!allocated_blocks)
+		return -ENOMEM;
 
 	/* First we compose a key to point at the writing position, we want to do
 	   that outside of any locking region. */
