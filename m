Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272307AbTHDXXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272309AbTHDXXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:23:50 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:7571 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S272307AbTHDXXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:23:41 -0400
Date: Mon, 04 Aug 2003 19:23:27 -0400
From: Josef Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL][2.6] Bugzilla bug # 267 - ver_linux script fails to
 give module-init-tools version
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308041923.27329.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the scripts/ver_linux script, which did not report any version for module-init-tools
when using module-init-tools. If modutils were used, it printed out the version. In both cases, the
effect was not wanted. (If modutils are used, nothing should be printed out.)

Josef "Jeff" Sipek

--- linux-2.6.0-test2-vanilla/scripts/ver_linux	2003-07-27 13:04:06.000000000 -0400
+++ linux-2.6.0-test2-used/scripts/ver_linux	2003-08-04 19:09:51.000000000 -0400
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-depmod -V  2>&1 | grep version | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | grep "module-init-tools" | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'

