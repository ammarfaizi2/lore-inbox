Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288798AbSAEMfh>; Sat, 5 Jan 2002 07:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSAEMf1>; Sat, 5 Jan 2002 07:35:27 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:37608 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288798AbSAEMfK>; Sat, 5 Jan 2002 07:35:10 -0500
Date: Sat, 5 Jan 2002 04:35:06 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Patch?: linux-2.5.2-pre8/fs/ext3/super.c - variation of fix by Andrew Morton
Message-ID: <20020105043506.A24538@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Andrwe Morton posted a fix for the compilation error in
linux-2.5.2-pre8/fs/ext3/super.c.  I have changed his test to
use "!kdev_none()" instead of "!kdev_val()".  It will compile
to the same opcodes, but I think this way is slightly more proper.
It may even make a difference some day if the internal representation
of kdev_val or kdev_none changes in a weird way so that
kdev_val(NODEV) returns non-zero, although I think this is unlikely.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3.diff"

--- linux-2.5.2-pre8/fs/ext3/super.c	Fri Jan  4 19:40:37 2002
+++ linux/fs/ext3/super.c	Sat Jan  5 04:29:20 2002
@@ -56,10 +56,10 @@
 
 static void make_rdonly(kdev_t dev, int *no_write)
 {
-	if (dev) {
+	if (!kdev_none(dev)) {
 		printk(KERN_WARNING "Turning device %s read-only\n", 
 		       bdevname(dev));
-		*no_write = 0xdead0000 + dev;
+		*no_write = 0xdead0000 + kdev_val(dev);
 	}
 }
 

--lrZ03NoBR/3+SXJZ--
