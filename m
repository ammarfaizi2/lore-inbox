Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTHZN6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbTHZN4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:56:49 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:25007 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263830AbTHZNys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:54:48 -0400
Subject: [PATCH] Fix SELinux format specifiers
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061906079.23880.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Aug 2003 09:54:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  James Morris <jmorris@redhat.com>

This patch corrects several format specifiers in the SELinux
security server code.  

 security/selinux/ss/ebitmap.c  |   10 +++++-----
 security/selinux/ss/policydb.c |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.5/security/selinux/ss/ebitmap.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.5/security/selinux/ss/ebitmap.c,v
retrieving revision 1.11
diff -u -r1.11 ebitmap.c
--- linux-2.5/security/selinux/ss/ebitmap.c	16 Jul 2003 16:55:31 -0000	1.11
+++ linux-2.5/security/selinux/ss/ebitmap.c	25 Aug 2003 16:03:08 -0000
@@ -250,8 +250,8 @@
 	count = le32_to_cpu(buf[2]);
 
 	if (mapsize != MAPSIZE) {
-		printk(KERN_ERR "security: ebitmap: map size %d does not "
-		       "match my size %d (high bit was %d)\n", mapsize,
+		printk(KERN_ERR "security: ebitmap: map size %u does not "
+		       "match my size %Zd (high bit was %d)\n", mapsize,
 		       MAPSIZE, e->highbit);
 		goto out;
 	}
@@ -261,7 +261,7 @@
 	}
 	if (e->highbit & (MAPSIZE - 1)) {
 		printk(KERN_ERR "security: ebitmap: high bit (%d) is not a "
-		       "multiple of the map size (%d)\n", e->highbit, MAPSIZE);
+		       "multiple of the map size (%Zd)\n", e->highbit, MAPSIZE);
 		goto bad;
 	}
 	l = NULL;
@@ -283,13 +283,13 @@
 
 		if (n->startbit & (MAPSIZE - 1)) {
 			printk(KERN_ERR "security: ebitmap start bit (%d) is "
-			       "not a multiple of the map size (%d)\n",
+			       "not a multiple of the map size (%Zd)\n",
 			       n->startbit, MAPSIZE);
 			goto bad_free;
 		}
 		if (n->startbit > (e->highbit - MAPSIZE)) {
 			printk(KERN_ERR "security: ebitmap start bit (%d) is "
-			       "beyond the end of the bitmap (%d)\n",
+			       "beyond the end of the bitmap (%Zd)\n",
 			       n->startbit, (e->highbit - MAPSIZE));
 			goto bad_free;
 		}
Index: linux-2.5/security/selinux/ss/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.5/security/selinux/ss/policydb.c,v
retrieving revision 1.23
diff -u -r1.23 policydb.c
--- linux-2.5/security/selinux/ss/policydb.c	13 Aug 2003 13:57:03 -0000	1.23
+++ linux-2.5/security/selinux/ss/policydb.c	25 Aug 2003 16:03:08 -0000
@@ -1074,7 +1074,7 @@
 	len = buf[1];
 	if (len != strlen(POLICYDB_STRING)) {
 		printk(KERN_ERR "security:  policydb string length %d does not "
-		       "match expected length %d\n",
+		       "match expected length %Zd\n",
 		       len, strlen(POLICYDB_STRING));
 		goto bad;
 	}


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

