Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422986AbWJSDXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422986AbWJSDXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 23:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWJSDXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 23:23:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:63732 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030294AbWJSDXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 23:23:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=HRfjw2bdEP4qlRD+K2VeuLSZ11joROf9bXpXligqPTPyOFCI7lJcpDP1q8CANy0KDPQ6D2LAMYk+xEXGIFywMGLYT2s1dSo8MY69BXYvWCU3wqKZ21n6OVBs1GRSvHHKl36PcB90EgR0XRzWY8XOBY+1pD06qkyrdObt3LIxLIQ=
Date: Thu, 19 Oct 2006 12:24:42 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] debugfs: check return value correctly
Message-ID: <20061019032442.GA20695@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value is stored in "*dentry", not in "dentry".

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Index: work-fault-inject/fs/debugfs/inode.c
===================================================================
--- work-fault-inject.orig/fs/debugfs/inode.c
+++ work-fault-inject/fs/debugfs/inode.c
@@ -147,13 +147,13 @@ static int debugfs_create_by_name(const 
 	*dentry = NULL;
 	mutex_lock(&parent->d_inode->i_mutex);
 	*dentry = lookup_one_len(name, parent, strlen(name));
-	if (!IS_ERR(dentry)) {
+	if (!IS_ERR(*dentry)) {
 		if ((mode & S_IFMT) == S_IFDIR)
 			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
 		else 
 			error = debugfs_create(parent->d_inode, *dentry, mode);
 	} else
-		error = PTR_ERR(dentry);
+		error = PTR_ERR(*dentry);
 	mutex_unlock(&parent->d_inode->i_mutex);
 
 	return error;
