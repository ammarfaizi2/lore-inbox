Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319638AbSH3SQJ>; Fri, 30 Aug 2002 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319641AbSH3SQJ>; Fri, 30 Aug 2002 14:16:09 -0400
Received: from mesatop.zianet.com ([216.234.192.105]:35076 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S319638AbSH3SQI>; Fri, 30 Aug 2002 14:16:08 -0400
Subject: [PATCH] 2.4.20-pre5-ac1 update ver_linux to report version of
	reiserfsprogs.
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Aug 2002 12:18:45 -0600
Message-Id: <1030731527.20626.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch updates the ver_linux script to work with recent 
versions of reiserfsprogs.

Reasons for this update are:

1) Recent versions of reiserfsprogs require the -V option
   to report the version number.
2) Very recent reiserfsprogs (3.6.3+) are installed in /usr/local/sbin.

Old reiserfsprogs which will not respond to -V are deprecated,
and are covered by "If some fields are empty or look unusual
you may have an old version."

This updated ver_linux script was tested with reiserfsprogs
3.x.0j, 3.6.3, and 3.6.4-pre1.

The addition of /usr/local/sbin to $PATH could have some
side effects, so further testing is welcomed.

This patch was made against 2.4.20-pre5-ac1.

Steven


--- linux-2.4.20-pre5-ac1/scripts/ver_linux.orig	Fri Aug 30 08:52:50 2002
+++ linux-2.4.20-pre5-ac1/scripts/ver_linux	Fri Aug 30 09:04:08 2002
@@ -4,7 +4,7 @@
 # /bin /sbin /usr/bin /usr/sbin /usr/local/bin, but it may
 # differ on your system.
 #
-PATH=/sbin:/usr/sbin:/bin:/usr/bin:$PATH
+PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:$PATH
 echo 'If some fields are empty or look unusual you may have an old version.'
 echo 'Compare to the current minimal requirements in Documentation/Changes.'
 echo ' '
@@ -33,7 +33,7 @@
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'
 
-reiserfsck 2>&1 | grep reiserfsprogs | awk \
+reiserfsck -V 2>&1 | grep reiserfsprogs | awk \
 'NR==1{print "reiserfsprogs         ", $NF}'
 
 cardmgr -V 2>&1| grep version | awk \



