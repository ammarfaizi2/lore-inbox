Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031680AbWLEVjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031680AbWLEVjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031675AbWLEVjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:39:55 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:48888 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031690AbWLEVjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:39:54 -0500
Date: Tue, 5 Dec 2006 22:32:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 23/35] Unionfs: Main module functions
In-Reply-To: <11652354712473-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052231300.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354712473-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+++ b/fs/unionfs/main.c
>+static int init_debug = 0;
>+module_param_named(debug, init_debug, int, S_IRUGO);
>+MODULE_PARM_DESC(debug, "Initial Unionfs debug value.");

I think there is not anything that forbids it being S_IRUGO | S_IWUSR.


>+
>+static int __init init_unionfs_fs(void)
>+{
>+	int err;
>+	printk("Registering unionfs " UNIONFS_VERSION "\n");
>+
>+	if ((err = init_filldir_cache()))
>+		goto out;
>+	if ((err = init_inode_cache()))
>+		goto out;
>+	if ((err = init_dentry_cache()))
>+		goto out;
>+	if ((err = init_sioq()))
>+		goto out;
>+	err = register_filesystem(&unionfs_fs_type);
>+out:
>+	if (err) {
>+		fin_sioq();
>+		destroy_filldir_cache();
>+		destroy_inode_cache();
>+		destroy_dentry_cache();
>+	}
>+	return err;
>+}
>+static void __exit exit_unionfs_fs(void)
>+{

There's that missing white line again :^)

>+	fin_sioq();
>+	destroy_filldir_cache();
>+	destroy_inode_cache();
>+	destroy_dentry_cache();
>+	unregister_filesystem(&unionfs_fs_type);
>+	printk("Completed unionfs module unload.\n");
>+}
>+
>+MODULE_AUTHOR("Erez Zadok, Filesystems and Storage Lab, Stony Brook University"
>+		" (http://www.fsl.cs.sunysb.edu)");
>+MODULE_DESCRIPTION("Unionfs " UNIONFS_VERSION
>+		" (http://www.unionfs.org)");
>+MODULE_LICENSE("GPL");
>+
>+module_init(init_unionfs_fs);
>+module_exit(exit_unionfs_fs);

Like with sioq, unionfs_init/unionfs_exit should suffice.


	-`J'
-- 
