Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSBMPlA>; Wed, 13 Feb 2002 10:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSBMPku>; Wed, 13 Feb 2002 10:40:50 -0500
Received: from duracef.shout.net ([204.253.184.12]:11789 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S286758AbSBMPkd>; Wed, 13 Feb 2002 10:40:33 -0500
Date: Wed, 13 Feb 2002 09:39:59 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200202131539.g1DFdwn10334@duracef.shout.net>
To: torvalds@transmeta.com
Subject: [PATCH] menuconfig: fix error exit if awk fails
Cc: achurch@achurch.org, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one-liner fixes an error case in Menuconfig when awk fails.
Written by Andrew Church (achurch@achurch.org).
Reviewed and tested by Michael Elizabeth Chastain (mec@shout.net).

Submission history:
  2002-02-05  submission #1
  2002-02-11  merged into patch-2.5.4-dj1.diff
  2002-02-13  submission #2

Linus ... would you like me to send you patches directly, or would you
like me to become a "stratum 2" maintainer, working through someone else?

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"

===

diff -u -r -N linux-2.5.4/scripts/Menuconfig linux/scripts/Menuconfig
--- linux-2.5.4/scripts/Menuconfig	Tue Jan 29 22:31:46 2002
+++ linux/scripts/Menuconfig	Wed Feb 13 07:27:59 2002
@@ -689,7 +689,7 @@
 # Call awk, and watch for error codes, etc.
 #
 function callawk () {
-awk "$1" || echo "Awk died with error code $?. Giving up." || exit 1
+awk "$1" || { echo "Awk died with error code $?. Giving up."; exit 1; }
 }
 
 #
