Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315863AbSEGPNa>; Tue, 7 May 2002 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSEGPNV>; Tue, 7 May 2002 11:13:21 -0400
Received: from backtop.namesys.com ([212.16.7.71]:6785 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315863AbSEGPLL>;
	Tue, 7 May 2002 11:11:11 -0400
Date: Tue, 7 May 2002 19:05:44 +0400
From: Hans Reiser <reiser@namesys.com>
Message-Id: <200205071505.g47F5id04044@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.4] Reiserfs changeset 4 out of 4, please apply.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

 You can get this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.4

 These 2 changesets are followup to previous cleanup changeset, these adds
 missed "attrs" option support and fix a slight mount options parsing bug.
    
 super.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.383.2.41 -> 1.383.2.42
#	 fs/reiserfs/super.c	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/01	mufasa@sis.com.tw	1.392
# Add support for SiS962 phy to sis900 net driver.
# Also introduce new sis900 maintainer.
# --------------------------------------------
# 02/05/01	green@angband.namesys.com	1.383.2.42
# super.c:
#   Fixed a bug where if the last option was argumentless-one, error message about incorrect argument was printed incorrectly
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue May  7 17:54:29 2002
+++ b/fs/reiserfs/super.c	Tue May  7 17:54:29 2002
@@ -414,7 +414,7 @@
    mount options */
 typedef struct {
     char * option_name;
-    int arg_required; /* 0 is argument is not required, not 0 otherwise */
+    int arg_required; /* 0 if argument is not required, not 0 otherwise */
     const arg_desc_t * values; /* list of values accepted by an option */
     int bitmask;  /* bit which is to be set in mount_options bitmask when this
 		     option is selected, 0 is not bits are to be set */
@@ -506,10 +506,10 @@
 	return -1;
     }
 	
-    /* move to the argument */
+    /* move to the argument, or to next option if argument is not required */
     p ++;
     
-    if (!strlen (p)) {
+    if ( opt->arg_required && !strlen (p) ) {
 	/* this catches "option=," */
 	printk ("reiserfs_getopt: empty argument for \"%s\"\n", opt->option_name);
 	return -1;

Diffstat:
 super.c |    1 +
 1 files changed, 1 insertion(+)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.406   -> 1.407  
#	 fs/reiserfs/super.c	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/06	green@angband.namesys.com	1.407
# super.c:
#   Added forgotten "attrs" option.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Tue May  7 17:54:42 2002
+++ b/fs/reiserfs/super.c	Tue May  7 17:54:42 2002
@@ -549,6 +549,7 @@
     opt_desc_t opts[] = {
 		{"notail", 0, 0, NOTAIL},
 		{"conv", 0, 0, REISERFS_CONVERT}, 
+		{"attrs", 0, 0, REISERFS_ATTRS}, 
 		{"nolog", 0, 0, 0},
 		{"replayonly", 0, 0, REPLAYONLY},
 		
