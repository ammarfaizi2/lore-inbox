Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287623AbSAEJXJ>; Sat, 5 Jan 2002 04:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287630AbSAEJW7>; Sat, 5 Jan 2002 04:22:59 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:51933 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287623AbSAEJWm>; Sat, 5 Jan 2002 04:22:42 -0500
Date: Sat, 5 Jan 2002 01:22:40 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: kraxel@goldbach.in-berlin.de, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre8/drivers/media/video/tvmixer.c kdev_t compilation fix
Message-ID: <20020105012240.A21698@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.2-pre8/drivers/media/video/tvmixer.c used
MINOR where it should have used minor.  Here is the fix
(untested aside from seeing that it compiles).

	This is the only compilation fix for the drivers/media
subtree.  That is why I am submitting it by itself.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tv.diff"

--- linux-2.5.2-pre8/drivers/media/video/tvmixer.c	Wed Oct 17 14:19:20 2001
+++ linux/drivers/media/video/tvmixer.c	Sat Jan  5 01:17:51 2002
@@ -177,7 +177,7 @@
 
 static int tvmixer_open(struct inode *inode, struct file *file)
 {
-        int i, minor = MINOR(inode->i_rdev);
+        int i, minor = minor(inode->i_rdev);
         struct TVMIXER *mix = NULL;
 	struct i2c_client *client = NULL;
 

--pWyiEgJYm5f9v55/--
