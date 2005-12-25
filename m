Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVLYQDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVLYQDE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 11:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVLYQDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 11:03:04 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:7 "EHLO mail.parknet.co.jp")
	by vger.kernel.org with ESMTP id S1750863AbVLYQDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 11:03:02 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [EXPERIMENT] Add new "flush" option
References: <877j9ufeio.fsf@devron.myhome.or.jp>
	<20051225041900.38fdcba7.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 26 Dec 2005 01:02:52 +0900
In-Reply-To: <20051225041900.38fdcba7.akpm@osdl.org> (Andrew Morton's message of "Sun, 25 Dec 2005 04:19:00 -0800")
Message-ID: <87bqz588r7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was missing the following part. Sorry.

Andrew Morton <akpm@osdl.org> writes:

> You can use filp->f_mapping here, remove the inode* argument.

Ah, I see. However, it is intended to use as ->release() handler.
So, I updated the patch as following.

+int fs_flush_sync_fdata(struct inode *inode, struct file *filp)
+{
+	int err = 0;
+
+	if (IS_FLUSH(inode) && filp->f_mode & FMODE_WRITE) {
+		current->flags |= PF_SYNCWRITE;
+		err = filemap_write_and_wait(filp->f_mapping);
+		current->flags &= ~PF_SYNCWRITE;
+	}
+	return err;
+}
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
