Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWGIVrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWGIVrl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161174AbWGIVrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:47:41 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:13003 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161173AbWGIVrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:47:41 -0400
Message-ID: <44B1798A.7080901@free.fr>
Date: Sun, 09 Jul 2006 23:47:54 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.6.18-rc1-mm1 reiser4 module calls generic_file_read
References: <20060709021106.9310d4d1.akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

generic_file_read has been dropped from 2.6.18-rc1-mm1. This patch 
works for me. Does it look good to reiser4 devloppers ?

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---
 fs/reiser4/plugin/file/cryptcompress.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-mm/fs/reiser4/plugin/file/cryptcompress.c
===================================================================
--- linux-2.6-mm.orig/fs/reiser4/plugin/file/cryptcompress.c
+++ linux-2.6-mm/fs/reiser4/plugin/file/cryptcompress.c
@@ -2883,7 +2883,7 @@ ssize_t read_cryptcompress(struct file *
 	down_read(&info->lock);
 	LOCK_CNT_INC(inode_sem_r);
 
-	result = generic_file_read(file, buf, size, off);
+	result = do_sync_read(file, buf, size, off);
 
 	up_read(&info->lock);
 	LOCK_CNT_DEC(inode_sem_r);

