Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270275AbTGVJWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 05:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270278AbTGVJWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 05:22:17 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:22943 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S270275AbTGVJWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 05:22:16 -0400
To: trivial@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] POSIXify use of tail (2.6.0-test1-bk2)
From: junkio@cox.net
Date: Tue, 22 Jul 2003 02:37:19 -0700
Message-ID: <7v8yqqvr5c.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a cleanup effort going on to add "-n" to
head; here is a corresponding fix for a use of tail as well.

    $ _POSIX2_VERSION=200112 head -1 /dev/null
    head: `-1' option is obsolete; use `-n 1'
    Try `head --help' for more information.
    $ _POSIX2_VERSION=200112 tail -1 /dev/null
    tail: `-1' option is obsolete; use `-n 1'
    Try `tail --help' for more information.

--- linux-2.6.0-test1-bk2/scripts/mkcompile_h	2003-07-22 02:28:15 -0700
+++ linux-2.6.0-test1-bk2/scripts/mkcompile_h	2003-07-22 02:27:39 -0700
@@ -54,7 +54,7 @@
     echo \#define LINUX_COMPILE_DOMAIN
   fi
 
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -1`\"
+  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -n 1`\"
 ) > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,

