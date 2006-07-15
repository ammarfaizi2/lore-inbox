Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWGOTjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWGOTjo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 15:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWGOTjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 15:39:44 -0400
Received: from tomts44.bellnexxia.net ([209.226.175.111]:64501 "EHLO
	tomts44-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030211AbWGOTjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 15:39:44 -0400
Date: Sat, 15 Jul 2006 12:36:17 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.17.6
Message-ID: <20060715193617.GB5330@kroah.com>
References: <20060715193552.GA5330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715193552.GA5330@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index cb8b93c..5c568d3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .5
+EXTRAVERSION = .6
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5a8b89a..f801693 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1404,8 +1404,8 @@ static int pid_revalidate(struct dentry 
 		} else {
 			inode->i_uid = 0;
 			inode->i_gid = 0;
-			inode->i_mode = 0;
 		}
+		inode->i_mode &= ~(S_ISUID | S_ISGID);
 		security_task_to_inode(task, inode);
 		return 1;
 	}
@@ -1433,6 +1433,7 @@ static int tid_fd_revalidate(struct dent
 				inode->i_uid = 0;
 				inode->i_gid = 0;
 			}
+			inode->i_mode &= ~(S_ISUID | S_ISGID);
 			security_task_to_inode(task, inode);
 			return 1;
 		}
