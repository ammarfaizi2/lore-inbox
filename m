Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271810AbTGROzB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271809AbTGROyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:54:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32389
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271808AbTGRONB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:13:01 -0400
Date: Fri, 18 Jul 2003 15:27:22 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181427.h6IERMh0017832@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix ver_linux for 2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/scripts/ver_linux linux-2.6.0-test1-ac2/scripts/ver_linux
--- linux-2.6.0-test1/scripts/ver_linux	2003-07-10 21:11:36.000000000 +0100
+++ linux-2.6.0-test1-ac2/scripts/ver_linux	2003-07-16 18:40:03.000000000 +0100
@@ -54,11 +54,14 @@
 isdnctrl 2>&1 | grep version | awk \
 'NR==1{print "isdn4k-utils          ", $NF}'
 
+showmount --version 2>&1 | grep nfs-utils | awk \
+'NR==1{print "nfs-utils             ", $NF}'
+
 ls -l `ldd /bin/sh | awk '/libc/{print $3}'` | sed \
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
 
-ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1 | awk \
+ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n 1 | awk \
 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
 
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
