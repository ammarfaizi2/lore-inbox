Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTICT35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTICT2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:28:36 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:65298 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S264307AbTICT1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:27:47 -0400
Date: Wed, 3 Sep 2003 12:27:26 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: minor TMPDIR fix
Message-ID: <20030903192726.GA23442@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Just a small fix to make the makeman script use $TMPDIR from the
environment if it's set.

	Sent it to the listed maintainer, mec, but he said he's not active
in the kernel development anymore.  I'll send out a patch to update the
MAINTAINERS file if anyone can tell me who it should be set to.

-- DN
Daniel

--- 1.2/scripts/makeman	Thu Aug 14 18:17:42 2003
+++ edited/scripts/makeman	Wed Sep  3 01:51:53 2003
@@ -12,7 +12,7 @@
 ##             $3 -- the filename which contained the sgmldoc output
 ##                     (I need this so I know which manpages to convert)
 
-my($LISTING, $GENERATED, $INPUT, $OUTPUT, $front, $mode, $filename);
+my($LISTING, $GENERATED, $INPUT, $OUTPUT, $front, $mode, $filename, $tmpdir);
 
 if($ARGV[0] eq ""){
   die "Usage: makeman [convert | install] <dir> <file>\n";
@@ -132,9 +132,13 @@
       }
     }
     close INPUT;
-
-    system("cd $ARGV[1]; docbook2man $filename.sgml; mv $filename.9 /tmp/$$.9\n");
-    open GENERATED, "< /tmp/$$.9";
+    if($ENV{'TMPDIR'}) {
+        $tmpdir=$ENV{'TMPDIR'};
+    } else {
+        $tmpdir="/tmp";
+    }
+    system("cd $ARGV[1]; docbook2man $filename.sgml; mv $filename.9 $tmpdir/$$.9\n");
+    open GENERATED, "< $tmpdir/$$.9";
     open OUTPUT, "> $ARGV[1]/$filename.9";
 
     print OUTPUT "$front";
@@ -146,7 +150,7 @@
     close GENERATED;
 
     system("gzip -f $ARGV[1]/$filename.9\n");
-    unlink("/tmp/$filename.9");
+    unlink("$tmpdir/$filename.9");
   }
 }
 elsif($ARGV[0] eq "install"){

