Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTBKAs2>; Mon, 10 Feb 2003 19:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTBKAs2>; Mon, 10 Feb 2003 19:48:28 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:62470 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265277AbTBKAs1>; Mon, 10 Feb 2003 19:48:27 -0500
Subject: [PATCH] 2.5.60 fix ver_linux script for correct output from depmod
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 10 Feb 2003 17:50:26 -0700
Message-Id: <1044924628.25378.906.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the depmod man page:

BUGS
       depmod [ -V | --version ] should exit immediately.  Instead, it prints
       the version information and behaves as if no options were given.

A recent change to the ver_linux script replaced "rmmod" with "depmod",
to determine module-init-tools version, but the output looks like this:

[snip]
mount                  2.11n
module-init-tools      file
e2fsprogs              1.28
[snip]

The following patch adds a "| grep version" filter to the depmod -V output.

[snip]
mount                  2.11n
module-init-tools      2.4.22
e2fsprogs              1.28
[snip]

Steven

--- linux-2.5.60/scripts/ver_linux.orig	Mon Feb 10 17:18:17 2003
+++ linux-2.5.60/scripts/ver_linux	Mon Feb 10 17:19:36 2003
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | grep version | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'

