Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWEEAj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWEEAj5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWEEAj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:39:57 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:41088 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932085AbWEEAj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:39:56 -0400
Date: Thu, 4 May 2006 17:42:44 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.14
Message-ID: <20060505004244.GX24291@moss.sous-sol.org>
References: <20060505003526.GW24291@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505003526.GW24291@moss.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index d4cc824..3c03fb9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .13
+EXTRAVERSION = .14
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/fs/smbfs/dir.c b/fs/smbfs/dir.c
index 0424d06..45862ec 100644
--- a/fs/smbfs/dir.c
+++ b/fs/smbfs/dir.c
@@ -434,6 +434,11 @@ smb_lookup(struct inode *dir, struct den
 	if (dentry->d_name.len > SMB_MAXNAMELEN)
 		goto out;
 
+	/* Do not allow lookup of names with backslashes in */
+	error = -EINVAL;
+	if (memchr(dentry->d_name.name, '\\', dentry->d_name.len))
+		goto out;
+
 	lock_kernel();
 	error = smb_proc_getattr(dentry, &finfo);
 #ifdef SMBFS_PARANOIA
