Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264662AbTFLBqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTFLBqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:46:45 -0400
Received: from dp.samba.org ([66.70.73.150]:12737 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264662AbTFLBql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:46:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ver_linux script version fix
Date: Thu, 12 Jun 2003 10:48:43 +1000
Message-Id: <20030612020025.CEFC82C002@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

ver_linux script should know whether depmod refers to old version or
new version (this way I can tell whether people haven't install
module-init-tools, although it's usually pretty obvious):

depmod -V (new output):
	module-init-tools 0.9.12

depmod -V (old output):
	depmod version 2.4.21

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.70-bk16/scripts/ver_linux working-2.5.70-bk16-ver_linux/scripts/ver_linux
--- linux-2.5.70-bk16/scripts/ver_linux	2003-05-27 15:02:29.000000000 +1000
+++ working-2.5.70-bk16-ver_linux/scripts/ver_linux	2003-06-12 10:41:09.000000000 +1000
@@ -28,7 +28,7 @@ fdformat --version | awk -F\- '{print "u
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-depmod -V  2>&1 | grep version | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | awk '/version/ {print "modutils              ",$NF} /module-init-tools/ {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
