Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262803AbSIPT5Z>; Mon, 16 Sep 2002 15:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262822AbSIPT5Z>; Mon, 16 Sep 2002 15:57:25 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:48108 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S262803AbSIPT5X>; Mon, 16 Sep 2002 15:57:23 -0400
Subject: [PATCH] 2.5.35 update ver_linux script for gcc 3.x, new
	reiserfsprogs, jfsutils and xfsprogs
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Sep 2002 13:58:49 -0600
Message-Id: <1032206329.2449.8.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an update for the ver_linux script.  Reasons for this update:

1) gcc 3.x has a different output for --version.  This will work with
both old and new forms of --version output.
2) New reiserfsprogs require -V option.
3) Newest reiserfsprogs are installed in /usr/local/sbin with make
install.
4) Added jfsutils check.
5) Added xfsprogs check.

Steven

--- linux-2.5.35/scripts/ver_linux.orig	Mon Sep 16 13:44:12 2002
+++ linux-2.5.35/scripts/ver_linux	Mon Sep 16 13:46:21 2002
@@ -4,7 +4,7 @@
 # /bin /sbin /usr/bin /usr/sbin /usr/local/bin, but it may
 # differ on your system.
 #
-PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
+PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:$PATH
 echo 'If some fields are empty or look unusual you may have an old version.'
 echo 'Compare to the current minimal requirements in Documentation/Changes.'
 echo ' '
@@ -12,7 +12,11 @@
 uname -a
 echo ' '
 
-echo "Gnu C                 " `gcc --version`
+gcc --version 2>&1| head -n 1 | grep -v gcc | awk \
+'NR==1{print "Gnu C                 ", $1}'
+
+gcc --version 2>&1| grep gcc | awk \
+'NR==1{print "Gnu C                 ", $3}'
 
 make --version 2>&1 | awk -F, '{print $1}' | awk \
       '/GNU Make/{print "Gnu make              ",$NF}'
@@ -29,9 +33,15 @@
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'
 
-reiserfsck 2>&1 | grep reiserfsprogs | awk \
+fsck.jfs -V 2>&1 | grep version | sed 's/,//' |  awk \
+'NR==1 {print "jfsutils              ", $3}'
+
+reiserfsck -V 2>&1 | grep reiserfsprogs | awk \
 'NR==1{print "reiserfsprogs         ", $NF}'
 
+xfs_db -V 2>&1 | grep version |  awk \
+'NR==1 {print "xfsprogs              ", $3}'
+
 cardmgr -V 2>&1| grep version | awk \
 'NR==1{print "pcmcia-cs             ", $3}'
 


