Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSLEQZN>; Thu, 5 Dec 2002 11:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSLEQZN>; Thu, 5 Dec 2002 11:25:13 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11280 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261550AbSLEQZM>;
	Thu, 5 Dec 2002 11:25:12 -0500
Date: Thu, 5 Dec 2002 08:32:34 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205163234.GB2865@kroah.com>
References: <20021205163152.GA2865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205163152.GA2865@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.797.131.1, 2002/11/30 00:13:57-08:00, steve@kbuxd.necst.nec.co.jp

[PATCH] fs/namei.c fix

One of Greg KH's security cleanups reversed the sense of a test.
Without this patch, 2.5.50 oopses at boot.  Please apply.


diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Thu Dec  5 01:19:28 2002
+++ b/fs/namei.c	Thu Dec  5 01:19:28 2002
@@ -1648,7 +1648,7 @@
 		error = -EBUSY;
 	else {
 		error = security_inode_unlink(dir, dentry);
-		if (error)
+		if (!error)
 			error = dir->i_op->unlink(dir, dentry);
 	}
 	up(&dentry->d_inode->i_sem);
