Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVIWOvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVIWOvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVIWOvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:51:00 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:51212 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751042AbVIWOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:50:59 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] open: cleanup in lookup_flags()
Message-Id: <E1EIost-0006Uf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Sep 2005 16:50:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lookup_flags() is only called from the non-create case, so it needn't
check for O_CREAT|O_EXCL.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-09-23 16:34:22.000000000 +0200
+++ linux/fs/namei.c	2005-09-23 16:34:27.000000000 +0200
@@ -1246,9 +1246,6 @@ static inline int lookup_flags(unsigned 
 	if (f & O_NOFOLLOW)
 		retval &= ~LOOKUP_FOLLOW;
 	
-	if ((f & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL))
-		retval &= ~LOOKUP_FOLLOW;
-	
 	if (f & O_DIRECTORY)
 		retval |= LOOKUP_DIRECTORY;
 
