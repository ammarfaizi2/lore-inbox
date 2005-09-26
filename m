Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVIZKpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVIZKpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 06:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVIZKpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 06:45:10 -0400
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:50614 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S1750748AbVIZKpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 06:45:09 -0400
Date: Mon, 26 Sep 2005 12:44:24 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Michal Wronski <michal.wronski@gmail.com>
Subject: [PATCH] umask in POSIX message queues
Message-ID: <Pine.GSO.4.58.0509261218080.5216@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

All kernels (form 2.6.6) ignore umask when creating new queues via
mq_open (when creating with open() on mqueue fs it is ok of course).
According to specification this a bug. The following trivial patch fixes
this. It should apply cleanly to any current kernel. Please apply.


Signed-off-by: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>


--- linux-2.6.14-rc2/ipc/mqueue.c.orig  2005-09-25 18:52:29.000000000 +0200
+++ linux-2.6.14-rc2/ipc/mqueue.c       2005-09-26 11:44:41.000000000 +0200
@@ -278,6 +278,8 @@ static int mqueue_create(struct inode *d
        queues_count++;
        spin_unlock(&mq_lock);

+       mode &= ~current->fs->umask;
+
        inode = mqueue_get_inode(dir->i_sb, mode, attr);
        if (!inode) {
                error = -ENOMEM;

