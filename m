Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTJTEp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 00:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTJTEp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 00:45:57 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:47718 "EHLO
	water-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262306AbTJTEpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 00:45:55 -0400
Date: Sun, 19 Oct 2003 21:45:51 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: jonathan@buzzard.org.uk
Cc: tlinux-users@tce.toshiba-dme.co.jp, linux-kernel@vger.kernel.org,
       rddunlap@osdl.org
Subject: [PATCH] Fix toshiba.c and neofb.c for CONFIG_PROC_FS=n
Message-ID: <Pine.GSO.4.58.0310171450020.13905@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

As the ChangeSet log details, this patch allows the Toshiba SMM driver to
compile with CONFIG_PROC_FS=n.  Randy Dunlap and myself identified the problem
and selected this solution.  Please consider.

This applies to the linux-2.5 BK tree and passes an allyesconfig compile on i386
as of 0400 UTC 10/20/2003.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1344  -> 1.1345
#	include/linux/toshiba.h	1.3     -> 1.4
#	drivers/char/toshiba.c	1.11    -> 1.12
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/10	noah@caltech.edu	1.1345
# Remove the prototypes for tosh_get_info from include/linux/toshiba.h and
# make the function's definition in drivers/char/toshiba.c static.  This
# function is specific to toshiba.c, so no other file needs the prototype.
#
# This allows drivers/char/toshiba.c to compile with CONFIG_PROC_FS=n and
# allows one to link more than one driver that includes toshiba.h into the
# kernel at the same time without a multiple declaration; for example, both
# drivers/char/toshiba.c and drivers/video/neofb.c.
# --------------------------------------------
#
diff -Nru a/drivers/char/toshiba.c b/drivers/char/toshiba.c
--- a/drivers/char/toshiba.c	Fri Oct 10 18:50:17 2003
+++ b/drivers/char/toshiba.c	Fri Oct 10 18:50:17 2003
@@ -292,7 +292,7 @@
  * Print the information for /proc/toshiba
  */
 #ifdef CONFIG_PROC_FS
-int tosh_get_info(char *buffer, char **start, off_t fpos, int length)
+static int tosh_get_info(char *buffer, char **start, off_t fpos, int length)
 {
 	char *temp;
 	int key;
diff -Nru a/include/linux/toshiba.h b/include/linux/toshiba.h
--- a/include/linux/toshiba.h	Fri Oct 10 18:50:17 2003
+++ b/include/linux/toshiba.h	Fri Oct 10 18:50:17 2003
@@ -33,13 +33,4 @@
 	unsigned int edi __attribute__ ((packed));
 } SMMRegisters;

-#ifdef CONFIG_PROC_FS
-static int tosh_get_info(char *, char **, off_t, int);
-#else /* !CONFIG_PROC_FS */
-inline int tosh_get_info(char *buffer, char **start, off_t fpos, int lenght)
-{
-	return 0;
-}
-#endif /* CONFIG_PROC_FS */
-
 #endif

