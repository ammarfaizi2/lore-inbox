Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310417AbSCEGf2>; Tue, 5 Mar 2002 01:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293186AbSCEGfP>; Tue, 5 Mar 2002 01:35:15 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:53912 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310417AbSCEGfI>; Tue, 5 Mar 2002 01:35:08 -0500
Date: Tue, 5 Mar 2002 08:21:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andries.Brouwer@cwi.nl
Subject: [PATCH] UFS blocksize fix
Message-ID: <Pine.LNX.4.44.0203050818490.23382-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like i got my test wrong in that last patch, pointed out by Andries 
Brouwer (backing it out causes oopses with certain blocksizes).

Thanks,
	Zwane

diffed against 2.4.19-pre2

--- linux-2.4.19/fs/ufs/super.c.orig	Tue Mar  5 08:17:30 2002
+++ linux-2.4.19/fs/ufs/super.c	Tue Mar  5 08:15:40 2002
@@ -597,7 +597,7 @@
 	}
 	
 again:	
-	if (!set_blocksize (sb->s_dev, block_size)) {
+	if (set_blocksize (sb->s_dev, block_size)) {
 		printk(KERN_ERR ""UFS: failed to set blocksize\n");
 		goto failed;
 	}


