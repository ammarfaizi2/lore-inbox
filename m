Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTIDThB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTIDThB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:37:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:38558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262070AbTIDTg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:36:58 -0400
Date: Thu, 4 Sep 2003 12:34:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: sam@ravnborg.org, kai.germaschewski@gmx.de, cherry@osdl.org
Subject: make checkconfig problem
Message-Id: <20030904123452.62dd732e.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You probably already know this...

Someone mentioned to me that 'make checkconfig' isn't working.
However, 'make checkincludes' does work.

'checkconfig' contains the string 'config', which implies to Makefile
that this is a configs-target...

Using a target named 'checkconf' works.   Patch is below.
Or fix it however you like, of course.

--
~Randy


patch_name:	check_targets.patch
patch_version:	2003-09-04.12:31:41
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	make checkconf so that it won't be a configs-target
product:	Linux
product_versions: 2.6.0-test4


diff -Naur ./Makefile~targets ./Makefile
--- ./Makefile~targets	2003-09-04 11:06:45.000000000 -0700
+++ ./Makefile	2003-09-04 12:23:55.000000000 -0700
@@ -815,7 +815,7 @@
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
-checkconfig:
+checkconf:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
 		| xargs $(PERL) -w scripts/checkconfig.pl
