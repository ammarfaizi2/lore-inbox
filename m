Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUHQDiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUHQDiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUHQDiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:38:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:1413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262114AbUHQDiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:38:00 -0400
Date: Mon, 16 Aug 2004 20:28:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] fix warnings in scripts/binoffset.c
Message-Id: <20040816202805.356f134d.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct gcc warnings for function return type, printf argument
types, and signed/unsigned compare.

Cross-compiled with no warnings/errors for alpha, ia64,
ppc32, ppc64, sparc32, sparc64, x86_64, and native on i386.
(-W -Wall)

[pre-built tool chains are available from:
http://developer.osdl.org/dev/plm/cross_compile/ ]

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:
 scripts/binoffset.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


--- ./scripts/binoffsetlk.c	2004-06-15 22:19:36.000000000 -0700
+++ ./scripts/binoffset.c	2004-08-09 20:28:01.000000000 -0700
@@ -41,7 +41,7 @@
 char		*progname;
 char		*inputname;
 int		inputfd;
-int		bix;			/* buf index */
+unsigned int	bix;			/* buf index */
 unsigned char	patterns [PAT_SIZE] = {0}; /* byte-sized pattern array */
 int		pat_len;		/* actual number of pattern bytes */
 unsigned char	*madr;			/* mmap address */
@@ -58,7 +58,7 @@ void usage (void)
 	exit (1);
 }
 
-int get_pattern (int pat_count, char *pats [])
+void get_pattern (int pat_count, char *pats [])
 {
 	int ix, err, tmp;
 
@@ -81,7 +81,7 @@ int get_pattern (int pat_count, char *pa
 	pat_len = pat_count;
 }
 
-int search_pattern (void)
+void search_pattern (void)
 {
 	for (bix = 0; bix < filesize; bix++) {
 		if (madr[bix] == patterns[0]) {
@@ -109,7 +109,7 @@ size_t get_filesize (int fd)
 	struct stat stat;
 
 	err = fstat (fd, &stat);
-	fprintf (stderr, "filesize: %d\n", err < 0 ? err : stat.st_size);
+	fprintf (stderr, "filesize: %ld\n", err < 0 ? (long)err : stat.st_size);
 	if (err < 0)
 		return err;
 	return (size_t) stat.st_size;
@@ -154,8 +154,8 @@ int main (int argc, char *argv [])
 	fprintf (stderr, "number of pattern matches = %d\n", num_matches);
 	if (num_matches == 0)
 		firstloc = ~0;
-	printf ("%d\n", firstloc);
-	fprintf (stderr, "%d\n", firstloc);
+	printf ("%ld\n", firstloc);
+	fprintf (stderr, "%ld\n", firstloc);
 
 	exit (num_matches ? 0 : 2);
 }


--
