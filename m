Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268086AbTBZQIC>; Wed, 26 Feb 2003 11:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbTBZQIC>; Wed, 26 Feb 2003 11:08:02 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:39865 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S268086AbTBZQIB>; Wed, 26 Feb 2003 11:08:01 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Use hex numbers in fs/block_dev.c
Date: Wed, 26 Feb 2003 17:19:15 +0100
User-Agent: KMail/1.5
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302261719.15884@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're using hex numbers to identify devices in most places. We should use
them in filesystem messages, errors etc. too, this would be much more
consistent and avoids things like this where two different naming styles
for the same error are used:

     end_request: [...] dev 16:45 (hdd), sector 9175248
     EXT3-fs error (device ide1(22,69)): [...] inode=575269, block=1146906

With this patch the second message would look like this:

     EXT3-fs error (device ide1(16:45)): [...] inode=575269, block=1146906

This code is used in some drivers outside fs/ too, but there only in *print*
or DEBUG's.

Eike

--- linux-2.5.63-eike/fs/block_dev.c.orig	Tue Feb 25 08:15:45 2003
+++ linux-2.5.63-eike/fs/block_dev.c	Wed Feb 26 16:04:28 2003
@@ -794,7 +794,7 @@
 	if (!name)
 		name = "unknown-block";
 
-	sprintf(buffer, "%s(%d,%d)", name, MAJOR(dev), MINOR(dev));
+	sprintf(buffer, "%s(%x:%x)", name, MAJOR(dev), MINOR(dev));
 	return buffer;
 }
 
