Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310817AbSCHSeG>; Fri, 8 Mar 2002 13:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310819AbSCHSdu>; Fri, 8 Mar 2002 13:33:50 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:60945 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S310807AbSCHSde>; Fri, 8 Mar 2002 13:33:34 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>, torvalds@transmeta.com
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in set_fs_altroot()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 10:33:25 -0800
Message-Id: <E16jPBF-0006qL-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a missing '!' in set_fs_altroot():

--- linux-2.5.6/fs/namei.c~	Fri Mar  8 10:21:38 2002
+++ linux-2.5.6/fs/namei.c	Fri Mar  8 10:26:36 2002
@@ -761,7 +761,7 @@
 	if (!emul)
 		goto set_it;
 	err = path_lookup(emul, LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);
-	if (err) {
+	if (!err) {
 		mnt = nd.mnt;
 		dentry = nd.dentry;
 	}


