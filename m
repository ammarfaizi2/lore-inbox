Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTJTFRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 01:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTJTFRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 01:17:46 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:2634 "EHLO
	earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262280AbTJTFRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 01:17:44 -0400
Date: Sun, 19 Oct 2003 22:17:42 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@clyde
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Missing include in swap.h for some architectures
Message-ID: <Pine.GSO.4.58.0310171453450.13905@blinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All,

This flaw broke kernel builds configured with SWAP=n on some architectures,
particularly alpha and ia64.  Since i386 managed to include pagemap.h
indirectly, this did not crop up there.  See log for details.

This applies to linux-2.5 BK as of 0400 UTC 10/20/2003 and passes all kinds of
ridiculous compile tests, probably including (allyesconfig - broken stuff) on
sparc, sparc64, ia64, alpha, and i386.  Don't know about VAX...

One could place this include within the #ifdef'ed block that contains the
relevant function uses, but that's not generally within the style of this file
or most others, per my recollection.

I didn't know who takes things like this, so if anyone would like to pick this
up, please do so.  Otherwise, I will send it to Linus after a few days.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1367  -> 1.1368
#	include/linux/swap.h	1.79    -> 1.80
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/16	noah@caltech.edu	1.1368
# The linux/swap.h header uses the page_cache_release and release_pages
# functions declared in linux/pagemap.h when CONFIG_SWAP is disabled.  Add
# an include of linux/pagemap.h so swap.h finds those declarations on
# architectures that don't include pagemap.h indirectly.
# --------------------------------------------
#
diff -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Fri Oct 17 13:40:06 2003
+++ b/include/linux/swap.h	Fri Oct 17 13:40:06 2003
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/linkage.h>
+#include <linux/pagemap.h>
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>

