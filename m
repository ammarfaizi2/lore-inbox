Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUIXQki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUIXQki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUIXQhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:37:54 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:37802 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268896AbUIXQPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:15:24 -0400
Date: Fri, 24 Sep 2004 17:15:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 9/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241714520.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 9/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/24 1.1952.1.4)
   NTFS: 2.1.19 - Many cleanups, improvements, and a minor bug fix.
   
   - Fix bug found by the new sparse bitwise warnings where the default
     upcase table was defined as a pointer to wchar_t rather than ntfschar
     in fs/ntfs/ntfs.h and super.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-09-24 17:06:31 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-09-24 17:06:31 +01:00
@@ -277,6 +277,11 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.19:
+	- Minor bugfix in handling of the default upcase table.
+	- Many internal cleanups and improvements.  Many thanks to Linus
+	  Torvalds and Al Viro for the help and advice with the sparse
+	  annotations and cleanups.
 2.1.18:
 	- Fix scheduling latencies at mount time.  (Ingo Molnar)
 	- Fix endianness bug in a little traversed portion of the attribute
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:31 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:31 +01:00
@@ -21,7 +21,7 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.19-WIP
+2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
 	- Update ->setattr (fs/ntfs/inode.c::ntfs_setattr()) to refuse to
 	  change the uid, gid, and mode of an inode as we do not support NTFS
@@ -51,6 +51,9 @@
 	- Fix all the sparse bitwise warnings.  Had to change all the enums
 	  storing little endian values to #defines because we cannot set enums
 	  to be little endian so we had lots of bitwise warnings from sparse.
+	- Fix a bug found by the new sparse bitwise warnings where the default
+	  upcase table was defined as a pointer to wchar_t rather than ntfschar
+	  in fs/ntfs/ntfs.h and super.c.
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-09-24 17:06:31 +01:00
+++ b/fs/ntfs/Makefile	2004-09-24 17:06:31 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.19-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.19\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	2004-09-24 17:06:31 +01:00
+++ b/fs/ntfs/ntfs.h	2004-09-24 17:06:31 +01:00
@@ -156,7 +156,7 @@
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000
-extern wchar_t *default_upcase;
+extern ntfschar *default_upcase;
 extern unsigned long ntfs_nr_upcase_users;
 extern struct semaphore ntfs_lock;
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-24 17:06:31 +01:00
+++ b/fs/ntfs/super.c	2004-09-24 17:06:31 +01:00
@@ -2574,7 +2574,7 @@
 kmem_cache_t *ntfs_index_ctx_cache;
 
 /* A global default upcase table and a corresponding reference count. */
-wchar_t *default_upcase = NULL;
+ntfschar *default_upcase = NULL;
 unsigned long ntfs_nr_upcase_users = 0;
 
 /* Driver wide semaphore. */
