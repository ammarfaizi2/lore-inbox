Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbTAITYD>; Thu, 9 Jan 2003 14:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266975AbTAITX6>; Thu, 9 Jan 2003 14:23:58 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:16903 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S266970AbTAITX4>;
	Thu, 9 Jan 2003 14:23:56 -0500
Date: Thu, 9 Jan 2003 11:27:27 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] module-init-tools update
Message-ID: <20030109192727.GA18727@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Here's a small patch for Documentation/Changes and scripts/ver_linux
to use depmod instead of rmmod as per Rusty's suggestion.

	rmmod will exec the old version of the modutils depending on the
command-line, whereas depmod will give its own version instead.

	Please apply.

-- DN
Daniel

--- Documentation/Changes.old	Thu Jan  9 10:51:36 2003
+++ Documentation/Changes	Thu Jan  9 11:27:54 2003
@@ -52,7 +52,7 @@
 o  Gnu make               3.78                    # make --version
 o  binutils               2.9.5.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  module-init-tools      0.9                     # rmmod -V
+o  module-init-tools      0.9                     # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
 o  jfsutils               1.0.14                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
--- scripts/ver_linux.old	Thu Jan  9 10:52:10 2003
+++ scripts/ver_linux		Thu Jan  9 11:27:57 2003
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-rmmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'
