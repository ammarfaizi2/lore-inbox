Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTJJF7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 01:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbTJJF7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 01:59:07 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:31688 "EHLO
	earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262454AbTJJF7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 01:59:00 -0400
Date: Thu, 9 Oct 2003 22:58:57 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@sue
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] Make net/ipx/ipx_proc.c compile w/o CONFIG_PROC_FS
Message-ID: <Pine.GSO.4.58.0310092214280.25392@sue>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo,

This is a trivial patch against ipx_proc.c that allows it to compile with
CONFIG_PROC_FS unset.  The patch simply makes ipx_proc.c include init.h
unconditionally, which ensures that __init and __exit are always defined.

This patch depends upon the patch "Make linux/init.h include linux/compiler.h",
which I have CC-ed to all recipients of this patch.  Should Linus decline that
patch, I can make the trivial changes necessary to make this patch work on its
own, if you wish.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1342  -> 1.1343
#	  net/ipx/ipx_proc.c	1.9     -> 1.10
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/10	noah@caltech.edu	1.1343
# This file needs the __init macro in all cases, so include init.h
# regardless of CONFIG_PROC_FS.  This fixes a compilation error in
# the absence of CONFIG_PROC_FS.
# --------------------------------------------
#
diff -Nru a/net/ipx/ipx_proc.c b/net/ipx/ipx_proc.c
--- a/net/ipx/ipx_proc.c	Fri Oct 10 01:05:06 2003
+++ b/net/ipx/ipx_proc.c	Fri Oct 10 01:05:06 2003
@@ -5,8 +5,8 @@
  */

 #include <linux/config.h>
-#ifdef CONFIG_PROC_FS
 #include <linux/init.h>
+#ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <linux/seq_file.h>

