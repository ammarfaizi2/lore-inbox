Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbULKNdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbULKNdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 08:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbULKNdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 08:33:52 -0500
Received: from asplinux.ru ([195.133.213.194]:62730 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261934AbULKNdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 08:33:12 -0500
Message-ID: <41BAF7C1.4080800@sw.ru>
Date: Sat, 11 Dec 2004 16:36:01 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Export of generic_forget_inode()
Content-Type: multipart/mixed;
 boundary="------------040403040103080104010301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403040103080104010301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds export of generic_forget_inode()

if sb->drop_inode method is set, than it's called in iput_final().
But it's impossible to call neither generic_drop_inode(), nor 
generic_forget_inode() inside this handler. Only generic_delete_inode() 
is accessiable.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------040403040103080104010301
Content-Type: text/plain;
 name="diff-export"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-export"

--- ./fs/inode.c.iexp	2004-12-10 17:42:16.000000000 +0300
+++ ./fs/inode.c	2004-12-11 16:33:35.468308456 +0300
@@ -1032,7 +1032,7 @@ void generic_delete_inode(struct inode *
 
 EXPORT_SYMBOL(generic_delete_inode);
 
-static void generic_forget_inode(struct inode *inode)
+void generic_forget_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -1059,6 +1059,8 @@ static void generic_forget_inode(struct 
 	destroy_inode(inode);
 }
 
+EXPORT_SYMBOL(generic_forget_inode);
+
 /*
  * Normal UNIX filesystem behaviour: delete the
  * inode when the usage count drops to zero, and
--- ./include/linux/fs.h.iexp	2004-12-10 17:42:17.000000000 +0300
+++ ./include/linux/fs.h	2004-12-11 16:33:31.541905360 +0300
@@ -1393,6 +1393,7 @@ extern struct inode * igrab(struct inode
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
+extern void generic_forget_inode(struct inode *inode);
 
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data);

--------------040403040103080104010301--

