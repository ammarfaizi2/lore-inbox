Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbULCWcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbULCWcT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbULCWcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 17:32:19 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:53425 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262432AbULCWcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 17:32:14 -0500
Date: Fri, 3 Dec 2004 23:31:58 +0100
From: franz_pletz@t-online.de (Franz Pletz)
To: Phil Oester <kernel@linuxace.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] loopback device can't act as its backing store
Message-ID: <20041203233158.41595f46@sgx.home>
In-Reply-To: <20041203214238.GA23245@linuxace.com>
References: <Pine.LNX.4.61.0412032028220.10184@sgx.home>
	<20041203214238.GA23245@linuxace.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ID: S81GhUZBZeOAJQoRnjmfCRhHvlbQgJ+VzxPOInVZEjY-qFjNjKSBrx
X-TOI-MSGID: fff89704-803e-46a1-bcc7-eb69557f8e3e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004 13:42:38 -0800, Phil Oester <kernel@linuxace.com> wrote:
> Your mailer mangled the patch.

Thanks for your feedback.
I apologize for any inconvenience at applying or evaluating the patch.

I think I got it now. Let's give it another try.


Signed-off-by: Franz Pletz <franz_pletz@t-online.de>

 linux/drivers/block/loop.c |    7 +++++++
  1 files changed, 7 insertions(+)

--- linux-2.6.10-rc2/drivers/block/loop.c	2004-11-25 19:56:32.000000000 +0100
+++ linux/drivers/block/loop.c	2004-12-02 23:39:43.516913144 +0100
@@ -596,6 +596,9 @@
 	old_file = lo->lo_backing_file;
 
 	error = -EINVAL;
+	/* new backing store mustn't be the loop device it's being mapped to */
+	if(inode->i_rdev == bdev->bd_dev)
+		goto out_putf;
 
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
 		goto out_putf;
@@ -652,6 +655,10 @@
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
 	error = -EINVAL;
+	/* new backing store mustn't be the loop device it's being mapped to */
+	if(inode->i_rdev == bdev->bd_dev)
+		goto out_putf;
+
 	if (S_ISREG(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		struct address_space_operations *aops = mapping->a_ops;
 		/*
