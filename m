Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbTIKMAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 08:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTIKMAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 08:00:41 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:23988 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261220AbTIKMAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 08:00:39 -0400
Date: Thu, 11 Sep 2003 13:59:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: [PATCH] sysfs & dput.
Message-ID: <20030911115957.GA4312@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pat,
there is another, small bug in sysfs. In sysfs_create_bin_file 
dentry gets assigned the error value of the call to sysfs_create
if the call failed. The subsequent call to dput will crash. The
solution is to remove the assignment of the error to dentry.

blue skies,
  Martin.

diffstat:
 fs/sysfs/file.c |    2 --
 1 files changed, 2 deletions(-)

diff -urN linux-2.6/fs/sysfs/file.c linux-2.6-s390/fs/sysfs/file.c
--- linux-2.6/fs/sysfs/file.c	Mon Sep  8 21:49:52 2003
+++ linux-2.6-s390/fs/sysfs/file.c	Thu Sep 11 13:38:57 2003
@@ -356,8 +356,6 @@
 		error = sysfs_create(dentry,(attr->mode & S_IALLUGO) | S_IFREG,init_file);
 		if (!error)
 			dentry->d_fsdata = (void *)attr;
-		else
-			dentry = ERR_PTR(error);
 		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
