Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbUKLXEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUKLXEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbUKLXDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:03:33 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56757 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262653AbUKLXAj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:00:39 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <11003004064171@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 12 Nov 2004 15:00:07 -0800
Message-Id: <11003004061439@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2096, 2004/11/12 11:42:46-08:00, maneesh@in.ibm.com

[PATCH] sysfs: fix duplicate driver registration error

o Do not release existing directory if the new directory happens to be a
  duplicate directory. Thanks to Kay Sievers for the testcase.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	2004-11-12 14:53:18 -08:00
+++ b/fs/sysfs/dir.c	2004-11-12 14:53:18 -08:00
@@ -111,7 +111,7 @@
 				d_rehash(*d);
 			}
 		}
-		if (error)
+		if (error && (error != -EEXIST))
 			d_drop(*d);
 		dput(*d);
 	} else

