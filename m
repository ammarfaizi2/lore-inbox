Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbUKSBMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUKSBMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbUKSBL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:11:56 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:49414 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S263007AbUKSBLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:11:31 -0500
Subject: [patch 1/4] hostfs - uml: set .sendfile to generic_file_sendfile
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade_spam@yahoo.it, viro@parcelfarce.linux.theplanet.co.uk
From: blaisorblade_spam@yahoo.it
Date: Fri, 19 Nov 2004 02:13:26 +0100
Message-Id: <20041119011328.023F57B9AA@zion.localdomain>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.80; host: ssc.unict.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>

Make hostfs use the generic sendfile implementation. As you can see, the
problem was simply that it was forgot to set hostfs_file_fops.sendfile to
point to it. I've got one report that it works, and since hostfs uses the VFS
cache it seems reasonable. However, can somebody confirm this?

Also, is there anything spotting similar treatment?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-add-sendfile fs/hostfs/hostfs_kern.c
--- linux-2.6.10-rc/fs/hostfs/hostfs_kern.c~uml-hostfs-add-sendfile	2004-11-18 14:32:39.436315536 +0100
+++ linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c	2004-11-18 14:32:39.439315080 +0100
@@ -393,6 +393,7 @@ int hostfs_fsync(struct file *file, stru
 static struct file_operations hostfs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
+	.sendfile	= generic_file_sendfile,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
 	.open		= hostfs_file_open,
_
