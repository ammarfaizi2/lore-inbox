Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290596AbSAaKws>; Thu, 31 Jan 2002 05:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290600AbSAaKwj>; Thu, 31 Jan 2002 05:52:39 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:52673 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290596AbSAaKw2>; Thu, 31 Jan 2002 05:52:28 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix xconfig help
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 31 Jan 2002 11:52:05 +0100
Message-ID: <878zaeiyi2.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a small patch to fix the missing help in make xconfig.

Regards, Olaf.

diff -X dontdiff -urN v2.5.3/scripts/header.tk linux/scripts/header.tk
--- v2.5.3/scripts/header.tk	Thu Jan 31 11:46:23 2002
+++ linux/scripts/header.tk	Thu Jan 31 11:38:30 2002
@@ -449,29 +449,24 @@
 	catch {destroy $w}
 	toplevel $w -class Dialog
 
-	set filefound 0
 	set found 0
-	set lineno 0
 
-	if { [file readable Documentation/Configure.help] == 1} then {
-		set filefound 1
-		# First escape sed regexp special characters in var:
-		set var [exec echo "$var" | sed s/\[\]\[\/.^$*\]/\\\\&/g]
-		# Now pick out right help text:
-		set message [exec sed -n "
-			/^$var\[ 	\]*\$/,\${
-				/^$var\[ 	\]*\$/c\\
+	# First escape sed regexp special characters in var:
+	set var [exec echo "$var" | sed s/\[\]\[\/.^$*\]/\\\\&/g]
+	# Now pick out right help text:
+	set message [exec find . -name Config.help | xargs sed -n "
+		/^$var\[ 	\]*\$/,\${
+			/^$var\[ 	\]*\$/c\\
 ${var}:\\
 
-				/^#/b
-				/^\[^ 	\]/q
-				s/^  //
-				/<file:\\(\[^>\]*\\)>/s//\\1/g
-				p
-			}
-			" Documentation/Configure.help]
-		set found [expr [string length "$message"] > 0]
-	}
+			/^#/b
+			/^\[^ 	\]/q
+			s/^  //
+			/<file:\\(\[^>\]*\\)>/s//\\1/g
+			p
+		}
+		" ]
+	set found [expr [string length "$message"] > 0]
 
 	frame $w.f1
 	pack $w.f1 -fill both -expand on
@@ -494,13 +489,8 @@
 	pack $w.f1.canvas -side right -fill y -expand on
 
 	if { $found == 0 } then {
-		if { $filefound == 0 } then {
-		message $w.f1.f.m -width 750 -aspect 300 -relief flat -text \
-			"No help available - unable to open file Documentation/Configure.help.  This file should have come with your kernel."
-		} else {
 		message $w.f1.f.m -width 400 -aspect 300 -relief flat -text \
 			"No help available for $var"
-		}
 		label $w.f1.bm -bitmap error
 		wm title $w "RTFM"
 	} else {
