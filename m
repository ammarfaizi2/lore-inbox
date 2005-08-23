Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVHWUsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVHWUsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVHWUsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:48:11 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:9737 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932390AbVHWUsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:48:10 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1E7feg-0006JB-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:45:58 +0200)
Subject: [PATCH 8/8] deprecate open("foo", 3)
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu> <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu> <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu> <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu> <E1E7feg-0006JB-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7fgZ-0006Ji-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:47:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate access mode of '3' in open() as suggested by Linus.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2005-08-23 13:15:49.000000000 +0200
+++ linux/fs/open.c	2005-08-23 13:16:15.000000000 +0200
@@ -756,6 +756,17 @@ struct file *filp_open(const char * file
 {
 	int namei_flags, error;
 	struct nameidata nd;
+	static int warned;
+
+	/*
+	 * Access mode of 3 had some old uses, that are probably not
+	 * applicable anymore.  For now just warn about deprecation.
+	 * Later it can be changed to return -EINVAL.
+	 */
+	if ((flags & O_ACCMODE) == 3 && warned < 5) {
+		warned++;
+		printk(KERN_WARNING "Warning: '%s' (pid=%i) uses deprecated open flags, please report!\n", current->comm, current->tgid);
+	}
 
 	namei_flags = flags;
 	if ((namei_flags+1) & O_ACCMODE)
