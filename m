Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTBSXlv>; Wed, 19 Feb 2003 18:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTBSXk4>; Wed, 19 Feb 2003 18:40:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35346 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262780AbTBSXkJ>;
	Wed, 19 Feb 2003 18:40:09 -0500
Date: Wed, 19 Feb 2003 15:43:14 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.62
Message-ID: <20030219234314.GH18590@kroah.com>
References: <20030219234140.GA18590@kroah.com> <20030219234203.GB18590@kroah.com> <20030219234216.GC18590@kroah.com> <20030219234228.GD18590@kroah.com> <20030219234239.GE18590@kroah.com> <20030219234250.GF18590@kroah.com> <20030219234302.GG18590@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219234302.GG18590@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.914.163.3, 2003/02/17 14:32:23-08:00, sds@epoch.ncsc.mil

[PATCH] LSM: coding style fixups in sb_kern_mount

This patch moves the error handling code for the sb_kern_mount hook call
out of line, per Christoph Hellwig's suggestion.


diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Wed Feb 19 15:38:39 2003
+++ b/fs/super.c	Wed Feb 19 15:38:39 2003
@@ -623,12 +623,8 @@
 	if (IS_ERR(sb))
 		goto out_mnt;
  	error = security_sb_kern_mount(sb);
- 	if (error) {
- 		up_write(&sb->s_umount);
- 		deactivate_super(sb);
- 		sb = ERR_PTR(error);
- 		goto out_mnt;
- 	}
+ 	if (error) 
+ 		goto out_sb;
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
@@ -636,6 +632,10 @@
 	up_write(&sb->s_umount);
 	put_filesystem(type);
 	return mnt;
+out_sb:
+	up_write(&sb->s_umount);
+	deactivate_super(sb);
+	sb = ERR_PTR(error);
 out_mnt:
 	free_vfsmnt(mnt);
 out:
