Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVCZCox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVCZCox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 21:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVCZCox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 21:44:53 -0500
Received: from mail.dif.dk ([193.138.115.101]:57806 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261917AbVCZCov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 21:44:51 -0500
Date: Sat, 26 Mar 2005 03:46:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of a single else clause in cifsfs.c
Message-ID: <Pine.LNX.4.62.0503260343330.2463@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Just a small patch on top of the other ones I sent you earlier for 
cifsfs.c, I overlooked this trivial bit.
We can get rid of the else clause in a if statement. Doesn't change 
anything code-wise, but shortens the file a bit and seems a bit cleaner 
(at least to me) - apply or not as you please of course.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c.with_patch4	2005-03-25 18:03:49.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/cifsfs.c	2005-03-26 03:41:29.000000000 +0100
@@ -96,9 +96,8 @@ static int cifs_read_super(struct super_
 	cifs_sb = CIFS_SB(sb);
 	if (cifs_sb == NULL)
 		return -ENOMEM;
-	else
-		memset(cifs_sb,0,sizeof(struct cifs_sb_info));
 
+	memset(cifs_sb,0,sizeof(struct cifs_sb_info));
 	rc = cifs_mount(sb, cifs_sb, data, devname);
 	if (rc) {
 		if (!silent)


