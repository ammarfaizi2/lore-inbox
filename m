Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267774AbUHRVHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267774AbUHRVHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUHRVHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:07:48 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:29231 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267774AbUHRVGJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:06:09 -0400
Date: Thu, 19 Aug 2004 01:06:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Fix warnings in binoffset.c
Message-ID: <20040818230623.GD23495@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040818230252.GA23495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818230252.GA23495@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/18 00:02:40+02:00 rddunlap@osdl.org 
#   fix warnings in scripts/binoffset.c
#   
#   Correct gcc warnings for function return type, printf argument
#   types, and signed/unsigned compare.
#   
#   Cross-compiled with no warnings/errors for alpha, ia64,
#   ppc32, ppc64, sparc32, sparc64, x86_64, and native on i386.
#   (-W -Wall)
#   
#   [pre-built tool chains are available from:
#   http://developer.osdl.org/dev/plm/cross_compile/ ]
#   
#   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/binoffset.c
#   2004/08/10 05:28:01+02:00 rddunlap@osdl.org +6 -6
#   fix warnings in scripts/binoffset.c
# 
diff -Nru a/scripts/binoffset.c b/scripts/binoffset.c
--- a/scripts/binoffset.c	2004-08-19 01:06:15 +02:00
+++ b/scripts/binoffset.c	2004-08-19 01:06:15 +02:00
@@ -41,7 +41,7 @@
 char		*progname;
 char		*inputname;
 int		inputfd;
-int		bix;			/* buf index */
+unsigned int	bix;			/* buf index */
 unsigned char	patterns [PAT_SIZE] = {0}; /* byte-sized pattern array */
 int		pat_len;		/* actual number of pattern bytes */
 unsigned char	*madr;			/* mmap address */
@@ -58,7 +58,7 @@
 	exit (1);
 }
 
-int get_pattern (int pat_count, char *pats [])
+void get_pattern (int pat_count, char *pats [])
 {
 	int ix, err, tmp;
 
@@ -81,7 +81,7 @@
 	pat_len = pat_count;
 }
 
-int search_pattern (void)
+void search_pattern (void)
 {
 	for (bix = 0; bix < filesize; bix++) {
 		if (madr[bix] == patterns[0]) {
@@ -109,7 +109,7 @@
 	struct stat stat;
 
 	err = fstat (fd, &stat);
-	fprintf (stderr, "filesize: %d\n", err < 0 ? err : stat.st_size);
+	fprintf (stderr, "filesize: %ld\n", err < 0 ? (long)err : stat.st_size);
 	if (err < 0)
 		return err;
 	return (size_t) stat.st_size;
@@ -154,8 +154,8 @@
 	fprintf (stderr, "number of pattern matches = %d\n", num_matches);
 	if (num_matches == 0)
 		firstloc = ~0;
-	printf ("%d\n", firstloc);
-	fprintf (stderr, "%d\n", firstloc);
+	printf ("%ld\n", firstloc);
+	fprintf (stderr, "%ld\n", firstloc);
 
 	exit (num_matches ? 0 : 2);
 }
