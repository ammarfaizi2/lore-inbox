Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWGOUME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWGOUME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 16:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWGOUME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 16:12:04 -0400
Received: from tomts23.bellnexxia.net ([209.226.175.185]:15309 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030291AbWGOUMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 16:12:03 -0400
Date: Sat, 15 Jul 2006 13:09:18 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.16.26
Message-ID: <20060715200918.GB15036@kroah.com>
References: <20060715200856.GA15036@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715200856.GA15036@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 84166a1..bea535b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .25
+EXTRAVERSION = .26
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9d99674..38f39c1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1366,8 +1366,8 @@ static int pid_revalidate(struct dentry 
 		} else {
 			inode->i_uid = 0;
 			inode->i_gid = 0;
-			inode->i_mode = 0;
 		}
+		inode->i_mode &= ~(S_ISUID | S_ISGID);
 		security_task_to_inode(task, inode);
 		return 1;
 	}
@@ -1395,6 +1395,7 @@ static int tid_fd_revalidate(struct dent
 				inode->i_uid = 0;
 				inode->i_gid = 0;
 			}
+			inode->i_mode &= ~(S_ISUID | S_ISGID);
 			security_task_to_inode(task, inode);
 			return 1;
 		}
