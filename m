Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTEODbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTEODWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:22:34 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:25068 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263811AbTEODS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:27 -0400
Date: Thu, 15 May 2003 04:31:14 +0100
Message-Id: <200305150331.h4F3VEcV000730@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: fix module-init-tools ver_linux problem.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Steven Cole to fix up ver_linux output on a system
with no module-init-tools, just modutils.

As noted in bugzilla #267 and at
http://marc.theaimsgroup.com/?l=linux-kernel&m=104492524815220&w=2

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/scripts/ver_linux linux-2.5/scripts/ver_linux
--- bk-linus/scripts/ver_linux	2003-04-10 06:01:44.000000000 +0100
+++ linux-2.5/scripts/ver_linux	2003-03-20 22:32:27.000000000 +0000
@@ -28,7 +28,7 @@ fdformat --version | awk -F\- '{print "u
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | grep version | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'
