Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTJJF5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 01:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTJJF5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 01:57:50 -0400
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:44845 "EHLO
	earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S262446AbTJJF5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 01:57:47 -0400
Date: Thu, 9 Oct 2003 22:57:44 -0700 (PDT)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@sue
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Cc: acme@conectiva.com.br, linux-net@vger.kernel.org
Subject: [PATCH] Make linux/init.h include linux/compiler.h
Message-ID: <Pine.GSO.4.58.0310092219040.25392@sue>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Linus,

Since __exit and __exit_call from init.h use __attribute_used__ from compiler.h
and are two of the most common macros for which files include init.h, init.h
should include compiler.h.

I think this patch would be appropriate anyway, but note the patch "Make
net/ipx/ipx_proc.c compile w/o CONFIG_PROC_FS", which I have CC-ed to all
recipients of this message, and that depends upon this patch.  Without this
patch, ipx_proc.c would need to include both init.h and compiler.h, the latter
for no other reason than to support init.h.  I don't think that's good.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1341  -> 1.1342
#	include/linux/init.h	1.27    -> 1.28
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/10	noah@caltech.edu	1.1342
# Make linux/init.h include linux/compiler.h.  The __exit and __exit_call
# macros, among others, need the __attribute_used__ macro defined there.
# --------------------------------------------
#
diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Fri Oct 10 00:58:50 2003
+++ b/include/linux/init.h	Fri Oct 10 00:58:50 2003
@@ -2,6 +2,7 @@
 #define _LINUX_INIT_H

 #include <linux/config.h>
+#include <linux/compiler.h>

 /* These macros are used to mark some functions or
  * initialized data (doesn't apply to uninitialized data)

