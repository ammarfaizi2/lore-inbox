Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSIEU7j>; Thu, 5 Sep 2002 16:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSIEU7j>; Thu, 5 Sep 2002 16:59:39 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:22929 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318141AbSIEU7j>; Thu, 5 Sep 2002 16:59:39 -0400
Date: Thu, 5 Sep 2002 16:04:10 -0500
From: David Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200209052104.g85L4A9d002084@kleikamp.austin.ibm.com>
To: marcelo@conectiva.com.br
Subject: [PATCH] Make in-kernel i_nlink field be unsigned int
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
This is a backport of the fix Linus dropped into the 2.5 tree.  Can you
put this into 2.4?

Linus' abstract:
> Make in-kernel inode 'nlink' field be "unsigned int" instead
> of something arch-dependent and usually less.
>
> We may want to do value limiting in generic_fillattr() if people
> end up caring.

Of course, 2.4 doesn't have generic_fillattr.  This would be cp_old_stat
and cp_new_stat.

Thanks,
Shaggy

===== include/linux/fs.h 1.68 vs edited =====
--- 1.68/include/linux/fs.h	Fri Aug 23 08:27:33 2002
+++ edited/include/linux/fs.h	Thu Sep  5 15:33:33 2002
@@ -442,7 +442,7 @@
 	atomic_t		i_count;
 	kdev_t			i_dev;
 	umode_t			i_mode;
-	nlink_t			i_nlink;
+	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
 	kdev_t			i_rdev;
