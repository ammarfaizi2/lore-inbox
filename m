Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVIWPWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVIWPWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVIWPWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:22:33 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:13075 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751083AbVIWPWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:22:33 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1EIost-0006Uf-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Fri, 23 Sep 2005 16:50:43 +0200)
Subject: Re: [PATCH] open: cleanup in lookup_flags()
References: <E1EIost-0006Uf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EIpND-0006Wt-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Sep 2005 17:22:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I only see now, that comment should be cleaned too.  Sorry.

lookup_flags() is only called from the non-create case, so it needn't
check for O_CREAT|O_EXCL.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-09-23 16:36:19.000000000 +0200
+++ linux/fs/namei.c	2005-09-23 17:16:57.000000000 +0200
@@ -1234,9 +1234,6 @@ static inline int may_create(struct inod
 }
 
 /* 
- * Special case: O_CREAT|O_EXCL implies O_NOFOLLOW for security
- * reasons.
- *
  * O_DIRECTORY translates into forcing a directory lookup.
  */
 static inline int lookup_flags(unsigned int f)
@@ -1246,9 +1243,6 @@ static inline int lookup_flags(unsigned 
 	if (f & O_NOFOLLOW)
 		retval &= ~LOOKUP_FOLLOW;
 	
-	if ((f & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL))
-		retval &= ~LOOKUP_FOLLOW;
-	
 	if (f & O_DIRECTORY)
 		retval |= LOOKUP_DIRECTORY;
 
